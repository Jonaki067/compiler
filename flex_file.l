%{
#include <bits/stdc++.h>
using namespace std;
int count_id=0;
int count_key=0;
int count_statements = 0;
%}

DIGIT [0-9]
ID [_][A-Za-z][A-Za-z0-9]*

%%
" " 
{ID} { cout<<"IDENTIFIER\n";count_id++;}
[+]?{DIGIT}+	{cout<<"positive integer\n";}
[-]?{DIGIT}+	{cout<<"negative integer\n";}
[+-]?{DIGIT}+[.]{DIGIT}+|{DIGIT}?[.]{DIGIT}+|{DIGIT}+e[+-]{DIGIT}+ {cout<<"floating value\n";}
"STARTHEAD" { cout<<"Starting the Main Function\n";count_key++;}
"ENDHEAD" { cout<<"Ending the Main Function\n";count_key++;}
"PURNO_NUMBER" { cout<<"INTEGER_DATA_TYPE\n";count_key++;}
"FRACTION_NUMBER" { cout<<"FLOATING_POINT_NUMBER_DATA_TYPE\n";count_key++;}
"PURFRAC_NUM" { cout<<"DOUBLE_DATA_TYPE\n";count_key++;}
"EXTRA_LONG_PURNO"  { cout<<"LONG_LONG_INTEGER_DATA_TYPE\n";count_key++;}
"LETTER"  { cout<<"CHARACTER_DATA_TYPE\n";count_key++;}
"LETTERS" { cout<<"STRING_DATA_TYPE\n";count_key++;}
"PLUS"  { cout<<"ADD\n";count_key++;}
"MINUS"  { cout<<"MINUS\n";count_key++;}
"MULTI"  { cout<<"MULTIPLICATION\n";count_key++;}
"DIVI"   { cout<<"DIVISION\n";count_key++;}
"MOD"    { cout<<"MODULUS\n";count_key++;}
"POWER"  { cout<<"POWER\n";count_key++;}
"MAX"	 { cout<<"MAXIMUM\n";count_key++;}
"MIN"	 { cout<<"MINIMUM\n";count_key++;}
"EQ"  { cout<<"EQUAL\n";count_key++;}
"LT"  { cout<<"LESS_THAN\n";count_key++;}
"GT"  { cout<<"GREATER_THAN\n";count_key++;}
"LE"  { cout<<"LESS_THAN_OR_EQUAL\n";count_key++;}
"GE"  { cout<<"LESS_THAN_OR_EQUAL\n";count_key++;}
[&&]     { cout<<"AND\n"; }
[||]     { cout<<"OR\n"; }
[!]     { cout<<"NOT\n"; }
[=]     { cout<<"ASSIGNMENT\n"; }
[++]    { cout<<"INCREMENT\n"; }
[--]    { cout<<"DECREMENT\n"; }
[/]     { cout<<"END_OF_STATEMENT\n";count_statements++;}
[,]     { cout<<"SEPARATOR\n"; }
"("     { cout<<"STARTING OF FIRST BRACES\n"; }
")"     { cout<<"ENDING OF FIRST BRACES\n"; }
"{"     { cout<<"STARTING OF SECOND BRACES\n"; }
"}"     { cout<<"ENDING OF SECOND BRACES\n"; }
"["     { cout<<"STARTING OF THIRD BRACES\n"; }
"]"     { cout<<"ENDING OF THIRD BRACES\n"; }
"OUT"   { cout<<"PRINT\n";count_key++;}
"IN"   { cout<<"SCAN\n";count_key++;}
"FOR_LOOP"   { cout<<"FOR\n";count_key++;}
"WHILE_LOOP"    { cout<<"WHILE\n";count_key++;}
"IF"   { cout<<"IF\n";count_key++;}
"ELSE"   { cout<<"ELSE\n";count_key++;}
"ELSE_IF"   { cout<<"ELSE_IF\n";count_key++;}
"#include <bits/stdc++.h>" { cout<<"PRE_PROCESSOR_DIECTIVES\n"; }
"/*" { cout<<"SINGLE_LINE_COMMENT\n"; }
[<](.*|\n)*[>] { cout<<"MULTI_LINE_COMMENT\n"; }
\n
%%

int yywrap(){
	return 1;
}

int main(){
	yyin=fopen("input.txt","r");
	yylex();
	fclose(yyin);
        cout<<"Total number of identifier is "<<count_id<<endl;
        cout<<"Total number of keywords is "<< count_key<<endl;
        cout<<"Total number of statements is "<<count_statements<<endl;
	return 0;
}