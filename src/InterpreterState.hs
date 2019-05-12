module InterpreterState where

import           Instances
import           PreprocessingState
import           Types

type Closure = Clos Expr Type

type Environment = Closure

data InterpreterState = InterpreterState
  { classHierarchy :: ClassHierarchy
  }

data InterpreterRuntime = InterpreterRuntime
  { environment :: Environment
  }

type InterpreterMonad a = VargMonad InterpreterRuntime InterpreterState a
