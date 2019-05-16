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

import System.Environment
import System.Exit
import System.IO
import Types

import Text.Read

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

logStderr :: String -> IO ()
logStderr str =
  lookupEnv "VargVerbosity" >>= \case
    Nothing -> pure ()
    Just _ -> hPutStr stderr str

printErr :: (Show s) => s -> IO ()
printErr = logStderr . show

logg :: (Show s) => s -> IO ()
logg obj =
  lookupEnv "VargVerbosity" >>= \case
    Nothing -> pure ()
    Just _ -> print obj

usage :: String
usage = "Invalid arguments given. Usage: Varg [-h] [-v] [-dN] <program>"

parse :: String -> IO ()
parse "-h" = putStrLn usage >> exitSuccess
parse "-v" = setEnv "VargVerbosity" "1"
parse s =
  if take 2 s == "-d"
    then setEnv "VargTraceDepth" (drop 2 s)
    else setEnv "VargProg" s

program :: IO String
program =
  lookupEnv "VargProg" >>= \case
    Nothing -> pure "Main"
    Just prog -> pure prog

defaultTraceDepth :: IO Int
defaultTraceDepth =
  lookupEnv "VargTraceDepth" >>= \case
    Nothing -> pure 20
    Just val ->
      case readMaybe val :: Maybe Int of
        Just ival -> pure ival
        Nothing -> pure 20

throw offending message =
  throwException
    ("Interpreter exception: " ++
     message ++ "\nOffending expression: " ++ show offending ++ "\n\n---------- STACK TRACE ---------- \n\n")

throwException' ex = throwException (ex ++ "\n\n---------- STACK TRACE ---------- \n\n")

throwException ex = do
  d <- liftIO defaultTraceDepth
  throwError $ VargException ex d

rethrow inst trace =
  catchError
    inst
    (\case
       VargException reason 1 ->
         throwError $ VargException (reason ++ "---------- SOME MORE TRACE HIDDEN ----------" ++ "\n") 0
       VargException reason 0 -> throwError $ VargException reason 0
       VargException reason v -> throwError $ VargException (reason ++ trace ++ "\n") (v - 1))