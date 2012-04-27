CFLAGS=-Wall -O2
LDFLAGS=-O2

all: z80sim

z80sim: z80sim.o cpu.o symbols.o debug.o parser.o eval.o tokens.o watch.o

clean:
	rm -f z80sim *.o
