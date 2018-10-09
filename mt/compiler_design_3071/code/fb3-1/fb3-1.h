/* Companion source code for "flex & bison", published by O'Reilly
 * Media, ISBN 978-0-596-15597-1
 * Copyright (c) 2009, Taughannock Networks. All rights reserved.
 * See the README file for license conditions and contact info.
 * $Header: /home/johnl/flnb/code/RCS/fb3-1.h,v 2.1 2009/11/08 02:53:18 johnl Exp $
 */

 /* HEADER FILE (.h) */
 /* HEADER */
 /* ------------------------------------------------------- */
 /* Declarations for file fb3-1.l */

/* Interface to the lexer */
extern int yylineno;                                                          /* Line number from lexer */
void yyerror(char *s, ...);                                                   /* yyerror function */
int yyparse();                                                                /* PARSER - yyparse function */
int yylex();                                                                  /* SCANNER - yylex function */

/* nodes in the Abstract Syntax Tree */
struct ast {
  int nodetype;
  struct ast *l;
  struct ast *r;
};

struct numval {
  int nodetype;			/* type K */
  double number;
};

/* build an AST */
struct ast *newast(int nodetype, struct ast *l, struct ast *r);
struct ast *newnum(double d);

/* evaluate an AST */
double eval(struct ast *);

/* delete and free an AST */
void treefree(struct ast *);
