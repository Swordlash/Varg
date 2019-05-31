{-# OPTIONS_GHC -fno-warn-incomplete-patterns #-}
module PrintVarg where

-- pretty-printer generated by the BNF converter

import AbsVarg
import Data.Char


-- the top-level printing method
printTree :: Print a => a -> String
printTree = render . prt 0

type Doc = [ShowS] -> [ShowS]

doc :: ShowS -> Doc
doc = (:)

render :: Doc -> String
render d = rend 0 (map ($ "") $ d []) "" where
  rend i ss = case ss of
    "["      :ts -> showChar '[' . rend i ts
    "("      :ts -> showChar '(' . rend i ts
    "{"      :ts -> showChar '{' . new (i+1) . rend (i+1) ts
    "}" : ";":ts -> new (i-1) . space "}" . showChar ';' . new (i-1) . rend (i-1) ts
    "}"      :ts -> new (i-1) . showChar '}' . new (i-1) . rend (i-1) ts
    ";"      :ts -> showChar ';' . new i . rend i ts
    t  : "," :ts -> showString t . space "," . rend i ts
    t  : ")" :ts -> showString t . showChar ')' . rend i ts
    t  : "]" :ts -> showString t . showChar ']' . rend i ts
    t        :ts -> space t . rend i ts
    _            -> id
  new i   = showChar '\n' . replicateS (2*i) (showChar ' ') . dropWhile isSpace
  space t = showString t . (\s -> if null s then "" else (' ':s))

parenth :: Doc -> Doc
parenth ss = doc (showChar '(') . ss . doc (showChar ')')

concatS :: [ShowS] -> ShowS
concatS = foldr (.) id

concatD :: [Doc] -> Doc
concatD = foldr (.) id

replicateS :: Int -> ShowS -> ShowS
replicateS n f = concatS (replicate n f)

-- the printer class does the job
class Print a where
  prt :: Int -> a -> Doc
  prtList :: Int -> [a] -> Doc
  prtList i = concatD . map (prt i)

instance Print a => Print [a] where
  prt = prtList

instance Print Char where
  prt _ s = doc (showChar '\'' . mkEsc '\'' s . showChar '\'')
  prtList _ s = doc (showChar '"' . concatS (map (mkEsc '"') s) . showChar '"')

mkEsc :: Char -> Char -> ShowS
mkEsc q s = case s of
  _ | s == q -> showChar '\\' . showChar s
  '\\'-> showString "\\\\"
  '\n' -> showString "\\n"
  '\t' -> showString "\\t"
  _ -> showChar s

prPrec :: Int -> Int -> Doc -> Doc
prPrec i j = if j<i then parenth else id


instance Print Integer where
  prt _ x = doc (shows x)


instance Print Double where
  prt _ x = doc (shows x)



instance Print UIdent where
  prt _ (UIdent i) = doc (showString ( i))


instance Print LIdent where
  prt _ (LIdent i) = doc (showString ( i))


instance Print MFun where
  prt _ (MFun i) = doc (showString ( i))


instance Print Op where
  prt _ (Op i) = doc (showString ( i))



instance Print ProgramDef where
  prt i e = case e of
    Program importdefs classdefs -> prPrec i 0 (concatD [prt 0 importdefs, prt 0 classdefs])

instance Print ImportDef where
  prt i e = case e of
    Import str -> prPrec i 0 (concatD [doc (showString "import"), prt 0 str])
  prtList _ [] = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, prt 0 xs])
instance Print ConstrTypeParam where
  prt i e = case e of
    InferredTypeParam lident -> prPrec i 0 (concatD [prt 0 lident])
    ConcreteTypeParam uident -> prPrec i 0 (concatD [prt 0 uident])
    WildcardTypeParam -> prPrec i 0 (concatD [doc (showString "?")])
    SuperConstrainedTypeParam lident typedefs -> prPrec i 0 (concatD [doc (showString "["), prt 0 lident, doc (showString "super"), prt 0 typedefs, doc (showString "]")])
    AnySuperConstrainedTypeParam typedefs -> prPrec i 0 (concatD [doc (showString "["), doc (showString "?"), doc (showString "super"), prt 0 typedefs, doc (showString "]")])
    DerivingConstrainedTypeParam lident typedefs -> prPrec i 0 (concatD [doc (showString "["), prt 0 lident, doc (showString "deriving"), prt 0 typedefs, doc (showString "]")])
    AnyDerivingConstrainedTypeParam typedefs -> prPrec i 0 (concatD [doc (showString "["), doc (showString "?"), doc (showString "deriving"), prt 0 typedefs, doc (showString "]")])
  prtList _ [] = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, prt 0 xs])
