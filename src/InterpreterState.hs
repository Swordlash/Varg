module InterpreterState where

import qualified Data.Map as M
import General
import PreprocessingState

type Environment = Closure

data InterpreterState = InterpreterState
  { hierarchy :: ClassHierarchy
  , lambdaIndex :: Int
  , pushName :: String
  , memory :: M.Map Loc Instance
  , freeChunks :: [Int]
  }

data InterpreterRuntime = InterpreterRuntime
  { environment :: Environment
  , realType :: Type
  , isUnifying :: Bool
  }

type InterpreterMonad a = VargStatefulMonad InterpreterRuntime InterpreterState a

exchangeEnvironment :: Updater Environment InterpreterRuntime
exchangeEnvironment nenv runt = runt {environment = nenv}

address :: Instance -> Int
address (IntInstance _ loc) = loc
address (DoubleInstance _ loc) = loc
address (CharInstance _ loc) = loc
address (BoolInstance _ loc) = loc
address (FunctionInstance _ _ loc) = loc
address (ThunkInstance _ _ loc) = loc
address t@TypeInstance {} = memoryLocation t

nextFreeLoc :: InterpreterMonad Int
nextFreeLoc = do
  elem:chunks <- gets freeChunks
  modify $ updateChunks chunks
  return elem

lookupInst :: String -> InterpreterMonad (Maybe Instance)
lookupInst name =
  asks (M.lookup name . environment) >>= \case
    Nothing -> return Nothing
    Just loc -> gets (M.lookup loc . memory)

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

deref :: Loc -> InterpreterMonad Instance
deref loc =
  gets (M.lookup loc . memory) >>= \case
    Just val -> pure val
    Nothing -> do
      mem <- gets (M.toList . memory)
      throwException' $ "Dereferencing nonexistent location " ++ show loc ++ "\nMemory: " ++ show mem

resolveEnv :: Environment -> InterpreterMonad (Mapping Instance)
resolveEnv env = do
  mem <- gets memory
  return $ M.mapMaybe (`M.lookup` mem) env

updateChunks :: Updater [Int] InterpreterState
updateChunks chunks stat = stat {freeChunks = chunks}

bindVariable :: Updater (String, Loc) InterpreterRuntime
bindVariable (name, loc) runt = runt {environment = M.insert name loc $ environment runt}

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
intType = gets hierarchy >>= lookupTypeFromClassHierarchy "Integer"

dblType :: InterpreterMonad Type
dblType = gets hierarchy >>= lookupTypeFromClassHierarchy "Double"

boolType :: InterpreterMonad Type
boolType = gets hierarchy >>= lookupTypeFromClassHierarchy "Bool"

charType :: InterpreterMonad Type
charType = gets hierarchy >>= lookupTypeFromClassHierarchy "Char"

functionType :: InterpreterMonad Type
functionType = gets hierarchy >>= lookupTypeFromClassHierarchy "Function"

strType :: InterpreterMonad Type
strType = gets hierarchy >>= lookupTypeFromClassHierarchy "String"