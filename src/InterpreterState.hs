module InterpreterState where

import qualified Data.Map           as M
import           Instances
import           PreprocessingState
import           Types

type Closure = Clos Function Type Expr

type Environment = Closure

data InterpreterState = InterpreterState
  { hierarchy   :: ClassHierarchy
  , lambdaIndex :: Int
  , pushName    :: String
  }

data InterpreterRuntime = InterpreterRuntime
  { environment :: Environment
  , realType    :: Type
  , isUnifying  :: Bool
  }

type InterpreterMonad a = VargStatefulMonad InterpreterRuntime InterpreterState a

exchangeEnvironment :: Updater Environment InterpreterRuntime
exchangeEnvironment nenv runt = runt {environment = nenv}

bindVariable :: Updater (String, Instance) InterpreterRuntime
bindVariable (name, inst) runt = runt {environment = M.insert name inst $ environment runt}

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
