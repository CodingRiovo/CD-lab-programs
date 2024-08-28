%{
    #include<stdio.h>
    #include<stdlib.h>
%}
%%
S:X Y {printf("Accepted1\n");};
X:'a'X'b'
|
;
Y:'b'Y'c'
|
;
%%
int yywrap(){
    return 1;
}
int yyerror(){
    printf("Error\n");
    exit(0);
}
int main(){
    yyparse();
}