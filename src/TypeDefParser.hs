{-  Source parsing module
    Parsing type definitions (deriving, super etc.) -}
module TypeDefParser where

import           PreprocessingState
import           Types

import           PrintVarg

import qualified AbsVarg            as Abs
import qualified Data.Map           as M
import qualified Data.Set           as S

import           Data.Maybe

readModifier :: Abs.ClassModifier -> HierarchyMonad TypeModifier
readModifier Abs.ClassModifier_sealed    = pure SealedType
readModifier Abs.ClassModifier_interface = pure InterfaceType
readModifier Abs.ClassModifier_module    = pure ModuleType
readModifier Abs.ClassModifier_native    = pure NativeType

{- TODO FIXME Lookup passing is redundant, could be included in the MonadReader environment
   TODO it appears here, in FunctionParser and Expressions -}
registerConstrainedTypeName ::
     Lookup
  -> Updater String HierarchyState
  -> Abs.ConstrTypeParam
  -> HierarchyMonad (String, [TypeParamConstraint])
registerConstrainedTypeName lookupFun updater constr = do
  name <- asks currentParsedTypeName
  fname <- asks currentParsedMember
  let errMsg = "In definition of template constraint for " ++ name ++ "." ++ fname ++ ": "
  
  tlookup <- gets templateFunctionSubsts
  let newlookup = combineLookups [tlookup, lookupFun]
  case constr of
    Abs.InferredTypeParam (Abs.LIdent name)
     -> do
      modify $ updater name
      let subst = fromJust $ M.lookup name newlookup
      liftIO $ logStderr $ "Bound " ++ subst ++ " to " ++ name ++ "\n"
      return (subst, [])
    Abs.DerivingConstrainedTypeParam (Abs.LIdent name) typedefs
     -> do
      modify $ updater name
      let subst = fromJust $ M.lookup name newlookup
      liftIO $ logStderr $ "Bound " ++ subst ++ " to " ++ name ++ " in deriving\n"
      local
        (setParsedTypeConstrName name)
        ((subst,) <$> map Deriving <$> mapM (parseTypeDef newlookup) typedefs)
    Abs.SuperConstrainedTypeParam (Abs.LIdent name) typedefs
     -> do
      modify $ updater name
      let subst = fromJust $ M.lookup name newlookup
      liftIO $ logStderr $ "Bound " ++ subst ++ " to " ++ name ++ " in super\n"
      local
        (setParsedTypeConstrName name)
        (((subst,) <$> map Super <$> mapM (parseTypeDef newlookup) typedefs))
    Abs.WildcardTypeParam -> throwException $ errMsg ++ "invalid usage of wildcard type param"
    Abs.ConcreteTypeParam (Abs.UIdent param) -> throwException $ errMsg ++ "invalid usage of concrete type " ++ param
    --Abs.AnotherClassTypeParam def ->
    --  throwError $ ParseException $ errMsg ++ "parentheses not expected in" ++ printTree def
    Abs.AnySuperConstrainedTypeParam _ -> throwException $ errMsg ++ "invalid usage of wildcard '?'"
    Abs.AnyDerivingConstrainedTypeParam _ -> throwException $ errMsg ++ "invalid usage of wildcard '?'"

parseTypeConstraint :: Lookup -> Abs.ConstrTypeParam -> HierarchyMonad TypeParamConstraint
parseTypeConstraint lookupFun constr = do
  name <- asks currentParsedTypeName
  let errMsg = "In definition of template constraint for " ++ name ++ ": "
  case constr of
    Abs.WildcardTypeParam -> pure Types.Any
    Abs.InferredTypeParam (Abs.LIdent tparam) ->
      case M.lookup tparam lookupFun of
        Nothing -> throwException $ errMsg ++ "unknown type param " ++ tparam ++"\n"
        Just subst -> do
          constrs <- gets (M.lookup subst . templateParamConstrains)
          return $ Exact $ InferredType subst (fromMaybe [] constrs) []
    Abs.DerivingConstrainedTypeParam (Abs.LIdent name) typedefs ->
      throwException $ errMsg ++ " template params not supported\n"
    Abs.SuperConstrainedTypeParam (Abs.LIdent name) typedefs ->
      throwException $ errMsg ++ " template params not supported\n"
    Abs.ConcreteTypeParam (Abs.UIdent param) -> pure $ Exact $ ConcreteType param []
    {-Abs.AnotherClassTypeParam def -> do
      typedef <- parseTypeDef lookupFun def
      return $ Exact typedef -}
    Abs.AnySuperConstrainedTypeParam typedefs ->
      (Exact . ConcreteType "?" . map Super) <$> mapM (parseTypeDef lookupFun) typedefs
    Abs.AnyDerivingConstrainedTypeParam typedefs -> 
      (Exact . ConcreteType "?" . map Deriving) <$> mapM (parseTypeDef lookupFun) typedefs

