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

{- TODO FIXME LookupFunction passing is redundant, could be included in MonadReader environment
   TODO it appears here, in FunctionParser and Expressions -}
registerConstrainedTypeName ::
     LookupFunction
  -> Updater String HierarchyState
  -> Abs.ConstrTypeParam
  -> HierarchyMonad (String, [TypeParamConstraint])
registerConstrainedTypeName lookupFun updater constr = do
  name <- asks currentParsedTypeName
  fname <- asks currentParsedMember
  let errMsg = "In definition of template constraint for " ++ name ++ "." ++ fname ++ ": "
  case constr of
    Abs.WildcardTypeParam -> throwError $ VargException $ errMsg ++ "invalid usage of wildcard type param"
    Abs.InferredTypeParam (Abs.LIdent name) --case newlookup name of
      --Just _ -> throwError $ ParseException $ errMsg ++ "multiple definition of constraint for "++name
      --Nothing ->  do FIXME: that allows for shadowing template params from header
     -> do
      modify $ updater name
      tlookup <- gets (flip M.lookup . templateFunctionSubsts)
      let newlookup = combineLookups [tlookup, lookupFun]
      let subst = fromJust $ newlookup name
      --liftIO $ putStrLn $ "Bound " ++ subst ++ " to " ++ name
      return (subst, [])
    Abs.DerivingConstrainedTypeParam (Abs.LIdent name) typedefs -- case newlookup name of
      --Just _ -> throwError $ ParseException $ errMsg ++ "multiple definition of constraint for "++name
      --Nothing -> do
     -> do
      modify $ updater name
      tlookup <- gets (flip M.lookup . templateFunctionSubsts)
      let newlookup = combineLookups [tlookup, lookupFun]
      let subst = fromJust $ newlookup name
      --liftIO $ putStrLn $ "Bound " ++ subst ++ " to " ++ name ++ " in deriving"
      local
        (setParsedTypeConstrName name)
        (do ptypedefs <- mapM (parseTypeDef newlookup) typedefs
            let constrs = map Deriving ptypedefs
            return (subst, constrs))
    Abs.SuperConstrainedTypeParam (Abs.LIdent name) typedefs --case newlookup name of
       --Just _ -> throwError $ ParseException $ errMsg ++ "multiple definition of constraint for "++name
       --Nothing -> do
     -> do
      modify $ updater name
      tlookup <- gets (flip M.lookup . templateFunctionSubsts)
      let newlookup = combineLookups [tlookup, lookupFun]
      let subst = fromJust $ newlookup name
      --liftIO $ putStrLn $ "Bound " ++ subst ++ " to " ++ name ++ " in super"
      local
        (setParsedTypeConstrName name)
        (do ptypedefs <- mapM (parseTypeDef newlookup) typedefs
            let constrs = map Super ptypedefs
            return (subst, constrs))
    Abs.ConcreteTypeParam (Abs.UIdent param) ->
      throwError $ VargException $ errMsg ++ "invalid usage of concrete type " ++ param
    --Abs.AnotherClassTypeParam def ->
    --  throwError $ ParseException $ errMsg ++ "parentheses not expected in" ++ printTree def
    Abs.AnySuperConstrainedTypeParam _ -> throwError $ VargException $ errMsg ++ "invalid usage of wildcard '?'"
    Abs.AnyDerivingConstrainedTypeParam _ -> throwError $ VargException $ errMsg ++ "invalid usage of wildcard '?'"

parseTypeConstraint :: LookupFunction -> Abs.ConstrTypeParam -> HierarchyMonad TypeParamConstraint
parseTypeConstraint lookupFun constr = do
  name <- asks currentParsedTypeName
  let errMsg = "In definition of template constraint for " ++ name ++ ": "
  case constr of
    Abs.WildcardTypeParam -> pure Types.Any
    Abs.InferredTypeParam (Abs.LIdent tparam) ->
      case lookupFun tparam of
        Nothing -> throwError $ VargException $ errMsg ++ "unknown type param " ++ tparam
        Just subst -> do
          constrs <- gets (M.lookup subst . templateParamConstrains)
          return $ Exact $ InferredType subst (fromMaybe [] constrs) []
    Abs.DerivingConstrainedTypeParam (Abs.LIdent name) typedefs ->
      throwError $ VargException $ errMsg ++ " template params not supported"
    Abs.SuperConstrainedTypeParam (Abs.LIdent name) typedefs ->
      throwError $ VargException $ errMsg ++ " template params not supported"
    Abs.ConcreteTypeParam (Abs.UIdent param) -> pure $ Exact $ ConcreteType param []
    {-Abs.AnotherClassTypeParam def -> do
      typedef <- parseTypeDef lookupFun def
      return $ Exact typedef -}
    Abs.AnySuperConstrainedTypeParam typedefs -> do
      tdefs <- mapM (parseTypeDef lookupFun) typedefs
      return $ Exact $ ConcreteType "?" (map Super tdefs)
    Abs.AnyDerivingConstrainedTypeParam typedefs -> do
      tdefs <- mapM (parseTypeDef lookupFun) typedefs
      return $ Exact $ ConcreteType "?" (map Super tdefs)

