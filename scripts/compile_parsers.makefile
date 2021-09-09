#
# compile_parsers.makefile
# Stephan Seitz, 2021-09-09 21:36
#
CC?=cc

all: parser.so

parser.o: src/parser.c
	$(CC) -c src/parser.c -std=c99 -fPIC -I./src

scanner.o: src/scanner.cc
	$(CC) -c src/scanner.cc -std=c++17 -fPIC -I./src

parser.so: parser.o scanner.o
	$(CC) parser.o scanner.o -o parser.so -shared -Os -lstdc++
