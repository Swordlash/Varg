module Types where

import qualified AbsVarg    as AV
import           Data.List  (intercalate)
import qualified Data.Map   as M
import           Data.Maybe
import qualified Data.Set   as S
import           Instances
import           PrintVarg

type TypeName = String

type MemberName = String

type Instance = Inst Function Type Expr

type Mapping a = M.Map String a

typeof :: Instance -> String
typeof (IntInstance _)             = "Int"
typeof (DoubleInstance _)          = "Double"
typeof (BoolInstance _)            = "Bool"
typeof (CharInstance _)            = "Char"
typeof (FunctionInstance f clos)   = show f
typeof (ThunkInstance _ _) = "Thunk"
typeof TypeInstance {baseType = t} = qualifiedTypeName t

ntake _ []    = []
ntake 0 _     = "..."
ntake n (h:t) = h : ntake (n - 1) t

show' inst = ntake 100 $ show inst

instance Show Instance where
  show (IntInstance val) = show val
  show (DoubleInstance val) = show val
  show (CharInstance val) = "'" ++ show val ++ "'"
  show (BoolInstance val) = show val
  show (FunctionInstance expr clos) = show expr -- ++ ", closure: " ++ show clos FIXME: show closure?
  show (ThunkInstance expr _) = show expr
  show t@(TypeInstance base var params flds) =
    case qualifiedTypeName base of
      "List" -> show (instanceListToList t)
      "String" ->
        if var == "Empty"
          then ""
          else (case lookup "head" flds of
                  Just (CharInstance ch) -> ch) :
               show (fromJust $ lookup "tail" flds)
      name -> name ++ "." ++ var ++ " (" ++ intercalate ")(" (map show params) ++ ") " ++ unwords (map show flds)

data Expr
  = Unparsed AV.Expr
  | EConstructor TypeName
                 String
                 [Expr]
  | EInterpreted Instance
  | EUnify Expr
           Expr
           Expr
  | ELambda String
            TypeDef
            TypeDef
            Expr
  | EMember Expr
            String
  | ELet String
         Expr
         TypeDef
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
  | ECons Expr
          Expr
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
  | ENeq Expr
         Expr
  | ENot Expr
  | EOr Expr
        Expr
  | EAnd Expr
         Expr
  | ENeg Expr
  | EOp Expr
        String
        Expr
  | EClass String
  | EComp Expr
          Expr
  | EBool Bool
  | EInt Integer
  | EChar Char
  | EString String
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
  show (EConstructor name str exprs) = name ++ "::" ++ str ++ unwords (map show exprs)
  show (ELambda name tdef retdef expr) =
    "(\\(" ++ name ++ " : " ++ show tdef ++ ") : " ++ show retdef ++ " -> " ++ show expr ++ ")"
  show (EInterpreted inst) = "Interpreted " ++ show inst
  show (EUnify e1 e2 ine3) = "unify " ++ show e1 ++ " with " ++ show e2 ++ " in " ++ show ine3
  show (EMember obj func) = show obj ++ "." ++ func
  show (ELet label val typ expr) = "let " ++ label ++ " : " ++ show typ ++ " = " ++ show val ++ " in " ++ show expr
  show (EApply f x) = show f ++ "(" ++ show x ++ ")"
  show (EVar name) = name
  show (EIfThenElse ife thene elsee) = "if " ++ show ife ++ " then " ++ show thene ++ " else " ++ show elsee
  show (EMatch val table) = "match " ++ show val ++ " with \n" ++ conds ++ "\n"
    where
      conds = concatMap (\(e, v) -> show e ++ " -> " ++ show v ++ "\n") table
  show (ECons e1 e2) = show e1 ++ " : " ++ show e2
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
  show (ENeq e1 e2) = show e1 ++ " /= " ++ show e2
  show (ENot e1) = "not " ++ show e1
  show (EOr e1 e2) = show e1 ++ " || " ++ show e2
  show (EAnd e1 e2) = show e1 ++ " && " ++ show e2
  show (EClass name) = name
  show (EBool val) = show val
  show (EInt val) = show val
  show (EString val) = show val
  show (EChar val) = show val
  show (EDouble val) = show val
  show (EFunctor val) = "@" ++ show val
  show (EOperator av) = "(" ++ show av ++ ")"
  show (EComp e1 e2) = show e1 ++ " . " ++ show e2
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
  show AnyType = "?"
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

data MemberModifier
  = StaticMember
  | InternalMember
  | ImplementMember
  | FinalMember
  | UniqueMember
  | NativeMember
  | ClassMember
  deriving (Eq, Ord)

instance Show MemberModifier where
  show StaticMember    = "static"
  show InternalMember  = "internal"
  show ImplementMember = "implement"
  show FinalMember     = "final"
  show UniqueMember    = "unique"
  show NativeMember    = "native"
  show ClassMember     = "<<class>>"

data Function = Function
  { functionModifiers  :: [MemberModifier]
  , functionName       :: String
  , functionInputType  :: TypeDef
  , functionOutputType :: TypeDef
  , functionBody       :: Expr
  } deriving (Eq, Ord)

emptyFunction :: Function
emptyFunction = Function [] "" AnyType AnyType EEmpty

functionToTypedef :: Function -> TypeDef
functionToTypedef (Function _ _ int outt _) = ConcreteType "Function" [Exact int, Exact outt]

showFunctionHeader :: Function -> String
showFunctionHeader (Function modifs name int outt b) =
  name ++
  " :: " ++
  case show int of
    "Void" -> unwords (map show modifs) ++ " " ++ show outt
    _ -> unwords (map show modifs) ++ " " ++ show int ++ " -> " ++ show outt

instance Show Function where
  show fn@Function {functionBody = b} = showFunctionHeader fn ++ " = " ++ show b

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
  , supervariant  :: TypeName
  , variantFields :: [(String, Function)]
    -- TODO: Think about storing only typedef and modifier, they're all Void -> Type
  }

instance Eq Variant where
  v1 == v2 = variantName v1 == variantName v2

instance Ord Variant where
  v1 <= v2 = variantName v1 <= variantName v2

instance Show Variant where
  show (Variant vname supervar fields) =
    "\n    " ++
    vname ++
    (if supervar == ""
       then ""
       else " derives " ++ supervar) ++
    ":\n        " ++ intercalate "\n        " (map (show . snd) fields)

emptyVariant :: TypeName -> TypeName -> Variant
emptyVariant name supervar = Variant name supervar []

data Type = Type
  { qualifiedTypeName    :: TypeName
  , supertype            :: DerivationKind
  , implementing         :: [DerivationKind]
  , typeVariants         :: S.Set Variant
  , typeParamCount       :: Int
  , typeParamConstraints :: [[TypeParamConstraint]]
  , typeMembers          :: Mapping Function
  }

emptyType :: TypeName -> Type
emptyType name = Type name voidDerivation [] S.empty 0 [] M.empty

voidType :: Type
voidType = Type "Void" (Concrete "Void" []) [] S.empty 0 [] M.empty

genParams :: Int -> [String]
genParams n = map (\n -> "_t" ++ show n) [0 .. (n - 1)]

instance Show Type where
  show t =
    qualifiedTypeName t ++
    " " ++
    intercalate ", " (zipWith showParam params (typeParamConstraints t)) ++
    deriv ++
    impl ++
    intercalate "\n" (map show (S.toList $ typeVariants t)) ++
    "\n\n    " ++ intercalate "\n    " (map (show . snd) (M.toList $ typeMembers t)) ++ "\n"
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
