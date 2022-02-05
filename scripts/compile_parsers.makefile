CC?=cc
CXX_STANDARD?=c++14

all: parser.so

parser.o: src/parser.c
	$(CC) -c src/parser.c -std=c99 -Os -fPIC -I./src

scanner.o: src/scanner.cc
	$(CC) -c src/scanner.cc -std=$(CXX_STANDARD) -Os -fPIC -I./src

parser.so: parser.o scanner.o
	$(CC) parser.o scanner.o -o parser.so -shared -lstdc++
