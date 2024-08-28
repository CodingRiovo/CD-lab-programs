%{
    #include "y.tab.h"
%}
%%
"int"|"float"|"char"|"double" {return TYPE;}
[a-zA-Z_][a-zA-Z_0-9]* {return ID;}
[0-9]+ {return NUM;}
[ \t\n] {}
"~~" {return 0;}
. {return yytext[0];}
%%