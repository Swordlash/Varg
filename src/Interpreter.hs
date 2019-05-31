module Interpreter where

import General
import Instances
import InterpreterState
import Preprocessing
import PreprocessingState

import Data.Fixed (mod')
import Data.List
import qualified Data.Map as M
import Data.Sequence hiding (filter, lookup, null, reverse, unzip, zip)
import qualified Data.Set as S

import qualified AbsVarg as Abs
import Control.Exception.Base (SomeException, evaluate, try)
import Data.Char (chr, isUpper, ord)
import Data.Maybe
import System.Console.ANSI (clearScreen)

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
     evalStateT (runReaderT (interpretMain $ functionBody f) emptyRuntime) (emptyState list hier))

interpretMain :: Expr -> InterpreterMonad Instance
interpretMain body =
  let supplied = supplyArgs body
   in do interpreted <- deepForce =<< interpretExpression supplied
         liftIO $ logStderr $ "[[Raw result]]\n" ++ show interpreted ++ "\n\n"
         memoryUsage
         --return interpreted
         interpretExpression (EMember (EInterpreted interpreted) "toString") >>= deepForce

emptyState :: Type -> ClassHierarchy -> InterpreterState
emptyState listtype hier = InterpreterState hier 0 "Main.main" (M.insert 0 (emptyArgs listtype) M.empty) M.empty [1 ..]

emptyRuntime :: InterpreterRuntime
emptyRuntime =
  let env = M.insert "args" (Left 0) M.empty
   in InterpreterRuntime env voidType False M.empty

supplyArgs :: Expr -> Expr
supplyArgs main = EApply main (EVar "args")

emptyArgs :: Type -> Instance
emptyArgs listtype = TypeInstance listtype "Empty" [Template "List" [Primitive "Char"]] [] 0

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
  p1 <- interpretExpression expr1
  p2 <- interpretExpression expr2
  env <- resolveEnv =<< asks environment
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
    ("Call: " ++ show whole ++ "\nBound variables: " ++ show (M.toList env) ++ "\n")

-- auxiliary functions
intFun e f v1 v2 =
  liftIO (try (evaluate $ f v1 v2) :: IO (Either SomeException Integer)) >>= \case
    Left expr -> throw e (show expr)
    Right val -> return $ IntInstance val

doubleFun e f v1 v2 =
  liftIO (try (evaluate $ f v1 v2) :: IO (Either SomeException Double)) >>= \case
    Left expr -> throw e (show expr)
    Right val -> return $ DoubleInstance val

boolFun e f b1 b2 =
  liftIO (try (evaluate $ f b1 b2) :: IO (Either SomeException Bool)) >>= \case
    Left expr -> throw e (show expr)
    Right val -> return $ BoolInstance val

errFun e str _ _ = throw e str

getBaseType :: Instance -> InterpreterMonad Type
getBaseType =
  \case
    IntInstance {} -> intType
    DoubleInstance {} -> dblType
    CharInstance {} -> charType
    BoolInstance {} -> boolType
    FunctionInstance {} -> functionType
    TypeInstance {baseType = t} -> pure t
    UnboundVar {} -> undefined
    th@ThunkInstance {} -> force th >>= getBaseType

memoryUsage :: InterpreterMonad ()
memoryUsage =
  liftIO isTracingMemory >>= \case
    True -> do
      mem <- gets memory
      let toTypes = map snd $ M.toList mem
      mapped <-
        foldM
          (\mp inst -> do
             t <- getBaseType inst
             let name = qualifiedTypeName t
             return $ M.insertWith (\_ v -> v + 1) name 1 mp)
          M.empty
          toTypes
      liftIO $ putStrErr "[[Memory Usage]]\n"
      liftIO $ putStrErr $ concatMap (\(name, val) -> name ++ ": " ++ show val ++ " references\n") (M.toList mapped)
      liftIO $ putStrErr "\n"
    False -> pure ()

nativeStringToInstance :: String -> InterpreterMonad Instance
nativeStringToInstance str = do
  strtp <- strType
  let chars = map CharInstance str
  empty <- register $ TypeInstance strtp "Empty" [] []
  foldM (\inst ch -> register $ TypeInstance strtp "Cons" [] [("head", ch), ("tail", inst)]) empty (reverse chars)

