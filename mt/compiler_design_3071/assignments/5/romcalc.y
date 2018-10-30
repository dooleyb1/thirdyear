/* BISON FILE (.y) */
/* PARSER - CALLS SCANNER */
/* ------------------------------------------------------- */
/* Roman numeral parser */
/* Code inspired/sampled using https://github.com/ChristophBerg/postgresql-numeral */

%{
#include <stdio.h>
#include <string.h>

int yylex();
void yyerror(char *s);
void print_roman(int num);

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
%token L_BRACKET R_BRACKET
%token EOL
%token ERR
%%

romancalc: /* parser entry */
| romancalc expr EOL {

  /* printf("= "); */
  print_roman($2);
  /* printf("\n> "); */
  /* results[current_index] = $2;
  current_index++; */

}
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
| L_BRACKET expr R_BRACKET { $$ = $2; }
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
  /* printf("> "); */

  /* Parse user input, call scanner */
  yyparse();

  int i;

  // Print the result integers
  for(i = 0; i < current_index; i++){
    print_roman(results[i]);
  }

  return 0;
}

void print_roman(int num)
{
  if (num == 0){ printf("Z");}
  
  while (num > 0) {
          if (num >= 1000) {
                  /* M - 1000 */
                  printf("M");
                  num = num - 1000;
          } else if (num >= 500) {
                  /*
                   * D is 500. CM is 900
                   * CM = M - C = 1000 - 100 => 900
                   */
                  if (num >= 900) {
                          printf("CM");
                          num = num - 900;
                  } else {
                          printf("D");
                          num = num - 500;
                  }
          } else if (num >= 100) {
                  /*
                   * C is 100. CD is 400
                   * CD = D - C = 500 - 100 => 400
                   */
                  if (num >= 400) {
                          printf("CD");
                          num = num - 400;
                  } else {
                          printf("C");
                          num = num - 100;
                  }
          } else if (num >= 50) {
                  /*
                   * L is 50. XC is 90
                   * XC = C - X = 100 - 10 => 90
                   */
                  if (num >= 90) {
                          printf("XC");
                          num = num - 90;
                  } else {
                          printf("L");
                          num = num - 50;
                  }
          } else if (num >= 9) {
                  /*
                   * XL is 40. IX is 9. X is 10
                   * XL = L - X = 50 - 10 = 40
                   * IX = X - I = 10 - 1 = 9
                   */
                  if (num >= 40) {
                          printf("XL");
                          num = num - 40;
                  } else if (num == 9) {
                          printf("IX");
                          num = num - 9;
                  } else {
                          printf("X");
                          num = num - 10;
                  }
          } else if (num >= 4) {
                  /*
                   * V is 5 and IV is 4
                   * IV = V - I = 5 - 1 => 4
                   */
                  if (num >= 5) {
                          printf("V");
                          num = num - 5;
                  } else {
                          printf("IV");
                          num = num - 4;
                  }
          } else {
                  printf("I");
                  num = num - 1;
          }
  }
  printf("\n");
}

void yyerror(char *s)
{
  fprintf(stdout, "%s\n", s);
}
