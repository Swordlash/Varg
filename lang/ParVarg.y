-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParVarg where
import AbsVarg
import LexVarg
import ErrM

}

%name pProgramDef ProgramDef
-- no lexer declaration
%monad { Err } { thenM } { returnM }
%tokentype {Token}
%token
  ' . ' { PT _ (TS _ 1) }
  '&&' { PT _ (TS _ 2) }
  '(' { PT _ (TS _ 3) }
  ')' { PT _ (TS _ 4) }
  '*' { PT _ (TS _ 5) }
  '+' { PT _ (TS _ 6) }
  ',' { PT _ (TS _ 7) }
  '-' { PT _ (TS _ 8) }
  '->' { PT _ (TS _ 9) }
  '..' { PT _ (TS _ 10) }
  '/' { PT _ (TS _ 11) }
  '/=' { PT _ (TS _ 12) }
  ':' { PT _ (TS _ 13) }
  ';' { PT _ (TS _ 14) }
  '<' { PT _ (TS _ 15) }
  '<=' { PT _ (TS _ 16) }
  '=' { PT _ (TS _ 17) }
  '==' { PT _ (TS _ 18) }
  '>' { PT _ (TS _ 19) }
  '>=' { PT _ (TS _ 20) }
  '?' { PT _ (TS _ 21) }
  '[' { PT _ (TS _ 22) }
  '[]' { PT _ (TS _ 23) }
  '\\' { PT _ (TS _ 24) }
  ']' { PT _ (TS _ 25) }
  '^' { PT _ (TS _ 26) }
  '_' { PT _ (TS _ 27) }
  'abstract' { PT _ (TS _ 28) }
  'class' { PT _ (TS _ 29) }
  'deriving' { PT _ (TS _ 30) }
  'else' { PT _ (TS _ 31) }
  'false' { PT _ (TS _ 32) }
  'final' { PT _ (TS _ 33) }
  'function' { PT _ (TS _ 34) }
  'has' { PT _ (TS _ 35) }
  'if' { PT _ (TS _ 36) }
  'implement' { PT _ (TS _ 37) }
  'implementing' { PT _ (TS _ 38) }
  'import' { PT _ (TS _ 39) }
  'in' { PT _ (TS _ 40) }
  'interface' { PT _ (TS _ 41) }
  'internal' { PT _ (TS _ 42) }
  'let' { PT _ (TS _ 43) }
  'match' { PT _ (TS _ 44) }
  'mod' { PT _ (TS _ 45) }
  'module' { PT _ (TS _ 46) }
  'native' { PT _ (TS _ 47) }
  'not' { PT _ (TS _ 48) }
  'sealed' { PT _ (TS _ 49) }
  'static' { PT _ (TS _ 50) }
  'struct' { PT _ (TS _ 51) }
  'super' { PT _ (TS _ 52) }
  'template' { PT _ (TS _ 53) }
  'then' { PT _ (TS _ 54) }
  'this' { PT _ (TS _ 55) }
  'true' { PT _ (TS _ 56) }
  'unify' { PT _ (TS _ 57) }
  'unique' { PT _ (TS _ 58) }
  'where' { PT _ (TS _ 59) }
  'with' { PT _ (TS _ 60) }
  '{' { PT _ (TS _ 61) }
  '||' { PT _ (TS _ 62) }
  '}' { PT _ (TS _ 63) }

L_quoted { PT _ (TL $$) }
L_integ  { PT _ (TI $$) }
L_doubl  { PT _ (TD $$) }
L_charac { PT _ (TC $$) }
L_UIdent { PT _ (T_UIdent $$) }
L_LIdent { PT _ (T_LIdent $$) }
L_MFun { PT _ (T_MFun $$) }
L_Op { PT _ (T_Op $$) }


%%

