/* Companion source code for "flex & bison", published by O'Reilly
 * Media, ISBN 978-0-596-15597-1
 * Copyright (c) 2009, Taughannock Networks. All rights reserved.
 * See the README file for license conditions and contact info.
 * $Header: /home/johnl/flnb/code/RCS/fb3-1.l,v 2.1 2009/11/08 02:53:18 johnl Exp $
 */

/* FLEX FILE (.l) */
/* SCANNER */
/* ------------------------------------------------------- */
/* Recognize tokens for the calculator */

/* noyywrap - no default main routine */
/* nodefault - no default rule */
/* yylineno - record current line number */
%option noyywrap nodefault yylineno

%{
/* Include custom header and auto-generated header */
#include "fb3-1.h"
#include "fb3-1.tab.h"
%}

/* Float exponent */
EXP	([Ee][-+]?[0-9]+)

%%
/* Catch operator symbols and return yytext[0] */
"+" |
"-" |
"*" |
"/" |
"|" |
"(" |
")"     { return yytext[0]; }

/* Catch decimal & float numbers */
[0-9]+"."[0-9]*{EXP}? |
"."?[0-9]+{EXP}? { yylval.d = atof(yytext); return NUMBER; }

/* Catch newline, comments and whitespace */
\n      { return EOL; }
"//".*
[\t\n]+   {}

/* Catch mystery characters */
.	{ yyerror("Mystery character %c\n", *yytext); }
%%
