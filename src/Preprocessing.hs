module Preprocessing where

import           InterpreterState
import           Types

import           ErrM
import           LayoutVarg
import           LexVarg
import           ParVarg
import           PrintVarg

import           Control.Monad.Except
import           Control.Monad.Identity
import           Control.Monad.Reader
import           Control.Monad.State
import           Control.Monad.Writer

import           Data.Maybe

import qualified AbsVarg                as Abs
import qualified Data.Map               as M
import qualified Data.Set               as S

------------------------------------ running Alex and Happy ----------------------------------------------
runLexer :: String -> PreprocessMonad Abs.ProgramDef
runLexer s =
  let ts = lexer s
   in case pProgramDef ts of
        Bad s -> throwError $ ParseException s
        Ok tree -> do
          tell $ "[[Abstract syntax]]\n\n" ++ show tree
          pure tree
  where
    lexer = resolveLayout True . tokens

runLexerState :: String -> ParseMonad (Abs.ProgramDef, ParserLog)
runLexerState s =
  runIdentity $
  runExceptT $ runWriterT (evalStateT (runReaderT (runLexer s) emptyPreprocessRuntime) emptyPreprocessState)

------------------------------------ preprocessing class headers ----------------------------------------------
readPrimFreeType :: Abs.PrimFreeType -> PreprocessMonad DerivationKind
readPrimFreeType primType =
  case primType of
    Abs.ConcreteTypeFreeType free -> readDerivation free
    Abs.TemplateFreeType (Abs.LIdent name) -> do
      substs <- gets templateParamSubsts
      case M.lookup name substs of
        Nothing -> do
          parsed <- asks currentPreparsedTypeName
          throwError $ ParseException $ "In declaration of " ++ parsed ++ ": unknown template parameter " ++ name
        Just subst -> pure $ Unbound subst
    Abs.ConcreteFreeType (Abs.UIdent name) -> pure $ Concrete name []

readDerivation :: Abs.FreeTypeDef -> PreprocessMonad DerivationKind
readDerivation freeTypeDef =
  case freeTypeDef of
    Abs.FreeType (Abs.UIdent name) subfreetypes -> do
      subDerivations <- mapM readPrimFreeType subfreetypes
      return $ Concrete name subDerivations

readSuperclass :: Abs.SuperclassType -> PreprocessMonad DerivationKind
readSuperclass (Abs.Superclass typedef) = readDerivation typedef

readDeriving :: Abs.IsDeriving -> PreprocessMonad DerivationKind
readDeriving Abs.NotDeriving           = pure voidDerivation
readDeriving (Abs.Deriving superclass) = readSuperclass superclass

readImplementing :: Abs.IsImplementing -> PreprocessMonad [DerivationKind]
readImplementing Abs.NotImplementing = do
  name <- asks currentPreparsedTypeName
  return [functorialDerivation name]
readImplementing (Abs.Implementing superclasses) = mapM readSuperclass superclasses

preparseStubTypeParam :: Abs.ConstrTypeParam -> PreprocessMonad ()
preparseStubTypeParam param =
  case param of
    Abs.InferredTypeParam (Abs.LIdent name) -> modify (bindName name)
    Abs.SuperConstrainedTypeParam (Abs.LIdent name) _ -> modify (bindName name)
    Abs.DerivingConstrainedTypeParam (Abs.LIdent name) _ -> modify (bindName name)
    _ -> do
      parsed <- asks currentPreparsedTypeName
      throwError $
        ParseException $
        "In declaration of " ++ parsed ++ ": illegal definition of template parameter " ++ printTree param