String  :: { String }  : L_quoted {  $1 }
Integer :: { Integer } : L_integ  { (read ( $1)) :: Integer }
Double  :: { Double }  : L_doubl  { (read ( $1)) :: Double }
Char    :: { Char }    : L_charac { (read ( $1)) :: Char }
UIdent    :: { UIdent} : L_UIdent { UIdent ($1)}
LIdent    :: { LIdent} : L_LIdent { LIdent ($1)}
MFun    :: { MFun} : L_MFun { MFun ($1)}
Op    :: { Op} : L_Op { Op ($1)}

ProgramDef :: { ProgramDef }
ProgramDef : ListImportDef ListClassDef { AbsVarg.Program (reverse $1) (reverse $2) }
ListClassDef :: { [ClassDef] }
ListClassDef : {- empty -} { [] }
             | ListClassDef ClassDef { flip (:) $1 $2 }
ImportDef :: { ImportDef }
ImportDef : 'import' String { AbsVarg.Import $2 }
ListImportDef :: { [ImportDef] }
ListImportDef : {- empty -} { [] }
              | ListImportDef ImportDef { flip (:) $1 $2 }
ListConstrTypeParam :: { [ConstrTypeParam] }
ListConstrTypeParam : {- empty -} { [] }
                    | ListConstrTypeParam ConstrTypeParam { flip (:) $1 $2 }
ConstrTypeParam :: { ConstrTypeParam }
ConstrTypeParam : LIdent { AbsVarg.InferredTypeParam $1 }
                | UIdent { AbsVarg.ConcreteTypeParam $1 }
                | '?' { AbsVarg.WildcardTypeParam }
                | '[' LIdent 'super' ListTypeDef ']' { AbsVarg.SuperConstrainedTypeParam $2 $4 }
                | '[' '?' 'super' ListTypeDef ']' { AbsVarg.AnySuperConstrainedTypeParam $4 }
                | '[' LIdent 'deriving' ListTypeDef ']' { AbsVarg.DerivingConstrainedTypeParam $2 $4 }
                | '[' '?' 'deriving' ListTypeDef ']' { AbsVarg.AnyDerivingConstrainedTypeParam $4 }
TypeDef :: { TypeDef }
TypeDef : UIdent ListConstrTypeParam { AbsVarg.ConcreteType $1 (reverse $2) }
        | LIdent ListConstrTypeParam { AbsVarg.InferredType $1 (reverse $2) }
        | TypeDef1 { $1 }
TypeDef1 :: { TypeDef }
TypeDef1 : '(' TypeDef ')' { $2 }
ListTypeDef :: { [TypeDef] }
ListTypeDef : TypeDef { (:[]) $1 }
            | TypeDef ',' ListTypeDef { (:) $1 $3 }
PrimFreeType :: { PrimFreeType }
PrimFreeType : '(' FreeTypeDef ')' { AbsVarg.ConcreteTypeFreeType $2 }
             | LIdent { AbsVarg.TemplateFreeType $1 }
             | UIdent { AbsVarg.ConcreteFreeType $1 }
FreeTypeDef :: { FreeTypeDef }
FreeTypeDef : UIdent ListPrimFreeType { AbsVarg.FreeType $1 (reverse $2) }
            | LIdent ListPrimFreeType { AbsVarg.InferredFreeType $1 (reverse $2) }
            | FreeTypeDef1 { $1 }
FreeTypeDef1 :: { FreeTypeDef }
FreeTypeDef1 : '(' FreeTypeDef ')' { $2 }
ListPrimFreeType :: { [PrimFreeType] }
ListPrimFreeType : {- empty -} { [] }
                 | ListPrimFreeType PrimFreeType { flip (:) $1 $2 }
ListArgDef :: { [ArgDef] }
ListArgDef : {- empty -} { [] }
           | ListArgDef ArgDef { flip (:) $1 $2 }
