%{
    #include "y.tab.h"
%}
%%
"for" {return FOR;}
"int"|"char"|"float" {return TYPE;}
[a-zA-Z_][a-zA-Z0-9_]* {return ID;}
">"|"<"|">="|"<="|"=="|"!=" {return OP;}
[0-9]+ {return NUM;}
[ \t\n] {}
"~~" {return 0;}
. {return yytext[0];}
%%
