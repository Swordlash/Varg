module InterpreterState where

import qualified Data.Map               as M
import qualified Data.Set               as S

import           Types

import           Control.Monad.Except
import           Control.Monad.Identity
import           Control.Monad.Reader
import           Control.Monad.State
import           Control.Monad.Writer

newtype ParseException = ParseException
  { reason :: String
  } deriving (Eq, Ord)

instance Show ParseException where
  show (ParseException reason) = "ParseException: " ++ reason

type ParseMonad = Either ParseException

data ParserState = ParserState
  { classStubs          :: M.Map String (Int, DerivationKind, [DerivationKind])
  , classHierarchy      :: S.Set Type
  , freshParamIdx       :: Int
  , templateParamSubsts :: M.Map String String
  }

registerStub :: (String, Int, DerivationKind, [DerivationKind]) -> ParserState -> ParserState
registerStub (name, params, deriv, impls) (ParserState s h i t) =
  ParserState (M.insert name (params, deriv, impls) s) h 0 M.empty

emptyParserState :: ParserState
emptyParserState = ParserState M.empty S.empty 0 M.empty

removeParamSubsts :: ParserState -> ParserState
removeParamSubsts (ParserState s h _ _) = ParserState s h 0 M.empty

registerClass :: Type -> ParserState -> ParserState
registerClass typ (ParserState s h _ _) = ParserState s (S.insert typ h) 0 M.empty

incrParamIdx :: ParserState -> ParserState
incrParamIdx (ParserState s h i t) = ParserState s h (i + 1) t

addSubst :: String -> String -> ParserState -> ParserState
addSubst name alias (ParserState s h i t) = ParserState s h i (M.insert name alias t)

bindName :: String -> ParserState -> ParserState
bindName name (ParserState s h i t) = ParserState s h (i + 1) (M.insert name ("_t" ++ show i) t)

data ParserRuntime = ParserRuntime
  { currentParsedTypeName :: TypeName
  }

emptyParserRuntime :: ParserRuntime
emptyParserRuntime = ParserRuntime ""

setParsedTypeName :: TypeName -> ParserRuntime -> ParserRuntime
setParsedTypeName name _ = ParserRuntime name

type ParserLog = String

type ParserT a = ReaderT ParserRuntime (StateT ParserState (WriterT ParserLog (ExceptT ParseException Identity))) a
