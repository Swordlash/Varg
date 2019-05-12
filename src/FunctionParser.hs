module FunctionParser where

import qualified AbsVarg            as Abs
import qualified Data.Map           as M
import           Expressions
import           PreprocessingState

import           Data.Maybe
import           TypeDefParser

nats = 0 : [n + 1 | n <- nats]

argGen = map (\n -> "_arg" ++ show n) nats

--TODO: add function modifiers
createFunctionHierarchy :: [(String, TypeDef)] -> TypeDef -> Expr -> HierarchyMonad Function
createFunctionHierarchy [] rettype expr = do
  mname <- asks currentParsedMember
  return $ Function [] mname voidTypeDef rettype expr
createFunctionHierarchy [(n, h)] rettype expr = do
  mname <- asks currentParsedMember
  return $ Function [] mname h rettype (ELambda n h rettype expr)
createFunctionHierarchy ((n, h):t) rettype expr = do
  rest <- createFunctionHierarchy t rettype expr
  let Function [] mname tdef nrettype body = rest
  return $ Function [] mname h (ConcreteType "Function" [Exact h, Exact nrettype]) (ELambda n h nrettype body)

parseFunction' ::
     String
  -> Abs.FunTemplateParams
  -> [Abs.ArgDef]
  -> (LookupFunction -> HierarchyMonad TypeDef)
  -> (LookupFunction -> HierarchyMonad Expr)
  -> HierarchyMonad Function
parseFunction' name templateParams argdefs retfun bodyfun = do
  lookupFun <- readSubstsFromCurrentStub
  constrs <- parseFunctionTemplateParameter templateParams
  mapM_ (\(alias, constrsl) -> tell $ "Constrained " ++ alias ++ " to " ++ show constrsl ++ "\n") constrs
  modify (\state -> foldl (flip registerTemplateParamConstraints) state constrs)
  namespargdefs <- mapM (parseArgDef lookupFun) argdefs
  let localFun = setParsedMember name
  rettype <- retfun lookupFun
  expr <- local localFun (bodyfun lookupFun)
  local localFun (createFunctionHierarchy namespargdefs rettype expr)

parseFunction :: Abs.FunDef -> HierarchyMonad Function
parseFunction fundef = do
  modify removeTemplateFunctionSubsts --TODO: check if we should clear some type param constraints
  let getname fname =
        case fname of
          Abs.FFunction (Abs.LIdent name) -> name
          Abs.FOperator op                -> nshow op
  case fundef of
    Abs.MemberFunctionDefinition _ funname templateParams argdefs rettype body ->
      parseFunction' (getname funname) templateParams argdefs (`parseRetType` rettype) (`parseExpression` body)
    Abs.AbstractFunctionDefinition _ funname templateParams argdefs rettype ->
      parseFunction' (getname funname) templateParams argdefs (`parseAbsRetType` rettype) (\_ -> pure EAbstract)
