/* Insert variables here */
%{
%}

%%

\"([^"]+)\"	{
              /* If quote found ignore everything until another quote*/
              printf("%s",yytext);
            }

"**".* {/* Detect Singleline Comments (**) */}

[}] {
      /* If closing bracket found before opening - return syntax error */
      printf ("syntax error\n");
      return 0;
    }

[{] {
      /* Otherwise if opening bracket, loop through file and ensure closing bracket */
      int current_char;

      for(;;){
        /* While no closing bracket or EOF, presume comment text */
        while ((current_char = input()) != '}' && current_char != EOF)
          ;

        /* Current char is now either } or EOF - If } comment finished */
        if (current_char == '}')
        {
           break;
        }

        /* If current char is EOF - Syntax error since no closing bracket */
        if (current_char == EOF)
        {
          printf ("syntax error\n");
          break;
        }
      }
    }

%%

int main()
{
  yylex();
	return 0;
}