parseTypeDef :: LookupFunction -> Abs.TypeDef -> HierarchyMonad TypeDef
parseTypeDef lookupFun (Abs.ConcreteType (Abs.UIdent name) constrs) = do
  params <- mapM (parseTypeConstraint lookupFun) constrs
  return $ ConcreteType name params
parseTypeDef lookupFun (Abs.InferredType (Abs.LIdent name) constrs) =
  case lookupFun name of
    Nothing -> do
      tname <- asks currentParsedTypeName
      throwError $ VargException $ "In type definition in class " ++ tname ++ " cannot infer type " ++ name
    Just subst -> do
      tconstrs <- gets (M.lookup subst . templateParamConstrains)
      params <- mapM (parseTypeConstraint lookupFun) constrs
      return $ InferredType subst (fromMaybe [] tconstrs) params

parsePrimFreeTypeDef :: LookupFunction -> Abs.PrimFreeType -> HierarchyMonad TypeParamConstraint
parsePrimFreeTypeDef lookupFun (Abs.ConcreteTypeFreeType tdef) = Exact <$> parseFreeTypeDef lookupFun tdef
parsePrimFreeTypeDef lookupFun (Abs.ConcreteFreeType (Abs.UIdent name)) = return $ Exact $ ConcreteType name []
parsePrimFreeTypeDef lookupFun (Abs.TemplateFreeType (Abs.LIdent name)) =
  case lookupFun name of
    Just subst -> do
      constrs <- gets (M.lookup subst . templateParamConstrains)
      let pconstrs = fromMaybe [] constrs
      return $ Exact $ InferredType subst pconstrs []
    Nothing -> do
      typename <- asks currentParsedTypeName
      field <- asks currentParsedMember
      variant <- asks currentParsedTypeVariant
      throwError $
        VargException $
        "In definition of " ++ typename ++ "." ++ variant ++ "." ++ field ++ ": unknown template param " ++ name

parseFreeTypeDef :: LookupFunction -> Abs.FreeTypeDef -> HierarchyMonad TypeDef
parseFreeTypeDef lookupFun (Abs.FreeType (Abs.UIdent name) prims) = do
  parsedPrims <- mapM (parsePrimFreeTypeDef lookupFun) prims
  return $ ConcreteType name parsedPrims
parseFreeTypeDef lookupFun (Abs.InferredFreeType (Abs.LIdent name) prims) = do
  parsedPrims <- mapM (parsePrimFreeTypeDef lookupFun) prims
  case lookupFun name of
    Just subst -> do
      constrs <- gets (M.lookup subst . templateParamConstrains)
      return $ InferredType subst (fromMaybe [] constrs) parsedPrims
    Nothing -> do
      typename <- asks currentParsedTypeName
      variant <- asks currentParsedTypeVariant
      throwError $
        VargException $ "In definition of " ++ typename ++ "." ++ variant ++ ": unknown template param " ++ name

parseArgDef :: LookupFunction -> Abs.ArgDef -> HierarchyMonad (String, TypeDef)
parseArgDef lookupFun (Abs.ArgumentDefinition (Abs.LIdent name) tdef) = do
  tlookup <- readFunctionSubsts
  tdef <- parseFreeTypeDef (combineLookups [lookupFun, tlookup]) tdef
  return (name, tdef)
parseArgDef lookupFun (Abs.InferredArgumentDef (Abs.LIdent name)) = pure (name, AnyType)

parseRetType :: LookupFunction -> Abs.RetType -> HierarchyMonad TypeDef
parseRetType lookupFun (Abs.ReturnType tdef) = do
  tlookup <- readFunctionSubsts
  parseFreeTypeDef (combineLookups [lookupFun, tlookup]) tdef
parseRetType _ (Abs.InferredReturnType) = pure AnyType -- TODO: Actually infer them or something

parseAbsRetType :: LookupFunction -> Abs.AbsRetType -> HierarchyMonad TypeDef
parseAbsRetType lookupFun (Abs.AbsReturnType tdef) = do
  tlookup <- readFunctionSubsts
  parseFreeTypeDef (combineLookups [lookupFun, tlookup]) tdef

parseFunctionTemplateParams :: [Abs.ConstrTypeParam] -> HierarchyMonad [(String, [TypeParamConstraint])]
parseFunctionTemplateParams [] = pure []
parseFunctionTemplateParams (h:t) = do
  lookup <- readSubstsFromCurrentStub
  let updater = registerTemplateFunctionSubst
  result <- registerConstrainedTypeName lookup updater h
  rest <- parseFunctionTemplateParams t
  return $ result : rest

parseFunctionTemplateParameter :: Abs.FunTemplateParams -> HierarchyMonad [(String, [TypeParamConstraint])]
parseFunctionTemplateParameter Abs.NoFunctionTemplateParameter = pure []
parseFunctionTemplateParameter (Abs.FunctionTemplateParameters params) =
  let constrTypeParams = map (\(Abs.TemplateParameter x) -> x) params
   in parseFunctionTemplateParams constrTypeParams
