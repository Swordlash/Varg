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
     evalStateT (runReaderT (interpretExpression $ supplyArgs $ functionBody f) (emptyRuntime list)) (emptyState hier))

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
       (TypeInstance {}, _) -> interpretExpression $ EApply (EMember (EInterpreted p1) name) (EInterpreted p2)
       _ -> throw whole ("You want to " ++ name ++ " numbers " ++ show p1 ++ " and " ++ show p2 ++ ". Are they though?"))
    ("Call: " ++ show whole ++ "\nBound variables: " ++ showTr env ++ "\n")

-- auxiliary functions
ifne e f v1 v2 =
  liftIO (try (evaluate $ f v1 v2) :: IO (Either SomeException Integer))
    >>= \case
      Left expr -> throw e (show expr)
      Right val -> pure $ IntInstance val

dfne e f v1 v2 =
  liftIO (try (evaluate $ f v1 v2) :: IO (Either SomeException Double))
    >>= \case
      Left expr -> throw e (show expr)
      Right val -> pure $ DoubleInstance val

bfne e f b1 b2 =
  liftIO (try (evaluate $ f b1 b2) :: IO (Either SomeException Bool))
    >>= \case
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

nativeStringToInstance :: String -> InterpreterMonad Instance
nativeStringToInstance str =
  interpretExpression (foldr (\ch expr -> ECons (EChar ch) expr) (EMember (EClass "String") "Empty") str)

getTypeFromDerivation :: DerivationKind -> InterpreterMonad Type
getTypeFromDerivation (Concrete name _) = gets hierarchy >>= lookupTypeFromClassHierarchy name
getTypeFromDerivation (Unbound _) = throwException' "Unbound derivation not implemented yet."

findNativeMethod :: Instance -> String -> InterpreterMonad Instance
findNativeMethod obj name = do
  realtyp <- asks realType
  case name of
    "toString" -> nativeStringToInstance (show obj {baseType = realtyp})
    _ -> throwException' $ "Nonexistent native method " ++ name

getMember :: Instance -> String -> InterpreterMonad Instance
getMember obj name =
  case obj of
    TypeInstance {baseType = t, fields = f} ->
      if qualifiedTypeName t == "Void"
        then findNativeMethod obj name
        else case M.lookup name (typeMembers t) of
               Just (Function _ fname _ _ body) -> do
                 modify $ pushLambdaName $ qualifiedTypeName t ++ "." ++ name
                 rethrow (interpretExpression body) ("Call: " ++ fname)
               Nothing ->
                 fmapMaybe (lookup name f) pure
                   (do
                     supert <- getTypeFromDerivation $ supertype t
                     rethrow
                       (getMember (obj {baseType = supert}) name)
                       ("Call to nonexistent field " ++ name ++ " of class " ++ show obj))
    other -> rethrow (findNativeMethod obj name) ("Call to member `" ++ name ++ "` on primitive type " ++ show other)

fmapMaybe m f err = case m of
  Just val -> f val
  Nothing -> err

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
        Nothing ->
          throwe (name ++ "? I have never seen this man in my life!\n I know only that "++showTr env)
        Just (ThunkInstance expr clos) ->
          rethrow (local (exchangeEnvironment clos) (interpretExpression expr))
            ("Evaluating thunk "++show expr++"\nBound variables: " ++ showTr env ++ "\n")
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
            argval <- interpretExpression arg
            case funval of
              FunctionInstance Function {functionName = name, functionBody = ELambda argname _ _ body} envf ->
                local (exchangeEnvironment $ M.insert argname argval envf) (interpretExpression body)
              _ ->
                throwe
                  ("One does not simply apply argument to a non-function. Functor: " ++
                   show fun ++ " (=" ++ show funval ++ ")" ++ ", argument: " ++ show arg ++ " (=" ++ show argval ++ ")"))
        ("Call apply: " ++ show fun ++ "(" ++ show arg ++ ")\nBound variables: " ++ showTr env ++ "\n")
    ELet name expr1 _ expr2 -- TODO: try to actually care about types
     -> let nenv = M.insert name (ThunkInstance expr1 nenv) env in -- bind as thunk, eval when needed as var, recursive def
        local (exchangeEnvironment nenv) (interpretExpression expr2)
    EMember (EClass tname) name -> do
      t <- lookupTypeFromClassHierarchy tname hier
      if isUpper (head name) -- call constructor
        then do
          Variant _ supervar fieldsEx <- lookupVariantFromType name t
          let argstypes = zip argGen (map (functionOutputType . snd) fieldsEx)
          let nargs = map (EVar . fst) argstypes
          interpretExpression $
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
        (interpretExpression expr >>= \obj ->
           local (saveRealType (baseType obj) . bindVariable ("this", obj)) (getMember obj name))
        ("Computing member " ++ show name ++ " of " ++ show (show expr) ++ "\nBound variables: " ++ showTr env ++ "\n")
    EConstructor tname var flds -- FIXME: It creates instances with no type params
     -> do
      typ <- lookupTypeFromClassHierarchy tname hier
      Variant _ supervar fieldsEx <- lookupVariantFromType var typ
      vals <- mapM interpretExpression flds
      return $ TypeInstance typ var [] $ zip (map fst fieldsEx) vals
    -- arithmetic ops
    ENeg expr ->
      interpretExpression expr >>= \case
        IntInstance val -> pure $ IntInstance $ -val
        DoubleInstance val -> pure $ DoubleInstance $ -val
        _ -> throwException "You can only (-Int) or (-Double) dude."
    ENot expr ->
      interpretExpression expr >>= \case
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
      p1 <- interpretExpression expr1
      p2 <- interpretExpression expr2
      return $ BoolInstance (p1 == p2)
    ENeq expr1 expr2 -> do
      p1 <- interpretExpression expr1
      p2 <- interpretExpression expr2
      return $ BoolInstance $ p1 /= p2
    ECons expr1 expr2 -> interpretExpression $ EApply (EMember expr2 ":") expr1
    EComp expr1 expr2 ->
      interpretExpression $ EApply (EApply (EMember (EClass "Function") "compose") expr1) expr2
    EOperator op -> return $
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
         Abs.Op_cons -> lstop ECons "List.:") env
    _ -> throwException $ "Cannot interpret expr " ++ show expr ++ ": not implemented\n"