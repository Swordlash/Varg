module FunctionParser where

import qualified AbsVarg            as Abs
import qualified Data.Map           as M
import           Expressions
import           PreprocessingState

import           Data.Maybe
import           TypeDefParser

--TODO: add function modifiers
createFunctionHierarchy :: [(String, TypeDef)] -> TypeDef -> Expr -> HierarchyMonad Function
createFunctionHierarchy [] rettype expr = pure $ Function [] voidTypeDef rettype expr
createFunctionHierarchy [(n, h)] rettype expr = pure $ Function [] h rettype (ELambda n h rettype expr)
createFunctionHierarchy ((n, h):t) rettype expr = do
  rest <- createFunctionHierarchy t rettype expr
  let Function [] tdef nrettype body = rest
  return $ Function [] h (ConcreteType "Function" [Exact h, Exact nrettype]) (ELambda n h nrettype body)

parseFunction' ::
     Abs.FunTemplateParams
  -> [Abs.ArgDef]
  -> (LookupFunction -> HierarchyMonad TypeDef)
  -> (LookupFunction -> HierarchyMonad Expr)
  -> HierarchyMonad Function
parseFunction' templateParams argdefs retfun bodyfun = do
  lookupFun <- readSubstsFromCurrentStub
  constrs <- parseFunctionTemplateParameter templateParams
  mapM_ (\(alias, constrsl) -> tell $ "Constrained " ++ alias ++ " to " ++ show constrsl ++ "\n") constrs
  modify (\state -> foldl (flip registerTemplateParamConstraints) state constrs)
  namespargdefs <- mapM (parseArgDef lookupFun) argdefs
  rettype <- retfun lookupFun
  expr <- bodyfun lookupFun
  createFunctionHierarchy namespargdefs rettype expr

parseFunction :: Abs.FunDef -> HierarchyMonad (String, Function)
parseFunction fundef = do
  modify removeTemplateFunctionSubsts --TODO: check if we should clear some type param constraints
  let getname fname =
        case fname of
          Abs.FFunction (Abs.LIdent name) -> name
          Abs.FOperator op                -> nshow op
  case fundef of
    Abs.MemberFunctionDefinition _ funname templateParams argdefs rettype body -> do
      f <-
        local
          (setParsedMember $ getname funname)
          (parseFunction' templateParams argdefs (`parseRetType` rettype) (`parseExpression` body))
      return (getname funname, f)
    Abs.AbstractFunctionDefinition _ funname templateParams argdefs rettype -> do
      f <-
        local
          (setParsedMember $ getname funname)
          (parseFunction' templateParams argdefs (`parseAbsRetType` rettype) (\_ -> pure EAbstract))
      return (getname funname, f)
