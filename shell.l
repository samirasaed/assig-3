%{
#include "shell.tab.h"
#include <string.h>
%}

%%
[ \t]+              ;
"\n"                { return NEWLINE; }
[a-zA-Z0-9_./-]+    {
                        yylval.string = strdup(yytext);
                        return WORD;
                     }
%%

int yywrap() {
    return 1;
}