readClassHeaders :: [Abs.ClassDef] -> PreprocessMonad ()
readClassHeaders [] = pure ()
readClassHeaders (cl:t) = do
  stubs <- gets classStubs
  (name, paramCount, deriv, impls) <- readStubs cl
  if M.member name stubs
    then throwError $ ParseException $ "Multiple definition of class " ++ name
    else do
      modify (registerStub (name, paramCount, deriv, impls))
      readClassHeaders t
      return ()
  where
    readStubs x =
      case x of
        Abs.StructDefinition modifs (Abs.UIdent sname) fields -> pure (sname, 0, functorialDerivation sname, [])
        Abs.ClassDefinition modifs (Abs.UIdent sname) isderiving isimplementing contents ->
          local
            (setPreparsedTypeName sname)
            (do superclasses <- readDeriving isderiving
                superifaces <- readImplementing isimplementing
                return (sname, 0, superclasses, superifaces))
        Abs.TemplateDefinition modifs (Abs.UIdent sname) typeParams isderiving isimplementing contents ->
          local
            (setPreparsedTypeName sname)
            (do mapM_ preparseStubTypeParam typeParams
                superclasses <- readDeriving isderiving
                superifaces <- readImplementing isimplementing
                return (sname, length typeParams, superclasses, superifaces))

runReadClassHeaders :: [Abs.ClassDef] -> ParseMonad (PreprocessState, ParserLog)
runReadClassHeaders cldefs =
  runIdentity $
  runExceptT $
  runWriterT $ execStateT (runReaderT (readClassHeaders cldefs) emptyPreprocessRuntime) emptyPreprocessState

------------------------------------ building class hierarchy ----------------------------------------------
readModifier :: Abs.ClassModifier -> HierarchyMonad TypeModifier
readModifier Abs.ClassModifier_sealed    = pure SealedType
readModifier Abs.ClassModifier_interface = pure InterfaceType
readModifier Abs.ClassModifier_module    = pure ModuleType

parseTypeConstraint :: Abs.ConstrTypeParam -> HierarchyMonad TypeParamConstraint
parseTypeConstraint constr = do
  name <- asks currentParsedTypeName
  substs <- gets ((\(Just (_, _, _, s)) -> s) . M.lookup name . preparsedStubs)
  let errMsg = "In definition of template constraint for " ++ name ++ ": "
  case constr of
    Abs.WildcardTypeParam -> pure Types.Any
    Abs.InferredTypeParam (Abs.LIdent tparam) ->
      case M.lookup tparam substs of
        Nothing -> throwError $ ParseException $ errMsg ++ "unknown type param " ++ tparam
        Just subst -> return $ Exact $ InferredType subst []
    Abs.DerivingConstrainedTypeParam (Abs.LIdent name) typedefs ->
      throwError $ ParseException $ errMsg ++ " template params not supported"
    Abs.SuperConstrainedTypeParam (Abs.LIdent name) typedefs ->
      throwError $ ParseException $ errMsg ++ " template params not supported"
    Abs.ConcreteTypeParam (Abs.UIdent param) -> pure $ Exact $ ConcreteType param []
    Abs.AnotherClassTypeParam def -> do
      typedef <- parseTypeDef def
      return $ Exact typedef
    Abs.AnySuperConstrainedTypeParam typedefs -> do
      tdefs <- mapM parseTypeDef typedefs
      return $ Exact $ ConcreteType "?" (map Super tdefs)
    Abs.AnyDerivingConstrainedTypeParam typedefs -> do
      tdefs <- mapM parseTypeDef typedefs
      return $ Exact $ ConcreteType "?" (map Super tdefs)

parseTypeDef :: Abs.TypeDef -> HierarchyMonad TypeDef
parseTypeDef (Abs.ConcreteType (Abs.UIdent name) constrs) = do
  params <- mapM parseTypeConstraint constrs
  return $ ConcreteType name params
parseTypeDef (Abs.InferredType (Abs.LIdent name) constrs) = do
  params <- mapM parseTypeConstraint constrs
  return $ ConcreteType name params

