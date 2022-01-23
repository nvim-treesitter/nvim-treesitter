#
# compile_parsers.makefile
# Stephan Seitz, 2021-09-09 21:36
#
CC?=cc
CXX_STANDARD?=c++14
C_STANDARD?=c99

all: parser.so

parser.o: src/parser.c
	$(CC) -c src/parser.c -std=$(C_STANDARD) -fPIC -I./src

scanner.o: src/scanner.cc
	$(CC) -c src/scanner.cc -std=$(CXX_STANDARD) -fPIC -I./src

parser.so: parser.o scanner.o
	$(CC) parser.o scanner.o -o parser.so -shared -Os -lstdc++
