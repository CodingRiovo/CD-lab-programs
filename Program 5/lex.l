%{
    #include "y.tab.h"
    extern int yylval;
%}
%%
"int"|"float" { return TYPE; }
[a-zA-Z_]+[a-zA-Z_0-9]*"["[0-9]+"]" { yylval++; return ARR; }
[a-zA-Z_]+[a-zA-Z_0-9]* { yylval++; return VAR; }
[\n\t ] {}
[;] { return 0; }
. {return yytext[0];}
%%