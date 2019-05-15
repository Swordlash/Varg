module General
  ( module Control.Monad.Except
  , module Control.Monad.Reader
  , module Control.Monad.State
  , module Control.Monad.Writer
  , module Control.Monad.Identity
  , module General
  , module Types
  ) where

import Control.Monad.Except
import Control.Monad.Identity
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Writer hiding (Any)

import Types

import qualified Data.Map as M
import qualified Data.Set as S

data VargException = VargException
  { reason :: String
  , traceDepth :: Int
  } deriving (Eq, Ord)

instance Show VargException where
  show v = "VargException: " ++ reason v

type VargExceptionMonad = Either VargException

type Substitutions = Mapping String

type Constraints = Mapping [TypeParamConstraint]

type Stub = (Int, DerivationKind, [DerivationKind], Substitutions)

type Stubs = M.Map TypeName Stub

type ClassHierarchy = S.Set Type

type ClassContents = (S.Set Variant, Mapping Function)

type LookupFunction = String -> Maybe String

type ConstrLookupFunction = String -> Maybe [TypeParamConstraint]

type Notifier a = a -> a

type Updater a b = a -> b -> b

type VargMonad = ExceptT VargException IO

type VargStatefulMonad a b c = ReaderT a (StateT b VargMonad) c

throw offending message =
  throwException
    ("Interpreter exception: " ++
     message ++ "\nOffending expression: " ++ show offending ++ "\n\n---------- STACK TRACE ---------- \n\n")

throwException' ex = throwException (ex ++ "\n\n---------- STACK TRACE ---------- \n\n")

throwException ex = throwError $ VargException ex 20

rethrow inst trace =
  catchError
    inst
    (\case
       VargException reason 1 ->
         throwError $ VargException (reason ++ "---------- SOME MORE TRACE HIDDEN ----------" ++ "\n") 0
       VargException reason 0 -> throwError $ VargException reason 0
       VargException reason v -> throwError $ VargException (reason ++ trace ++ "\n") (v - 1))