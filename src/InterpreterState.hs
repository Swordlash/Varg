{-  Interpreter module
    Definition of InterpreterMonad and its state manipulation -}
module InterpreterState where

import qualified Data.Map as M
import Data.Maybe (catMaybes, fromJust, isJust)
import General
import PreprocessingState

type Closure = Clos Instance

type Environment = Closure

data InterpreterState = InterpreterState
  { hierarchy :: ClassHierarchy
  , lambdaIndex :: Int
  , pushName :: String
  , memory :: M.Map Loc Instance
  , evaluatedStaticMembers :: M.Map String Loc
  , freeChunks :: [Int]
  }

data InterpreterRuntime = InterpreterRuntime
  { environment :: Environment
  , realType :: Type
  , isUnifying :: Bool
  , unifyingEnv :: Environment
  }

type InterpreterMonad a = VargStatefulMonad InterpreterRuntime InterpreterState a

exchangeEnvironment :: Updater Environment InterpreterRuntime
exchangeEnvironment nenv runt = runt {environment = nenv}

setUnifying :: Updater Bool InterpreterRuntime
setUnifying isunifying runt = runt {isUnifying = isunifying}

registerEvaluatedStaticMember :: Updater (String, Loc) InterpreterState
registerEvaluatedStaticMember (name, loc) st =
  st {evaluatedStaticMembers = M.insert name loc $ evaluatedStaticMembers st}

nextFreeLoc :: InterpreterMonad Int
nextFreeLoc = do
  elem:chunks <- gets freeChunks
  modify $ updateChunks chunks
  return elem

lookupInst :: String -> InterpreterMonad (Maybe Instance)
lookupInst name =
  asks (M.lookup name . environment) >>= \case
    Nothing -> return Nothing
    Just (Left loc) -> gets (M.lookup loc . memory)
    Just (Right val) -> return $ Just val

register constr = do
  addr <- nextFreeLoc
  let obj = constr addr
  modify $ putValue (addr, obj)
  return obj

putValue :: Updater (Loc, Instance) InterpreterState
putValue (loc, val) st = st {memory = M.insert loc val $ memory st}

free :: Updater Loc InterpreterState
free loc st = st {memory = M.delete loc $ memory st, freeChunks = loc : freeChunks st}

malloc :: Instance -> InterpreterMonad Int
malloc val = do
  newloc <- nextFreeLoc
  modify $ putValue (newloc, val)
  return newloc

resolve :: Either Loc Instance -> InterpreterMonad Instance
resolve (Left loc) = deref loc
resolve (Right inst) = pure inst

deref :: Loc -> InterpreterMonad Instance
deref loc =
  gets (M.lookup loc . memory) >>= \case
    Just val -> pure val
    Nothing -> do
      mem <- gets (M.toList . memory)
      throwException' $ "Dereferencing nonexistent location " ++ show loc ++ "\nMemory: " ++ show mem

resolveEnv :: Environment -> InterpreterMonad (Mapping Instance)
resolveEnv map = do
  mem <- gets memory
  let (lefts, rights) = M.mapEither id map
  let resolvedLefts = M.mapMaybe (`M.lookup` mem) lefts
  return $ M.union resolvedLefts rights

resolveName :: String -> InterpreterMonad (Maybe Instance)
resolveName name =
  asks (M.lookup name . environment) >>= \case
    Nothing -> pure Nothing
    Just (Left loc) ->
      gets (M.lookup loc . memory) >>= \case
        Nothing -> return Nothing
        val -> return val
    Just (Right val) -> pure $ Just val

updateChunks :: Updater [Int] InterpreterState
updateChunks chunks stat = stat {freeChunks = chunks}

clearUnifyingEnv :: Notifier InterpreterRuntime
clearUnifyingEnv runt = runt {unifyingEnv = M.empty}

bindVariableLoc :: Updater (String, Loc) InterpreterRuntime
bindVariableLoc (name, loc) runt = runt {environment = M.insert name (Left loc) $ environment runt}

bindVariable :: Updater (String, Instance) InterpreterRuntime
bindVariable (name, inst) runt = runt {environment = M.insert name (Right inst) $ environment runt}

bindManagedVariable :: Updater (String, Instance) InterpreterRuntime
bindManagedVariable (name, inst) runt =
  runt
    { environment =
        M.insert
          name
          (if isManaged inst
             then Left $ address inst
             else Right inst) $
        environment runt
    }

bindUnifiedManagedVariable :: Updater (String, Instance) InterpreterRuntime
bindUnifiedManagedVariable (name, inst) runt =
  runt
    { unifyingEnv =
        M.insert
          name
          (if isManaged inst
             then Left $ address inst
             else Right inst) $
        unifyingEnv runt
    }

unbindVariable :: Updater String InterpreterRuntime
unbindVariable name runt = runt {environment = M.delete name $ environment runt}

mergeWithEnv :: Updater Environment InterpreterRuntime
mergeWithEnv nenv runt = runt {environment = M.union nenv $ environment runt}

pushLambdaName :: Updater String InterpreterState
pushLambdaName name st = st {pushName = name}

saveRealType :: Updater Type InterpreterRuntime
saveRealType typ runt = runt {realType = typ}

