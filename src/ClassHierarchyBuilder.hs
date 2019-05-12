module ClassHierarchyBuilder where

import           PreprocessingState
import           Types

import           PrintVarg

import qualified AbsVarg            as Abs
import qualified Data.Map           as M
import qualified Data.Set           as S

import           FieldParser
import           FunctionParser
import           TypeDefParser

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
  pfundefs <- mapM parseFunction fundefs
  return (S.fromList pmembers, S.fromList pfundefs)

parseClass :: Abs.ClassDef -> HierarchyMonad Type
parseClass classDef =
  case classDef of
    Abs.StructDefinition modifs name fields -> return VoidType
    Abs.ClassDefinition modifs (Abs.UIdent name) _ _ contents -> do
      tell $ "\nParsing class " ++ name ++ "\n"
      classModifs <- mapM readModifier modifs
      stub <- gets (M.lookup name . preparsedStubs)
      case stub of
        Just (0, deriv, impls, substs) ->
          local
            (setParsedTypeName name)
            (do (variants, functions) <- parseClassContents contents
                return $ Type name deriv impls variants 0 [] functions)
        Nothing ->
          throwError $ VargException $ "Parser error: non-existent stub for " ++ name ++ " type, or invalid param count"
    Abs.TemplateDefinition modifs (Abs.UIdent name) typeParams _ _ contents ->
      let paramlen = length typeParams
       in do tell $ "\nParsing template " ++ name ++ "\n"
             classModifs <- mapM readModifier modifs
             stub <- gets (M.lookup name . preparsedStubs)
             case stub of
               Just (paramlen, deriv, impls, substs) ->
                 local
                   (setParsedTypeName name)
                   (do constrs <- mapM (registerConstrainedTypeName (`M.lookup` substs) (flip const)) typeParams
                       modify (\state -> foldl (flip registerTemplateParamConstraints) state constrs)
                       (variants, functions) <- parseClassContents contents
                       return $ Type name deriv impls variants paramlen (map snd constrs) functions)
               Nothing ->
                 throwError $
                 VargException $ "Parser error: non-existent stub for " ++ name ++ " type, or invalid param count"

buildClassHierarchy :: [Abs.ClassDef] -> HierarchyMonad ()
buildClassHierarchy [] = pure ()
buildClassHierarchy (cl:t) = do
  newcl <- parseClass cl
  hierarchy <- gets preClassHierarchy
  if S.member newcl hierarchy
    then throwError $ VargException ("Multiple definition of class " ++ qualifiedTypeName newcl)
    else do
      modify (registerClass newcl)
      buildClassHierarchy t

runBuildClassHierarchy :: Stubs -> [Abs.ClassDef] -> VargExceptionMonad (HierarchyState, Log)
runBuildClassHierarchy stubs cldefs =
  runIdentity $
  runExceptT $
  runWriterT $
  execStateT
    (runReaderT (buildClassHierarchy cldefs) emptyHierarchyRuntime)
    (HierarchyState stubs S.empty M.empty M.empty)