ArgDef :: { ArgDef }
ArgDef : '(' LIdent ':' FreeTypeDef ')' { AbsVarg.ArgumentDefinition $2 $4 }
       | LIdent { AbsVarg.InferredArgumentDef $1 }
SuperclassType :: { SuperclassType }
SuperclassType : FreeTypeDef { AbsVarg.Superclass $1 }
ListSuperclassType :: { [SuperclassType] }
ListSuperclassType : SuperclassType { (:[]) $1 }
                   | SuperclassType ',' ListSuperclassType { (:) $1 $3 }
ClassDef :: { ClassDef }
ClassDef : ListClassModifier 'struct' UIdent 'where' '{' ListClassField '}' { AbsVarg.StructDefinition (reverse $1) $3 $6 }
         | ListClassModifier 'class' UIdent IsDeriving IsImplementing 'where' '{' ClassContents '}' { AbsVarg.ClassDefinition (reverse $1) $3 $4 $5 $8 }
         | ListClassModifier 'template' UIdent ListConstrTypeParam IsDeriving IsImplementing 'where' '{' ClassContents '}' { AbsVarg.TemplateDefinition (reverse $1) $3 (reverse $4) $5 $6 $9 }
IsImplementing :: { IsImplementing }
IsImplementing : 'implementing' ListSuperclassType { AbsVarg.Implementing $2 }
               | {- empty -} { AbsVarg.NotImplementing }
IsDeriving :: { IsDeriving }
IsDeriving : 'deriving' SuperclassType { AbsVarg.Deriving $2 }
           | {- empty -} { AbsVarg.NotDeriving }
ListClassModifier :: { [ClassModifier] }
ListClassModifier : {- empty -} { [] }
                  | ListClassModifier ClassModifier { flip (:) $1 $2 }
ClassModifier :: { ClassModifier }
ClassModifier : 'module' { AbsVarg.ClassModifier_module }
              | 'interface' { AbsVarg.ClassModifier_interface }
              | 'sealed' { AbsVarg.ClassModifier_sealed }
              | 'native' { AbsVarg.ClassModifier_native }
ClassContents :: { ClassContents }
ClassContents : ListMemberDef ListFunDef { AbsVarg.ClassContent $1 $2 }
MemberDef :: { MemberDef }
MemberDef : UIdent { AbsVarg.EmptyMemberDefinition $1 }
          | UIdent 'has' '{' ListClassField '}' { AbsVarg.MemberDefinition $1 $4 }
ListMemberDef :: { [MemberDef] }
ListMemberDef : {- empty -} { [] }
              | MemberDef { (:[]) $1 }
              | MemberDef ';' ListMemberDef { (:) $1 $3 }
FunDef :: { FunDef }
FunDef : ListFunctionModifier 'function' FunctionName FunTemplateParams ListArgDef RetType '=' Expr { AbsVarg.MemberFunctionDefinition (reverse $1) $3 $4 (reverse $5) $6 $8 }
       | ListFunctionModifier 'function' FunctionName FunTemplateParams ListArgDef AbsRetType { AbsVarg.AbstractFunctionDefinition (reverse $1) $3 $4 (reverse $5) $6 }
RetType :: { RetType }
RetType : ':' FreeTypeDef { AbsVarg.ReturnType $2 }
        | {- empty -} { AbsVarg.InferredReturnType }
FunctionName :: { FunctionName }
FunctionName : LIdent { AbsVarg.FFunction $1 }
             | '(' Operator ')' { AbsVarg.FOperator $2 }
             | '(' Op ')' { AbsVarg.FOperatorDef $2 }
Operator :: { Operator }
Operator : '+' { AbsVarg.Op_plus }
         | '-' { AbsVarg.Op_minus }
         | '*' { AbsVarg.Op_mul }
         | '/' { AbsVarg.Op_div }
         | '^' { AbsVarg.Op_pow }
         | '<' { AbsVarg.Op_less }
         | '>' { AbsVarg.Op_gr }
         | '<=' { AbsVarg.Op_leq }
         | '>=' { AbsVarg.Op_geq }
         | '==' { AbsVarg.Op_eq }
         | ':' { AbsVarg.Op_cons }