instance Print TypeDef where
  prt i e = case e of
    ConcreteType uident constrtypeparams -> prPrec i 0 (concatD [prt 0 uident, prt 0 constrtypeparams])
    InferredType lident constrtypeparams -> prPrec i 0 (concatD [prt 0 lident, prt 0 constrtypeparams])
  prtList _ [x] = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ","), prt 0 xs])
instance Print PrimFreeType where
  prt i e = case e of
    ConcreteTypeFreeType freetypedef -> prPrec i 0 (concatD [doc (showString "("), prt 0 freetypedef, doc (showString ")")])
    TemplateFreeType lident -> prPrec i 0 (concatD [prt 0 lident])
    ConcreteFreeType uident -> prPrec i 0 (concatD [prt 0 uident])
  prtList _ [] = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, prt 0 xs])
instance Print FreeTypeDef where
  prt i e = case e of
    FreeType uident primfreetypes -> prPrec i 0 (concatD [prt 0 uident, prt 0 primfreetypes])
    InferredFreeType lident primfreetypes -> prPrec i 0 (concatD [prt 0 lident, prt 0 primfreetypes])

instance Print ArgDef where
  prt i e = case e of
    ArgumentDefinition lident freetypedef -> prPrec i 0 (concatD [doc (showString "("), prt 0 lident, doc (showString ":"), prt 0 freetypedef, doc (showString ")")])
    InferredArgumentDef lident -> prPrec i 0 (concatD [prt 0 lident])
  prtList _ [] = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, prt 0 xs])
instance Print SuperclassType where
  prt i e = case e of
    Superclass freetypedef -> prPrec i 0 (concatD [prt 0 freetypedef])
  prtList _ [x] = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ","), prt 0 xs])
instance Print ClassDef where
  prt i e = case e of
    StructDefinition classmodifiers uident classfields -> prPrec i 0 (concatD [prt 0 classmodifiers, doc (showString "struct"), prt 0 uident, doc (showString "where"), doc (showString "{"), prt 0 classfields, doc (showString "}")])
    ClassDefinition classmodifiers uident isderiving isimplementing classcontents -> prPrec i 0 (concatD [prt 0 classmodifiers, doc (showString "class"), prt 0 uident, prt 0 isderiving, prt 0 isimplementing, doc (showString "where"), doc (showString "{"), prt 0 classcontents, doc (showString "}")])
    TemplateDefinition classmodifiers uident constrtypeparams isderiving isimplementing classcontents -> prPrec i 0 (concatD [prt 0 classmodifiers, doc (showString "template"), prt 0 uident, prt 0 constrtypeparams, prt 0 isderiving, prt 0 isimplementing, doc (showString "where"), doc (showString "{"), prt 0 classcontents, doc (showString "}")])
  prtList _ [] = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, prt 0 xs])
instance Print IsImplementing where
  prt i e = case e of
    Implementing superclasstypes -> prPrec i 0 (concatD [doc (showString "implementing"), prt 0 superclasstypes])
    NotImplementing -> prPrec i 0 (concatD [])

instance Print IsDeriving where
  prt i e = case e of
    Deriving superclasstype -> prPrec i 0 (concatD [doc (showString "deriving"), prt 0 superclasstype])
    NotDeriving -> prPrec i 0 (concatD [])

instance Print ClassModifier where
  prt i e = case e of
    ClassModifier_module -> prPrec i 0 (concatD [doc (showString "module")])
    ClassModifier_interface -> prPrec i 0 (concatD [doc (showString "interface")])
    ClassModifier_sealed -> prPrec i 0 (concatD [doc (showString "sealed")])
    ClassModifier_native -> prPrec i 0 (concatD [doc (showString "native")])
  prtList _ [] = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, prt 0 xs])
instance Print ClassContents where
  prt i e = case e of
    ClassContent memberdefs fundefs -> prPrec i 0 (concatD [prt 0 memberdefs, prt 0 fundefs])

