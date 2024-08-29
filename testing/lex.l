%{
    #include<string.h>
    #include "y.tab.h"
%}
%%
[a-zA-Z_][a-zA-Z0-9_]* {yylval.exp = strdup(yytext); return ID;}
[0-9]+ {yylval.exp = strdup(yytext); return NUM;}
[-+*/()=] {return yytext[0];}
[\n]+ return '\n';
"~~" return 0;
. ;
%%