findIfaceOrNativeMethod :: Instance -> String -> InterpreterMonad Instance
findIfaceOrNativeMethod obj name = do
  realtyp <- asks realType
  getIfaceMember realtyp name >>= \case
    Just member -> do
      Just o <- asks (M.lookup "this" . environment)
      local (exchangeEnvironment $ M.insert "this" o M.empty) (interpretExpression $ functionBody member)
    Nothing ->
      case obj of
        TypeInstance {} ->
          case name of
            "toString" -> nativeStringToInstance (show $ obj {baseType = realtyp})
            "toUTFCode" ->
              case lookup "value" (fields obj) of
                Just (CharInstance val) -> return $ IntInstance (toInteger $ ord val)
                _ -> throwException' "Call of toUTFCode on non-character"
            "codeToChar" ->
              case lookup "value" (fields obj) of
                Just (IntInstance val) -> return $ CharInstance (chr $ fromInteger val)
                _ -> throwException' "Call to codeToChar on non-integer"
            "floor" ->
              case lookup "value" (fields obj) of
                Just (DoubleInstance val) -> return $ IntInstance (floor val)
                _ -> throwException' "Call to floor on non-real type"
            "toReal" ->
              case lookup "value" (fields obj) of
                Just (IntInstance val) -> return $ DoubleInstance (fromIntegral val)
                _ -> throwException' "Call to toReal on non-integer"
            _ -> throwException' $ "Nonexistent native method " ++ name ++ "\n"
        _ -> throwException' "Interpreter error: findNativeMethod called on primitive / thunk"

deepForce :: Instance -> InterpreterMonad Instance
deepForce =
  \case
    ThunkInstance expr clos loc -> do
      forced <- local (exchangeEnvironment clos) (interpretExpression expr >>= force)
      modify $ putValue (loc, forced)
      deepForce forced
    t@TypeInstance {fields = flds, memoryLocation = loc} -> do
      let (names, insts) = unzip flds
      forcedInsts <- mapM deepForce insts
      let forced = t {fields = zip names forcedInsts}
      modify $ putValue (loc, forced)
      return forced
    a -> pure a

force' :: Instance -> InterpreterMonad Instance
force' =
  \case
    ThunkInstance expr clos loc -> do
      forced <- local (exchangeEnvironment clos) (interpretExpression expr)
      modify $ putValue (loc, forced)
      force forced
    a -> pure a

force :: Instance -> InterpreterMonad Instance
force =
  \case
    ThunkInstance expr clos loc -> do
      located <- deref loc
      forced <- force' located
      modify $ putValue (loc, forced)
      force forced
    a -> pure a

delay :: Expr -> InterpreterMonad Instance
delay expr =
  liftIO isVargLazy >>= \case
    True -> do
      addr <- nextFreeLoc
      env <- asks environment
      let thunk = ThunkInstance expr env addr
      modify $ putValue (addr, thunk)
      return thunk
    False -> interpretExpression expr

deepEq :: Instance -> Instance -> InterpreterMonad Bool
deepEq i1 i2 = deepEq' $ singleton (i1, i2)

deepEq' :: Seq (Instance, Instance) -> InterpreterMonad Bool -- BFS deepEquality on Sequence as Queue
deepEq' Empty = pure True
deepEq' ((inst1, inst2) :<| t) = do
  inst1f <- force inst1
  inst2f <- force inst2
  case (inst1f, inst2f) of
    (IntInstance v1, IntInstance v2) -> pure $ v1 == v2
    (DoubleInstance v1, DoubleInstance v2) -> pure $ v1 == v2
    (CharInstance c1, CharInstance c2) -> pure $ c1 == c2
    (BoolInstance b1, BoolInstance b2) -> pure $ b1 == b2
    (FunctionInstance f1 c1 _, FunctionInstance f2 c2 _) -> pure $ (f1 == f2) && (c1 == c2)
    (TypeInstance typ1 var1 _ f1 _, TypeInstance typ2 var2 _ f2 _) ->
      if typ1 /= typ2 || var1 /= var2
        then pure False
        else let tocheck = fromList $ zip (map snd f1) (map snd f2)
              in deepEq' (t >< tocheck)
    _ -> pure False

tryUnify :: Instance -> Instance -> InterpreterMonad (Maybe Environment)
tryUnify pattern with = tryUnify' $ singleton (pattern, with)

