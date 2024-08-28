%{
    #include<stdio.h>
    #include<stdlib.h>
%}
%token NUM
%%
S:E {printf("%d\n", $$);};
E:E'+'E {$$ = $1 + $3;}
|E'-'E {$$ = $1 - $3;}
|E'*'E {$$ = $1 * $3;}
|E'/'E {$$ = $1 / $3;}
|'('E')' {$$ = $2;}
|NUM {$$ = $1;}
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
    printf("Accepted\n");
}