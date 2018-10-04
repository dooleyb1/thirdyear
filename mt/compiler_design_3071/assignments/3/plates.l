/* Insert variables here */
%{
  int new_base = 18;

  int old_base = 2018;
%}

/* Define Regex here */
OLD_YEAR (8{1}[7-9]{1})|(9{1}[0-9]{1})|(1{1}[0-2]{1})
NEW_YEAR (1[3-8]{1}[1-2]{1})
OLD_COUNTIES (-(C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|TN|TS|W|W|WH|WX|WW)-)
NEW_COUNTIES (-(C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LK|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|T|W|WH|WX|WW)-)
NUMBER ([0-9]{1,6})

OLD_REG ({OLD_YEAR}{OLD_COUNTIES}{NUMBER})
NEW_REG ({NEW_YEAR}{NEW_COUNTIES}{NUMBER})
%%

[ \t\n]*{OLD_REG}[ \t\n]* {
  char year[2];
  strncpy(year, yytext, 2);

  int years = atoi(year);

  if(years > 12){
    years = years + 1900;
  }

  else{
    years = years + 2000;
  }

  int age = old_base-years;
  printf("%d\n", age);
}

[ \t\n]*{NEW_REG}[ \t\n]* {
  char year[2];
  strncpy(year, yytext, 2);

  int years = atoi(year);
  int age = new_base-years;
  printf("%d\n", age);
}

[ \t\n]*.+[ \t\n]* {printf("INVALID\n");}

%%

int main()
{
  yylex();
  return 0;
}
