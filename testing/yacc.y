%{
    #include<stdio.h>
    #include<stdlib.h>
    typedef char* string;
    struct{
        string op1;
        string op2;
        string res;
        char op;
    }code[100];
    int idx = -1;
    string addToTable(char, string, string);
    void threeAddressCode();
    void quadruples();
    void targetCode();
%}
%union{
    char* exp;
}
%token <exp> ID NUM
%type <exp> EXP

%left '+' '-'
%left '*' '/' 
%%
STMTS: STMTS STMT
|
;
STMT: EXP '\n';
EXP: EXP '+' EXP {$$ = addToTable('+', $1, $3);}
|EXP '-' EXP {$$ = addToTable('-', $1, $3);}
|EXP '*' EXP {$$ = addToTable('*', $1, $3);}
|EXP '/' EXP {$$ = addToTable('/', $1, $3);}
|ID {$$ = $1;}
|NUM {$$ = $1;}
|'(' EXP ')' {$$ = $2;}
;
%%

int yywrap(){
    return 1;
}

int yyerror(char* msg){
    printf("Error: %s\n", msg);
    exit(1);
}

int main(){
    yyparse();
    threeAddressCode();
    quadruples();
    targetCode();
    return 0;
}

string addToTable(char op, string op1, string op2){
    idx++;
    string res = malloc(2);
    sprintf(res, "@%c", idx+'A');
    code[idx].op = op;
    code[idx].op1 = op1;
    code[idx].op2 = op2;
    code[idx].res = res;
    return res;
}

void threeAddressCode(){
    printf("Three Address Code:\n");
    for(int i=0; i<=idx; i++){
    printf("%s = %s %c %s\n",code[i].res,code[i].op1,code[i].op,code[i].op2);    }
}

void quadruples(){
    printf("Quadruples:\n");
    for(int i=0; i<=idx; i++){
        printf("%c %s %s %s\n", code[i].op, code[i].op1, code[i].op2, code[i].res);
    }
}

void targetCode(){
    printf("Target Code:\n");
    for(int i=0; i<=idx; i++){
        string instr;
        switch(code[i].op){
            case '+':
                instr = "ADD";
                break;
            case '-':
                instr = "SUB";
                break;
            case '*':
                instr = "MUL";
                break;
            case '/':
                instr = "DIV";
                break;
        }
        printf("LOAD\tR1, %s\n", code[i].op1);
        printf("LOAD\tR2, %s\n", code[i].op2);
        printf("%s\tR3, R1, R2\n", instr);
        printf("STORE\t%s, R3\n", code[i].res);
    }
}