parseTypeDef :: Lookup -> Abs.TypeDef -> HierarchyMonad TypeDef
parseTypeDef lookupFun (Abs.ConcreteType (Abs.UIdent name) constrs) =
  ConcreteType name <$> mapM (parseTypeConstraint lookupFun) constrs
parseTypeDef lookupFun (Abs.InferredType (Abs.LIdent name) constrs) =
  case M.lookup name lookupFun of
    Nothing -> do
      tname <- asks currentParsedTypeName
      throwException $ "In type definition in class " ++ tname ++ " cannot infer type " ++ name ++ "\n"
    Just subst -> do
      tconstrs <- gets (M.lookup subst . templateParamConstrains)
      params <- mapM (parseTypeConstraint lookupFun) constrs
      return $ InferredType subst (fromMaybe [] tconstrs) params

parsePrimFreeTypeDef :: Lookup -> Abs.PrimFreeType -> HierarchyMonad TypeParamConstraint
parsePrimFreeTypeDef lookupFun (Abs.ConcreteTypeFreeType tdef) = Exact <$> parseFreeTypeDef lookupFun tdef
parsePrimFreeTypeDef lookupFun (Abs.ConcreteFreeType (Abs.UIdent name)) = return $ Exact $ ConcreteType name []
parsePrimFreeTypeDef lookupFun (Abs.TemplateFreeType (Abs.LIdent name)) =
  case M.lookup name lookupFun of
    Just subst -> do
      pconstrs <- fromMaybe [] <$> gets (M.lookup subst . templateParamConstrains)
      return $ Exact $ InferredType subst pconstrs []
    Nothing -> do
      typename <- asks currentParsedTypeName
      field <- asks currentParsedMember
      variant <- asks currentParsedTypeVariant
      throwException $
        "In definition of " ++ typename ++ "." ++ variant ++ "." ++ field ++ ": unknown template param " ++ name ++ "\n"

parseFreeTypeDef :: Lookup -> Abs.FreeTypeDef -> HierarchyMonad TypeDef
parseFreeTypeDef lookupFun (Abs.FreeType (Abs.UIdent name) prims) = ConcreteType name <$> mapM (parsePrimFreeTypeDef lookupFun) prims
parseFreeTypeDef lookupFun (Abs.InferredFreeType (Abs.LIdent name) prims) = do
  parsedPrims <- mapM (parsePrimFreeTypeDef lookupFun) prims
  case M.lookup name lookupFun of
    Just subst -> do
      constrs <- gets (M.lookup subst . templateParamConstrains)
      return $ InferredType subst (fromMaybe [] constrs) parsedPrims
    Nothing -> do
      typename <- asks currentParsedTypeName
      variant <- asks currentParsedTypeVariant
      throwException $ "In definition of " ++ typename ++ "." ++ variant ++ ": unknown template param " ++ name ++ "\n"

parseArgDef :: Lookup -> Abs.ArgDef -> HierarchyMonad (String, TypeDef)
parseArgDef lookupFun (Abs.ArgumentDefinition (Abs.LIdent name) tdef) = do
  tlookup <- readFunctionSubsts
  (name,) <$> parseFreeTypeDef (combineLookups [lookupFun, tlookup]) tdef
parseArgDef lookupFun (Abs.InferredArgumentDef (Abs.LIdent name)) = pure (name, AnyType)

parseRetType :: Lookup -> Abs.RetType -> HierarchyMonad TypeDef
parseRetType lookupFun (Abs.ReturnType tdef) = do
  tlookup <- readFunctionSubsts
  parseFreeTypeDef (combineLookups [lookupFun, tlookup]) tdef
parseRetType _ Abs.InferredReturnType = pure AnyType -- TODO: Actually infer them or something

parseAbsRetType :: Lookup -> Abs.AbsRetType -> HierarchyMonad TypeDef
parseAbsRetType lookupFun (Abs.AbsReturnType tdef) = do
  tlookup <- readFunctionSubsts
  parseFreeTypeDef (combineLookups [lookupFun, tlookup]) tdef

parseFunctionTemplateParams :: [Abs.ConstrTypeParam] -> HierarchyMonad [(String, [TypeParamConstraint])]
parseFunctionTemplateParams [] = pure []
parseFunctionTemplateParams (h:t) = do
  lookup <- readSubstsFromCurrentStub
  let updater = registerTemplateFunctionSubst
  (:) <$> registerConstrainedTypeName lookup updater h <*> parseFunctionTemplateParams t

parseFunctionTemplateParameter :: Abs.FunTemplateParams -> HierarchyMonad [(String, [TypeParamConstraint])]
parseFunctionTemplateParameter Abs.NoFunctionTemplateParameter = pure []
parseFunctionTemplateParameter (Abs.FunctionTemplateParameters params) =
  parseFunctionTemplateParams $ map (\(Abs.TemplateParameter x) -> x) params
  
