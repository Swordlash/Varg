module Types where

import qualified AbsVarg   as AV
import           Data.List (intercalate)
import qualified Data.Set  as S
import           Instances
import           PrintVarg

type TypeName = String

type MemberName = String

type Instance = Inst Expr Type

typeof :: Instance -> String
typeof (IntInstance _)             = "Int"
typeof (DoubleInstance _)          = "Double"
typeof (BoolInstance _)            = "Bool"
typeof (CharInstance _)            = "Char"
typeof (FunctionInstance _)        = "Function"
typeof TypeInstance {baseType = t} = qualifiedTypeName t

data Expr
  = Unparsed AV.Expr
  | EInterpreted Instance
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
  | EMod Expr
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
  | ELt Expr
        Expr
  | EGt Expr
        Expr
  | ELeq Expr
         Expr
  | EGeq Expr
         Expr
  | EEq Expr
        Expr
  | ENot Expr
  | EOr Expr
        Expr
  | EAnd Expr
         Expr
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
  deriving (Eq, Ord)

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
  show (EMod e1 e2) = show e1 ++ " mod " ++ show e2
  show (EAdd e1 e2) = show e1 ++ " + " ++ show e2
  show (ESub e1 e2) = show e1 ++ " - " ++ show e2
  show (EMul e1 e2) = show e1 ++ " * " ++ show e2
  show (EDiv e1 e2) = show e1 ++ " / " ++ show e2
  show (EPow e1 e2) = show e1 ++ " ^ " ++ show e2
  show (ELt e1 e2) = show e1 ++ " < " ++ show e2
  show (EGt e1 e2) = show e1 ++ " > " ++ show e2
  show (ELeq e1 e2) = show e1 ++ " <= " ++ show e2
  show (EGeq e1 e2) = show e1 ++ " >= " ++ show e2
  show (EEq e1 e2) = show e1 ++ " == " ++ show e2
  show (ENot e1) = "not " ++ show e1
  show (EOr e1 e2) = show e1 ++ " || " ++ show e2
  show (EAnd e1 e2) = show e1 ++ " && " ++ show e2
  show (EClass name) = name
  show (EBool val) = show val
  show (EInt val) = show val
  show (EChar val) = show val
  show (EDouble val) = show val
  show (EFunctor val) = "@" ++ show val
  show EWild = "_"
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

voidTypeDef :: TypeDef
voidTypeDef = ConcreteType "Void" []

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

emptyFunction :: MemberName -> Function
emptyFunction name = Function [] name AnyType AnyType EEmpty

functionToTypedef :: Function -> TypeDef
functionToTypedef (Function _ _ int outt _) = ConcreteType "Function" [Exact int, Exact outt]

instance Eq Function where
  f1 == f2 = qualifiedFunName f1 == qualifiedFunName f2 -- &&
    --(functionInputType f1 == functionInputType f2) && (functionOutputType f1 == functionOutputType f2)

instance Show Function where
  show (Function modifs name int outt b) =
    case show int of
      "Void" -> unwords (map show modifs) ++ "function " ++ name ++ " : " ++ show outt ++ " = " ++ show b
      _ ->
        unwords (map show modifs) ++ "function " ++ name ++ " : " ++ show int ++ " -> " ++ show outt ++ " = " ++ show b

instance Ord Function where
  f1 <= f2 = qualifiedFunName f1 <= qualifiedFunName f2 -- &&
    -- (functionInputType f1 <= functionInputType f2) && (functionOutputType f1 <= functionOutputType f2)

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
  | IntType Integer
  | RealType Double
  | BoolType Bool
  | Type { qualifiedTypeName    :: TypeName
         , supertype            :: DerivationKind
         , implementing         :: [DerivationKind]
         , typeVariants         :: S.Set Variant
         , typeParamCount       :: Int
         , typeParamConstraints :: [[TypeParamConstraint]]
         , typeMembers          :: S.Set Function }

emptyType :: TypeName -> Type
emptyType name = Type name voidDerivation [] S.empty 0 [] S.empty

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

instance Eq Type where
  t1 == t2 = qualifiedTypeName t1 == qualifiedTypeName t2

instance Ord Type where
  t1 <= t2 = qualifiedTypeName t1 <= qualifiedTypeName t2
