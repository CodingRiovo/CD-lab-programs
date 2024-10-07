%{
    #include "y.tab.h"
%}
%%
"int"|"float"|"char" {return TYPE;}
"return" {return RET;}
[a-zA-Z_][a-zA-Z0-9_]* {return ID;}
[0-9]+ {return NUM;}
"~~" {return 0;}
[ \t\n] {}
. {return yytext[0];}
%%