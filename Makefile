UNAME_S = $(shell uname -s)

PROJNAME = game

CC = clang
CFLAGS = -std=c11 -O0 -g -Wall -Wextra -Wpedantic -Wstrict-aliasing
CFLAGS += -Wno-pointer-arith -Wno-newline-eof -Wno-unused-parameter -Wno-gnu-statement-expression
CFLAGS += -Wno-gnu-compound-literal-initializer -Wno-gnu-zero-variadic-macro-arguments
CFLAGS += -fbracket-depth=1024
LDFLAGS = -lm
LDFLAGS += -ldl -lpthread
LDFLAGS += -lSDL3

SRC  = $(wildcard src/**/*.c) $(wildcard src/*.c) $(wildcard src/**/**/*.c) $(wildcard src/**/**/**/*.c)
OBJ  = $(SRC:.c=.o)
BIN = bin

.PHONY: all clean

all: dirs libs game

quick: dirs $(PROJNAME) run

libs:

dirs:
	mkdir -p ./$(BIN)

run:
	$(BIN)/game

$(PROJNAME): $(OBJ)
	$(CC) -o $(BIN)/$(PROJNAME) $^ $(LDFLAGS)

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

clean:
	rm -rf $(BIN) $(OBJ)
