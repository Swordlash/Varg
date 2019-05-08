module Instances where

import           Types

data TypeParam
  = Primitive String
  | Template String
             [TypeParam]

data Instance
  = IntInstance Int
  | DoubleInstance Double
  | CharInstance Char
  | BoolInstance Bool
  | TypeInstance { baseType       :: Type
                 , instanceParams :: [TypeParam]
                 , fields         :: [Instance] }
