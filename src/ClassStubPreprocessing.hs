module ClassStubPreprocessing where

import           InterpreterState
import           PrintVarg

import qualified AbsVarg          as Abs
import qualified Data.Map         as M
import qualified Data.Set         as S

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

bindAndLogName :: String -> PreprocessMonad ()
bindAndLogName name = do
  bound <- gets getLastTypeParam
  modify (bindName name)
  tell $ "TypeParam `" ++ name ++ "` bound to `" ++ bound ++ "`\n"

preparseStubTypeParam :: Abs.ConstrTypeParam -> PreprocessMonad ()
preparseStubTypeParam param =
  case param of
    Abs.InferredTypeParam (Abs.LIdent name) -> bindAndLogName name
    Abs.SuperConstrainedTypeParam (Abs.LIdent name) _ -> bindAndLogName name
    Abs.DerivingConstrainedTypeParam (Abs.LIdent name) _ -> bindAndLogName name
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
            (do tell $ "\nReading header of class " ++ sname ++ "\n"
                superclasses <- readDeriving isderiving
                superifaces <- readImplementing isimplementing
                return (sname, 0, superclasses, superifaces))
        Abs.TemplateDefinition modifs (Abs.UIdent sname) typeParams isderiving isimplementing contents ->
          local
            (setPreparsedTypeName sname)
            (do tell $ "\nReading header of template " ++ sname ++ "\n"
                mapM_ preparseStubTypeParam typeParams
                superclasses <- readDeriving isderiving
                superifaces <- readImplementing isimplementing
                return (sname, length typeParams, superclasses, superifaces))

runReadClassHeaders :: [Abs.ClassDef] -> ParseMonad (PreprocessState, ParserLog)
runReadClassHeaders cldefs =
  runIdentity $
  runExceptT $
  runWriterT $ execStateT (runReaderT (readClassHeaders cldefs) emptyPreprocessRuntime) emptyPreprocessState