instance Print MemberDef where
  prt i e = case e of
    EmptyMemberDefinition uident derivationdef -> prPrec i 0 (concatD [prt 0 uident, prt 0 derivationdef])
    MemberDefinition uident derivationdef classfields -> prPrec i 0 (concatD [prt 0 uident, prt 0 derivationdef, doc (showString "has"), doc (showString "{"), prt 0 classfields, doc (showString "}")])
  prtList _ [] = (concatD [])
  prtList _ [x] = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ";"), prt 0 xs])
instance Print DerivationDef where
  prt i e = case e of
    Derives uident -> prPrec i 0 (concatD [doc (showString "derives"), prt 0 uident])
    NotDerives -> prPrec i 0 (concatD [])

instance Print FunDef where
  prt i e = case e of
    MemberFunctionDefinition functionmodifiers functionname funtemplateparams argdefs rettype expr -> prPrec i 0 (concatD [prt 0 functionmodifiers, doc (showString "function"), prt 0 functionname, prt 0 funtemplateparams, prt 0 argdefs, prt 0 rettype, doc (showString "="), prt 0 expr])
    AbstractFunctionDefinition functionmodifiers functionname funtemplateparams argdefs absrettype -> prPrec i 0 (concatD [prt 0 functionmodifiers, doc (showString "function"), prt 0 functionname, prt 0 funtemplateparams, prt 0 argdefs, prt 0 absrettype])
  prtList _ [] = (concatD [])
  prtList _ [x] = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ";"), prt 0 xs])
instance Print RetType where
  prt i e = case e of
    ReturnType freetypedef -> prPrec i 0 (concatD [doc (showString ":"), prt 0 freetypedef])
    InferredReturnType -> prPrec i 0 (concatD [])

instance Print FunctionName where
  prt i e = case e of
    FFunction lident -> prPrec i 0 (concatD [prt 0 lident])
    FOperator operator -> prPrec i 0 (concatD [doc (showString "("), prt 0 operator, doc (showString ")")])
    FOperatorDef op -> prPrec i 0 (concatD [doc (showString "("), prt 0 op, doc (showString ")")])

instance Print Operator where
  prt i e = case e of
    Op_plus -> prPrec i 0 (concatD [doc (showString "+")])
    Op_minus -> prPrec i 0 (concatD [doc (showString "-")])
    Op_mul -> prPrec i 0 (concatD [doc (showString "*")])
    Op_div -> prPrec i 0 (concatD [doc (showString "/")])
    Op_pow -> prPrec i 0 (concatD [doc (showString "^")])
    Op_less -> prPrec i 0 (concatD [doc (showString "<")])
    Op_gr -> prPrec i 0 (concatD [doc (showString ">")])
    Op_leq -> prPrec i 0 (concatD [doc (showString "<=")])
    Op_geq -> prPrec i 0 (concatD [doc (showString ">=")])
    Op_eq -> prPrec i 0 (concatD [doc (showString "==")])
    Op_cons -> prPrec i 0 (concatD [doc (showString ":")])
    Op_scons -> prPrec i 0 (concatD [doc (showString ":'")])
    Op_appl -> prPrec i 0 (concatD [doc (showString "$")])
    Op_append -> prPrec i 0 (concatD [doc (showString "++")])

instance Print AbsRetType where
  prt i e = case e of
    AbsReturnType freetypedef -> prPrec i 0 (concatD [doc (showString ":"), doc (showString "abstract"), prt 0 freetypedef])
    AbsInferredReturnType -> prPrec i 0 (concatD [])

instance Print FunTemplateParams where
  prt i e = case e of
    NoFunctionTemplateParameter -> prPrec i 0 (concatD [])
    FunctionTemplateParameters templateparams -> prPrec i 0 (concatD [doc (showString "<"), prt 0 templateparams, doc (showString ">")])

instance Print TemplateParam where
  prt i e = case e of
    TemplateParameter constrtypeparam -> prPrec i 0 (concatD [prt 0 constrtypeparam])
  prtList _ [x] = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ","), prt 0 xs])
instance Print FunctionModifier where
  prt i e = case e of
    FunctionModifier_static -> prPrec i 0 (concatD [doc (showString "static")])
    FunctionModifier_internal -> prPrec i 0 (concatD [doc (showString "internal")])
    FunctionModifier_implement -> prPrec i 0 (concatD [doc (showString "implement")])
    FunctionModifier_final -> prPrec i 0 (concatD [doc (showString "final")])
    FunctionModifier_unique -> prPrec i 0 (concatD [doc (showString "unique")])
    FunctionModifier_native -> prPrec i 0 (concatD [doc (showString "native")])
  prtList _ [] = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, prt 0 xs])
