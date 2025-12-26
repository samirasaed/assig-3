%{
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

void execute_command(char **args);
void yyerror(const char *s);
int yylex();
%}

/* ===== UNION ===== */
%union {
    char *string;
    char **strlist;
}

/* ===== TOKENS ===== */
%token <string> WORD
%token NEWLINE

/* ===== NON-TERMINALS TYPES ===== */
%type <strlist> args

%%

input:
      command NEWLINE
    | input command NEWLINE
    ;

command:
    WORD args {
        char **cmd = malloc(sizeof(char*) * 100);
        cmd[0] = $1;

        int i = 1;
        while ($2[i-1] != NULL) {
            cmd[i] = $2[i-1];
            i++;
        }
        cmd[i] = NULL;

        execute_command(cmd);
    }
    ;

args:
      /* empty */
        {
            $$ = malloc(sizeof(char*));
            $$[0] = NULL;
        }
    | args WORD
        {
            int i = 0;
            while ($1[i] != NULL)
                i++;

            $1 = realloc($1, sizeof(char*) * (i + 2));
            $1[i] = $2;
            $1[i + 1] = NULL;
            $$ = $1;
        }
    ;

%%

void execute_command(char **args) {

    if (strcmp(args[0], "exit") == 0) {
        exit(0);
    }

    if (strcmp(args[0], "cd") == 0) {
        chdir(args[1]);
        return;
    }

    pid_t pid = fork();

    if (pid == 0) {
        execvp(args[0], args);
        perror("execvp failed");
        exit(1);
    } else {
        wait(NULL);
    }
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("MiniShell started...\n");
    yyparse();
    return 0;
}

