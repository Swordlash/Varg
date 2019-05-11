module FunctionParser where

import qualified AbsVarg          as Abs
import qualified Data.Map         as M
import           Expressions
import           InterpreterState

import           Data.Maybe
import           TypeDefParser

nats = 0 : [n + 1 | n <- nats]

argGen = map (\n -> "_arg" ++ show n) nats

createFunctionHierarchy :: [TypeDef] -> TypeDef -> Expr -> HierarchyMonad [Function]
createFunctionHierarchy [] _ _ = do
  mname <- asks currentParsedMember
  cname <- asks currentParsedTypeName
  throwError $
    ParseException $ "In definition of " ++ cname ++ "." ++ mname ++ ": empty argument list, use field instead"
createFunctionHierarchy [h] rettype expr = do
  mname <- asks currentParsedMember
  depth <- asks currentCurryingDepth
  pure [Function [] ("_" ++ mname ++ show depth) h rettype (ELambda (argGen !! depth) h rettype expr)]
createFunctionHierarchy (h:t) rettype expr = do
  mname <- asks currentParsedMember
  depth <- asks currentCurryingDepth
  rest <- local incrCurrentCurryingDepth (createFunctionHierarchy t rettype expr)
  let f@(Function _ name intype outtype exp) = head rest
  return $
    Function
      []
      ("_" ++ mname ++ show depth)
      h
      (functionToTypedef f)
      (ELambda (argGen !! depth) h (functionToTypedef f) exp) :
    rest

parseFunction' ::
     String
  -> Abs.FunTemplateParams
  -> [Abs.ArgDef]
  -> (LookupFunction -> HierarchyMonad TypeDef)
  -> (LookupFunction -> HierarchyMonad Expr)
  -> HierarchyMonad [Function]
parseFunction' name templateParams argdefs retfun bodyfun = do
  lookupFun <- readSubstsFromCurrentStub
  constrs <- parseFunctionTemplateParameter templateParams
  mapM_ (\(alias, constrsl) -> tell $ "Constrained " ++ alias ++ " to " ++ show constrsl ++ "\n") constrs
  modify (\state -> foldl (flip registerTemplateParamConstraints) state constrs)
  namespargdefs <- mapM (parseArgDef lookupFun) argdefs
  let (names, pargdefs) = unzip namespargdefs
  let substs = M.fromList $ zip names argGen
  let localFun = setCurrentFunArgSubsts substs . setParsedMember name
  rettype <- retfun lookupFun
  expr <- local localFun (bodyfun lookupFun)
  local (setCurrentFunArgSubsts substs . setParsedMember name) (createFunctionHierarchy pargdefs rettype expr)

parseFunction :: Abs.FunDef -> HierarchyMonad [Function]
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
