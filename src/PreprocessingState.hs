{-# LANGUAGE FlexibleContexts #-}

module PreprocessingState
  ( module Control.Monad.Except
  , module Control.Monad.Reader
  , module Control.Monad.State
  , module Control.Monad.Writer
  , module Control.Monad.Identity
  , module Types
  , module PreprocessingState
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
import           Data.Maybe             (fromJust, fromMaybe, isJust)

newtype VargException =
  VargException String
  deriving (Eq, Ord)

instance Show VargException where
  show (VargException reason) = "VargException: " ++ reason

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

data PreprocessState = PreprocessState
  { classStubs          :: Stubs
  , freshParamIdx       :: Int
  , templateParamSubsts :: Substitutions
  }

data HierarchyState = HierarchyState
  { preparsedStubs          :: Stubs
  , preClassHierarchy       :: ClassHierarchy
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
  }

getLastTypeParam :: PreprocessState -> String
getLastTypeParam (PreprocessState _ i _) = "_t" ++ show i

emptyPreprocessRuntime :: PreprocessRuntime
emptyPreprocessRuntime = PreprocessRuntime ""

emptyHierarchyRuntime :: HierarchyRuntime
emptyHierarchyRuntime = HierarchyRuntime "" "" "" ""

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

type Log = String

type VargMonad a b c = ReaderT a (StateT b (WriterT Log (ExceptT VargException Identity))) c

type PreprocessMonad c = VargMonad PreprocessRuntime PreprocessState c

type HierarchyMonad c = VargMonad HierarchyRuntime HierarchyState c

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

--lookupVariantFromType :: TypeName -> Type -> VargExceptionMonad Variant
lookupVariantFromType name Type {qualifiedTypeName = n, typeVariants = v} =
  let cand = emptyVariant name
   in if S.member cand v
        then pure $ fromJust $ S.lookupGE cand v
        else throwError $ VargException $ "Cannot find variant " ++ name ++ " of type " ++ n

--lookupTypeFromClassHierarchy :: TypeName -> ClassHierarchy -> VargExceptionMonad Type
lookupTypeFromClassHierarchy name hier =
  if S.member (emptyType name) hier
    then pure $ fromJust $ S.lookupGE (emptyType name) hier
    else throwError $
         VargException $
         "Cannot find type of name " ++ name ++ ". Registered classes: " ++ show (map qualifiedTypeName $ S.toList hier)

--lookupFunctionFromType :: MemberName -> Type -> VargExceptionMonad Function
lookupFunctionFromType name typ =
  case M.lookup name (typeMembers typ) of
    Just elem -> pure elem
    Nothing -> throwError $ VargException $ "Cannot find method " ++ name ++ " in type " ++ qualifiedTypeName typ
