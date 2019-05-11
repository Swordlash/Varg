module Types where

import qualified AbsVarg   as AV
import           Data.List (intercalate)
import qualified Data.Set  as S
import           PrintVarg

type TypeName = String

type MemberName = String

data Expr
  = Unparsed AV.Expr
  | ELambda String
            TypeDef
            TypeDef
            Expr
  | EMember Expr
            String
  | ELet String
         Expr
         Expr
  | EApply Expr
           Expr
  | EVar String
  | EFunctor String
  | EIfThenElse Expr
                Expr
                Expr
  | EMatch Expr
           [(Expr, Expr)]
  | EClass String
  | EBool Bool
  | EInt Integer
  | EChar Char
  | EDouble Double
  | EOperator AV.Operator
  | EWild
  | ENative
  | EAbstract
  | EConst
  | EThis
  | ESuper
  | EEmpty
  deriving (Eq)

instance Show Expr where
  show (Unparsed expr) = printTree expr
  show (ELambda name tdef retdef expr) =
    "(\\(" ++ name ++ " : " ++ show tdef ++ ") : " ++ show retdef ++ " -> " ++ show expr ++ ")"
  show (EMember obj func) = show obj ++ "." ++ func
  show (ELet label val expr) = "let " ++ label ++ " = " ++ show val ++ " in " ++ show expr
  show (EApply f x) = show f ++ "(" ++ show x ++ ")"
  show (EVar name) = name
  show (EIfThenElse ife thene elsee) = "if " ++ show ife ++ " then " ++ show thene ++ " else " ++ show elsee
  show (EMatch val table) = "match " ++ show val ++ " with \n" ++ conds ++ "\n"
    where
      conds = concatMap (\(e, v) -> show e ++ " -> " ++ show v ++ "\n") table
  show (EBool val) = show val
  show (EInt val) = show val
  show (EChar val) = show val
  show (EDouble val) = show val
  show (EFunctor val) = "@" ++ show val
  show EWild = "_"
  show (EClass name) = name
  show ENative = "native"
  show EAbstract = "abstract"
  show EConst = "const"
  show EThis = "this"
  show ESuper = "super"
  show EEmpty = "EMPTY"

data TypeDef
  = AnyType
  | InferredType String
                 [TypeParamConstraint]
                 [TypeParamConstraint]
  | ConcreteType TypeName
                 [TypeParamConstraint]
  deriving (Eq, Ord)

instance Show TypeDef where
  show AnyType = "AnyType"
  show (InferredType str mainconstrs constrs)
    | null constrs =
      if null mainconstrs
        then str
        else str ++ " " ++ intercalate "," (map show mainconstrs)
    | null mainconstrs = "[" ++ str ++ " " ++ intercalate "," (map show constrs) ++ "]"
    | otherwise =
      "[(" ++ str ++ " " ++ intercalate "," (map show mainconstrs) ++ ") " ++ intercalate "," (map show constrs) ++ "]"
  show (ConcreteType str constrs) =
    if null constrs
      then str
      else str ++ " (" ++ intercalate ") (" (map show constrs) ++ ")"

data TypeParamConstraint
  = Any
  | Exact TypeDef
  | Super TypeDef
  | Deriving TypeDef
  deriving (Eq, Ord)

instance Show TypeParamConstraint where
  show Any                = "?"
  show (Exact typedef)    = show typedef
  show (Super typedef)    = "super " ++ show typedef
  show (Deriving typedef) = "deriving " ++ show typedef

data TypeModifier
  = ModuleType
  | InterfaceType
  | SealedType
  | NativeType
  deriving (Eq)

instance Show TypeModifier where
  show ModuleType    = "module"
  show InterfaceType = "interface"
  show SealedType    = "sealed"
  show NativeType    = "native"

data MethodModifier
  = StaticMethod
  | InternalMethod
  | ImplementMethod
  | FinalMethod
  | UniqueMethod
  | NativeMethod
  deriving (Eq)

