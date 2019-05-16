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
nshow Abs.Op_cons  = ":"

{-
parseFunctorial :: LookupFunction -> Abs.Functorial -> HierarchyMonad Expr
parseFunctorial lookupFun funct =
  case funct of
    Abs.ThisFunctor -> pure EThis
    Abs.SuperFunctor -> pure ESuper
    Abs.InstanceFunctor (Abs.LIdent var) -> pure $ EVar var
    Abs.TypeFunctor (Abs.UIdent _class) -> pure $ EClass _class
    Abs.MemberFunctor _ -> throwException "The leading application functor cannot be .ident"
    Abs.ExprFunctor expr -> parseExpression lookupFun expr
    Abs.OperatorFunctor op -> pure $ EOperator op


accumulateApplication :: LookupFunction -> Expr -> Abs.Arg -> HierarchyMonad Expr
accumulateApplication lookupFun expr (Abs.ArgExpr argexpr) = do
  pexpr <- parseExpression lookupFun argexpr
  return $ EApply expr pexpr
accumulateApplication lookupFun expr (Abs.ArgFunc funct) =
  case funct of
    Abs.ThisFunctor -> pure $ EApply expr EThis
    Abs.SuperFunctor -> throwException "Cannot pass super as function argument"
    Abs.InstanceFunctor (Abs.LIdent var) -> pure $ EApply expr $ EVar var
    Abs.TypeFunctor (Abs.UIdent _class) -> pure $ EApply expr $ EClass _class --TODO: is EClass a function?
    Abs.MemberFunctor (Abs.MFun name) -> pure $ EMember expr (drop 1 name)
    Abs.ExprFunctor fexpr -> do
      pexpr <- parseExpression lookupFun fexpr
      return $ EApply expr pexpr
    Abs.OperatorFunctor op -> pure $ EApply expr $ EOperator op-}
makeList :: LookupFunction -> Expr -> Abs.Expr -> HierarchyMonad Expr
makeList lookupFun head newfirst = do
  pfirst <- parseExpression lookupFun newfirst
  return $ ECons pfirst head

shiftDefinition :: [(String, TypeDef)] -> TypeDef -> Expr -> HierarchyMonad (TypeDef, Expr)
shiftDefinition lst rettype body =
  case lst of
    [] -> pure (rettype, body)
    (s, td):t -> do
      (resttype, restbody) <- shiftDefinition t rettype body
      let t = ConcreteType "Function" [Exact td, Exact resttype]
      return (t, ELambda s td t restbody)

-- TODO: zaorać tę funkcję, jest mnóstwo boilerplate
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
    Abs.EThis -> pure EThis
    Abs.ESuper -> pure ESuper
    Abs.EVar (Abs.LIdent name) -> pure $ EVar name
    Abs.EType (Abs.UIdent name) -> pure $ EClass name
    Abs.EMember (Abs.MFun name) -> pure $ ELambda "x" AnyType AnyType (EMember (EVar "x") (drop 1 name))
    Abs.EOperator op -> pure $ EOperator op
    Abs.EDefinition (Abs.IInferredDefinition (Abs.LIdent name) argdefs expr) inexpr ->
      parseExpression lookupFun $
      Abs.EDefinition
        (Abs.IDefinition (Abs.LIdent name) argdefs (Abs.FreeType (Abs.UIdent "?") []) expr)
        inexpr -- FIXME: same as in lambda
    Abs.EDefinition (Abs.IDefinition (Abs.LIdent name) argdefs ftdef expr) inexpr -> do
      pexpr <- parseExpression lookupFun expr
      pinexpr <- parseExpression lookupFun inexpr
      pftdef <- parseFreeTypeDef lookupFun ftdef
      namespargdefs <- mapM (parseArgDef lookupFun) argdefs
      (tdef, shifted) <- shiftDefinition namespargdefs pftdef pexpr
      return $ ELet name shifted tdef pinexpr
    Abs.EDefinitionsList [h] expr -> parseExpression lookupFun $ Abs.EDefinition h expr
    Abs.EDefinitionsList (h:t) expr -> parseExpression lookupFun (Abs.EDefinition h (Abs.EDefinitionsList t expr))
    Abs.EUnify e1 e2 ine3 -> do
      p1 <- parseExpression lookupFun e1
      p2 <- parseExpression lookupFun e2
      p3 <- parseExpression lookupFun ine3
      return $ EUnify p1 p2 p3
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
    Abs.EInferredLambda t body -> parseExpression lookupFun $ Abs.ELambda t (Abs.ConcreteType (Abs.UIdent "?") []) body
      --FIXME : change that to some AnyType
    Abs.EApply expr (Abs.EMember (Abs.MFun name)) -> do
      pexpr <- parseExpression lookupFun expr
      return $ EMember pexpr (drop 1 name)
    Abs.EApply func arg -> do
      pfunc <- parseExpression lookupFun func
      parg <- parseExpression lookupFun arg
      return $ EApply pfunc parg
    Abs.EList lelems -> do
      let elems = reverse $ map (\(Abs.EListElem expr) -> expr) lelems
      foldM (makeList lookupFun) (EMember (EClass "List") "Empty") elems
    Abs.ERange beg end -> parseExpression lookupFun $ Abs.EList $ map (Abs.EListElem . Abs.EInt) [beg .. end]
    Abs.EEmptyList -> pure $ EMember (EClass "List") "Empty"
    Abs.EIfThenElse expr1 expr2 expr3 -> do
      pe1 <- parseExpression lookupFun expr1
      pe2 <- parseExpression lookupFun expr2
      pe3 <- parseExpression lookupFun expr3
      return $ EIfThenElse pe1 pe2 pe3
    Abs.EString str -> pure $ EString str
    Abs.ECompose expr1 expr2 -> do
      p1 <- parseExpression lookupFun expr1
      p2 <- parseExpression lookupFun expr2
      return $ EComp p1 p2
    Abs.ECons hd tl -> do
      phd <- parseExpression lookupFun hd
      ptl <- parseExpression lookupFun tl
      return $ ECons phd ptl
    Abs.EOp expr1 (Abs.Op name) expr2 -> do
      p1 <- parseExpression lookupFun expr1
      p2 <- parseExpression lookupFun expr2
      return $ EApply (EMember p1 name) p2
    Abs.ELambdaMatch matchclauses -> do
      pclauses <-
        mapM
          (\(Abs.IMatchClause e1 e2) -> do
             pe1 <- parseExpression lookupFun e1
             pe2 <- parseExpression lookupFun e2
             return (pe1, pe2))
          matchclauses
      return $ ELambda "matchvar" AnyType AnyType (EMatch (EVar "matchvar") pclauses) -- FIXME: what about types?
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
    Abs.ENeq expr1 expr2 -> do
      p1 <- parseExpression lookupFun expr1
      p2 <- parseExpression lookupFun expr2
      return $ ENeq p1 p2
    Abs.ENeg expr -> do
      p <- parseExpression lookupFun expr
      return $ ENeg p
    _ -> throwException $ "Cannot parse " ++ show expr ++ ". Not implemented."
