%{
    #include<stdio.h>
    #include<stdlib.h>
    int maxCnt = 1;
    int cnt;
%}
%token ID LOGOP IF NUM TYPE
%%
S:I {cnt = 1;};
I:IF '(' COND ')' BODY;
COND: T LOGOP T;
BODY: S1 ';'|'{' SS '}'
|I {cnt++; if(cnt > maxCnt) maxCnt = cnt;}
|';';
SS: S1 ';' SS|I SS {cnt++; if(cnt > maxCnt) maxCnt = cnt;}
|
;
S1:DECL|ASSGN|E;
DECL: TYPE ASSGN|TYPE ID;
ASSGN: ID '=' E;
E : E '+' E | E '-' E | E '*' E | E '/' E | '-''-'E | '+''+'E | E'+''+' | E'-''-' | T ;
T : NUM | ID ;
%%
int yywrap(){
    return 1;
}
void yyerror(char* msg){
    printf("Error: %s\n", msg);
    exit(0);
}
int main(){
    yyparse();
    printf("maximum nesting: %d levels\n", maxCnt);
    return 0;
}