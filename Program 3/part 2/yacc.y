%{
	#include<stdio.h>
	#include<stdlib.h>
	int nesting=0;
%}
%token FOR ID NUM TYPE OP
%left '+' '-'
%left '*' '/'
%%
S:F S {$$ = max($1, $2); nesting = max(nesting, $$);} 
| F {$$ = $1;};
F:FOR'('DA';'COND';'S1')'BODY { $$ = $9+1; } |
  FOR'(' ';'COND';'S1')'BODY { $$ = $8+1; } |
  FOR'('DA';' ';'S1')'BODY { $$ = $8+1; } |
  FOR'('DA';'COND';' ')'BODY { $$ = $8+1; } |
  FOR'(' ';' ';'S1')'BODY { $$ = $7+1; } |
  FOR'('DA';' ';' ')'BODY { $$ = $7+1; } |
  FOR'(' ';'COND';' ')'BODY { $$ = $7+1; } |
  FOR'(' ';' ';' ')'BODY { $$ = $6+1; };

DA:DECL|ASSGN
DECL: TYPE ID | TYPE ASSGN;
ASSGN : ID '=' E;
COND : T OP T;
T : NUM | ID ;

BODY: S1';' {$$ = 0;}
| '{'SS'}' {$$ = $2;}
| F {$$ = $1;}
|';' {$$ = 0;};

SS: S1 ';' SS {$$ = $3;}
| F SS {$$ = max($1,$2); nesting = max(nesting, $$);}
| {$$ = 0;};
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
int max(int a, int b){
	return (a>b)?a:b;
}
int main()
{
	printf("Enter the snippet:\n");
	yyparse();
	printf("Maximum nesting : %d\n",nesting+1);
	return 0;
}