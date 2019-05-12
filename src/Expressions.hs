module Expressions where

import           PreprocessingState
import           TypeDefParser

import qualified AbsVarg            as Abs
import qualified Data.Map           as M
import qualified Data.Set           as S

nshow Abs.Op_plus  = "+"
nshow Abs.Op_minus = "-"
nshow Abs.Op_mul   = "*"
nshow Abs.Op_div   = "/"
nshow Abs.Op_pow   = "^"
nshow Abs.Op_less  = "<"
nshow Abs.Op_gr    = ">"
nshow Abs.Op_leq   = "<="
nshow Abs.Op_geq   = ">="
nshow Abs.Op_eq    = "=="

parseLeadingFunctorial :: LookupFunction -> Abs.Functorial -> HierarchyMonad Expr
parseLeadingFunctorial lookupFun funct =
  case funct of
    Abs.ThisFunctor -> pure EThis
    Abs.SuperFunctor -> pure ESuper
    Abs.InstanceFunctor (Abs.LIdent var) -> pure $ EVar var
    Abs.TypeFunctor (Abs.UIdent _class) -> pure $ EClass _class
    Abs.MemberFunctor _ -> throwError $ VargException "The leading application functor cannot be .ident"
    Abs.ExprFunctor expr -> parseExpression lookupFun expr
    Abs.OperatorFunctor op -> pure $ EOperator op

accumulateApplication :: LookupFunction -> Expr -> Abs.Arg -> HierarchyMonad Expr
accumulateApplication lookupFun expr (Abs.ArgExpr argexpr) = do
  pexpr <- parseExpression lookupFun argexpr
  return $ EApply expr pexpr
accumulateApplication lookupFun expr (Abs.ArgFunc funct) =
  case funct of
    Abs.ThisFunctor -> pure $ EApply expr EThis
    Abs.SuperFunctor -> throwError $ VargException "Cannot pass super as function argument"
    Abs.InstanceFunctor (Abs.LIdent var) -> pure $ EApply expr $ EVar var
    Abs.TypeFunctor (Abs.UIdent _class) -> pure $ EApply expr $ EClass _class --TODO: is EClass a function?
    Abs.MemberFunctor (Abs.MFun name) -> pure $ EMember expr (drop 1 name)
    Abs.ExprFunctor fexpr -> do
      pexpr <- parseExpression lookupFun fexpr
      return $ EApply expr pexpr
    Abs.OperatorFunctor op -> pure $ EApply expr $ EOperator op

makeList :: LookupFunction -> Expr -> Abs.Expr -> HierarchyMonad Expr
makeList lookupFun head newfirst = do
  pfirst <- parseExpression lookupFun newfirst
  return $ EApply (EMember head ":") pfirst

