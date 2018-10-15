/* BISON FILE (.y) */
/* PARSER - CALLS SCANNER */
/* ------------------------------------------------------- */
/* Roman numeral parser */
/* Code inspired/sampled using https://github.com/ChristophBerg/postgresql-numeral */

%{
#include <stdio.h>
int yylex();
void yyerror(char *s);
%}

%token I
%token V
%token X
%token L
%token C
%token D
%token M
%token EOL
%%

romanparse: /* parser entry */
 | romanparse expr EOL {printf("%d\n", $2);}  /* Prints expr ($2 since second element) */
;

expr:
  max_c M max_m { $$ = $2 - $1 + $3; }
| max_c D max_c { $$ = $2 - $1 + $3; }
| max_x C max_c { $$ = $2 - $1 + $3; }
| max_x L max_x { $$ = $2 - $1 + $3; }
| max_i X max_x { $$ = $2 - $1 + $3; }
| max_i V max_i { $$ = $2 - $1 + $3; }
|       I max_i { $$ = $1 + $2; }
;

max_m:
  %empty { $$ = 0; }
| max_c M max_m { $$ = $2 - $1 + $3; }
| max_c D max_c { $$ = $2 - $1 + $3; }
| max_x C max_c { $$ = $2 - $1 + $3; }
| max_x L max_x { $$ = $2 - $1 + $3; }
| max_i X max_x { $$ = $2 - $1 + $3; }
| max_i V max_i { $$ = $2 - $1 + $3; }
|       I max_i { $$ = $1 + $2; }
;

max_c:
  %empty { $$ = 0; }
| max_x C max_c { $$ = $2 - $1 + $3; }
| max_x L max_x { $$ = $2 - $1 + $3; }
| max_i X max_x { $$ = $2 - $1 + $3; }
| max_i V max_i { $$ = $2 - $1 + $3; }
|       I max_i { $$ = $1 + $2; }
;

max_x:
  %empty { $$ = 0; }
| max_i X max_x { $$ = $2 - $1 + $3; }
| max_i V max_i { $$ = $2 - $1 + $3; }
|       I max_i { $$ = $1 + $2; }
;

max_i:
  %empty { $$ = 0; }
|       I max_i { $$ = $1 + $2; }
;

%%
/* parse a given string and return the result via the second argument */
int main ()
{
  /* Parse user input, call scanner */
  yyparse();
  return 0;
}

void yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}
