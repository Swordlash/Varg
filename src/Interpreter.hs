module Interpreter where

import Control.Monad.Except (catchError)
import Instances
import InterpreterState
import Preprocessing
import PreprocessingState

import Data.Fixed (mod')
import Data.List
import qualified Data.Map as M
import qualified Data.Set as S
import Types

import qualified AbsVarg as Abs
import Control.Exception.Base (SomeException, evaluate, try)
import Data.Char (isUpper)

nats = 0 : [n + 1 | n <- nats]

argGen = map (\n -> "_arg" ++ show n) nats

interpret :: String -> VargMonad String
interpret text = do
  classes <- preprocessClasses text
  main <- lookupTypeFromClassHierarchy "Main" classes
  list <- lookupTypeFromClassHierarchy "List" classes
  liftIO $ logStderr "\n\n[[Interpreting...]]\n\n"
  show <$> runInterpreter (main, list) classes

runInterpreter :: (Type, Type) -> ClassHierarchy -> VargMonad Instance
runInterpreter (main, list) hier =
  lookupFunctionFromType "main" main >>=
  (\f -> do
     liftIO $ logg $ functionBody f
     evalStateT
       (runReaderT (interpretExpression (supplyArgs (functionBody f)) >>= deepForce) (emptyRuntime list))
       (emptyState hier))

emptyState :: ClassHierarchy -> InterpreterState
emptyState hier = InterpreterState hier 0 "Main.main"

emptyRuntime :: Type -> InterpreterRuntime
emptyRuntime listtype =
  let env = M.insert "args" (emptyArgs listtype) M.empty
   in InterpreterRuntime env voidType False

supplyArgs :: Expr -> Expr
supplyArgs main = EApply main (EVar "args")

emptyArgs :: Type -> Instance
emptyArgs listtype = TypeInstance listtype "Empty" [Template "List" [Primitive "Char"]] []

interpretBinaryArithmetic ::
     Expr
  -> String
  -> Expr
  -> Expr
  -> (Integer -> Integer -> InterpreterMonad Instance)
  -> (Double -> Double -> InterpreterMonad Instance)
  -> (Bool -> Bool -> InterpreterMonad Instance)
  -> InterpreterMonad Instance
interpretBinaryArithmetic whole name expr1 expr2 intfun dblfun boolfun = do
  env <- asks environment
  p1 <- interpretExpression expr1
  p2 <- interpretExpression expr2
  rethrow
    (case (p1, p2) of
       (IntInstance v1, IntInstance v2) -> intfun v1 v2
       (DoubleInstance v1, DoubleInstance v2) -> dblfun v1 v2
       (BoolInstance v1, BoolInstance v2) -> boolfun v1 v2
       (v1@ThunkInstance {}, _) -> do
         fv1 <- force v1
         interpretBinaryArithmetic whole name (EInterpreted fv1) expr2 intfun dblfun boolfun
       (_, v2@ThunkInstance {}) -> do
         fv2 <- force v2
         interpretBinaryArithmetic whole name expr1 (EInterpreted fv2) intfun dblfun boolfun
       (TypeInstance {}, _) -> interpretExpression $ EApply (EMember (EInterpreted p1) name) (EInterpreted p2)
       _ -> throw whole ("You want to " ++ name ++ " numbers " ++ show p1 ++ " and " ++ show p2 ++ ". Are they though?"))
    ("Call: " ++ show whole ++ "\nBound variables: " ++ showTr env ++ "\n")

-- auxiliary functions
ifne e f v1 v2 =
  liftIO (try (evaluate $ f v1 v2) :: IO (Either SomeException Integer)) >>= \case
    Left expr -> throw e (show expr)
    Right val -> pure $ IntInstance val

dfne e f v1 v2 =
  liftIO (try (evaluate $ f v1 v2) :: IO (Either SomeException Double)) >>= \case
    Left expr -> throw e (show expr)
    Right val -> pure $ DoubleInstance val

bfne e f b1 b2 =
  liftIO (try (evaluate $ f b1 b2) :: IO (Either SomeException Bool)) >>= \case
    Left expr -> throw e (show expr)
    Right val -> pure $ BoolInstance val

efn str e _ _ = throw e str

num = ConcreteType "Num" []

fun a b = ConcreteType "Function" [Exact a, Exact b]

tany = AnyType

lany = ConcreteType "List" [Any]

anyop op n =
  FunctionInstance
    (Function [] n tany (fun tany tany) $
     ELambda "x" tany (fun tany tany) $ ELambda "y" tany tany $ op (EVar "x") (EVar "y"))

numop op n =
  FunctionInstance
    (Function [] n num (fun num num) $ ELambda "x" num (fun num num) $ ELambda "y" num num $ op (EVar "x") (EVar "y"))

lstop op n =
  FunctionInstance
    (Function [] n lany (fun lany lany) $
     ELambda "x" lany (fun tany lany) $ ELambda "y" lany lany $ op (EVar "x") (EVar "y"))

funop n =
  FunctionInstance
    (Function [] n (fun tany tany) (fun tany tany) $
     ELambda "f" (fun tany tany) (fun tany tany) $ ELambda "x" tany tany $ EApply (EVar "f") (EVar "x"))

nativeStringToInstance :: String -> InterpreterMonad Instance
nativeStringToInstance str =
  interpretExpression (foldr (\ch expr -> ESCons (EChar ch) expr) (EMember (EClass "String") "Empty") str)

getTypeFromDerivation :: DerivationKind -> InterpreterMonad Type
getTypeFromDerivation (Concrete name _) = gets hierarchy >>= lookupTypeFromClassHierarchy name
getTypeFromDerivation (Unbound _) = throwException' "Unbound derivation not implemented yet."

findNativeMethod :: Instance -> String -> InterpreterMonad Instance
findNativeMethod obj name = do
  realtyp <- asks realType
  case name of
    "toString" -> nativeStringToInstance (show obj {baseType = realtyp})
    "call" -> interpretExpression $ EApply (EMember (EClass "Function") "call") $ EInterpreted obj
    _ -> throwException' $ "Nonexistent native method " ++ name

deepForce :: Instance -> InterpreterMonad Instance
deepForce =
  \case
    ThunkInstance expr clos -> local (exchangeEnvironment clos) (interpretExpression expr >>= deepForce)
    t@TypeInstance {fields = flds} -> do
      let (names, insts) = unzip flds
      forcedInsts <- mapM deepForce insts
      return $ t {fields = zip names forcedInsts}
    a -> pure a

force :: Instance -> InterpreterMonad Instance
force =
  \case
    ThunkInstance expr clos -> local (exchangeEnvironment clos) (interpretExpression expr >>= force)
    a -> pure a

delay :: Expr -> InterpreterMonad Instance
delay expr = do
  islazy <- liftIO isVargLazy
  if islazy
    then ThunkInstance expr <$> asks environment
    else interpretExpression expr

deepEq :: Instance -> Instance -> InterpreterMonad Bool
deepEq inst1 inst2 = do
  inst1f <- force inst1
  inst2f <- force inst2
  case (inst1f, inst2f) of
    (IntInstance v1, IntInstance v2) -> pure $ v1 == v2
    (DoubleInstance v1, DoubleInstance v2) -> pure $ v1 == v2
    (CharInstance c1, CharInstance c2) -> pure $ c1 == c2
    (BoolInstance b1, BoolInstance b2) -> pure $ b1 == b2
    (FunctionInstance f1 c1, FunctionInstance f2 c2) -> pure $ (f1 == f2) && (c1 == c2)
    (TypeInstance typ1 var1 _ f1, TypeInstance typ2 var2 _ f2) ->
      if typ1 /= typ2 || var1 /= var2
        then pure False
        else foldM (\acc (i1, i2) -> deepEq i1 i2 >>= \r -> return $ acc && r) True (zip (map snd f1) (map snd f2))
    _ -> pure False

getMember :: Instance -> String -> InterpreterMonad Instance
getMember obj name = do
  hier <- gets hierarchy
  case obj of
    TypeInstance {baseType = t, fields = f} ->
      if qualifiedTypeName t == "Void"
        then findNativeMethod obj name
        else case M.lookup name (typeMembers t) of
               Just (Function _ fname _ _ body) -> do
                 modify $ pushLambdaName $ qualifiedTypeName t ++ "." ++ name
                 rethrow (interpretExpression body) ("Call: " ++ fname)
               Nothing ->
                 fmapMaybe
                   (lookup name f)
                   pure
                   (do supert <- getTypeFromDerivation $ supertype t
                       rethrow
                         (getMember (obj {baseType = supert}) name)
                         ("Call to nonexistent field " ++ name ++ " of class " ++ show obj))
    IntInstance {} -> do
      intcl <- lookupTypeFromClassHierarchy "Integer" hier
      getMember (TypeInstance intcl "" [] []) name
    DoubleInstance {} -> do
      dblcl <- lookupTypeFromClassHierarchy "Double" hier
      getMember (TypeInstance dblcl "" [] []) name
    BoolInstance {} -> do
      boolcl <- lookupTypeFromClassHierarchy "Bool" hier
      getMember (TypeInstance boolcl "" [] []) name
    CharInstance {} -> do
      charcl <- lookupTypeFromClassHierarchy "Char" hier
      getMember (TypeInstance charcl "" [] []) name
    th@ThunkInstance {} -> do
      forced <- force th
      getMember forced name
    other -> rethrow (findNativeMethod obj name) ("Call to member `" ++ name ++ "` on primitive type " ++ show other)

fmapMaybe m f err =
  case m of
    Just val -> f val
    Nothing -> err

appFun :: Instance -> Instance -> Expr -> InterpreterMonad Instance
appFun inst argval expr =
  case inst of
    FunctionInstance Function {functionName = name, functionBody = ELambda argname _ _ body} envf ->
      local (exchangeEnvironment $ M.insert argname argval envf) (delay body)
    th@ThunkInstance {} -> do
      forced <- force th
      appFun forced argval expr
    funval -> do
      env <- asks environment
      funvalf <- deepForce funval
      argvalf <- deepForce argval
      throw
        expr
        ("One does not simply apply argument to a non-function. Functor: (=" ++
         show funvalf ++ "), argument: (=" ++ show argvalf ++ ")\nBound variables: " ++ showTr env ++ "\n")

interpretExpression :: Expr -> InterpreterMonad Instance
interpretExpression expr = do
  let throwe = throw expr
      binary = interpretBinaryArithmetic expr
      ifn = ifne expr
      dfn = dfne expr
      bfn = bfne expr
  env <- asks environment
  hier <- gets hierarchy
  case expr of
    EAbstract -> throwe "Call to an abstract function"
    EInterpreted inst -> pure inst
    EInt val -> pure $ IntInstance val
    EDouble val -> pure $ DoubleInstance val
    EBool val -> pure $ BoolInstance val
    EChar val -> pure $ CharInstance val
    EString val -> nativeStringToInstance val
    EThis -> fmapMaybe (M.lookup "this" env) pure (throwe "Referencing this from a static context")
    ESuper -> fmapMaybe (M.lookup "super" env) pure (throwe "Referencing super from a static context")
    EVar name ->
      case M.lookup name env of
        Nothing -> throwe (name ++ "? I have never seen this man in my life!\n I know only that " ++ showTr env)
        Just th@ThunkInstance {} ->
          rethrow (force th) ("Evaluating thunk " ++ show expr ++ "\nBound variables: " ++ showTr env ++ "\n")
        Just val -> return val
    ELambda _ int out _ ->
      modify incrLambdaIdx >> gets nextLambdaName >>= \lname ->
        return $ FunctionInstance (Function [] lname int out expr) env
    EIfThenElse ife thene elsee ->
      rethrow (interpretExpression ife) ("Computing if condition " ++ show (show expr)) >>= \case
        BoolInstance True -> rethrow (interpretExpression thene) ("Computing then expression " ++ show (show thene))
        BoolInstance False -> rethrow (interpretExpression elsee) ("Computing else expression " ++ show (show elsee))
        res -> throwe ("Usage of invalid type (" ++ typeof res ++ ") in if clause")
    EApply fun arg ->
      rethrow
        (do funval <- interpretExpression fun
            argval <- delay arg
            appFun funval argval expr)
        ("Call apply: " ++ show fun ++ "(" ++ show arg ++ ")\nBound variables: " ++ showTr env ++ "\n")
    ELet name expr1 _ expr2 -- TODO: try to actually care about types
     ->
      let nenv = M.insert name (ThunkInstance expr1 nenv) env -- bind as thunk, eval when needed as var, recursive def
       in local (exchangeEnvironment nenv) (delay expr2)
    EMember (EClass tname) name -> do
      t <- lookupTypeFromClassHierarchy tname hier
      if isUpper (head name) -- call constructor
        then do
          Variant _ supervar fieldsEx <- lookupVariantFromType name t
          let argstypes = zip argGen (map (functionOutputType . snd) fieldsEx)
          let nargs = map (EVar . fst) argstypes
          delay $
            fst $
            foldr
              (\(narg, typ) (expr, typename) ->
                 let ftype = ConcreteType "Function" [Exact typ, Exact typename]
                  in (ELambda narg typ ftype expr, ftype))
              (EConstructor tname name nargs, ConcreteType tname [])
              argstypes
        else case M.lookup name (typeMembers t) of
               Just (Function _ fname _ _ body) -> do
                 modify $ pushLambdaName $ qualifiedTypeName t ++ "." ++ name
                 rethrow (interpretExpression body) ("Call: " ++ fname)
               Nothing -> throwe ("Call to nonexistent static method " ++ name ++ " of class " ++ tname)
    EMember expr name ->
      rethrow
        (interpretExpression expr >>= force >>= \obj ->
           let t = baseType obj
            in local (saveRealType (baseType obj) . bindVariable ("this", obj)) (getMember obj name))
        ("Computing member " ++ show name ++ " of " ++ show (show expr) ++ "\nBound variables: " ++ showTr env ++ "\n")
    EConstructor tname var flds -- FIXME: It creates instances with no type params
     -> do
      typ <- lookupTypeFromClassHierarchy tname hier
      Variant _ supervar fieldsEx <- lookupVariantFromType var typ
      vals <- mapM delay flds
      return $ TypeInstance typ var [] $ zip (map fst fieldsEx) vals
    -- arithmetic ops
    ENeg expr ->
      interpretExpression expr >>= force >>= \case
        IntInstance val -> pure $ IntInstance $ -val
        DoubleInstance val -> pure $ DoubleInstance $ -val
        _ -> throwException "You can only (-Int) or (-Double) dude."
    ENot expr ->
      interpretExpression expr >>= force >>= \case
        BoolInstance val -> pure $ BoolInstance $ not val
        _ -> throwe ("You can only negate bools, change my mind\nTrying to negate " ++ show expr)
    EMod expr1 expr2 -> binary "mod" expr1 expr2 (ifn mod) (dfn mod') (efn "Roll safe, is moduling booleans ok?" expr)
    EAdd expr1 expr2 -> binary "+" expr1 expr2 (ifn (+)) (dfn (+)) (efn "Roll safe, is adding booleans ok?" expr)
    ESub expr1 expr2 -> binary "-" expr1 expr2 (ifn (-)) (dfn (-)) (efn "Roll safe, is subtracting booleans ok?" expr)
    EOr expr1 expr2 ->
      binary
        "||"
        expr1
        expr2
        (efn "One does not simply alternate integers" expr)
        (efn "One does not simply alternate doubles" expr)
        (bfn (||))
    EAnd expr1 expr2 ->
      binary
        "&&"
        expr1
        expr2
        (efn "One does not simply conjunct integers" expr)
        (efn "One does not simply conjunct doubles" expr)
        (bfn (&&))
    EMul expr1 expr2 -> binary "*" expr1 expr2 (ifn (*)) (dfn (*)) (efn "Roll safe, is multiplying booleans ok?" expr)
    EDiv expr1 expr2 -> binary "/" expr1 expr2 (ifn quot) (dfn (/)) (efn "Roll safe, is dividing booleans ok?" expr)
    EPow expr1 expr2 -> binary "^" expr1 expr2 (ifn (^)) (dfn (**)) (bfn (/=))
    ELt expr1 expr2 -> binary "<" expr1 expr2 (bfn (<)) (bfn (<)) (efn "Roll safe, is comparing booleans ok?" expr)
    EGt expr1 expr2 -> binary "<" expr1 expr2 (bfn (>)) (bfn (>)) (efn "Roll safe, is comparing booleans ok?" expr)
    ELeq expr1 expr2 -> binary "<=" expr1 expr2 (bfn (<=)) (bfn (<=)) (efn "Roll safe, is comparing booleans ok?" expr)
    EGeq expr1 expr2 -> binary ">=" expr1 expr2 (bfn (>=)) (bfn (>=)) (efn "Roll safe, is comparing booleans ok?" expr)
    EEq expr1 expr2 -> do
      p1 <- delay expr1
      p2 <- delay expr2
      eq <- deepEq p1 p2
      return $ BoolInstance eq
    ENeq expr1 expr2 -> do
      BoolInstance val <- interpretExpression $ EEq expr1 expr2
      return $ BoolInstance $ not val
    ECons expr1 expr2 -> do
      p1 <- delay expr1
      p2 <- delay expr2
      list <- lookupTypeFromClassHierarchy "List" hier
      return $ TypeInstance list "Cons" [] [("head", p1), ("tail", p2)] -- FIXME: hardcoded List.Cons, but can we do better?
    ESCons expr1 expr2 -> delay $ EApply (EMember expr2 ":") expr1 --strict cons
    EComp expr1 expr2 -> delay $ EApply (EApply (EMember (EClass "Function") "compose") expr1) expr2
    ERange expr1 expr2 ->
      delay $
      if expr2 == EWild
        then EMember expr1 "rangeFrom"
        else EApply (EMember expr1 "rangeTo") expr2
    EOperator op ->
      return $
      (case op of
         Abs.Op_plus -> numop EAdd "Num.+"
         Abs.Op_minus -> numop ESub "Num.-"
         Abs.Op_mul -> numop EMul "Num.*"
         Abs.Op_div -> numop EDiv "Num./"
         Abs.Op_pow -> numop EPow "Num.^"
         Abs.Op_less -> numop ELt "Num.<"
         Abs.Op_gr -> numop EGt "Num.>"
         Abs.Op_leq -> numop ELeq "Num.<="
         Abs.Op_geq -> numop EGeq "Num.>="
         Abs.Op_eq -> anyop EEq "Num.=="
         Abs.Op_cons -> lstop ECons "List.:"
         Abs.Op_scons -> lstop ESCons "List.:"
         Abs.Op_appl -> funop "Function.call")
        env
    _ -> throwException $ "Cannot interpret expr " ++ show expr ++ ": not implemented\n"