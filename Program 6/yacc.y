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

int idx=-1;
string addToTable(string, string,char);
%}

%union{
	char* exp;
}

%token<exp> ID NUM
%type<exp> EXP

%right '='
%left '+' '-'
%left '*' '/'
%left '('
%%

STMTS : STMTS STMT
|
;
      
STMT: EXP '\n';
      
EXP: EXP '+' EXP { $$=addToTable($1,$3,'+');}
| EXP '-' EXP { $$=addToTable($1,$3,'-');}
| EXP '*' EXP { $$=addToTable($1,$3,'*');}
| EXP '/' EXP { $$=addToTable($1,$3,'/');}
| ID '=' EXP { $$=addToTable($1,$3,'=');}
| '(' EXP ')' { $$=$2;}
| ID { $$=$1;}
| NUM { $$=$1;};
      
%%

int yyerror(){
	printf("\nError\n");
	exit(1);
}
int yywrap(){
	return 1;
}

string addToTable(string op1,string op2, char op){
	idx++;
	if(op=='='){
		code[idx].res=op1;
		code[idx].op1=op2;
		code[idx].op=op;
		code[idx].op2="NULL";
		return code[idx].res;
	}
	code[idx].op1=op1;
	code[idx].op2=op2;
	code[idx].op=op;

	string res=malloc(3);
	sprintf(res,"@%c",'A'+idx);
	code[idx].res=res;

	return res;
}

void threeAddressCode(){
	for(int i=0;i<=idx;i++){
		if(code[i].op=='='){
			printf ("%s = %s\n",code[i].res,code[i].op1);
		}
		else{
			printf("%s = %s %c %s\n",code[i].res,code[i].op1,code[i].op,code[i].op2);
		}
	}
}

void quadruples(){
	for(int i=0;i<=idx;i++){
		printf("%s %s %c %s\n",code[i].res,code[i].op1,code[i].op,code[i].op2);
	}
}

void assembly()
{
	for(int i=0;i<=idx;i++)
	{
		string instr;
		switch(code[i].op)
		{
			case '+' : instr="ADD"; break;
			case '-' : instr="SUB"; break;
			case '*' : instr="MUL"; break;
			case '/' : instr="DIV"; break;
			case '=' : instr="MOV"; break;
		}
		if(instr == "MOV"){
			printf("LOAD R4, %s\n",code[i].op1);
			printf("STR %s, R4\n",code[i].res);

		}
		else{
			printf("LOAD R1, %s\n",code[i].op1);
			printf("LOAD R2, %s\n",code[i].op2);
			printf("%s R3, R1, R2\n", instr);
			printf("STR %s, R3\n", code[i].res);
		}
	}
}

int main(){
	yyparse();
	printf("Three Address Code:\n");
	threeAddressCode();
	printf("Quadruples:\n");
	quadruples();
	printf("Assembly:\n");
	assembly();
	return 0;
}