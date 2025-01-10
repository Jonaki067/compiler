%{
#include <bits/stdc++.h>
using namespace std;
#include "1907067.tab.h" // Include the generated Bison header file
int yylex();
extern YYSTYPE yylval;
int count_id = 0;
int count_statements = 0;
int single_Line_comment = 0;
int multi_Line_comment = 0;
set<string> encounteredIDs;
extern int yylineno;
%}

%option noyywrap

DIGIT [0-9]
ID [_][A-Za-z][A-Za-z0-9]*
SLC "/*"[^\n]*\n
MLC  <[^>]*>

%%
" " 
{ID} {
    yylval.stringValue = strdup(yytext); 
    return IDENTIFIER;
}

{SLC} { return SLC ;}
{MLC} { return MLC ;}
"eol" {return LINE_COMPLEMENT;}

[+]?{DIGIT}+  { yylval.intValue = atoi(yytext); return INT_VAL; }
[-]?{DIGIT}+  { yylval.intValue = atoi(yytext); return INT_VAL; }
[+-]?{DIGIT}+[.]{DIGIT}+|{DIGIT}?[.]{DIGIT}+|{DIGIT}+e[+-]{DIGIT}+ { yylval.floatValue = atof(yytext); return FLOAT_VAL; }

[&]{2}     { return AND; }
[|]{2}     { return OR; }

"PURNO_NUMBER" { return DATATYPE; }
"FRACTION_NUMBER" { return DATATYPE; }
"PURFRAC_NUM" { return DATATYPE; }
"EXTRA_LONG_PURNO"  { return DATATYPE; }

[<>,:;]     { return *yytext;	}  
[+]     { return ADD; }
[-]     { return SUBTRACT; }
[/]     { return DIVIDE; }
[*]     { return MULTIPLY; }
[=]     { return EQUAL; }
[%]     { return MOD; }

"LOOP"   { return LOOP; }
"IF"    { return IF; }
"ELSE"  { return ELSE; }
"FUNCTION" { return FUNCTION; }
"RETURN" { return RETURN; }
[A-Z][A-Za-z0-9_]+ { return FUNCTION_NAME; }


\n      { yylineno++; }
.       { return *yytext; }
%%
