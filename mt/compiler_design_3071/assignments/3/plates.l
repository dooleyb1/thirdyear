/* Insert variables here */
%{
%}

/* Define Regex here */
OLD_YEAR (((8{1}[7-9]{1})|(9{1}[0-9]{1})|(1{1}[0-2]{1})))
NEW_YEAR (1[3-8]{1}[1-2]{1})
OLD_COUNTIES (-(C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|TN|TS|W|W|WH|WX|WW)-)
NEW_COUNTIES (-(C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LK|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|T|W|WH|WX|WW)-)
NUMBER ([0-9]{1,6})

%%

{OLD_YEAR}{OLD_COUNTIES}{NUMBER} {printf("OLD REG FOUND\n");}
{NEW_YEAR}{NEW_COUNTIES}{NUMBER} {printf("NEW REG FOUND\n");}
[\s\t\n]+ {}
.   {printf("INVALID\n");}
%%

int main()
{
  yylex();
  return 0;
}
