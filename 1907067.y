%{
#include <bits/stdc++.h>
using namespace std;
#ifndef YYSTYPE
#define YYSTYPE YYSTYPE
typedef union {
    int intValue;
    float floatValue;
    char *stringValue;
} YYSTYPE;
#endif

void yyerror(const char *s);
int yylex();
extern int count_id;
extern int count_statements;
extern int single_Line_comment;
extern int multi_Line_comment;
extern int yyparse();
void printTotalCount();
extern YYSTYPE yylval;
int yylineno = 1;
extern FILE *yyin, *yyout;
map<string, float> identifierValues;
void all_identifier();
int fn = 0;
int lp = 0;
int ifelse = 0;
%}


%token IDENTIFIER INT_VAL FLOAT_VAL SLC MLC FUNCTION FUNCTION_NAME RETURN LINE_COMPLEMENT
%token DATATYPE  EQUAL 
%token LOOP IF ELSE 
%left ADD SUBTRACT
%left MULTIPLY DIVIDE 
%left AND OR 
%left MOD 
%right UNARY_MINUS


%union {
    int intValue;
    float floatValue;
    char *stringValue;
}

%type <intValue> INT_VAL 
%type <floatValue> FLOAT_VAL
%type <stringValue> IDENTIFIER DATATYPE IDENTIFIER1
%type <intValue> exp term factor expr if_statement 


%%
main:/*empty*/
    | start
    ;
start: 
    |';'
    | start declaration 
    | start expression 
    | start if_else 
    | start loop_stat 
    | start SLC { cout << "Single_Line_Comment" <<endl;single_Line_comment++;}
    | start MLC { cout << "Multi_Line_Comment" <<endl;multi_Line_comment++;}
    | start function_stat
    | start LINE_COMPLEMENT {cout<<"LINE_COMPLEMENT"<<endl;count_statements++;}
    ;
function_stat:function
        ;
function : DATATYPE FUNCTION FUNCTION_NAME '{' loop '}'  RETURN {fn++;cout<<"FUNCTION DEFINED SUCCESSFULLY . LOOP INSIDE THE FUNCTION"<<endl;}
         | DATATYPE FUNCTION FUNCTION_NAME '{' if_else '}'  RETURN {fn++;cout<<"FUNCTION DEFINED SUCCESSFULLY . IF_STATEMENT INSIDE THE FUNCTION"<<endl;}
         | DATATYPE FUNCTION FUNCTION_NAME '{' expr_list '}'  RETURN {fn++;cout<<"FUNCTION DEFINED SUCCESSFULLY . EXPRESSION INSIDE THE FUNCTION"<<endl;}
        ; 
loop_stat: loop
         ;
loop : LOOP '(' IDENTIFIER EQUAL INT_VAL ';' IDENTIFIER '<' INT_VAL ';' IDENTIFIER EQUAL IDENTIFIER ADD INT_VAL ')' '{' if_else '}' {
    cout<<"IF STATEMENT INSIDE THE LOOP"<<endl;
    int  x = 0 ;
    lp++;
    for(int i = $5 ; i < $9 ; i = i + $15 )
    {
         x++;
         cout<<" The loop is runing " <<endl;
    }
    cout<<"Finally , "<<x<<" times the loop run "<<endl;
}
    | LOOP '(' IDENTIFIER EQUAL INT_VAL ';' IDENTIFIER '<' INT_VAL ';' IDENTIFIER EQUAL IDENTIFIER ADD INT_VAL ')' '{' expr_list '}' {
        cout<<"EXPRESSION INSIDE THE LOOP"<<endl;
        lp++;
        int  x = 0 ;
        for(int i = $5 ; i < $9 ; i = i + $15 )
        {
         x++;
         cout<<" The loop is runing " <<endl;
        }
        cout<<"Finally , "<<x<<" times the loop run "<<endl;
     }
     ;
if_else: if_statement
       ;   
if_statement: IF '(' expr ')' '{' if_statement '}'  ELSE '{' expr_list '}' {
               ifelse++; cout << "\nNested if else executed" << endl;
             }
             | IF '(' expr ')' '{' expr_list '}' ELSE '{' expr_list '}' {
                ifelse++; cout << "\nif else executed" << endl;
             }
             | IF '(' expr ')' '{' expr_list '}' {
                ifelse++; cout << "\nif executed" << endl;
             }
             ;

declaration: DATATYPE IDENTIFIER1 ';' {
                cout << "\nValid declaration" << endl;
            }
           ;

IDENTIFIER1:  IDENTIFIER1 ',' IDENTIFIER {count_id++;}
           |  IDENTIFIER {count_id++;}
           ;  
expression: expr_list
          ;
expr_list: expr
         | expr_list ',' expr
         ;
expr: exp {
        cout << "The value of the expression is :" << $$ << endl;
    }
    | IDENTIFIER EQUAL exp {
        $$ = $3;
        cout << $1 << "=" << $$ << endl;
        identifierValues[$1] = $$;
    }
    ;

exp: exp ADD term { $$ = $1 + $3; cout<<"PLUS"<<endl; }
    | exp SUBTRACT term { $$ = $1 - $3; }
    | term
    ;

term: term MULTIPLY factor { $$ = $1 * $3; }
    | term DIVIDE factor { 
        if($3){
            $$ = $1 / $3;
        } else {
            $$ = 0;
            cout << "Invalid as denominator is zero. By default 0 will be returned." << endl;
        } 
    }
    | term MOD factor { 
        if($3){
            $$ = $1 % $3;
        } else {
            $$ = 0;
            cout << "Invalid as denominator is zero.SO Modulas is not possible" << endl;
        } 
    }
    | term AND factor { 
       cout<<"This is the binary AND operation"<<endl;
       $$ = $1 && $3 ;

    }
    | term OR factor { 
       cout<<"This is the binary OR operation"<<endl;
       $$ = $1 || $3 ;

    }
    | factor
    ;

factor: INT_VAL {$$=$1}
    | FLOAT_VAL {$$=$1}
    | '(' exp ')' { $$ = $2; }
    | SUBTRACT factor %prec UNARY_MINUS { $$ = -$2; }

    ;

%%

int main()
{
    yyin=fopen("input.txt","r");
    yyparse();
    fclose(yyin);
    all_identifier();
    printTotalCount();
    return 0;
}

void yyerror(const char *s)
{
    fprintf(stderr, "Syntax error near line %d: %s\n", yylineno, s);
}

void printTotalCount()
{
    cout<<"Total number of identifier is "<<count_id<<endl;
    cout<<"Total number of single line comment is "<<single_Line_comment<<endl;
    cout<<"Total number of multi line comment is "<<count_id<<endl;
    cout<<"Total number of statement is "<<count_statements<<endl;
    cout<<"Total number of function declared is "<<fn<<endl;
    cout<<"Total number of if_else statement is "<<ifelse<<endl;
    cout<<"Total number of loop statement is "<<lp<<endl;
}

void all_identifier()
{
    cout<<"All Variables with there value "<<endl;
    for(auto child : identifierValues )
    {
        cout<<child.first<<"="<<child.second<<endl;
    }
    cout<<endl;
}