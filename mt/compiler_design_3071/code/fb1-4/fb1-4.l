/* Companion source code for "flex & bison", published by O'Reilly
 * Media, ISBN 978-0-596-15597-1
 * Copyright (c) 2009, Taughannock Networks. All rights reserved.
 * See the README file for license conditions and contact info.
 * $Header: /home/johnl/flnb/code/RCS/fb1-4.l,v 2.1 2009/11/08 02:53:18 johnl Exp $
 */

/* recognize tokens for the calculator and print them out */

%{
   /* Define enumeration object to define names to number tokens */
   enum yytokentype {
     NUMBER = 258,
     ADD = 259,
     SUB = 260,
     MUL = 261,
     DIV = 262,
     ABS = 263,
     EOL = 264
   };

   /* Define variable for yyval */
   int yylval;

%}

%%

/* Catch operator symbol tokens and return associated token number as defined in yytokentype */
"+"	{ return ADD; }
"-"	{ return SUB; }
"*"	{ return MUL; }
"/"	{ return DIV; }
"|"     { return ABS; }

/* Catch number and return number */
[0-9]+	{ yylval = atoi(yytext); return NUMBER; }

/* Catch new line and tab/space */
\n      { return EOL; }
[ \t]   { }

/* Catch everything else not caught and print character */
.	{ printf("Mystery character %c\n", *yytext); }

%%

int main()
{
  /* Token variable */
  int tok;

  /* Parse input and extract each token at a time */
  while(tok = yylex()) {

    /* Print the number for token caught e.g 256*/
    printf("%d", tok);

    /* If token is a number print the associated yyval */
    if(tok == NUMBER) printf(" = %d\n", yylval);

    /* Otherwise print newline */
    else printf("\n");
  }
  return 0;
}
