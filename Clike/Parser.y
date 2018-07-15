{

module Clike.Parser where

import Clike.Language
import Clike.Lexer

}

%name      parse
%tokentype { Token }
%error     { (alexError . ("Parse error: " ++) . show) }
%monad     { Alex }
%lexer     {lexwrap} {TokEOF}


%token
  '('        { TokLParen }
  ')'        { TokRParen }
  '{'        { TokLBrace }
  '}'        { TokRBrace }
  '.'        { TokDot }
  '?'        { TokQuestion }
  ':'        { TokColon }
  ','        { TokComma }
  ';'        { TokSemi }
  '='        { TokEquals }
  '=='       { TokEqEq }
  '!='       { TokBangEq }
  '<'        { TokLt }
  '<='       { TokLte }
  '>'        { TokGt }
  '>='       { TokGte }
  '+'        { TokPlus }
  '-'        { TokMinus }
  '*'        { TokStar }
  '~'        { TokTilde }
  '&'        { TokAmp }
  '|'        { TokBar }
  '<<'       { TokShl }
  '>>'       { TokLshr }
  '>>>'      { TokAshr }

  'int'      { TokInt }
  'struct'   { TokStruct }
  'if'       { TokIf }
  'else'     { TokElse }
  'while'    { TokWhile }
  'break'    { TokBreak }
  'continue' { TokContinue }
  'return'   { TokReturn }

  id         { TokID $$ }
  number     { TokLiteral $$ }

%%

prog :: { [TopDecl] }
      : fundecl         { [$1] }
      | fundecl prog    { $1 : $2 }

typ   :: { Type }
       : 'int'           { Int }
       | 'struct' '{' params '}'
                         { Struct (reverse $3) }

params :: { [(Type, String)] }
        : params ',' typ id
                         { ($3, $4) : $1 }
        | typ id         { [($1, $2)] }
        |                { [] }

asgne :: { Expr }
       : path '=' asgne  { Bin Assign (OpE $1) $3 }
       | ore             { $1 }

ore :: { Expr }
     : ande '|' ore      { Bin Or $1 $3 }
     | ande              { $1 }

ande :: { Expr }
      : compe '&' ande   { Bin And $1 $3 }
      | compe            { $1 }

compe :: { Expr }
       : shifte '<' compe  { Bin Lt  $1 $3 }
       | shifte '<=' compe { Bin Lte $1 $3 }
       | shifte '==' compe { Bin Eq  $1 $3 }
       | shifte '!=' compe { Bin Neq $1 $3 }
       | shifte '>' compe  { Bin Gt  $1 $3 }
       | shifte '>=' compe { Bin Gte $1 $3 }
       | shifte            { $1 }

shifte :: { Expr }
        : adde '<<' shifte  { Bin Shl $1 $3 }
        | adde '>>' shifte  { Bin Lshr $1 $3 }
        | adde '>>>' shifte { Bin Ashr $1 $3 }
        | adde              { $1 }

adde :: { Expr }
      : mule '+' adde   { Bin Plus $1 $3 }
      | mule '-' adde   { Bin Minus $1 $3 }
      | mule '|' adde   { Bin Or $1 $3 }
      | mule            { $1 }

mule :: { Expr }
      : atome '*' mule  { Bin Times $1 $3 }
      | atome '&' mule  { Bin And $1 $3 }
      | atome           { $1 }

path  :: { Operand }
       : path '.' id    { Dot $1 $3 }
       | id             { Var $1 }

atome :: { Expr }
       : '(' asgne ')'  { $2 }
       | '-' atome      { Unary Negate $2 }
       | '~' atome      { Unary Complement $2 }
       | id '(' args ')'
                        { Call $1 (reverse $3) }
       | number         { OpE (Const $1) }
       | path           { OpE $1 }

args  :: { [Expr] }
       : args ',' asgne { $3 : $1 }
       | asgne          { [$1] }
       |                { [] }

block :: { [Stmt] }
       : '{' stmts '}'  { reverse $2 }

stmts :: { [Stmt] }
       : stmts stmt     { $2 : $1 }
       | stmt           { [$1] }

stmt :: { Stmt }
      : block           { Block $1 }
      | 'if' '(' asgne ')' stmt 'else' stmt
                        { If $3 $5 $7 }
      | 'if' '(' asgne ')' stmt
                        { If $3 $5 (Block []) }
      | 'while' '(' asgne ')' stmt
                        { While $3 $5 }
      | 'break' ';'     { Break }
      | 'continue' ';'  { Continue }
      | 'return' asgne ';'
                        { Return $2 }
      | typ id ';'      { Decl $1 $2 }
      | asgne ';'       { ExpS $1 }

fundecl :: { TopDecl }
         : typ id '(' params ')' '{' stmts '}'
                        { FunDecl $1 $2 (reverse $4) (reverse $7) }