parseExpression :: LookupFunction -> Abs.Expr -> HierarchyMonad Expr
parseExpression lookupFun expr =
  case expr of
    Abs.EInt val -> pure $ EInt val
    Abs.EReal val -> pure $ EDouble val
    Abs.EBoolean val ->
      pure $
      if val == Abs.ETrue
        then EBool True
        else EBool False
    Abs.EChar val -> pure $ EChar val
    Abs.EWild -> pure EWild
    Abs.EDefinition (Abs.IDefinition letdef (Abs.LIdent name)) expr -> do
      letd <- parseExpression lookupFun letdef
      exprd <- parseExpression lookupFun expr
      return $ ELet name letd exprd
    Abs.EDefinitionsList [h] expr -> parseExpression lookupFun $ Abs.EDefinition h expr
    Abs.EDefinitionsList (Abs.IDefinition letdef (Abs.LIdent name):t) expr -> do
      rest <- parseExpression lookupFun $ Abs.EDefinitionsList t expr
      letd <- parseExpression lookupFun letdef
      return $ ELet name letd rest
    Abs.ELambda [argdef] typedef body --TODO: allow inferred typedefs
     -> do
      (name, pargtdef) <- parseArgDef lookupFun argdef
      rettdef <- parseTypeDef lookupFun typedef
      pbody <- parseExpression lookupFun body
      return $ ELambda name pargtdef rettdef pbody
    Abs.ELambda (h:t) typedef body -> do
      (name, pargtdef) <- parseArgDef lookupFun h
      pbody <- parseExpression lookupFun (Abs.ELambda t typedef body)
      let (ELambda _ argtype rettype _) = pbody
      let frettype = ConcreteType "Function" [Exact argtype, Exact rettype]
      return $ ELambda name pargtdef frettype pbody
    Abs.EApply funct args -> do
      leading <- parseLeadingFunctorial lookupFun funct
      foldM (accumulateApplication lookupFun) leading args
    Abs.EList lelems -> do
      let elems = reverse $ map (\(Abs.EListElem expr) -> expr) lelems
      foldM (makeList lookupFun) (EClass "List.Empty") elems
    Abs.EIfThenElse expr1 expr2 expr3 -> do
      pe1 <- parseExpression lookupFun expr1
      pe2 <- parseExpression lookupFun expr2
      pe3 <- parseExpression lookupFun expr3
      return $ EIfThenElse pe1 pe2 pe3
    Abs.EString str ->
      let chars = map (Abs.EListElem . Abs.EChar) str
       in parseExpression lookupFun $ Abs.EList chars
    Abs.EMatch mexpr matchclauses -> do
      pm <- parseExpression lookupFun mexpr
      pclauses <-
        mapM
          (\(Abs.IMatchClause e1 e2) -> do
             pe1 <- parseExpression lookupFun e1
             pe2 <- parseExpression lookupFun e2
             return (pe1, pe2))
          matchclauses
      return $ EMatch pm pclauses
    --arithmetic exprs
    Abs.ENot expr -> do
      p <- parseExpression lookupFun expr
      return $ ENot p
    Abs.EMod expr1 expr2 -> do
      p1 <- parseExpression lookupFun expr1
      p2 <- parseExpression lookupFun expr2
      return $ EMod p1 p2
    Abs.EAdd expr1 expr2 -> do
      p1 <- parseExpression lookupFun expr1
      p2 <- parseExpression lookupFun expr2
      return $ EAdd p1 p2
    Abs.ESub expr1 expr2 -> do
      p1 <- parseExpression lookupFun expr1
      p2 <- parseExpression lookupFun expr2
      return $ ESub p1 p2
    Abs.EOr expr1 expr2 -> do
      p1 <- parseExpression lookupFun expr1
      p2 <- parseExpression lookupFun expr2
      return $ EOr p1 p2
    Abs.EAnd expr1 expr2 -> do
      p1 <- parseExpression lookupFun expr1
      p2 <- parseExpression lookupFun expr2
      return $ EAnd p1 p2
    Abs.EMul expr1 expr2 -> do
      p1 <- parseExpression lookupFun expr1
      p2 <- parseExpression lookupFun expr2
      return $ EMul p1 p2
    Abs.EDiv expr1 expr2 -> do
      p1 <- parseExpression lookupFun expr1
      p2 <- parseExpression lookupFun expr2
      return $ EDiv p1 p2
    Abs.EPow expr1 expr2 -> do
      p1 <- parseExpression lookupFun expr1
      p2 <- parseExpression lookupFun expr2
      return $ EPow p1 p2
    Abs.ELt expr1 expr2 -> do
      p1 <- parseExpression lookupFun expr1
      p2 <- parseExpression lookupFun expr2
      return $ ELt p1 p2
    Abs.EGt expr1 expr2 -> do
      p1 <- parseExpression lookupFun expr1
      p2 <- parseExpression lookupFun expr2
      return $ EGt p1 p2
    Abs.ELeq expr1 expr2 -> do
      p1 <- parseExpression lookupFun expr1
      p2 <- parseExpression lookupFun expr2
      return $ ELeq p1 p2
    Abs.EGeq expr1 expr2 -> do
      p1 <- parseExpression lookupFun expr1
      p2 <- parseExpression lookupFun expr2
      return $ EGeq p1 p2
    Abs.EEq expr1 expr2 -> do
      p1 <- parseExpression lookupFun expr1
      p2 <- parseExpression lookupFun expr2
      return $ EEq p1 p2
    _ -> throwError $ VargException $ "Cannot parse " ++ show expr