tryUnify' :: Seq (Instance, Instance) -> InterpreterMonad (Maybe Environment)
tryUnify' Empty = do
  env <- asks unifyingEnv
  resolved <- resolveEnv env
  liftIO $ logg $ "Match successful with " ++ show (M.toList resolved)
  return $ Just env
tryUnify' ((mpattern, mwith) :<| t) = do
  unif <- asks unifyingEnv
  pattern <- force mpattern
  with <- force mwith
  liftIO $ logg $ "\nTry match " ++ show pattern ++ " with " ++ show with
  resolved <- resolveEnv =<< asks environment
  liftIO $ logg $ "Resolved: " ++ show (M.toList resolved)
  case (pattern, with) of
    (UnboundVar name, val) ->
      if name == "_"
        then tryUnify' t
        else asks (M.lookup name . unifyingEnv) >>= -- double use of identifier
              \case
               Just oldval ->
                 resolve oldval >>= deepEq val >>= \case
                   True -> tryUnify' t -- match with old value, go further
                   False -> liftIO $ logg "Unify: no match with old value" >> pure Nothing
               Nothing -> local (bindUnifiedManagedVariable (name, val)) (tryUnify' t) -- bind var, go further
    (IntInstance v1, IntInstance v2) ->
      if v1 == v2
        then tryUnify' t
        else liftIO $ logg "Unify: int inequality" >> pure Nothing
    (DoubleInstance v1, DoubleInstance v2) ->
      if v1 == v2
        then tryUnify' t
        else liftIO $ logg "Unify: double inequality" >> pure Nothing
    (CharInstance c1, CharInstance c2) ->
      if c1 == c2
        then tryUnify' t
        else liftIO $ logg "Unify: char inequality" >> pure Nothing
    (BoolInstance b1, BoolInstance b2) ->
      if b1 == b2
        then tryUnify' t
        else liftIO $ logg "Unify: bool inequality" >> pure Nothing
    (FunctionInstance f1 c1 _, FunctionInstance f2 c2 _) --maybe try to unify envs? idk
     ->
      if (f1 == f2) && (c1 == c2)
        then tryUnify' t
        else liftIO $ logg "Unify: function inequality" >> pure Nothing
    (TypeInstance typ1 var1 _ f1 _, TypeInstance typ2 var2 _ f2 _) ->
      if typ1 /= typ2 || var1 /= var2
        then liftIO $ logg "Unify: type inequality" >> pure Nothing
        else let tocheck = fromList $ zip (map snd f1) (map snd f2)
              in tryUnify' (t >< tocheck)
    _ -> liftIO $ logg "Unify: other case" >> pure Nothing

getMember :: Instance -> String -> InterpreterMonad Instance
getMember obj name = do
  hier <- gets hierarchy
  typ <- getBaseType obj
  rtyp <- asks realType
  rethrow
    (case obj of
       TypeInstance {baseType = t, fields = f} ->
         if qualifiedTypeName t == "Void"
           then findIfaceOrNativeMethod obj name
           else case M.lookup name (typeMembers t) of
                  Just (Function _ fname _ _ body) -> do
                    Just o <- asks (M.lookup "this" . environment)
                    modify $ pushLambdaName $ qualifiedTypeName t ++ "." ++ name
                    rethrow (local (exchangeEnvironment (M.insert "this" o M.empty)) (delay body)) ("Call: " ++ fname)
                  Nothing ->
                    fmapMaybe
                      (lookup name f)
                      pure
                      (do supert <- getTypeFromDerivation $ supertype t
                          getMember (obj {baseType = supert}) name)
       IntInstance {} -- Actual boxing
        -> do
         intcl <- lookupTypeFromClassHierarchy "Int" hier
         getMember (TypeInstance intcl "" [] [("value", obj)] (-1)) name
       DoubleInstance {} -> do
         dblcl <- lookupTypeFromClassHierarchy "Real" hier
         getMember (TypeInstance dblcl "" [] [("value", obj)] (-1)) name
       BoolInstance {} -> do
         boolcl <- lookupTypeFromClassHierarchy "Bool" hier
         getMember (TypeInstance boolcl "" [] [("value", obj)] (-1)) name
       CharInstance {} -> do
         charcl <- lookupTypeFromClassHierarchy "Char" hier
         getMember (TypeInstance charcl "" [] [("value", obj)] (-1)) name
       FunctionInstance {} -> do
         charcl <- lookupTypeFromClassHierarchy "Function" hier
         getMember (TypeInstance charcl "" [] [("value", obj)] (-1)) name
       th@ThunkInstance {} -> do
         forced <- force th
         getMember forced name)
    ("Call to member `" ++
     qualifiedTypeName rtyp ++
     "." ++ name ++ "` in (possibly base) type " ++ qualifiedTypeName typ ++ " on object " ++ show obj)

fmapMaybe m f err =
  case m of
    Just val -> f val
    Nothing -> err

appFun :: Instance -> Instance -> Expr -> InterpreterMonad Instance
appFun inst argval expr =
  case inst of
    FunctionInstance Function {functionName = name, functionBody = ELambda argname _ _ body} envf _ ->
      if isManaged argval
        then local (exchangeEnvironment $ M.insert argname (Left $ address argval) envf) (interpretExpression body)
        else local (exchangeEnvironment $ M.insert argname (Right argval) envf) (interpretExpression body)
    th@ThunkInstance {} -> do
      forced <- force th
      appFun forced argval expr
    funval -> do
      env <- resolveEnv =<< asks environment
      funvalf <- deepForce funval
      argvalf <- deepForce argval
      throw
        expr
        ("One does not simply apply argument to a non-function. Functor: (=" ++
         show funvalf ++ "), argument: (=" ++ show argvalf ++ ")\nBound variables: " ++ show (M.toList env) ++ "\n")

interpretExpression :: Expr -> InterpreterMonad Instance
interpretExpression expr = do
  let throwe = throw expr
      binary = interpretBinaryArithmetic expr
      ifn = intFun expr
      dfn = doubleFun expr
      bfn = boolFun expr
      efn = errFun expr
  env <- asks environment
  resolved <- resolveEnv env
  hier <- gets hierarchy
  mem <- gets memory
  liftIO isTracingEvaluation >>= \case
    True ->
      liftIO $ do
        clearScreen
        putStrLn $ "Evaluating " ++ show expr ++ "\nBounded variables: \n"
        print (M.toList env)
        putStrLn $ "\nResolved: " ++ show (M.toList resolved)
        comm <- getLine
        if comm == "m"
          then putStrLn $ "\nStorage: " ++ show (M.toList mem)
          else pure ()
    False -> pure ()
  case expr of
    EAbstract -> throwe "Call to an abstract function"
    EInterpreted inst -> pure inst
    EInt val -> return $ IntInstance val
    EDouble val -> return $ DoubleInstance val
    EBool val -> return $ BoolInstance val
    EChar val -> return $ CharInstance val
    EString val -> nativeStringToInstance val
    EThis ->
      asks (M.lookup "this" . environment) >>= \case
        Nothing -> throwe "Referencing this from a static context"
        Just (Left loc) -> deref loc
        Just (Right val) -> pure val
    ESuper ->
      asks (M.lookup "super" . environment) >>= \case
        Nothing -> throwe "Referencing super from a static context"
        Just (Left loc) -> deref loc
        Just (Right val) -> pure val
    EWild ->
      asks isUnifying >>= \case
        True -> pure $ UnboundVar "_"
        False -> throwe "Unexpected wildcard when not unifying"
    EVar name ->
      asks (M.lookup name . environment) >>= \case
        Nothing ->
          asks isUnifying >>= \case
            False ->
              throwe
                (name ++
                 "? I have never seen this man in my life!\n I know only that " ++ show (M.toList resolved) ++ "\n")
            True -> pure $ UnboundVar name
        Just (Left loc) ->
          deref loc >>= \case
            th@ThunkInstance {} ->
              rethrow
                (force th)
                ("Evaluating thunk " ++ show expr ++ "\nBound variables: " ++ show (M.toList resolved) ++ "\n")
            val -> return val
        Just (Right val) -> pure val
    ELambda _ int out _ ->
      modify incrLambdaIdx >> gets nextLambdaName >>= \lname ->
        register $ FunctionInstance (Function [] lname int out expr) env
    EIfThenElse ife thene elsee ->
      rethrow (interpretExpression ife >>= force) ("Computing if condition " ++ show (show expr)) >>= \case
        BoolInstance True -> rethrow (interpretExpression thene) ("Computing then expression " ++ show (show thene))
        BoolInstance False -> rethrow (interpretExpression elsee) ("Computing else expression " ++ show (show elsee))
        res -> throwe ("Usage of invalid type (" ++ typeof res ++ ") in if clause")
    EApply fun arg ->
      rethrow
        (do funval <- interpretExpression fun
            argval <- delay arg
            appFun funval argval expr)
        ("Call apply: " ++ show fun ++ "(" ++ show arg ++ ")\nBound variables: " ++ show (M.toList resolved) ++ "\n")
    ELet name expr1 _ expr2 -- TODO: try to actually care about types
     -> do
      addr <- nextFreeLoc
      let nenv = M.insert name (Left addr) env -- bind as thunk, eval when needed as var, recursive def
      modify $ putValue (addr, ThunkInstance expr1 nenv addr)
      local (exchangeEnvironment nenv) (delay expr2)
    EMember (EClass tname) name ->
      gets (M.lookup (tname ++ "." ++ name) . evaluatedStaticMembers) >>= \case
        (Just val) -> deref val
        Nothing -> do
          t <- lookupTypeFromClassHierarchy tname hier
          evaluated <-
            if isUpper (head name) -- call constructor
              then do
                fieldsEx <- supertypeFieldTypes tname name
                let argstypes = zip argGen (map snd fieldsEx)
                let nargs = map (EVar . fst) argstypes
                interpretExpression
                  (fst $
                   foldr
                     (\(narg, typ) (expr, typename) ->
                        let ftype = ConcreteType "Function" [Exact typ, Exact typename]
                         in (ELambda narg typ ftype expr, ftype))
                     (EConstructor tname name nargs, ConcreteType tname [])
                     argstypes)
              else case M.lookup name (typeMembers t) of
                     Just (Function _ fname _ _ body) -> do
                       modify $ pushLambdaName $ qualifiedTypeName t ++ "." ++ name
                       rethrow
                         (local (unbindVariable "super" . unbindVariable "this") (interpretExpression body))
                         ("Call: " ++ fname)
                     Nothing -> throwe ("Call to nonexistent static method " ++ name ++ " of class " ++ tname)
          modify $ registerEvaluatedStaticMember (tname ++ "." ++ name, address evaluated)
          return evaluated
    EMember expr name ->
      rethrow
        (do obj <- force =<< interpretExpression expr
            typ <- getBaseType obj
            local (saveRealType typ . bindManagedVariable ("this", obj)) (getMember obj name))
        ("Computing member " ++
         show name ++ " of " ++ show (show expr) ++ "\nBound variables: " ++ show (M.toList resolved) ++ "\n")
    EConstructor tname var flds -- FIXME: It creates instances with no type params
     -> do
      typ <- lookupTypeFromClassHierarchy tname hier
      fieldsEx <- supertypeFieldTypes tname var
      vals <- mapM delay flds
      register $ TypeInstance typ var [] (zip (map fst fieldsEx) vals)
    -- arithmetic ops
    ENeg expr ->
      interpretExpression expr >>= force >>= \case
        IntInstance val -> return $ IntInstance (-val)
        DoubleInstance val -> return $ DoubleInstance (-val)
        _ -> throwException "You can only (-Int) or (-Double) dude."
    ENot expr ->
      interpretExpression expr >>= force >>= \case
        BoolInstance val -> return $ BoolInstance (not val)
        _ -> throwe ("You can only negate bools, change my mind\nTrying to negate " ++ show expr)
    EMod expr1 expr2 -> binary "mod" expr1 expr2 (ifn mod) (dfn mod') (efn "Roll safe, is moduling booleans ok?")
    EAdd expr1 expr2 -> binary "+" expr1 expr2 (ifn (+)) (dfn (+)) (efn "Roll safe, is adding booleans ok?")
    ESub expr1 expr2 -> binary "-" expr1 expr2 (ifn (-)) (dfn (-)) (efn "Roll safe, is subtracting booleans ok?")
    EOr expr1 expr2 --TODO: lazy evaluate boolean expressions (return true if first is already true etc.)
     ->
      binary
        "||"
        expr1
        expr2
        (efn "One does not simply alternate integers")
        (efn "One does not simply alternate doubles")
        (bfn (||))
    EAnd expr1 expr2 ->
      binary
        "&&"
        expr1
        expr2
        (efn "One does not simply conjunct integers")
        (efn "One does not simply conjunct doubles")
        (bfn (&&))
    EMul expr1 expr2 -> binary "*" expr1 expr2 (ifn (*)) (dfn (*)) (efn "Roll safe, is multiplying booleans ok?")
    EDiv expr1 expr2 -> binary "/" expr1 expr2 (ifn quot) (dfn (/)) (efn "Roll safe, is dividing booleans ok?")
    EPow expr1 expr2 -> binary "^" expr1 expr2 (ifn (^)) (dfn (**)) (bfn (/=))
    ELt expr1 expr2 -> binary "<" expr1 expr2 (bfn (<)) (bfn (<)) (efn "Roll safe, is comparing booleans ok?")
    EGt expr1 expr2 -> binary "<" expr1 expr2 (bfn (>)) (bfn (>)) (efn "Roll safe, is comparing booleans ok?")
    ELeq expr1 expr2 -> binary "<=" expr1 expr2 (bfn (<=)) (bfn (<=)) (efn "Roll safe, is comparing booleans ok?")
    EGeq expr1 expr2 -> binary ">=" expr1 expr2 (bfn (>=)) (bfn (>=)) (efn "Roll safe, is comparing booleans ok?")
    EEq expr1 expr2 -> do
      p1 <- delay expr1
      p2 <- delay expr2
      eq <- deepEq p1 p2
      return $ BoolInstance eq
    ENeq expr1 expr2 -> do
      BoolInstance val <- interpretExpression $ EEq expr1 expr2
      return $ BoolInstance (not val)
    ECons expr1 expr2 -> do
      p1 <- interpretExpression expr1
      p2 <- delay expr2
      list <- lookupTypeFromClassHierarchy "List" hier
      register $ TypeInstance list "Cons" [] [("head", p1), ("tail", p2)]
        -- FIXME: Hardcoded List.Cons erases types, but can we do better in lazy eval? See: ESCons
    ESCons expr1 expr2 -> delay $ EApply (EMember expr2 ":") expr1 -- Strict cons
    EComp expr1 expr2 -> delay $ EApply (EApply (EMember (EClass "Function") "composeI") expr1) expr2
    ERange expr1 expr2 ->
      delay $
      if expr2 == EWild
        then EMember expr1 "rangeFrom"
        else EApply (EMember expr1 "rangeTo") expr2
    EAppend expr1 expr2 -> delay $ EApply (EMember expr1 "++") expr2
    EUnify epattern ewith inexpr -> do
      pattern <- delay epattern
      with <- delay ewith
      local (setUnifying True) (tryUnify pattern with) >>= \case
        Nothing ->
          throwe $
          "Cannot unify " ++
          show (show pattern) ++
          " with " ++ show (show with) ++ ".\nBound variables: " ++ show (M.toList resolved) ++ "\n"
        Just substs -> local (mergeWithEnv substs) (interpretExpression inexpr)
    EMatch ewith [] ->
      throwe $
      "Irrefutable pattern match with " ++
      show (show ewith) ++ " failed.\nBound variables: " ++ show (M.toList resolved) ++ "\n"
    EMatch ewith ((epattern, ine):t) ->
      local
        (clearUnifyingEnv)
        (do pattern <- local (setUnifying True) (interpretExpression epattern)
            with <- force =<< delay ewith
            rethrow
              (local (setUnifying True) (tryUnify pattern with) >>= \case
                 Nothing -> interpretExpression $ EMatch ewith t
                 Just substs -> local (mergeWithEnv substs) (interpretExpression ine))
              ("Trying to match " ++
               show pattern ++ " with " ++ show with ++ "\nBound variables: " ++ show (M.toList resolved) ++ "\n"))
    EOperator op ->
      case op of
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
        Abs.Op_cons -> listop ECons "List.:"
        Abs.Op_scons -> listop ESCons "List.:"
        Abs.Op_appl -> funop "Function.call"
        Abs.Op_append -> listop EAppend "List.++"
    _ -> throwException $ "Cannot interpret expr " ++ show expr ++ ": not implemented\n"