AbsRetType :: { AbsRetType }
AbsRetType : ':' 'abstract' FreeTypeDef { AbsVarg.AbsReturnType $3 }
           | {- empty -} { AbsVarg.AbsInferredReturnType }
FunTemplateParams :: { FunTemplateParams }
FunTemplateParams : {- empty -} { AbsVarg.NoFunctionTemplateParameter }
                  | '<' ListTemplateParam '>' { AbsVarg.FunctionTemplateParameters $2 }
TemplateParam :: { TemplateParam }
TemplateParam : ConstrTypeParam { AbsVarg.TemplateParameter $1 }
ListTemplateParam :: { [TemplateParam] }
ListTemplateParam : TemplateParam { (:[]) $1 }
                  | TemplateParam ',' ListTemplateParam { (:) $1 $3 }
ListFunDef :: { [FunDef] }
ListFunDef : {- empty -} { [] }
           | FunDef { (:[]) $1 }
           | FunDef ';' ListFunDef { (:) $1 $3 }
ListFunctionModifier :: { [FunctionModifier] }
ListFunctionModifier : {- empty -} { [] }
                     | ListFunctionModifier FunctionModifier { flip (:) $1 $2 }
FunctionModifier :: { FunctionModifier }
FunctionModifier : 'static' { AbsVarg.FunctionModifier_static }
                 | 'internal' { AbsVarg.FunctionModifier_internal }
                 | 'implement' { AbsVarg.FunctionModifier_implement }
                 | 'final' { AbsVarg.FunctionModifier_final }
                 | 'unique' { AbsVarg.FunctionModifier_unique }
                 | 'native' { AbsVarg.FunctionModifier_native }
ClassField :: { ClassField }
ClassField : FieldModifier LIdent ':' FreeTypeDef { AbsVarg.ModifiedClassField $1 $2 $4 }
           | LIdent ':' FreeTypeDef { AbsVarg.NormalClassField $1 $3 }
ListClassField :: { [ClassField] }
ListClassField : {- empty -} { [] }
               | ClassField { (:[]) $1 }
               | ClassField ';' ListClassField { (:) $1 $3 }
FieldModifier :: { FieldModifier }
FieldModifier : 'internal' { AbsVarg.FieldModifier_internal }
              | 'unique' { AbsVarg.FieldModifier_unique }
Expr :: { Expr }
Expr : 'let' '{' ListLetDef '}' 'in' Expr { AbsVarg.EDefinitionsList $3 $6 }
     | 'let' LetDef 'in' Expr { AbsVarg.EDefinition $2 $4 }
     | 'match' Expr 'with' '{' ListMatchClause '}' { AbsVarg.EMatch $2 $5 }
     | 'if' Expr 'then' Expr 'else' Expr { AbsVarg.EIfThenElse $2 $4 $6 }
     | 'unify' Expr 'with' Expr 'in' Expr { AbsVarg.EUnify $2 $4 $6 }
     | Expr1 ':' Expr { AbsVarg.ECons $1 $3 }
     | Expr1 { $1 }
ListLetDef :: { [LetDef] }
ListLetDef : LetDef { (:[]) $1 }
           | LetDef ';' ListLetDef { (:) $1 $3 }
LetDef :: { LetDef }
LetDef : LIdent ListArgDef ':' FreeTypeDef '=' Expr { AbsVarg.IDefinition $1 (reverse $2) $4 $6 }
       | LIdent ListArgDef '=' Expr { AbsVarg.IInferredDefinition $1 (reverse $2) $4 }
ListMatchClause :: { [MatchClause] }
ListMatchClause : MatchClause { (:[]) $1 }
                | MatchClause ';' ListMatchClause { (:) $1 $3 }
