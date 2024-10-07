%{
	#include<stdio.h>
	#include<stdlib.h>
%}
%token TYPE ID NUM RET
%%
S: TYPE ID '(' PARAMS ')' BODY
| TYPE ID '(' ')' BODY;
PARAMS: TYPE ID ',' PARAMS
| TYPE ID;
BODY: '{' SS '}';
SS: S1 ';' SS
| RET ';'
| RET ID';'
| RET E';'
| RET ASSGN';'
|
;
S1: DECL|ASSGN|E;
DECL: TYPE ID
| TYPE ASSGN;
ASSGN: ID '=' E;
E: E '+' E|E '-' E|E '*' E|E '/' E|'('E')'|E'+''+'|E'-''-'|'+''+'E|'-''-'E|T;
T: ID|NUM;
%%
int yywrap(){
    return 1;
}
int yyerror(char *s){
    printf("Error: %s\n", s);
    exit(1);
}

int main()
{
	yyparse();
	printf("Accepted\n");
	return 0;
}