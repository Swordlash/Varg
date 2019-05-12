module Instances where

import           Data.List (intercalate)
import qualified Data.Map  as M

data TypeParam
  = Primitive String
  | Template String
             [TypeParam]
  deriving (Eq, Ord)

instance Show TypeParam where
  show (Primitive str) = str
  show (Template str params) = str ++ " (" ++ intercalate ")(" (map show params)

type Clos e t = M.Map String (Inst e t)

data Inst e t
  = IntInstance Integer
  | DoubleInstance Double
  | CharInstance Char
  | BoolInstance Bool
  | FunctionInstance e
  | TypeInstance { baseType        :: t
                 , typeVariantName :: String
                 , instanceParams  :: [TypeParam]
                 , fields          :: [(String, Inst e t)]
                 , instanceEnv     :: Clos e t }
  deriving (Eq, Ord)

instance (Show t, Show e) => Show (Inst e t) where
  show (IntInstance val) = show val
  show (DoubleInstance val) = show val
  show (CharInstance val) = "'" ++ show val ++ "'"
  show (BoolInstance val) = show val
  show (FunctionInstance expr) = "function " ++ show expr
  show (TypeInstance base var params flds env) =
    "Class " ++
    show base ++
    " of variant " ++
    var ++
    ", with params " ++
    unwords (map show params) ++
    ").\n" ++ "Fields: " ++ intercalate "\n\t" (map show flds) ++ "\nClosure: \n" ++ show (M.toList env)