instance Print ClassField where
  prt i e = case e of
    ModifiedClassField fieldmodifier lident freetypedef -> prPrec i 0 (concatD [prt 0 fieldmodifier, prt 0 lident, doc (showString ":"), prt 0 freetypedef])
    NormalClassField lident freetypedef -> prPrec i 0 (concatD [prt 0 lident, doc (showString ":"), prt 0 freetypedef])
  prtList _ [] = (concatD [])
  prtList _ [x] = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ";"), prt 0 xs])
instance Print FieldModifier where
  prt i e = case e of
    FieldModifier_internal -> prPrec i 0 (concatD [doc (showString "internal")])
    FieldModifier_unique -> prPrec i 0 (concatD [doc (showString "unique")])

instance Print Expr where
  prt i e = case e of
    EDefinitionsList letdefs expr -> prPrec i 0 (concatD [doc (showString "let"), doc (showString "{"), prt 0 letdefs, doc (showString "}"), doc (showString "in"), prt 0 expr])
    EDefinition letdef expr -> prPrec i 0 (concatD [doc (showString "let"), prt 0 letdef, doc (showString "in"), prt 0 expr])
    EMatch expr matchclauses -> prPrec i 0 (concatD [doc (showString "match"), prt 0 expr, doc (showString "with"), doc (showString "{"), prt 0 matchclauses, doc (showString "}")])
    ELambdaMatch matchclauses -> prPrec i 0 (concatD [doc (showString "matching"), doc (showString "{"), prt 0 matchclauses, doc (showString "}")])
    EIfThenElse expr1 expr2 expr3 -> prPrec i 0 (concatD [doc (showString "if"), prt 0 expr1, doc (showString "then"), prt 0 expr2, doc (showString "else"), prt 0 expr3])
    EUnify expr1 expr2 expr3 -> prPrec i 0 (concatD [doc (showString "unify"), prt 0 expr1, doc (showString "with"), doc (showString "{"), prt 0 expr2, doc (showString "}"), doc (showString "in"), prt 0 expr3])
    ELambda argdefs typedef expr -> prPrec i 7 (concatD [doc (showString "("), doc (showString "\\"), prt 0 argdefs, doc (showString ":"), prt 0 typedef, doc (showString "->"), prt 0 expr, doc (showString ")")])
    EInferredLambda argdefs expr -> prPrec i 7 (concatD [doc (showString "("), doc (showString "\\"), prt 0 argdefs, doc (showString "->"), prt 0 expr, doc (showString ")")])
    EList listelems -> prPrec i 7 (concatD [doc (showString "["), prt 0 listelems, doc (showString "]")])
    EEmptyList -> prPrec i 7 (concatD [doc (showString "[]")])
    ERange expr1 expr2 -> prPrec i 7 (concatD [doc (showString "["), prt 0 expr1, doc (showString ".."), prt 0 expr2, doc (showString "]")])
    ERangeFr expr -> prPrec i 7 (concatD [doc (showString "["), prt 0 expr, doc (showString ".."), doc (showString "]")])
    ETuple expr listelems -> prPrec i 7 (concatD [doc (showString "("), prt 0 expr, doc (showString ","), prt 0 listelems, doc (showString ")")])
    EAppl expr1 expr2 -> prPrec i 1 (concatD [prt 1 expr1, doc (showString "$"), prt 2 expr2])
    ECons expr1 expr2 -> prPrec i 2 (concatD [prt 3 expr1, doc (showString ":"), prt 2 expr2])
    ESCons expr1 expr2 -> prPrec i 2 (concatD [prt 3 expr1, doc (showString "::"), prt 2 expr2])
    EAppend expr1 expr2 -> prPrec i 2 (concatD [prt 3 expr1, doc (showString "++"), prt 2 expr2])
    EOp expr1 op expr2 -> prPrec i 3 (concatD [prt 3 expr1, prt 0 op, prt 4 expr2])
    EEq expr1 expr2 -> prPrec i 2 (concatD [prt 3 expr1, doc (showString "=="), prt 3 expr2])
    ENeq expr1 expr2 -> prPrec i 2 (concatD [prt 4 expr1, doc (showString "/="), prt 3 expr2])
    EMod expr1 expr2 -> prPrec i 2 (concatD [prt 3 expr1, doc (showString "mod"), prt 3 expr2])
    ENot expr -> prPrec i 2 (concatD [doc (showString "not"), prt 3 expr])
    EOr expr1 expr2 -> prPrec i 1 (concatD [prt 2 expr1, doc (showString "||"), prt 2 expr2])
    EAnd expr1 expr2 -> prPrec i 2 (concatD [prt 3 expr1, doc (showString "&&"), prt 3 expr2])
    ELt expr1 expr2 -> prPrec i 2 (concatD [prt 3 expr1, doc (showString "<"), prt 3 expr2])
    EGt expr1 expr2 -> prPrec i 2 (concatD [prt 3 expr1, doc (showString ">"), prt 3 expr2])
    ELeq expr1 expr2 -> prPrec i 2 (concatD [prt 3 expr1, doc (showString "<="), prt 3 expr2])
    EGeq expr1 expr2 -> prPrec i 2 (concatD [prt 3 expr1, doc (showString ">="), prt 3 expr2])
    EAdd expr1 expr2 -> prPrec i 3 (concatD [prt 3 expr1, doc (showString "+"), prt 4 expr2])
    ESub expr1 expr2 -> prPrec i 3 (concatD [prt 3 expr1, doc (showString "-"), prt 4 expr2])
    EMul expr1 expr2 -> prPrec i 4 (concatD [prt 4 expr1, doc (showString "*"), prt 5 expr2])
    EDiv expr1 expr2 -> prPrec i 4 (concatD [prt 4 expr1, doc (showString "/"), prt 5 expr2])
    EPow expr1 expr2 -> prPrec i 5 (concatD [prt 6 expr1, doc (showString "^"), prt 5 expr2])
    ECompose expr1 expr2 -> prPrec i 5 (concatD [prt 6 expr1, doc (showString " . "), prt 5 expr2])
    ENeg expr -> prPrec i 6 (concatD [doc (showString "-"), prt 7 expr])
    EBoolean boolean -> prPrec i 7 (concatD [prt 0 boolean])
    EThis -> prPrec i 7 (concatD [doc (showString "this")])
    ESuper -> prPrec i 7 (concatD [doc (showString "super")])
    EVar lident -> prPrec i 7 (concatD [prt 0 lident])
    EType uident -> prPrec i 7 (concatD [prt 0 uident])
    EMember mfun -> prPrec i 7 (concatD [prt 0 mfun])
    EMemberAsFun lident -> prPrec i 7 (concatD [doc (showString "("), doc (showString "^"), prt 0 lident, doc (showString ")")])
    EOperator operator -> prPrec i 7 (concatD [doc (showString "("), prt 0 operator, doc (showString ")")])
    EInt n -> prPrec i 7 (concatD [prt 0 n])
    EReal d -> prPrec i 7 (concatD [prt 0 d])
    EChar c -> prPrec i 7 (concatD [prt 0 c])
    EString str -> prPrec i 7 (concatD [prt 0 str])
    EWild -> prPrec i 7 (concatD [doc (showString "_")])
    EApply expr1 expr2 -> prPrec i 6 (concatD [prt 6 expr1, prt 7 expr2])

instance Print LetDef where
  prt i e = case e of
    IDefinition lident argdefs freetypedef expr -> prPrec i 0 (concatD [prt 0 lident, prt 0 argdefs, doc (showString ":"), prt 0 freetypedef, doc (showString "="), prt 0 expr])
    IInferredDefinition lident argdefs expr -> prPrec i 0 (concatD [prt 0 lident, prt 0 argdefs, doc (showString "="), prt 0 expr])
  prtList _ [x] = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ";"), prt 0 xs])
instance Print MatchClause where
  prt i e = case e of
    IMatchClause expr1 expr2 -> prPrec i 0 (concatD [prt 0 expr1, doc (showString "->"), prt 0 expr2])
  prtList _ [x] = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ";"), prt 0 xs])
instance Print ListElem where
  prt i e = case e of
    EListElem expr -> prPrec i 0 (concatD [prt 0 expr])
  prtList _ [x] = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ","), prt 0 xs])
instance Print Boolean where
  prt i e = case e of
    ETrue -> prPrec i 0 (concatD [doc (showString "true")])
    EFalse -> prPrec i 0 (concatD [doc (showString "false")])


