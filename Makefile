CC=gcc

all: build test

build:
	mkdir -p bin
	$(CC) -o ./bin/c ts.c
	javac -d ./bin ts.java
	nasm -felf64 ts.asm
	ld -o bin/asm ts.o
	rm ts.o
	rustc -o bin/rust ts.rs

test:
	echo "Testing.."
	./bin/c 2>/dev/null || echo "C: Success!"
	java -cp bin ts >/dev/null || echo "Java: Success!"
	rm *.log
	./bin/asm 2>/dev/null || echo "Assembler: Success!"
	./bin/rust 2>/dev/null || echo "Rust: Success!"

clean:
	rm -rf bin

.PHONY: build test clean