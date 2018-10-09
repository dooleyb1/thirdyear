/* Companion source code for "flex & bison", published by O'Reilly
 * Media, ISBN 978-0-596-15597-1
 * Copyright (c) 2009, Taughannock Networks. All rights reserved.
 * See the README file for license conditions and contact info.
 * $Header: /home/johnl/flnb/code/RCS/fb3-1.y,v 2.1 2009/11/08 02:53:18 johnl Exp $
 */

/* BISON FILE (.y) */
/* PARSER - CALLS SCANNER */
/* ------------------------------------------------------- */
/* Calculator with AST */

%{
#include <stdio.h>
#include <stdlib.h>
#include "fb3-1.h"
%}

/* Union ds to house Abstract Syntax Tree (AST) and a double */
%union {
  struct ast *a;
  double d;
}

/* Declare tokens */
%token <d> NUMBER
%token EOL

/* Declare type of expressions */
%type <a> exp factor term

%%

/* Switch(calclist)... default -> null  */
calclist: /* nothing */
| calclist exp EOL {
     printf("= %4.4g\n", eval($2));               /* Call eval(exp) and print the value of number */
     treefree($2);                                /* Free up exp from AST */
     printf("> ");
 }

 | calclist EOL { printf("> "); }                 /* Blank line or a comment */
 ;

/* Switch(exp)... default -> factor() */
exp: factor
 | exp '+' factor { $$ = newast('+', $1,$3); }    /* build new AST for (+, exp and factor) */
 | exp '-' factor { $$ = newast('-', $1,$3);}     /* build new AST for (-, exp and factor) */
 ;

/* Switch(factor)... default -> term() */
factor: term
 | factor '*' term { $$ = newast('*', $1,$3); }   /* build new AST for (*, exp and factor) */
 | factor '/' term { $$ = newast('/', $1,$3); }   /* build new AST for (/, exp and factor) */
 ;

/* Switch(term)... default -> NUMBER  */
term: NUMBER   { $$ = newnum($1); }               /* build new num for (NUMBER) */
 | '|' term    { $$ = newast('|', $2, NULL); }    /* build new AST for (|, term and null) */
 | '(' exp ')' { $$ = $2; }                       /* return exp */
 | '-' term    { $$ = newast('M', $2, NULL); }    /* build new AST for (M, term and null) */
 ;
%%
