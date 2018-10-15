/* Companion source code for "flex & bison", published by O'Reilly
 * Media, ISBN 978-0-596-15597-1
 * Copyright (c) 2009, Taughannock Networks. All rights reserved.
 * See the README file for license conditions and contact info.
 * $Header: /home/johnl/flnb/code/RCS/fb1-5.l,v 2.1 2009/11/08 02:53:18 johnl Exp $
 */

/* FLEX FILE (.l) */
/* SCANNER */
/* ------------------------------------------------------- */
/* recognize tokens for the calculator and print them out */

%{
/* Include header file roman.tab.h (AUTO CREATED BY BISON)*/
/* Auto-defines token numbers and yyval definition*/
#include "roman.tab.h"

/* Define yyerror to take a char pointer*/
void yyerror(char *s);
%}

%%

/* Catch operator symbol tokens and return associated token number as defined in yytokentype */
"M"	  { return M; }
"CM"	{ return CM; }
"D"	  { return D; }
"CD"	{ return CD; }
"C"   { return C; }
"XC"	{ return XC; }
"L"	  { return L; }
"XL"	{ return XL; }
"X"	  { return X; }
"IX"  { return IX; }
"V"	  { return V; }
"IV"	{ return IV; }
"I"	  { return I; }

/* Catch number and return number */
[0-9]+	{ yylval = atoi(yytext); return NUMBER; }

/* Catch new line and tab/space */
\n      { return EOL; }
[ \t]   { }

/* Catch everything else not caught and print character */
.	{ yyerror("Mystery character\n");}
%%

/* Mainline deleted since parser(fb1-5.y) calls scanner(THIS FILE)*/
