/* Companion source code for "flex & bison", published by O'Reilly
 * Media, ISBN 978-0-596-15597-1
 * Copyright (c) 2009, Taughannock Networks. All rights reserved.
 * See the README file for license conditions and contact info.
 * $Header: /home/johnl/flnb/code/RCS/fb1-5.y,v 2.1 2009/11/08 02:53:18 johnl Exp $
 */

/* BISON FILE (.y) */
/* PARSER - CALLS SCANNER */
/* ------------------------------------------------------- */
/* Simplest version of calculator */

%{
#include <stdio.h>
int yylex();
void yyerror(char *s);
%}

/* Declare tokens to be caught */
%token M
%token CM
%token D
%token CD
%token C
%token XC
%token L
%token XL
%token X
%token IX
%token V
%token IV


%%
/* Switch(calclist)... default -> null  */
calclist: /* Nothing */
 | calclist exp EOL { printf("= %d\n> ", $2); }   /* Prints exp ($2 since second element) */
 ;

/* Switch(exp)... default -> factor() */
exp: factor
 | exp ADD factor { $$ = $1 + $3; }               /* Applies exp ($1) + factor ($3) */
 | exp SUB factor { $$ = $1 - $3; }               /* Applies exp ($1) - factor ($3) */
 ;

/* Switch(factor)... default -> term() */
factor: term
 | factor MUL term { $$ = $1 * $3; }             /* Applies factor ($1) * term ($3) */
 | factor DIV term { $$ = $1 / $3; }             /* Applies factor ($1) / term ($3) */
 ;

/* Switch(term)... default -> NUMBER  */
term: NUMBER
 | ABS term { $$ = $2 >= 0? $2 : - $2; }         /* Finds the ABS of a term if required */
 ;
%%

/* Mainline for parser */
int main()
{
  printf("> ");

  /* Parse user input, call scanner */
  yyparse();
  return 0;
}

void yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}
