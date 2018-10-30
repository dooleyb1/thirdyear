/* BISON FILE (.y) */
/* PARSER - CALLS SCANNER */
/* ------------------------------------------------------- */
/* Roman numeral parser */
/* Code inspired/sampled using https://github.com/ChristophBerg/postgresql-numeral */

%{
#include <stdio.h>
int yylex();
void yyerror(char *s);
int results[50];
int current_index = 0;
%}

%token I
%token V
%token X
%token L
%token C
%token D
%token M
%token ADD SUB MUL DIV ABS
%token EOL
%token ERR
%%

romancalc: /* parser entry */
 | romancalc expr EOL { printf("= %d\n> ", $2); }
;

/* Switch(exp)... default -> factor() */
expr: factor
 | expr ADD factor { $$ = $1 + $3; }               /* Applies exp ($1) + factor ($3) */
 | expr SUB factor { $$ = $1 - $3; }               /* Applies exp ($1) - factor ($3) */
 ;

/* Switch(factor)... default -> term() */
factor: term
| factor MUL term { $$ = $1 * $3; }             /* Applies factor ($1) * term ($3) */
| factor DIV term { $$ = $1 / $3; }             /* Applies factor ($1) / term ($3) */
;

term:
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
  printf("> ");

  /* Parse user input, call scanner */
  yyparse();
  return 0;
}

void yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}
