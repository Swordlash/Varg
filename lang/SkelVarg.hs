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

transProgramDef :: ProgramDef -> Result
transProgramDef x =
  case x of
    Program importdefs classdefs -> failure x

transImportDef :: ImportDef -> Result
transImportDef x =
  case x of
    Import uident -> failure x

transConstrTypeParam :: ConstrTypeParam -> Result
transConstrTypeParam x =
  case x of
    InferredTypeParam lident                     -> failure x
    ConcreteTypeParam uident                     -> failure x
    WildcardTypeParam                            -> failure x
    AnotherClassTypeParam typedef                -> failure x
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
    ArgumentDefinition lident typedef -> failure x
    InferredArgumentDef lident        -> failure x

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
    MemberFunctionDefinition functionmodifiers lident argdefs rettype expr -> failure x
    AbstractFunctionDefinition functionmodifiers lident argdefs absrettype -> failure x

transRetType :: RetType -> Result
transRetType x =
  case x of
    ReturnType freetypedef -> failure x
    InferredReturnType     -> failure x

transAbsRetType :: AbsRetType -> Result
transAbsRetType x =
  case x of
    AbsReturnType freetypedef -> failure x
    AbsInferredReturnType     -> failure x

transFunctionModifier :: FunctionModifier -> Result
transFunctionModifier x =
  case x of
    FunctionModifier_static    -> failure x
    FunctionModifier_internal  -> failure x
    FunctionModifier_implement -> failure x
    FunctionModifier_final     -> failure x
    FunctionModifier_unique    -> failure x

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
    EDefinitionsList asdefs expr  -> failure x
    EDefinition asdef expr        -> failure x
    EMatch expr matchclauses      -> failure x
    EIfThenElse expr1 expr2 expr3 -> failure x
    EApply functorial args        -> failure x
    ELambda argdefs typedef expr  -> failure x
    EList listelems               -> failure x
    EEq expr1 expr2               -> failure x
    ELq expr1 expr2               -> failure x
    EGt expr1 expr2               -> failure x
    ELeq expr1 expr2              -> failure x
    EGeq expr1 expr2              -> failure x
    EAdd expr1 expr2              -> failure x
    ESub expr1 expr2              -> failure x
    EMul expr1 expr2              -> failure x
    EDiv expr1 expr2              -> failure x
    EPow expr1 expr2              -> failure x
    EInt integer                  -> failure x
    EReal double                  -> failure x
    EWild                         -> failure x

transAsDef :: AsDef -> Result
transAsDef x =
  case x of
    IDefinition expr lident -> failure x

transMatchClause :: MatchClause -> Result
transMatchClause x =
  case x of
    IMatchClause expr1 expr2 -> failure x

transFunctorial :: Functorial -> Result
transFunctorial x =
  case x of
    ThisFunctor            -> failure x
    SuperFunctor           -> failure x
    TypeFunctor uident     -> failure x
    InstanceFunctor lident -> failure x
    MemberFunctor mfun     -> failure x

transArg :: Arg -> Result
transArg x =
  case x of
    ArgExpr expr       -> failure x
    ArgFunc functorial -> failure x

transListElem :: ListElem -> Result
transListElem x =
  case x of
    EListElem expr -> failure x
