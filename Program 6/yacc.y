%{
#include<stdio.h>
#include<stdlib.h>

extern FILE *yyin;
typedef char* string;

struct {
string op1;
string op2;
string res;
char op;
} code[100];

int idx=-1;

string addToTable(string,string,char);
void threeaddresscode();
void quadruples();
%}

%union {
char *exp;
}

%token <exp> IDEN NUM
%type <exp> EXP

%left '+' '-'
%left '*' '/' 

%%

STMTS : STMTS STMT
      |
      ;
 
STMT : EXP '\n'
      ;

EXP  : EXP '+' EXP {$$=addToTable($1,$3,'+');}
     | EXP '-' EXP {$$=addToTable($1,$3,'-');}
     | EXP '*' EXP {$$=addToTable($1,$3,'*');}
     | EXP '/' EXP {$$=addToTable($1,$3,'/');}
     | IDEN {$$=$1;}
     | NUM { $$=$1;}
     | '(' EXP ')' {$$=$2;}
     ;
     
%%

void yyerror(char* msg)
{
	printf("Error: %s\n", msg);
	exit(1);
}

int yywrap(){
    return 1;
}

int main()
{
	yyparse();
	printf("Three Address Code:\n");
	threeaddresscode();
	printf("Quadruples:\n");
	quadruples();
	return 0;
}

string addToTable(string op1,string op2, char op)
{
	idx++;
	if(op=='=')
	{
		code[idx].op='=';
		code[idx].op1=op1;
		code[idx].res=op1;
		return op1;
	}
	string res=malloc(3);
	sprintf(res,"@%c",idx+'A');
	code[idx].op1=op1;
	code[idx].op2=op2;
	code[idx].op=op;
	code[idx].res=res;
	
	return res;
}

void threeaddresscode()
{
	int i;
	for(i=0;i<=idx;i++)
	{
		printf("%s = %s %c %s \n",code[i].res,code[i].op1,code[i].op,code[i].op2);
	}
}

void quadruples()
{
	int i;
	for(i=0;i<=idx;i++)
	{
		printf("%c %s %s %s \n",code[i].op,code[i].op1,code[i].op2,code[i].res);
	}
}