parseTemplateConstraint :: Abs.ConstrTypeParam -> HierarchyMonad [TypeParamConstraint]
parseTemplateConstraint constr = do
  name <- asks currentParsedTypeName
  let errMsg = "In definition of template constraint for " ++ name ++ ": "
  case constr of
    Abs.WildcardTypeParam -> throwError $ ParseException $ errMsg ++ "invalid usage of wildcard type param"
    Abs.InferredTypeParam _ -> pure [] -- already parsed
    Abs.DerivingConstrainedTypeParam (Abs.LIdent name) typedefs ->
      local
        (setParsedTypeConstrName name)
        (do ptypedefs <- mapM parseTypeDef typedefs
            let constrs = map Deriving ptypedefs
            return constrs)
    Abs.SuperConstrainedTypeParam (Abs.LIdent name) typedefs ->
      local
        (setParsedTypeConstrName name)
        (do ptypedefs <- mapM parseTypeDef typedefs
            let constrs = map Super ptypedefs
            return constrs)
    Abs.ConcreteTypeParam (Abs.UIdent param) ->
      throwError $ ParseException $ errMsg ++ "invalid usage of concrete type " ++ param
    Abs.AnotherClassTypeParam def ->
      throwError $ ParseException $ errMsg ++ "parentheses not expected in" ++ printTree def
    Abs.AnySuperConstrainedTypeParam _ -> throwError $ ParseException $ errMsg ++ "invalid usage of wildcard '?'"
    Abs.AnyDerivingConstrainedTypeParam _ -> throwError $ ParseException $ errMsg ++ "invalid usage of wildcard '?'"

parsePrimFreeTypeDef :: Abs.PrimFreeType -> HierarchyMonad TypeParamConstraint
parsePrimFreeTypeDef (Abs.ConcreteTypeFreeType tdef) = Exact <$> parseFreeTypeDef tdef
parsePrimFreeTypeDef (Abs.ConcreteFreeType (Abs.UIdent name)) = return $ Exact $ ConcreteType name []
parsePrimFreeTypeDef (Abs.TemplateFreeType (Abs.LIdent name)) = do
  typename <- asks currentParsedTypeName
  field <- asks currentParsedField
  variant <- asks currentParsedTypeVariant
  let msg = "In definition of " ++ typename ++ "." ++ variant ++ "." ++ field
  stub <- gets (M.lookup typename . preparsedStubs)
  case stub of
    Nothing -> throwError $ ParseException $ msg ++ ": no stub for " ++ typename
    Just (_, _, _, substs) ->
      case M.lookup name substs of
        Just subst -> return $ Exact $ InferredType subst []
        Nothing -> throwError $ ParseException $ msg ++ ": unknown template param" ++ name

parseFreeTypeDef :: Abs.FreeTypeDef -> HierarchyMonad TypeDef
parseFreeTypeDef (Abs.FreeType (Abs.UIdent name) prims) = do
  parsedPrims <- mapM parsePrimFreeTypeDef prims
  return $ ConcreteType name parsedPrims
parseFreeTypeDef (Abs.InferredFreeType (Abs.LIdent name) prims) = do
  parsedPrims <- mapM parsePrimFreeTypeDef prims
  typename <- asks currentParsedTypeName
  variant <- asks currentParsedTypeVariant
  stub <- gets (M.lookup typename . preparsedStubs)
  let msg = "In definition of " ++ typename ++ "." ++ variant
  case stub of
    Nothing -> throwError $ ParseException $ msg ++ ": no stub for " ++ typename
    Just (_, _, _, substs) ->
      case M.lookup name substs of
        Just subst -> return $ InferredType subst parsedPrims
        Nothing -> throwError $ ParseException $ msg ++ ": unknown template param" ++ name

parseField :: Abs.ClassField -> HierarchyMonad Function
parseField (Abs.NormalClassField (Abs.LIdent fldname) freeTypeDef) =
  local
    (setParsedField fldname)
    (do fieldTypeDef <- parseFreeTypeDef freeTypeDef
        return $ Function fldname (ConcreteType "Void" []) fieldTypeDef Const)

