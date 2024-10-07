%{
	#include<stdio.h>
	#include<stdlib.h>
	int nesting=0;
%}
%token FOR ID NUM TYPE OP
%left '+' '-'
%left '*' '/'
%%

SS: S1 ';' SS {$$ = $3;}
| F SS {$$ = $1>$2?$1:$2; nesting = max(nesting, $$);}
| {$$ = 0;};

F:FOR'('DA';'COND';'S1')'BODY { $$ = $9+1; };

DA:DECL|ASSGN| ;
DECL: TYPE ID | TYPE ASSGN;
ASSGN : ID '=' E;
COND : T OP T| ;
T : NUM | ID ;

BODY: S1';' {$$ = 0;}
| '{'SS'}' {$$ = $2;}
| F {$$ = $1;}
|';' {$$ = 0;};

S1: ASSGN | E | DECL| ;
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
	printf("Maximum nesting : %d\n",nesting);
	return 0;
}