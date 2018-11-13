/* FLEX FILE (.l) */
/* SCANNER */
/* ------------------------------------------------------- */
/* recognize tokens for the calculator and print them out */
%option noyywrap nodefault yylineno

%{
/* Include header file calcwithvariables.tab.h (AUTO CREATED BY BISON)*/
/* Auto-defines token numbers and yylval definition*/
#include "calcwithvariables.tab.h"

/* Define yyerror to take a char pointer*/
void yyerror(char *s);
%}

%%


"+"	    { return ADD; }
"-"	    { return SUB; }
"*"	    { return MUL; }
"/"	    { return DIV; }
":="	  { return ASSIGN; }
[a-z]?  { yylval = *yytext - 'a'; return VARIABLE; }
(print) { return PRINT; }

[0-9]+	{ yylval = atoi(yytext); return NUMBER; /* Catch number and return number */}

";"     { return COMMA; }
\n      { }
[ \t]   { }

.	{ yyerror("syntax error"); /* Catch everything else not caught and print character */}
%%

/* Mainline deleted since parser(fb1-5.y) calls scanner(THIS FILE)*/
