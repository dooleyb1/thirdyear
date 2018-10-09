/* recognize tokens for the roman numeral interpreter and print them out */

%{
# include "fb1-5.tab.h"
void yyerror(char *s);
%}

%%
"+"	{ return ADD; }
"-"	{ return SUB; }
"*"	{ return MUL; }
"/"	{ return DIV; }
"|"     { return ABS; }
[0-9]+	{ yylval = atoi(yytext); return NUMBER; }

\n      { return EOL; }
[ \t]   { /* ignore white space */ }
.	{ yyerror("Mystery character\n");}
%%
