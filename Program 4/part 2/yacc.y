%{
    #include<stdio.h>
    #include<stdlib.h>
    int nesting = 0;
%}
%token ID LOGOP IF NUM TYPE
%left '+' '-'
%left '*' '/'
%%
SS: S1 ';' SS {$$=$3;}
|I SS {$$ = max($1, $2); nesting = max(nesting, $$);}
| {$$ = 0;};
I:IF '(' COND ')' BODY {$$ = $5+1;};
COND: T LOGOP T;
BODY: S1 ';' {$$ = 0;}
|'{' SS '}' {$$ = $2;}
|I {$$ = $1;}
|';' {$$ = 0;};
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
int max(int a, int b){
	return (a>b)?a:b;
}
int main(){
    yyparse();
    printf("maximum nesting: %d levels\n", nesting);
    return 0;
}