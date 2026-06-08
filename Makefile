ASM = nasm
LD = ld

ASMFLAGS = -f elf64

TARGET = forca
OBJS = main.o io.o banco_palavras.o draw_hangman.o

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LD) $(OBJS) -o $(TARGET)

main.o: main.asm
	$(ASM) $(ASMFLAGS) main.asm -o main.o

io.o: io.asm
	$(ASM) $(ASMFLAGS) io.asm -o io.o

banco_palavras.o: banco_palavras.asm
	$(ASM) $(ASMFLAGS) banco_palavras.asm -o banco_palavras.o

draw_hangman.o: draw_hangman.asm
	$(ASM) $(ASMFLAGS) draw_hangman.asm -o draw_hangman.o

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(OBJS) $(TARGET)

.PHONY: all run clean
