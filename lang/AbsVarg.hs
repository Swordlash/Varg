module AbsVarg where

-- Haskell module generated by the BNF converter
newtype UIdent =
  UIdent String
  deriving (Eq, Ord, Show, Read)

newtype LIdent =
  LIdent String
  deriving (Eq, Ord, Show, Read)

newtype MFun =
  MFun String
  deriving (Eq, Ord, Show, Read)

newtype Op =
  Op String
  deriving (Eq, Ord, Show, Read)

data ProgramDef =
  Program [ImportDef]
          [ClassDef]
  deriving (Eq, Ord, Show, Read)

data ImportDef =
  Import String
  deriving (Eq, Ord, Show, Read)

data ConstrTypeParam
  = InferredTypeParam LIdent
  | ConcreteTypeParam UIdent
  | WildcardTypeParam
  | SuperConstrainedTypeParam LIdent
                              [TypeDef]
  | AnySuperConstrainedTypeParam [TypeDef]
  | DerivingConstrainedTypeParam LIdent
                                 [TypeDef]
  | AnyDerivingConstrainedTypeParam [TypeDef]
  deriving (Eq, Ord, Show, Read)

data TypeDef
  = ConcreteType UIdent
                 [ConstrTypeParam]
  | InferredType LIdent
                 [ConstrTypeParam]
  deriving (Eq, Ord, Show, Read)

data PrimFreeType
  = ConcreteTypeFreeType FreeTypeDef
  | TemplateFreeType LIdent
  | ConcreteFreeType UIdent
  deriving (Eq, Ord, Show, Read)

data FreeTypeDef
  = FreeType UIdent
             [PrimFreeType]
  | InferredFreeType LIdent
                     [PrimFreeType]
  deriving (Eq, Ord, Show, Read)

data ArgDef
  = ArgumentDefinition LIdent
                       FreeTypeDef
  | InferredArgumentDef LIdent
  deriving (Eq, Ord, Show, Read)

data SuperclassType =
  Superclass FreeTypeDef
  deriving (Eq, Ord, Show, Read)

data ClassDef
  = StructDefinition [ClassModifier]
                     UIdent
                     [ClassField]
  | ClassDefinition [ClassModifier]
                    UIdent
                    IsDeriving
                    IsImplementing
                    ClassContents
  | TemplateDefinition [ClassModifier]
                       UIdent
                       [ConstrTypeParam]
                       IsDeriving
                       IsImplementing
                       ClassContents
  deriving (Eq, Ord, Show, Read)

data IsImplementing
  = Implementing [SuperclassType]
  | NotImplementing
  deriving (Eq, Ord, Show, Read)

data IsDeriving
  = Deriving SuperclassType
  | NotDeriving
  deriving (Eq, Ord, Show, Read)

data ClassModifier
  = ClassModifier_module
  | ClassModifier_interface
  | ClassModifier_sealed
  | ClassModifier_native
  deriving (Eq, Ord, Show, Read)

data ClassContents =
  ClassContent [MemberDef]
               [FunDef]
  deriving (Eq, Ord, Show, Read)

data MemberDef
  = EmptyMemberDefinition UIdent
                          DerivationDef
  | MemberDefinition UIdent
                     DerivationDef
                     [ClassField]
  deriving (Eq, Ord, Show, Read)

data DerivationDef
  = Derives UIdent
  | NotDerives
  deriving (Eq, Ord, Show, Read)

data FunDef
  = MemberFunctionDefinition [FunctionModifier]
                             FunctionName
                             FunTemplateParams
                             [ArgDef]
                             RetType
                             Expr
  | AbstractFunctionDefinition [FunctionModifier]
                               FunctionName
                               FunTemplateParams
                               [ArgDef]
                               AbsRetType
  deriving (Eq, Ord, Show, Read)

data RetType
  = ReturnType FreeTypeDef
  | InferredReturnType
  deriving (Eq, Ord, Show, Read)

data FunctionName
  = FFunction LIdent
  | FOperator Operator
  | FOperatorDef Op
  deriving (Eq, Ord, Show, Read)

data Operator
  = Op_plus
  | Op_minus
  | Op_mul
  | Op_div
  | Op_pow
  | Op_less
  | Op_gr
  | Op_leq
  | Op_geq
  | Op_eq
  | Op_cons
  | Op_scons
  | Op_appl
  deriving (Eq, Ord, Show, Read)

data AbsRetType
  = AbsReturnType FreeTypeDef
  | AbsInferredReturnType
  deriving (Eq, Ord, Show, Read)

data FunTemplateParams
  = NoFunctionTemplateParameter
  | FunctionTemplateParameters [TemplateParam]
  deriving (Eq, Ord, Show, Read)

data TemplateParam =
  TemplateParameter ConstrTypeParam
  deriving (Eq, Ord, Show, Read)

data FunctionModifier
  = FunctionModifier_static
  | FunctionModifier_internal
  | FunctionModifier_implement
  | FunctionModifier_final
  | FunctionModifier_unique
  | FunctionModifier_native
  deriving (Eq, Ord, Show, Read)

data ClassField
  = ModifiedClassField FieldModifier
                       LIdent
                       FreeTypeDef
  | NormalClassField LIdent
                     FreeTypeDef
  deriving (Eq, Ord, Show, Read)

data FieldModifier
  = FieldModifier_internal
  | FieldModifier_unique
  deriving (Eq, Ord, Show, Read)

data Expr
  = EDefinitionsList [LetDef]
                     Expr
  | EDefinition LetDef
                Expr
  | EMatch Expr
           [MatchClause]
  | ELambdaMatch [MatchClause]
  | EIfThenElse Expr
                Expr
                Expr
  | EUnify Expr
           Expr
           Expr
  | ELambda [ArgDef]
            TypeDef
            Expr
  | EInferredLambda [ArgDef]
                    Expr
  | EList [ListElem]
  | EEmptyList
  | ERange Expr
           Expr
  | ERangeFr Expr
  | EAppl Expr
          Expr
  | ECons Expr
          Expr
  | ESCons Expr
           Expr
  | EOp Expr
        Op
        Expr
  | EEq Expr
        Expr
  | ENeq Expr
         Expr
  | EMod Expr
         Expr
  | ENot Expr
  | EOr Expr
        Expr
  | EAnd Expr
         Expr
  | ELt Expr
        Expr
  | EGt Expr
        Expr
  | ELeq Expr
         Expr
  | EGeq Expr
         Expr
  | EAdd Expr
         Expr
  | ESub Expr
         Expr
  | EMul Expr
         Expr
  | EDiv Expr
         Expr
  | EPow Expr
         Expr
  | ECompose Expr
             Expr
  | ENeg Expr
  | EBoolean Boolean
  | EThis
  | ESuper
  | EVar LIdent
  | EType UIdent
  | EMember MFun
  | EOperator Operator
  | EInt Integer
  | EReal Double
  | EChar Char
  | EString String
  | EWild
  | EApply Expr
           Expr
  deriving (Eq, Ord, Show, Read)

data LetDef
  = IDefinition LIdent
                [ArgDef]
                FreeTypeDef
                Expr
  | IInferredDefinition LIdent
                        [ArgDef]
                        Expr
  deriving (Eq, Ord, Show, Read)

data MatchClause =
  IMatchClause Expr
               Expr
  deriving (Eq, Ord, Show, Read)

data ListElem =
  EListElem Expr
  deriving (Eq, Ord, Show, Read)

data Boolean
  = ETrue
  | EFalse
  deriving (Eq, Ord, Show, Read)