parseFields :: [Abs.ClassField] -> HierarchyMonad (S.Set Function)
parseFields [] = pure S.empty
parseFields (field:t) = do
  parsedTail <- parseFields t
  parsed <- parseField field
  if S.member parsed parsedTail
    then do
      typename <- asks currentParsedTypeName
      variant <- asks currentParsedTypeVariant
      throwError $
        ParseException $
        "In definition of " ++
        typename ++ "." ++ variant ++ ": multiple definition of field " ++ qualifiedFunName parsed
    else return $ S.insert parsed parsedTail

parseMember :: Abs.MemberDef -> HierarchyMonad Variant
parseMember (Abs.EmptyMemberDefinition (Abs.UIdent name)) = pure $ emptyVariant name
parseMember (Abs.MemberDefinition (Abs.UIdent name) fields) =
  local
    (setParsedTypeVariant name)
    (do parsedFields <- parseFields fields
        return $ Variant name parsedFields)

parseClassContents :: Abs.ClassContents -> HierarchyMonad ClassContents
parseClassContents (Abs.ClassContent members fundefs) = do
  pmembers <- mapM parseMember members
  return (S.fromList pmembers, S.empty)

parseClass :: Abs.ClassDef -> HierarchyMonad Type
parseClass classDef =
  case classDef of
    Abs.StructDefinition modifs name fields -> return VoidType
    Abs.ClassDefinition modifs (Abs.UIdent name) _ _ contents -> do
      classModifs <- mapM readModifier modifs
      stub <- gets (M.lookup name . preparsedStubs)
      case stub of
        Just (0, deriv, impls, substs) ->
          local
            (setParsedTypeName name)
            (do (variants, functions) <- parseClassContents contents
                return $ Type name deriv impls variants 0 [] functions)
        Nothing ->
          throwError $
          ParseException $ "Parser error: non-existent stub for " ++ name ++ " type, or invalid param count"
    Abs.TemplateDefinition modifs (Abs.UIdent name) typeParams _ _ contents ->
      let paramlen = length typeParams
       in do classModifs <- mapM readModifier modifs
             stub <- gets (M.lookup name . preparsedStubs)
             case stub of
               Just (paramlen, deriv, impls, substs) ->
                 local
                   (setParsedTypeName name)
                   (do constrs <- mapM parseTemplateConstraint typeParams
                       (variants, functions) <- parseClassContents contents
                       return $ Type name deriv impls variants paramlen constrs functions)
               Nothing ->
                 throwError $
                 ParseException $ "Parser error: non-existent stub for " ++ name ++ " type, or invalid param count"

buildClassHierarchy :: [Abs.ClassDef] -> HierarchyMonad ()
buildClassHierarchy [] = pure ()
buildClassHierarchy (cl:t) = do
  newcl <- parseClass cl
  hierarchy <- gets classHierarchy
  if S.member newcl hierarchy
    then throwError $ ParseException ("Multiple definition of class " ++ qualifiedTypeName newcl)
    else do
      modify (registerClass newcl)
      buildClassHierarchy t

runBuildClassHierarchy :: Stubs -> [Abs.ClassDef] -> ParseMonad (HierarchyState, ParserLog)
runBuildClassHierarchy stubs cldefs =
  runIdentity $
  runExceptT $
  runWriterT $ execStateT (runReaderT (buildClassHierarchy cldefs) emptyHierarchyRuntime) (HierarchyState stubs S.empty)

preprocessClasses :: String -> ParseMonad (ClassHierarchy, ParserLog)
preprocessClasses programText = do
  (Abs.Program _ cldefs, l1) <- runLexerState programText
  (PreprocessState stubs _ _, l2) <- runReadClassHeaders cldefs
  (HierarchyState _ hier, l3) <- runBuildClassHierarchy stubs cldefs
  return (hier, l1 ++ l2 ++ l3)