incrLambdaIdx :: Notifier InterpreterState
incrLambdaIdx st =
  if pushName st == ""
    then st {lambdaIndex = lambdaIndex st + 1}
    else st {pushName = ""}

nextLambdaName :: InterpreterState -> String
nextLambdaName st =
  if pushName st == ""
    then "lambda@" ++ show (lambdaIndex st)
    else pushName st

----------------------------------- some type functions ---------------------------------
intType :: InterpreterMonad Type
intType = gets hierarchy >>= lookupTypeFromClassHierarchy "Int"

dblType :: InterpreterMonad Type
dblType = gets hierarchy >>= lookupTypeFromClassHierarchy "Real"

boolType :: InterpreterMonad Type
boolType = gets hierarchy >>= lookupTypeFromClassHierarchy "Bool"

charType :: InterpreterMonad Type
charType = gets hierarchy >>= lookupTypeFromClassHierarchy "Char"

functionType :: InterpreterMonad Type
functionType = gets hierarchy >>= lookupTypeFromClassHierarchy "Function"

strType :: InterpreterMonad Type
strType = gets hierarchy >>= lookupTypeFromClassHierarchy "String"

supertypeFieldTypes :: TypeName -> TypeName -> InterpreterMonad [(String, TypeDef)]
supertypeFieldTypes name varname =
  if name == "Void" || varname == ""
    then pure []
    else do
      hier <- gets hierarchy
      typ <- lookupTypeFromClassHierarchy name hier
      supertyp <- getTypeFromDerivation (supertype typ)
      var <- lookupVariantFromType varname typ
      superfields <- supertypeFieldTypes (qualifiedTypeName supertyp) (supervariant var)
      let fieldtypes = map (\(s, f) -> (s, functionOutputType f)) (variantFields var)
      return $ superfields ++ fieldtypes

supertypeFieldCount name varname = length <$> supertypeFieldTypes name varname

getTypeFromDerivation :: DerivationKind -> InterpreterMonad Type
getTypeFromDerivation (Concrete name _) = gets hierarchy >>= lookupTypeFromClassHierarchy name
getTypeFromDerivation (Unbound _) = throwException' "Unbound derivation not implemented yet."

getIfaceMember :: Type -> String -> InterpreterMonad (Maybe Function)
getIfaceMember t name =
  if qualifiedTypeName t == "Void"
    then pure Nothing
    else let found = M.lookup name (typeMembers t)
          in if isJust found && functionBody (fromJust found) /= EAbstract
               then pure found
               else if qualifiedTypeName t == "Function"
                      then pure Nothing
                      else do
                        superIfaces <- mapM getTypeFromDerivation (implementing t)
                        superFound <- mapM (`getIfaceMember` name) superIfaces
                        let superNotAbstract = filter (\f -> functionBody f /= EAbstract) (catMaybes superFound)
                        return $
                          if null superNotAbstract
                            then Nothing
                            else Just $ head superNotAbstract

numType = ConcreteType "Num" []

funType a b = ConcreteType "Function" [Exact a, Exact b]

anyType = AnyType

listAny = ConcreteType "List" [Any]

anyop op n =
  gets (M.lookup n . evaluatedStaticMembers) >>= \case
    Just val -> deref val
    Nothing -> do
      evaled <-
        register $
        FunctionInstance
          (Function
             []
             n
             AnyType
             (funType AnyType AnyType)
             (ELambda "x" AnyType (funType AnyType AnyType) $ ELambda "y" AnyType AnyType $ op (EVar "x") (EVar "y")))
          M.empty
      modify $ registerEvaluatedStaticMember (n, address evaled)
      return evaled

numop op n =
  gets (M.lookup n . evaluatedStaticMembers) >>= \case
    Just val -> deref val
    Nothing -> do
      env <- asks environment
      evaled <-
        register $
        FunctionInstance
          (Function
             []
             n
             numType
             (funType numType numType)
             (ELambda "x" numType (funType numType numType) $ ELambda "y" numType numType $ op (EVar "x") (EVar "y")))
          env
      modify $ registerEvaluatedStaticMember (n, address evaled)
      return evaled

listop op n =
  gets (M.lookup n . evaluatedStaticMembers) >>= \case
    Just val -> deref val
    Nothing -> do
      evaled <-
        register $
        FunctionInstance
          (Function
             []
             n
             listAny
             (funType listAny listAny)
             (ELambda "x" listAny (funType AnyType listAny) $ ELambda "y" listAny listAny $ op (EVar "x") (EVar "y")))
          M.empty
      modify $ registerEvaluatedStaticMember (n, address evaled)
      return evaled

funop n =
  gets (M.lookup n . evaluatedStaticMembers) >>= \case
    Just val -> deref val
    Nothing -> do
      evaled <-
        register $
        FunctionInstance
          (Function
             []
             n
             (funType AnyType AnyType)
             (funType AnyType AnyType)
             (ELambda
                "f"
                (funType AnyType AnyType)
                (funType AnyType AnyType)
                (ELambda "x" AnyType AnyType (EApply (EVar "f") (EVar "x")))))
          M.empty
      modify $ registerEvaluatedStaticMember (n, address evaled)
      return evaled
-----------------------------------------------------------------------------------------------------