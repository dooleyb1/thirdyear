bison -d romancalc.y && flex romancalc.l && gcc romancalc.tab.c lex.yy.c
