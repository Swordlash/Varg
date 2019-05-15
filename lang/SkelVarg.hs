module SkelVarg where

-- Haskell module generated by the BNF converter
import           AbsVarg
import           ErrM

type Result = Err String

failure :: Show a => a -> Result
failure x = Bad $ "Undefined case: " ++ show x

transUIdent :: UIdent -> Result
transUIdent x =
  case x of
    UIdent string -> failure x

transLIdent :: LIdent -> Result
transLIdent x =
  case x of
    LIdent string -> failure x

transMFun :: MFun -> Result
transMFun x =
  case x of
    MFun string -> failure x

transOp :: Op -> Result
transOp x =
  case x of
    Op string -> failure x

transProgramDef :: ProgramDef -> Result
transProgramDef x =
  case x of
    Program importdefs classdefs -> failure x

transImportDef :: ImportDef -> Result
transImportDef x =
  case x of
    Import string -> failure x

transConstrTypeParam :: ConstrTypeParam -> Result
transConstrTypeParam x =
  case x of
    InferredTypeParam lident                     -> failure x
    ConcreteTypeParam uident                     -> failure x
    WildcardTypeParam                            -> failure x
    SuperConstrainedTypeParam lident typedefs    -> failure x
    AnySuperConstrainedTypeParam typedefs        -> failure x
    DerivingConstrainedTypeParam lident typedefs -> failure x
    AnyDerivingConstrainedTypeParam typedefs     -> failure x

transTypeDef :: TypeDef -> Result
transTypeDef x =
  case x of
    ConcreteType uident constrtypeparams -> failure x
    InferredType lident constrtypeparams -> failure x

transPrimFreeType :: PrimFreeType -> Result
transPrimFreeType x =
  case x of
    ConcreteTypeFreeType freetypedef -> failure x
    TemplateFreeType lident          -> failure x
    ConcreteFreeType uident          -> failure x

transFreeTypeDef :: FreeTypeDef -> Result
transFreeTypeDef x =
  case x of
    FreeType uident primfreetypes         -> failure x
    InferredFreeType lident primfreetypes -> failure x

transArgDef :: ArgDef -> Result
transArgDef x =
  case x of
    ArgumentDefinition lident freetypedef -> failure x
    InferredArgumentDef lident            -> failure x

transSuperclassType :: SuperclassType -> Result
transSuperclassType x =
  case x of
    Superclass freetypedef -> failure x

transClassDef :: ClassDef -> Result
transClassDef x =
  case x of
    StructDefinition classmodifiers uident classfields -> failure x
    ClassDefinition classmodifiers uident isderiving isimplementing classcontents -> failure x
    TemplateDefinition classmodifiers uident constrtypeparams isderiving isimplementing classcontents -> failure x

transIsImplementing :: IsImplementing -> Result
transIsImplementing x =
  case x of
    Implementing superclasstypes -> failure x
    NotImplementing              -> failure x

transIsDeriving :: IsDeriving -> Result
transIsDeriving x =
  case x of
    Deriving superclasstype -> failure x
    NotDeriving             -> failure x

transClassModifier :: ClassModifier -> Result
transClassModifier x =
  case x of
    ClassModifier_module    -> failure x
    ClassModifier_interface -> failure x
    ClassModifier_sealed    -> failure x
    ClassModifier_native    -> failure x

transClassContents :: ClassContents -> Result
transClassContents x =
  case x of
    ClassContent memberdefs fundefs -> failure x

transMemberDef :: MemberDef -> Result
transMemberDef x =
  case x of
    EmptyMemberDefinition uident        -> failure x
    MemberDefinition uident classfields -> failure x

transFunDef :: FunDef -> Result
transFunDef x =
  case x of
    MemberFunctionDefinition functionmodifiers functionname funtemplateparams argdefs rettype expr -> failure x
    AbstractFunctionDefinition functionmodifiers functionname funtemplateparams argdefs absrettype -> failure x

transRetType :: RetType -> Result
transRetType x =
  case x of
    ReturnType freetypedef -> failure x
    InferredReturnType     -> failure x

transFunctionName :: FunctionName -> Result
transFunctionName x =
  case x of
    FFunction lident   -> failure x
    FOperator operator -> failure x
    FOperatorDef op    -> failure x