instance Show MethodModifier where
  show StaticMethod    = "static"
  show InternalMethod  = "internal"
  show ImplementMethod = "implement"
  show FinalMethod     = "final"
  show UniqueMethod    = "unique"
  show NativeMethod    = "native"

data FieldModifier
  = InternalField
  | UniqueField
  deriving (Eq)

instance Show FieldModifier where
  show InternalField = "internal"
  show UniqueField   = "unique"

data MemberModifier
  = MethodModifier
  | TypeModifier
  deriving (Eq, Show)

data Function = Function
  { functionModifiers  :: [MemberModifier]
  , qualifiedFunName   :: MemberName
  , functionInputType  :: TypeDef
  , functionOutputType :: TypeDef
  , functionBody       :: Expr
  }

functionToTypedef :: Function -> TypeDef
functionToTypedef (Function _ _ int outt _) = ConcreteType "Function" [Exact int, Exact outt]

instance Eq Function where
  f1 == f2 =
    (qualifiedFunName f1 == qualifiedFunName f2) &&
    (functionInputType f1 == functionInputType f2) && (functionOutputType f1 == functionOutputType f2)

instance Show Function where
  show (Function modifs name int outt b) =
    unwords (map show modifs) ++ "function " ++ name ++ " : " ++ show int ++ " -> " ++ show outt ++ " = " ++ show b

instance Ord Function where
  f1 <= f2 =
    (qualifiedFunName f1 <= qualifiedFunName f2) &&
    (functionInputType f1 <= functionInputType f2) && (functionOutputType f1 <= functionOutputType f2)

data DerivationKind
  = Unbound String
  | Concrete TypeName
             [DerivationKind]
  deriving (Eq, Ord)

instance Show DerivationKind where
  show (Unbound v) = v
  show (Concrete name []) = name
  show (Concrete name kinds) = name ++ " (" ++ intercalate ") (" (show <$> kinds) ++ ")"

voidDerivation :: DerivationKind
voidDerivation = Concrete "Void" []

functorialDerivation :: TypeName -> DerivationKind
functorialDerivation typename = Concrete "Function" [voidDerivation, Concrete typename []]

data Variant = Variant
  { variantName   :: TypeName
  , variantFields :: S.Set Function
  }

instance Eq Variant where
  v1 == v2 = variantName v1 == variantName v2

instance Ord Variant where
  v1 <= v2 = variantName v1 <= variantName v2

instance Show Variant where
  show (Variant vname fields) =
    "\n    " ++ vname ++ ":\n        " ++ intercalate "\n        " (map show (S.toList fields))

emptyVariant :: TypeName -> Variant
emptyVariant name = Variant name S.empty

data Type
  = VoidType
  | EmptyType TypeName
  | IntType Int
  | RealType Double
  | BoolType Bool
  | Type { qualifiedTypeName    :: TypeName
         , supertype            :: DerivationKind
         , implementing         :: [DerivationKind]
         , typeVariants         :: S.Set Variant
         , typeParamCount       :: Int
         , typeParamConstraints :: [[TypeParamConstraint]]
         , typeMembers          :: S.Set Function }
  deriving (Eq)

genParams :: Int -> [String]
genParams n = map (\n -> "_t" ++ show n) [0 .. (n - 1)]

instance Show Type where
  show VoidType = "Void"
  show (EmptyType name) = "I" ++ name
  show t =
    qualifiedTypeName t ++
    " " ++
    intercalate ", " (zipWith showParam params (typeParamConstraints t)) ++
    deriv ++
    impl ++
    intercalate "\n" (map show (S.toList $ typeVariants t)) ++
    "\n\n    " ++ intercalate "\n    " (map show (S.toList $ typeMembers t)) ++ "\n"
    where
      deriv = " deriving " ++ show (supertype t)
      impl = " implementing " ++ intercalate ", " (show <$> implementing t)
      params = genParams $ typeParamCount t
      showL ll = intercalate ", " $ map show ll
      showParam p constr =
        if null constr
          then p
          else "[" ++ p ++ " " ++ showL constr ++ "]"

instance Ord Type where
  t1 <= t2 = qualifiedTypeName t1 <= qualifiedTypeName t2
