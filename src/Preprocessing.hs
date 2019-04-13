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
runLexer :: String -> ParserT Abs.ProgramDef
runLexer s =
  let ts = lexer s
   in case pProgramDef ts of
        Bad s   -> throwError $ ParseException s
        Ok tree -> pure tree
  where
    lexer = resolveLayout True . tokens

runLexerState :: String -> ParseMonad (Abs.ProgramDef, ParserLog)
runLexerState s =
  runIdentity $ runExceptT $ runWriterT (evalStateT (runReaderT (runLexer s) emptyParserRuntime) emptyParserState)

------------------------------------ preprocessing class headers ----------------------------------------------
readPrimFreeType :: Abs.PrimFreeType -> ParserT DerivationKind
readPrimFreeType primType =
  case primType of
    Abs.ConcreteTypeFreeType free -> readDerivation free
    Abs.TemplateFreeType (Abs.LIdent name) -> do
      substs <- gets templateParamSubsts
      case M.lookup name substs of
        Nothing -> do
          parsed <- asks currentParsedTypeName
          throwError $ ParseException $ "In declaration of " ++ parsed ++ ": unknown template parameter " ++ name
        Just subst -> pure $ Unbound subst
    Abs.ConcreteFreeType (Abs.UIdent name) -> pure $ Concrete name []

readDerivation :: Abs.FreeTypeDef -> ParserT DerivationKind
readDerivation freeTypeDef =
  case freeTypeDef of
    Abs.FreeType (Abs.UIdent name) subfreetypes -> do
      subDerivations <- mapM readPrimFreeType subfreetypes
      return $ Concrete name subDerivations

readSuperclass :: Abs.SuperclassType -> ParserT DerivationKind
readSuperclass (Abs.Superclass typedef) = readDerivation typedef

readDeriving :: Abs.IsDeriving -> ParserT DerivationKind
readDeriving Abs.NotDeriving           = pure voidDerivation
readDeriving (Abs.Deriving superclass) = readSuperclass superclass

readImplementing :: Abs.IsImplementing -> ParserT [DerivationKind]
readImplementing Abs.NotImplementing = do
  name <- asks currentParsedTypeName
  return [functorialDerivation name]
readImplementing (Abs.Implementing superclasses) = mapM readSuperclass superclasses

preparseStubTypeParam :: Abs.ConstrTypeParam -> ParserT ()
preparseStubTypeParam param =
  case param of
    Abs.InferredTypeParam (Abs.LIdent name) -> modify (bindName name)
    Abs.SuperConstrainedTypeParam (Abs.LIdent name) _ -> modify (bindName name)
    Abs.DerivingConstrainedTypeParam (Abs.LIdent name) _ -> modify (bindName name)
    _ -> do
      parsed <- asks currentParsedTypeName
      throwError $
        ParseException $
        "In declaration of " ++ parsed ++ ": illegal definition of template parameter " ++ printTree param

readClassHeaders :: [Abs.ClassDef] -> ParserT ()
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
            (setParsedTypeName sname)
            (do superclasses <- readDeriving isderiving
                superifaces <- readImplementing isimplementing
                return (sname, 0, superclasses, superifaces))
        Abs.TemplateDefinition modifs (Abs.UIdent sname) typeParams isderiving isimplementing contents ->
          local
            (setParsedTypeName sname)
            (do mapM_ preparseStubTypeParam typeParams
                superclasses <- readDeriving isderiving
                superifaces <- readImplementing isimplementing
                return (sname, length typeParams, superclasses, superifaces))

runReadClassHeaders :: Abs.ProgramDef -> ParseMonad (ParserState, ParserLog)
runReadClassHeaders (Abs.Program _ cldefs) =
  runIdentity $
  runExceptT $ runWriterT (execStateT (runReaderT (readClassHeaders cldefs) emptyParserRuntime) emptyParserState)

------------------------------------ building class hierarchy ----------------------------------------------
readModifier :: Abs.ClassModifier -> ParserT TypeModifier
readModifier Abs.ClassModifier_sealed    = pure SealedType
readModifier Abs.ClassModifier_interface = pure InterfaceType
readModifier Abs.ClassModifier_module    = pure ModuleType

parseClass :: Abs.ClassDef -> ParserT Type
parseClass classDef =
  case classDef of
    Abs.StructDefinition modifs name fields -> return VoidType
    Abs.ClassDefinition modifs (Abs.UIdent name) _ _ contents -> do
      classModifs <- mapM readModifier modifs
      stub <- gets (M.lookup name . classStubs)
      case stub of
        Just (0, deriv, impls) -> return $ Type name deriv impls [] 0 [] S.empty
        Nothing ->
          throwError $
          ParseException $ "Parser error: non-existent stub for " ++ name ++ " type, or invalid param count"
    Abs.TemplateDefinition modifs (Abs.UIdent name) typeParams _ _ contents ->
      let paramlen = length typeParams
       in do classModifs <- mapM readModifier modifs
             stub <- gets (M.lookup name . classStubs)
             case stub of
               Just (paramlen, deriv, impls)
        --strenuous parsing of constraints
                -> return $ Type name deriv impls [] paramlen [] S.empty
               Nothing ->
                 throwError $
                 ParseException $ "Parser error: non-existent stub for " ++ name ++ " type, or invalid param count"

buildClassHierarchy :: [Abs.ClassDef] -> ParserT ()
buildClassHierarchy [] = pure ()
buildClassHierarchy (cl:t) = do
  newcl <- parseClass cl
  hierarchy <- gets classHierarchy
  if S.member newcl hierarchy
    then throwError $ ParseException ("Multiple definition of class " ++ qualifiedTypeName newcl)
    else do
      modify (registerClass newcl)
      buildClassHierarchy t
      return ()

preprocessClasses :: String -> ParserT ()
preprocessClasses programText = do
  (Abs.Program _ cldefs) <- runLexer programText
  readClassHeaders cldefs
  buildClassHierarchy cldefs

runPreprocessing :: String -> ParseMonad (ParserState, ParserLog)
runPreprocessing programText =
  runIdentity $
  runExceptT $ runWriterT (execStateT (runReaderT (preprocessClasses programText) emptyParserRuntime) emptyParserState)
