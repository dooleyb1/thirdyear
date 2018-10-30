/* FLEX FILE (.l) */
/* SCANNER */
/* ------------------------------------------------------- */
/* Recognize tokens for the roman parser */
/* Code inspired/sampled using https://github.com/ChristophBerg/postgresql-numeral */

%option noyywrap nodefault yylineno

%{
#include "romcalc.tab.h"
void yyerror(char *s);
%}

%%

[I]  { yylval = 1; return I; }
[V]  { yylval = 5; return V; }
[X]  { yylval = 10; return X; }
[L]  { yylval = 50; return L; }
[C]  { yylval = 100; return C; }
[D]  { yylval = 500; return D; }
[M]  { yylval = 1000; return M; }
[+]	{ return ADD; }
[-]	{ return SUB; }
[*]	{ return MUL; }
[/]	{ return DIV; }
[{]	{ return L_BRACKET; }
[}]	{ return R_BRACKET; }


\n      { return EOL; /* Catch new line and tab/space */}
[ \t\n]  { }

.	{ printf("syntax error\n"); exit(0);/* Catch everything else not caught and print character */}
%%

/* Mainline deleted since parser(roman.y) calls scanner(THIS FILE)*/
