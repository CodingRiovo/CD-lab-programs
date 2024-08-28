%{
    #include "y.tab.h"
%}

%%
[\t\n ] ;

"int"|"float"|"char"|"void" {return TYPE;}

[a-zA-Z][a-zA-Z0-9_]* {return IDEN;}

[0-9]+ {return NUM;}
"~~" {return 0;}
. {return yytext[0];}
%%