CC = gcc
CFLAGS = -I./include -lcurl
SRC = src/apk_tool.c
OBJ = $(SRC:.c=.o)
BIN = bin/apk_tool

all: $(BIN)

$(BIN): $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)

clean:
	rm -f $(OBJ) $(BIN)
