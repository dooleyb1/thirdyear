/* BISON FILE (.y) */
/* PARSER - CALLS SCANNER */
/* ------------------------------------------------------- */
/* Simplest version of calculator */

%{
#include <stdio.h>
int yylex();
void yyerror(char *s);
int variables[26];
%}

/* Declare tokens to be caught */
%token NUMBER
%token COMMA
%token ASSIGN
%token PRINT
%token VARIABLE
%token ADD SUB MUL DIV ABS
%token EOL

%%
/* Switch(calclist)... default -> null  */
calclist: /* Nothing */
 | calclist stmt COMMA { }   /* Prints exp ($2 since second element) */
 | calclist PRINT VARIABLE COMMA { printf("%d\n", variables[$3]);}
 ;

stmt: exp
 | VARIABLE ASSIGN exp { variables[$1] = $3; }

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
 | VARIABLE { $$ = variables[$1]; }
 | SUB NUMBER {$$ = $2 * -1;}
 | ABS term { $$ = $2 >= 0? $2 : - $2; }         /* Finds the ABS of a term if required */
 ;
%%

/* Mainline for parser */
int main()
{
  /* printf("> "); */

  /* Parse user input, call scanner */
  yyparse();
  return 0;
}

void yyerror(char *s)
{
  fprintf(stderr, "%s\n", s);
}
