module TypeDefs where

import Data.List (intercalate)

type TypeName = String

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