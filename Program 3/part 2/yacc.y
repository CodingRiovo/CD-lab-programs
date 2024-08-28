%{
	#include<stdio.h>
	#include<stdlib.h>
	int cnt=0;
%}
%token FOR ID NUM TYPE OP
%%

// Tokens

// FOR -> for
// ID -> identifier
// NUM -> number
// TYPE -> datatype
// OP -> relational operator

// Non-terminals

// S -> Start symbol
// BODY -> Body  of For loop
// COND -> Condition
// S1 -> Single Statement
// SS -> Set of statements
// T -> Term
// E -> Expression
// F -> For loop block
// DA -> Declaration or assignment
// DECL -> Declaration
// ASSGN -> Assignment

S:F;
F:FOR'('DA';'COND';'S1')'BODY { cnt++; } |
  FOR'(' ';'COND';'S1')'BODY { cnt++; } |
  FOR'('DA';' ';'S1')'BODY { cnt++; } |
  FOR'('DA';'COND';' ')'BODY { cnt++; } |
  FOR'(' ';' ';'S1')'BODY { cnt++; } |
  FOR'('DA';' ';' ')'BODY { cnt++; } |
  FOR'(' ';'COND';' ')'BODY { cnt++; } |
  FOR'(' ';' ';' ')'BODY { cnt++; };

DA:DECL|ASSGN
DECL: TYPE ID | TYPE ASSGN;
ASSGN : ID '=' E;
COND : T OP T;
T : NUM | ID ;

BODY: S1';' | '{'SS'}' | F |';';

SS: S1 ';' SS | F SS |;
S1: ASSGN | E | DECL ;
E : E '+' E | E '-' E | E '*' E | E '/' E | '-''-'E | '+''+'E | E'+''+' | E'-''-' | T ;
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
	printf("Enter the snippet:\n");
	yyparse();
	printf("Count of for : %d\n",cnt);
	return 0;
}