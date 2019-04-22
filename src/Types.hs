module Types where

import qualified AbsVarg   as AV
import           Data.List (intercalate)
import qualified Data.Set  as S

type TypeName = String

type MemberName = String

data TypeDef
  = AnyType
  | InferredType String
                 [TypeParamConstraint]
  | ConcreteType TypeName
                 [TypeParamConstraint]
  deriving (Eq)

instance Show TypeDef where
  show AnyType = "AnyType"
  show (InferredType str constrs) =
    if null constrs
      then str
      else "[" ++ str ++ " " ++ intercalate "," (map show constrs) ++ "]"
  show (ConcreteType str constrs) =
    if null constrs
      then str
      else str ++ " (" ++ intercalate ") (" (map show constrs) ++ ")"

data TypeParamConstraint
  = Any
  | Exact TypeDef
  | Super TypeDef
  | Deriving TypeDef
  deriving (Eq)

instance Show TypeParamConstraint where
  show Any                = "?"
  show (Exact typedef)    = show typedef
  show (Super typedef)    = "super " ++ show typedef
  show (Deriving typedef) = "deriving " ++ show typedef

data TypeModifier
  = ModuleType
  | InterfaceType
  | SealedType

data MethodModifier
  = StaticMethod
  | InternalMethod
  | ImplementMethod
  | FinalMethod
  | UniqueMethod

data FieldModifier
  = InternalField
  | UniqueField

data FunctionBody
  = Const
  | Body AV.Expr
  deriving (Eq)

data Function = Function
  { qualifiedFunName   :: MemberName
  , functionInputType  :: TypeDef
  , functionOutputType :: TypeDef
  , functionBody       :: FunctionBody
  } deriving (Eq)

instance Show Function where
  show (Function name int outt _) = "function " ++ name ++ " : " ++ show int ++ " -> " ++ show outt

instance Ord Function where
  f1 <= f2 = qualifiedFunName f1 <= qualifiedFunName f2

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

data Instance
  = PrimInstance { instanceName :: String
                 , instanceType :: Type }
  | Instance { instanceName       :: String
             , instanceType       :: Type
             , instanceParameters :: [TypeName] }

genParams :: Int -> [String]
genParams n = map (\n -> "_t" ++ show n) [0 .. (n - 1)]

instance Show Type where
  show VoidType = "Void"
  show (EmptyType name) = "I" ++ name
  show t =
    qualifiedTypeName t ++
    " " ++
    intercalate ", " (zipWith showParam params (typeParamConstraints t)) ++
    deriv ++ impl ++ intercalate "\n" (map show (S.toList $ typeVariants t)) ++ "\n"
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
