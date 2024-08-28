%{
    #include<stdio.h>
    #include<stdlib.h>
    int posfrac = 0;
    int posint = 0;
    int negfrac = 0;
    int negint = 0;

%}
%%
"+"?[0-9]+"/""+"?[0-9]+|"-"[0-9]+"/""-"[0-9]+ {posfrac++;}
"+"?[0-9]+"/""-"[0-9]+|"-"[0-9]+"/""+"?[0-9]+ {negfrac++;}
"+"?[0-9]+ {posint++;}
"-"[0-9]+ {negint++;}
\n {}
"~~" {return 0;}
. {return yytext[0];}
%%
int yywrap(){
    return 1;
}
int yyerror(){
    exit(0);
}
int main(){
    yylex();
    printf("number of positive fractions: %d\n", posfrac);
    printf("number of negative fractions: %d\n", negfrac);
    printf("number of positive integers: %d\n", posint);
    printf("number of negatives integers: %d\n", negint);
    return 0;
}