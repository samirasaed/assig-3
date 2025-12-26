# MiniShell Project

Hi! This is my MiniShell project for the Operating Systems course.  
I built a simple Unix-like shell using Lex and Yacc. Here's what it can do and how I worked on it.

## What My Shell Can Do
- Run regular Unix commands
- Built-in commands: `cd` and `exit`
- Supports pipes (`|`) and I/O redirection (`>`, `<`, `>>`)
- Creates new processes with `fork()` and executes programs with `execvp()`

## Files in This Project
- `shell.l` : My lexical analyzer for splitting commands into tokens
- `shell.y` : The parser and logic that runs commands
- `Makefile` : To compile everything easily
- `theory_answers.pdf` : My answers to the assignment questions
- `screenshots/` : Shows how my shell works with different commands
- `README.md` : This file, explaining the project

## How I Built and Tested It
1. Installed tools I needed:

```bash
sudo apt update
sudo apt install flex bison build-essential -y

