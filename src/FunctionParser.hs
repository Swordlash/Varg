{-  Source parsing module
    Parsing functions, transforming them into nested lambdas  -}
module FunctionParser where

import qualified AbsVarg as Abs
import qualified Data.Map as M
import Expressions
import PreprocessingState

import Data.Maybe
import TypeDefParser

parseFunctionModifier :: Abs.FunctionModifier -> HierarchyMonad MemberModifier
parseFunctionModifier =
  \case
    Abs.FunctionModifier_final -> pure FinalMember
    Abs.FunctionModifier_implement -> pure ImplementMember
    Abs.FunctionModifier_internal -> pure InternalMember
    Abs.FunctionModifier_native -> pure NativeMember
    Abs.FunctionModifier_static -> pure StaticMember
    Abs.FunctionModifier_unique -> pure UniqueMember

parseFunctionModifiers :: [Abs.FunctionModifier] -> HierarchyMonad [MemberModifier]
parseFunctionModifiers modifs =
  mapM parseFunctionModifier modifs >>= \case
    [] -> pure [ClassMember]
    meth -> pure meth -- too good not to leave it here

--TODO: add function modifiers
createFunctionHierarchy ::
     String -> [MemberModifier] -> [(String, TypeDef)] -> TypeDef -> Expr -> HierarchyMonad Function
createFunctionHierarchy name modifs [] rettype expr = pure $ Function modifs name voidTypeDef rettype expr
createFunctionHierarchy name modifs [(n, h)] rettype expr =
  pure $ Function modifs name h rettype (ELambda n h rettype expr)
createFunctionHierarchy name modifs ((n, h):t) rettype expr = do
  rest <- createFunctionHierarchy name modifs t rettype expr
  let Function modifs name tdef nrettype body = rest
  return $ Function modifs name h (ConcreteType "Function" [Exact h, Exact nrettype]) (ELambda n h nrettype body)

parseFunction' ::
     [Abs.FunctionModifier]
  -> Abs.FunTemplateParams
  -> [Abs.ArgDef]
  -> (LookupFunction -> HierarchyMonad TypeDef)
  -> (LookupFunction -> HierarchyMonad Expr)
  -> HierarchyMonad Function
parseFunction' modifs templateParams argdefs retfun bodyfun = do
  clsname <- asks currentParsedTypeName
  memname <- asks currentParsedMember
  let name = clsname ++ "." ++ memname
  pmodifs <- parseFunctionModifiers modifs
  lookupFun <- readSubstsFromCurrentStub
  constrs <- parseFunctionTemplateParameter templateParams
  --mapM_ (\(alias, constrsl) -> liftIO $ putStr $ "Constrained " ++ alias ++ " to " ++ show constrsl ++ "\n") constrs
  modify (\state -> foldl (flip registerTemplateParamConstraints) state constrs)
  namespargdefs <- mapM (parseArgDef lookupFun) argdefs
  rettype <- retfun lookupFun
  expr <- bodyfun lookupFun
  createFunctionHierarchy name pmodifs namespargdefs rettype expr

parseFunction :: Abs.FunDef -> HierarchyMonad (String, Function)
parseFunction fundef = do
  modify removeTemplateFunctionSubsts --TODO: check if we should clear some type param constraints
  let getname fname =
        case fname of
          Abs.FFunction (Abs.LIdent name) -> name
          Abs.FOperator op -> nshow op
          Abs.FOperatorDef (Abs.Op str) -> str
  case fundef of
    Abs.MemberFunctionDefinition modifs funname templateParams argdefs rettype body -> do
      f <-
        local
          (setParsedMember $ getname funname)
          (parseFunction' modifs templateParams argdefs (`parseRetType` rettype) (`parseExpression` body))
      return (getname funname, f)
    Abs.AbstractFunctionDefinition modifs funname templateParams argdefs rettype -> do
      f <-
        local
          (setParsedMember $ getname funname)
          (parseFunction' modifs templateParams argdefs (`parseAbsRetType` rettype) (\_ -> pure EAbstract))
      return (getname funname, f)