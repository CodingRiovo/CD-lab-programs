%{
    #include<stdio.h>
    #include<stdlib.h>
%}
%token TYPE ARR VAR SC CO
%%
S: TYPE E { printf("Accepted, declarations: %d\n", yylval); };
E: ARR { $$ = 1; } 
 | VAR { $$ = 1; }
 | ARR ',' E { $$ = 1 + $$; }
 | VAR ',' E { $$ = 1 + $$; }
 ;
%%
int yywrap(){
    return 1;
}
int yyerror(char *s){
    printf("Error: %s\n", s);
    exit(1);
}
int main(){
    yyparse();
    return 0;
}