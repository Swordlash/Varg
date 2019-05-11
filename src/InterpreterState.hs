module InterpreterState
  ( module Control.Monad.Except
  , module Control.Monad.Reader
  , module Control.Monad.State
  , module Control.Monad.Writer
  , module Control.Monad.Identity
  , module Types
  , module InterpreterState
  ) where

import qualified Data.Map               as M
import qualified Data.Set               as S

import           Control.Monad.Except
import           Control.Monad.Identity
import           Control.Monad.Reader
import           Control.Monad.State
import           Control.Monad.Writer   hiding (Any)
import           Types

import           Data.List              (find)
import           Data.Maybe             (fromJust, isJust)

newtype ParseException = ParseException
  { reason :: String
  } deriving (Eq, Ord)

instance Show ParseException where
  show (ParseException reason) = "ParseException: " ++ reason

type ParseMonad = Either ParseException

type Substitutions = M.Map String String

type Constraints = M.Map String [TypeParamConstraint]

type Stub = (Int, DerivationKind, [DerivationKind], Substitutions)

type Stubs = M.Map TypeName Stub

type ClassHierarchy = S.Set Type

type ClassContents = (S.Set Variant, S.Set Function)

type LookupFunction = String -> Maybe String

type ConstrLookupFunction = String -> Maybe [TypeParamConstraint]

type Notifier a = a -> a

type Updater a b = a -> b -> b

data PreprocessState = PreprocessState
  { classStubs          :: Stubs
  , freshParamIdx       :: Int
  , templateParamSubsts :: Substitutions
  }

data HierarchyState = HierarchyState
  { preparsedStubs          :: Stubs
  , classHierarchy          :: ClassHierarchy
  , templateFunctionSubsts  :: Substitutions
  , templateParamConstrains :: Constraints
  }

registerStub :: Updater (String, Int, DerivationKind, [DerivationKind]) PreprocessState
registerStub (name, params, deriv, impls) (PreprocessState s _ t) =
  PreprocessState (M.insert name (params, deriv, impls, t) s) 0 M.empty

emptyPreprocessState :: PreprocessState
emptyPreprocessState = PreprocessState M.empty 0 M.empty

emptyHierarchyState :: HierarchyState
emptyHierarchyState = HierarchyState M.empty S.empty M.empty M.empty

removeParamSubsts :: Notifier PreprocessState
removeParamSubsts (PreprocessState s h _) = PreprocessState s 0 M.empty

registerClass :: Updater Type HierarchyState
registerClass typ (HierarchyState s h _ _) = HierarchyState s (S.insert typ h) M.empty M.empty

incrParamIdx :: Notifier PreprocessState
incrParamIdx state = state {freshParamIdx = freshParamIdx state + 1}

addSubst :: Updater (String, String) PreprocessState
addSubst (name, alias) state = state {templateParamSubsts = M.insert name alias $ templateParamSubsts state}

bindName :: Updater String PreprocessState
bindName name (PreprocessState s i t) = PreprocessState s (i + 1) (M.insert name ("_t" ++ show i) t)

registerTemplateFunctionSubst :: Updater String HierarchyState
registerTemplateFunctionSubst name state =
  let alias = "_tf" ++ show (M.size $ templateFunctionSubsts state)
   in registerTemplateFunctionSubst1 (name, alias) state

registerTemplateFunctionSubst1 :: Updater (String, String) HierarchyState
registerTemplateFunctionSubst1 (name, alias) state =
  state {templateFunctionSubsts = M.insert name alias $ templateFunctionSubsts state}

removeTemplateFunctionSubsts :: Notifier HierarchyState
removeTemplateFunctionSubsts state = state {templateFunctionSubsts = M.empty}

registerTemplateParamConstraints :: Updater (String, [TypeParamConstraint]) HierarchyState
registerTemplateParamConstraints (alias, consts) state =
  state {templateParamConstrains = M.insert alias consts $ templateParamConstrains state}

newtype PreprocessRuntime = PreprocessRuntime
  { currentPreparsedTypeName :: TypeName
  }

data HierarchyRuntime = HierarchyRuntime
  { currentParsedTypeName       :: TypeName
  , currentParsedTypeConstrName :: String
  , currentParsedTypeVariant    :: MemberName
  , currentParsedMember         :: MemberName
  , currentCurryingDepth        :: Int
  , currentFunArgsSubsts        :: Substitutions
  }

getLastTypeParam :: PreprocessState -> String
getLastTypeParam (PreprocessState _ i _) = "_t" ++ show i

emptyPreprocessRuntime :: PreprocessRuntime
emptyPreprocessRuntime = PreprocessRuntime ""

emptyHierarchyRuntime :: HierarchyRuntime
emptyHierarchyRuntime = HierarchyRuntime "" "" "" "" 0 M.empty

setPreparsedTypeName :: Updater TypeName PreprocessRuntime
setPreparsedTypeName name _ = PreprocessRuntime name

setParsedTypeVariant :: Updater MemberName HierarchyRuntime
setParsedTypeVariant vname state = state {currentParsedTypeVariant = vname}

setParsedTypeName :: Updater TypeName HierarchyRuntime
setParsedTypeName name state = state {currentParsedTypeName = name}

setParsedMember :: Updater MemberName HierarchyRuntime
setParsedMember fld state = state {currentParsedMember = fld}

setParsedTypeConstrName :: Updater String HierarchyRuntime
setParsedTypeConstrName name state = state {currentParsedTypeConstrName = name}

incrCurrentCurryingDepth :: Notifier HierarchyRuntime
incrCurrentCurryingDepth r = r {currentCurryingDepth = currentCurryingDepth r + 1}

setCurrentFunArgSubsts :: Updater Substitutions HierarchyRuntime
setCurrentFunArgSubsts s r = r {currentFunArgsSubsts = s}

type ParserLog = String

type ParserMonad a b c = ReaderT a (StateT b (WriterT ParserLog (ExceptT ParseException Identity))) c

type PreprocessMonad c = ParserMonad PreprocessRuntime PreprocessState c

type HierarchyMonad c = ParserMonad HierarchyRuntime HierarchyState c

readSubstsFromCurrentStub :: HierarchyMonad LookupFunction
readSubstsFromCurrentStub = do
  tname <- asks currentParsedTypeName
  readSubstsFromStub tname

readSubstsFromStub :: TypeName -> HierarchyMonad LookupFunction
readSubstsFromStub tname = do
  substs <- gets ((\(_, _, _, s) -> s) . fromJust . M.lookup tname . preparsedStubs)
  return $ flip M.lookup substs

readFunctionSubsts :: HierarchyMonad LookupFunction
readFunctionSubsts = do
  substs <- gets templateFunctionSubsts
  return $ flip M.lookup substs

combineLookups :: [a -> Maybe b] -> (a -> Maybe b)
combineLookups lookups name =
  let results = map ($ name) lookups
   in fromJust <$> find isJust results