transOperator :: Operator -> Result
transOperator x =
  case x of
    Op_plus  -> failure x
    Op_minus -> failure x
    Op_mul   -> failure x
    Op_div   -> failure x
    Op_pow   -> failure x
    Op_less  -> failure x
    Op_gr    -> failure x
    Op_leq   -> failure x
    Op_geq   -> failure x
    Op_eq    -> failure x
    Op_cons  -> failure x

transAbsRetType :: AbsRetType -> Result
transAbsRetType x =
  case x of
    AbsReturnType freetypedef -> failure x
    AbsInferredReturnType     -> failure x

transFunTemplateParams :: FunTemplateParams -> Result
transFunTemplateParams x =
  case x of
    NoFunctionTemplateParameter               -> failure x
    FunctionTemplateParameters templateparams -> failure x

transTemplateParam :: TemplateParam -> Result
transTemplateParam x =
  case x of
    TemplateParameter constrtypeparam -> failure x

transFunctionModifier :: FunctionModifier -> Result
transFunctionModifier x =
  case x of
    FunctionModifier_static    -> failure x
    FunctionModifier_internal  -> failure x
    FunctionModifier_implement -> failure x
    FunctionModifier_final     -> failure x
    FunctionModifier_unique    -> failure x
    FunctionModifier_native    -> failure x

transClassField :: ClassField -> Result
transClassField x =
  case x of
    ModifiedClassField fieldmodifier lident freetypedef -> failure x
    NormalClassField lident freetypedef                 -> failure x

transFieldModifier :: FieldModifier -> Result
transFieldModifier x =
  case x of
    FieldModifier_internal -> failure x
    FieldModifier_unique   -> failure x

transExpr :: Expr -> Result
transExpr x =
  case x of
    EDefinitionsList letdefs expr -> failure x
    EDefinition letdef expr       -> failure x
    EMatch expr matchclauses      -> failure x
    EIfThenElse expr1 expr2 expr3 -> failure x
    EUnify expr1 expr2 expr3      -> failure x
    ELambda argdefs typedef expr  -> failure x
    EInferredLambda argdefs expr  -> failure x
    EList listelems               -> failure x
    EEmptyList                    -> failure x
    ERange integer1 integer2      -> failure x
    ENeg expr                     -> failure x
    ECons expr1 expr2             -> failure x
    EOp expr1 op expr2            -> failure x
    EEq expr1 expr2               -> failure x
    ENeq expr1 expr2              -> failure x
    EMod expr1 expr2              -> failure x
    ENot expr                     -> failure x
    EOr expr1 expr2               -> failure x
    EAnd expr1 expr2              -> failure x
    ELt expr1 expr2               -> failure x
    EGt expr1 expr2               -> failure x
    ELeq expr1 expr2              -> failure x
    EGeq expr1 expr2              -> failure x
    EAdd expr1 expr2              -> failure x
    ESub expr1 expr2              -> failure x
    EMul expr1 expr2              -> failure x
    EDiv expr1 expr2              -> failure x
    EPow expr1 expr2              -> failure x
    ECompose expr1 expr2          -> failure x
    EBoolean boolean              -> failure x
    EThis                         -> failure x
    ESuper                        -> failure x
    EVar lident                   -> failure x
    EType uident                  -> failure x
    EMember mfun                  -> failure x
    EOperator operator            -> failure x
    EInt integer                  -> failure x
    EReal double                  -> failure x
    EChar char                    -> failure x
    EString string                -> failure x
    EWild                         -> failure x
    EApply expr1 expr2            -> failure x

transLetDef :: LetDef -> Result
transLetDef x =
  case x of
    IDefinition lident argdefs freetypedef expr -> failure x
    IInferredDefinition lident argdefs expr     -> failure x

transMatchClause :: MatchClause -> Result
transMatchClause x =
  case x of
    IMatchClause expr1 expr2 -> failure x

transListElem :: ListElem -> Result
transListElem x =
  case x of
    EListElem expr -> failure x

transBoolean :: Boolean -> Result
transBoolean x =
  case x of
    ETrue  -> failure x
    EFalse -> failure x
