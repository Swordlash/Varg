{-  Source parsing module
    Transforming expressions from BNFC parser
    into internal representation              -}
module Expressions where

import           PreprocessingState
import           TypeDefParser

import qualified AbsVarg            as Abs
import qualified Data.Map           as M
import qualified Data.Set           as S

nshow Abs.Op_plus   = "+"
nshow Abs.Op_minus  = "-"
nshow Abs.Op_mul    = "*"
nshow Abs.Op_div    = "/"
nshow Abs.Op_pow    = "^"
nshow Abs.Op_less   = "<"
nshow Abs.Op_gr     = ">"
nshow Abs.Op_leq    = "<="
nshow Abs.Op_geq    = ">="
nshow Abs.Op_eq     = "=="
nshow Abs.Op_cons   = ":"
nshow Abs.Op_appl   = "$"
nshow Abs.Op_append = "++"

{-
parseFunctorial :: Lookup -> Abs.Functorial -> HierarchyMonad Expr
parseFunctorial lookupFun funct =
  case funct of
    Abs.ThisFunctor -> pure EThis
    Abs.SuperFunctor -> pure ESuper
    Abs.InstanceFunctor (Abs.LIdent var) -> pure $ EVar var
    Abs.TypeFunctor (Abs.UIdent _class) -> pure $ EClass _class
    Abs.MemberFunctor _ -> throwException "The leading application functor cannot be .ident"
    Abs.ExprFunctor expr -> parseExpression lookupFun expr
    Abs.OperatorFunctor op -> pure $ EOperator op


accumulateApplication :: Lookup -> Expr -> Abs.Arg -> HierarchyMonad Expr
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
makeList :: Lookup -> Expr -> Abs.Expr -> HierarchyMonad Expr
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
parseExpression :: Lookup -> Abs.Expr -> HierarchyMonad Expr
parseExpression lookupFun expr =
  case expr of
    Abs.EInt val -> pure $ EInt val
    Abs.EReal val -> pure $ EDouble val
    Abs.EBoolean Abs.ETrue -> pure $ EBool True
    Abs.EBoolean Abs.EFalse -> pure $ EBool False
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
    Abs.EUnify e1 e2 ine3 -> 
      EUnify 
      <$> parseExpression lookupFun e1 
      <*> parseExpression lookupFun e2 
      <*> parseExpression lookupFun ine3
    Abs.ELambda [argdef] typedef body --TODO: allow inferred typedefs
     -> uncurry ELambda 
      <$> parseArgDef lookupFun argdef
      <*> parseTypeDef lookupFun typedef
      <*> parseExpression lookupFun body
    Abs.ELambda (h:t) typedef body -> do
      (name, pargtdef) <- parseArgDef lookupFun h
      pbody <- parseExpression lookupFun (Abs.ELambda t typedef body)
      let (ELambda _ argtype rettype _) = pbody
      let frettype = ConcreteType "Function" [Exact argtype, Exact rettype]
      return $ ELambda name pargtdef frettype pbody
    Abs.EInferredLambda t body -> parseExpression lookupFun $ Abs.ELambda t (Abs.ConcreteType (Abs.UIdent "?") []) body
      --FIXME : change that to some AnyType
    Abs.EApply expr (Abs.EMember (Abs.MFun name)) -> flip EMember (drop 1 name) <$> parseExpression lookupFun expr
    Abs.EApply func arg -> 
      EApply
      <$> parseExpression lookupFun func
      <*> parseExpression lookupFun arg
    Abs.EList lelems -> let elems = reverse $ map (\(Abs.EListElem expr) -> expr) lelems in
      foldM (makeList lookupFun) (EMember (EClass "List") "Empty") elems
    Abs.ERange beg end -> 
      ERange 
      <$> parseExpression lookupFun beg
      <*> parseExpression lookupFun end
    Abs.ERangeFr beg -> flip ERange EWild <$> parseExpression lookupFun beg
    Abs.EEmptyList -> pure $ EMember (EClass "List") "Empty"
    Abs.EAppend e1 e2 -> 
      EAppend 
      <$> parseExpression lookupFun e1
      <*> parseExpression lookupFun e2
    Abs.EIfThenElse expr1 expr2 expr3 -> 
      EIfThenElse 
      <$> parseExpression lookupFun expr1
      <*> parseExpression lookupFun expr2
      <*> parseExpression lookupFun expr3
    Abs.EString str -> pure $ EString str
    Abs.ECompose expr1 expr2 -> 
      EComp
      <$> parseExpression lookupFun expr1
      <*> parseExpression lookupFun expr2
    Abs.ECons hd tl -> 
      ECons 
      <$> parseExpression lookupFun hd
      <*> parseExpression lookupFun tl
    Abs.ESCons hd tl ->  
      ESCons 
      <$> parseExpression lookupFun hd
      <*> parseExpression lookupFun tl
    Abs.EOp expr1 (Abs.Op name) expr2 -> 
      (\x y -> EApply (EMember x name) y)
      <$> parseExpression lookupFun expr1
      <*> parseExpression lookupFun expr2
    Abs.EMemberAsFun (Abs.LIdent name) ->
      parseExpression lookupFun $
      Abs.ELambda
        [Abs.InferredArgumentDef (Abs.LIdent "x")]
        (Abs.ConcreteType (Abs.UIdent "Any") [])
        (Abs.EApply (Abs.EVar $ Abs.LIdent "x") (Abs.EMember (Abs.MFun $ "." ++ name)))
    Abs.ELambdaMatch matchclauses -> 
      (\pclauses -> ELambda "matchvar" AnyType AnyType (EMatch (EVar "matchvar") pclauses))
      <$> mapM (\(Abs.IMatchClause e1 e2) -> (,) <$> parseExpression lookupFun e1 <*> parseExpression lookupFun e2) matchclauses 
      -- FIXME: what about types?
    Abs.EMatch mexpr matchclauses -> 
      EMatch
      <$> parseExpression lookupFun mexpr
      <*> mapM (\(Abs.IMatchClause e1 e2) -> (,) <$> parseExpression lookupFun e1 <*> parseExpression lookupFun e2) matchclauses
    Abs.ETuple front exprs -> 
      ETuple <$> ((:) <$> parseExpression lookupFun front <*> mapM (\(Abs.EListElem expr) -> parseExpression lookupFun expr) exprs)
    
    --arithmetic exprs
    Abs.ENot expr -> ENot <$> parseExpression lookupFun expr
    Abs.EMod expr1 expr2 -> 
      EMod 
      <$> parseExpression lookupFun expr1
      <*> parseExpression lookupFun expr2
    Abs.EAdd expr1 expr2 -> 
      EAdd
      <$> parseExpression lookupFun expr1
      <*> parseExpression lookupFun expr2
    Abs.ESub expr1 expr2 -> 
      ESub
      <$> parseExpression lookupFun expr1
      <*> parseExpression lookupFun expr2
    Abs.EOr expr1 expr2 -> 
      EOr 
      <$> parseExpression lookupFun expr1
      <*> parseExpression lookupFun expr2
    Abs.EAnd expr1 expr2 -> 
      EAnd 
      <$> parseExpression lookupFun expr1
      <*> parseExpression lookupFun expr2
    Abs.EMul expr1 expr2 -> 
      EMul 
      <$> parseExpression lookupFun expr1
      <*> parseExpression lookupFun expr2
    Abs.EDiv expr1 expr2 -> 
      EDiv 
      <$> parseExpression lookupFun expr1
      <*> parseExpression lookupFun expr2
    Abs.EPow expr1 expr2 -> 
      EPow 
      <$> parseExpression lookupFun expr1
      <*> parseExpression lookupFun expr2
    Abs.ELt expr1 expr2 -> 
      ELt 
      <$> parseExpression lookupFun expr1
      <*> parseExpression lookupFun expr2
    Abs.EGt expr1 expr2 -> 
      EGt 
      <$> parseExpression lookupFun expr1
      <*> parseExpression lookupFun expr2
    Abs.ELeq expr1 expr2 -> 
      ELeq 
      <$> parseExpression lookupFun expr1
      <*> parseExpression lookupFun expr2
    Abs.EGeq expr1 expr2 -> 
      EGeq 
      <$> parseExpression lookupFun expr1
      <*> parseExpression lookupFun expr2
    Abs.EEq expr1 expr2 -> 
      EEq 
      <$> parseExpression lookupFun expr1
      <*> parseExpression lookupFun expr2
    Abs.EAppl expr1 expr2 -> 
      EApply 
      <$> parseExpression lookupFun expr1
      <*> parseExpression lookupFun expr2
    Abs.ENeq expr1 expr2 -> 
      ENeq 
      <$> parseExpression lookupFun expr1
      <*> parseExpression lookupFun expr2
    Abs.ENeg expr -> ENeg <$> parseExpression lookupFun expr
    _ -> throwException $ "Cannot parse " ++ show expr ++ ". Not implemented."
