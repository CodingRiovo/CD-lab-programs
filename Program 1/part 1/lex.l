%{
    #include<stdio.h>
    #include<stdlib.h>
    int words = 0;
    int lines = 0;
    int characters = 0;
    int whites = 0;
%}
%%
[a-zA-Z]+ {words++; characters+=yyleng;}
\n {lines++;characters++;}
[ \t] {whites++; characters++;}
"~~" {return 0;}
. {characters++;}
%%
int yywrap(){
    return 1;
}
int yyerror(){
    exit(0);
}
int main(){
    yylex();
    printf("Number of words: %d\n", words);
    printf("Number of lines: %d\n", lines);
    printf("Number of characters: %d\n", characters);
    printf("Number of white spaces: %d\n", whites);
    return 0;
}