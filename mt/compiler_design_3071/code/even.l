/* Companion source code for "flex & bison", published by O'Reilly
 * Media, ISBN 978-0-596-15597-1
 * Copyright (c) 2009, Taughannock Networks. All rights reserved.
 * See the README file for license conditions and contact info.
 * $Header: /home/johnl/flnb/code/RCS/fb1-1.l,v 2.1 2009/11/08 02:53:18 johnl Exp $
 */

/* fb1-1 just like unix wc */
%{
int count = 0;
int intval = 0;
%}

%%

[0-9]+ {
     intval = atoi(yytext);
     if(intval%2 == 0)
      count++;
   }
\n		{ }
.		{  }

%%

int main()
{
  yylex();
  printf("%d\n", count);
	return 0;
}
