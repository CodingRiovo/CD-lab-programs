%{
    #include<stdio.h>
    #include<stdlib.h>
%}
%token NUM TYPE ID
%%
S:TYPE ID '(' PARAMS ')' BODY {printf("Accepted\n");}
|TYPE ID '('')' BODY {printf("Accepted\n");};
PARAMS:TYPE ID ',' PARAMS
|TYPE ID
;
BODY:'{' SS '}';
SS:S1 ';' SS
|
;
S1:ASSGN|DECL|E;
DECL:TYPE ID|TYPE ASSGN;
ASSGN:ID '=' E;
E:E'+'E
|E'-'E
|E'*'E
|E'/'E
|E'+''+'
|E'-''-'
|'+''+'E
|'-''-'E
|'(' E ')'
|T;
T:NUM|ID;
%%
void yyerror(char* msg)
{
    printf("Error: %s\n", msg);
    exit(0);
}
int yywrap()
{
    return 1;
}
int main(){
    yyparse();
    return 0;
}