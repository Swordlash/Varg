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

type Stub = (Int, DerivationKind, [DerivationKind], M.Map String String)

type Stubs = M.Map TypeName Stub

type ClassHierarchy = S.Set Type

type ClassContents = (S.Set Variant, S.Set Function)

data PreprocessState = PreprocessState
  { classStubs          :: Stubs
  , freshParamIdx       :: Int
  , templateParamSubsts :: M.Map String String
  }

data HierarchyState = HierarchyState
  { preparsedStubs :: Stubs
  , classHierarchy :: ClassHierarchy
  }

registerStub :: (String, Int, DerivationKind, [DerivationKind]) -> PreprocessState -> PreprocessState
registerStub (name, params, deriv, impls) (PreprocessState s i t) =
  PreprocessState (M.insert name (params, deriv, impls, t) s) 0 M.empty

emptyPreprocessState :: PreprocessState
emptyPreprocessState = PreprocessState M.empty 0 M.empty

emptyHierarchyState :: HierarchyState
emptyHierarchyState = HierarchyState M.empty S.empty

removeParamSubsts :: PreprocessState -> PreprocessState
removeParamSubsts (PreprocessState s h _) = PreprocessState s 0 M.empty

registerClass :: Type -> HierarchyState -> HierarchyState
registerClass typ (HierarchyState s h) = HierarchyState s (S.insert typ h)

incrParamIdx :: PreprocessState -> PreprocessState
incrParamIdx (PreprocessState s i t) = PreprocessState s (i + 1) t

addSubst :: String -> String -> PreprocessState -> PreprocessState
addSubst name alias (PreprocessState s i t) = PreprocessState s i (M.insert name alias t)

bindName :: String -> PreprocessState -> PreprocessState
bindName name (PreprocessState s i t) = PreprocessState s (i + 1) (M.insert name ("_t" ++ show i) t)

data PreprocessRuntime = PreprocessRuntime
  { currentPreparsedTypeName :: TypeName
  }

data HierarchyRuntime = HierarchyRuntime
  { currentParsedTypeName       :: TypeName
  , currentParsedTypeConstrName :: String
  , currentParsedTypeVariant    :: MemberName
  , currentParsedField          :: MemberName
  }

emptyPreprocessRuntime :: PreprocessRuntime
emptyPreprocessRuntime = PreprocessRuntime ""

emptyHierarchyRuntime :: HierarchyRuntime
emptyHierarchyRuntime = HierarchyRuntime "" "" "" ""

setPreparsedTypeName :: TypeName -> PreprocessRuntime -> PreprocessRuntime
setPreparsedTypeName name _ = PreprocessRuntime name

setParsedTypeVariant :: MemberName -> HierarchyRuntime -> HierarchyRuntime
setParsedTypeVariant vname (HierarchyRuntime name constr _ fld) = HierarchyRuntime name constr vname fld

setParsedTypeName :: TypeName -> HierarchyRuntime -> HierarchyRuntime
setParsedTypeName name (HierarchyRuntime _ c v f) = HierarchyRuntime name c v f

setParsedField :: MemberName -> HierarchyRuntime -> HierarchyRuntime
setParsedField fld (HierarchyRuntime n c v _) = HierarchyRuntime n c v fld

setParsedTypeConstrName :: String -> HierarchyRuntime -> HierarchyRuntime
setParsedTypeConstrName name (HierarchyRuntime n _ v f) = HierarchyRuntime n name v f

type ParserLog = String

type ParserMonad a b c = ReaderT a (StateT b (WriterT ParserLog (ExceptT ParseException Identity))) c

type PreprocessMonad c = ParserMonad PreprocessRuntime PreprocessState c

type HierarchyMonad c = ParserMonad HierarchyRuntime HierarchyState c
