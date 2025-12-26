all: minishell

minishell: shell.tab.c lex.yy.c
	gcc shell.tab.c lex.yy.c -o minishell

shell.tab.c: shell.y
	bison -d shell.y

lex.yy.c: shell.l
	flex shell.l

clean:
	rm -f minishell shell.tab.c shell.tab.h lex.yy.c