MatchClause :: { MatchClause }
MatchClause : Expr '->' Expr { AbsVarg.IMatchClause $1 $3 }
Expr6 :: { Expr }
Expr6 : '(' '\\' ListArgDef ':' TypeDef '->' Expr ')' { AbsVarg.ELambda (reverse $3) $5 $7 }
      | '(' '\\' ListArgDef '->' Expr ')' { AbsVarg.EInferredLambda (reverse $3) $5 }
      | '[' ListListElem ']' { AbsVarg.EList $2 }
      | '[]' { AbsVarg.EEmptyList }
      | '[' Integer '..' Integer ']' { AbsVarg.ERange $2 $4 }
      | Boolean { AbsVarg.EBoolean $1 }
      | 'this' { AbsVarg.EThis }
      | 'super' { AbsVarg.ESuper }
      | LIdent { AbsVarg.EVar $1 }
      | UIdent { AbsVarg.EType $1 }
      | MFun { AbsVarg.EMember $1 }
      | '(' Operator ')' { AbsVarg.EOperator $2 }
      | Integer { AbsVarg.EInt $1 }
      | Double { AbsVarg.EReal $1 }
      | Char { AbsVarg.EChar $1 }
      | String { AbsVarg.EString $1 }
      | '_' { AbsVarg.EWild }
      | '(' Expr ')' { $2 }
ListElem :: { ListElem }
ListElem : Expr { AbsVarg.EListElem $1 }
ListListElem :: { [ListElem] }
ListListElem : ListElem { (:[]) $1 }
             | ListElem ',' ListListElem { (:) $1 $3 }
Expr5 :: { Expr }
Expr5 : '-' Expr6 { AbsVarg.ENeg $2 }
      | Expr5 Expr6 { AbsVarg.EApply $1 $2 }
      | Expr6 { $1 }
Expr1 :: { Expr }
Expr1 : Expr1 Op Expr2 { AbsVarg.EOp $1 $2 $3 }
      | Expr1 '==' Expr2 { AbsVarg.EEq $1 $3 }
      | Expr1 '/=' Expr2 { AbsVarg.ENeq $1 $3 }
      | Expr2 'mod' Expr2 { AbsVarg.EMod $1 $3 }
      | 'not' Expr2 { AbsVarg.ENot $2 }
      | Expr2 '||' Expr2 { AbsVarg.EOr $1 $3 }
      | Expr2 '&&' Expr2 { AbsVarg.EAnd $1 $3 }
      | Expr2 '<' Expr2 { AbsVarg.ELt $1 $3 }
      | Expr2 '>' Expr2 { AbsVarg.EGt $1 $3 }
      | Expr2 '<=' Expr2 { AbsVarg.ELeq $1 $3 }
      | Expr2 '>=' Expr2 { AbsVarg.EGeq $1 $3 }
      | Expr2 { $1 }
Expr2 :: { Expr }
Expr2 : Expr2 '+' Expr3 { AbsVarg.EAdd $1 $3 }
      | Expr2 '-' Expr3 { AbsVarg.ESub $1 $3 }
      | Expr3 { $1 }
Expr3 :: { Expr }
Expr3 : Expr3 '*' Expr4 { AbsVarg.EMul $1 $3 }
      | Expr3 '/' Expr4 { AbsVarg.EDiv $1 $3 }
      | Expr4 { $1 }
Expr4 :: { Expr }
Expr4 : Expr5 '^' Expr4 { AbsVarg.EPow $1 $3 }
      | Expr5 ' . ' Expr4 { AbsVarg.ECompose $1 $3 }
      | Expr5 { $1 }
Boolean :: { Boolean }
Boolean : 'true' { AbsVarg.ETrue } | 'false' { AbsVarg.EFalse }
{

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    _ -> " before " ++ unwords (map (id . prToken) (take 4 ts))

myLexer = tokens
}

