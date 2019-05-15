module FieldParser where

import           PreprocessingState

import qualified AbsVarg            as Abs
import qualified Data.Map           as M
import qualified Data.Set           as S

import           TypeDefParser

parseField :: Abs.ClassField -> HierarchyMonad (String, Function)
parseField (Abs.NormalClassField (Abs.LIdent fldname) freeTypeDef) =
  local
    (setParsedMember fldname)
    (do lookupFun <- readSubstsFromCurrentStub
        clname <- asks currentParsedMember
        fieldTypeDef <- parseFreeTypeDef lookupFun freeTypeDef
        return (fldname, Function [] (clname ++ "." ++ fldname) (ConcreteType "Void" []) fieldTypeDef EConst))

parseFields :: [Abs.ClassField] -> HierarchyMonad [(String, Function)]
parseFields [] = pure []
parseFields (field:t) = do
  parsedTail <- parseFields t
  (pname, parsed) <- parseField field
  if pname `elem` map fst parsedTail
    then do
      typename <- asks currentParsedTypeName
      variant <- asks currentParsedTypeVariant
      throwException $ "In definition of " ++ typename ++ "." ++ variant ++ ": multiple definition of field " ++ pname
    else return $ (pname, parsed) : parsedTail
