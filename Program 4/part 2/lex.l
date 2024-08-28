%{
    #include "y.tab.h"
%}
%%
"if" return IF;
"int"|"float"|"char" return TYPE;
"<"|">"|"<="|">="|"=="|"!=" return LOGOP;
[a-zA-Z_][a-zA-Z0-9_]* return ID;
[0-9]+ return NUM;
[ \n\t] ;
"~~" return 0;
. return yytext[0];
%%