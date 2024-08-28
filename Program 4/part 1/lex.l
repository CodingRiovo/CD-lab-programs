%{
    #include<stdio.h>
    #include<stdlib.h>
    int keycnt = 0;
    int idcnt = 0;
    int opcnt = 0;
%}
%%
"int"|"float"|"char"|"double"|"for"|"while"|"do"|"break"|"continue"|"return" {keycnt++;}
[a-zA-Z_][a-zA-Z0-9_]* {idcnt++;}
"<"|">"|"="|"!"|"+"|"-"|"*"|"/"|"&"|"%" {opcnt++;}
. {}
%%
int yywrap(){
    return 1;
}
void yyerror(char* msg){
    printf("Error: %s\n", msg);
    exit(1);
}
int main(){
    yyin = fopen("input.txt", "r");
    yylex();
    printf("Keywords: %d\nIdentifiers: %d\nOperators: %d\n", keycnt, idcnt, opcnt);
    return 0;
}