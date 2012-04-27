/*
  This program was written by Lorenzo J. Lucchini in 2003.
  It is put by its author in the public domain, for each
  country where the concept of public domain applies.
*/


#include "../../utils/profile.h"

typedef struct {
	char Foo[256];
	int Count;
} footype;

footype MyGlobalVar;

void CodeStart(void);
void CodeEnd(void);

_SimProtectedCodeBegins

void main() {
	footype MyLocalVar;
	long i;
	_SimPrintString("Z80Sim memory protection demo by LjL\n");
	_SimPrintString("Protecting ...\n");
	_SimWriteProtectVar(MyGlobalVar);
	_SimPrintString("Protecting program code...\n");
	_SimWriteProtectVar(MyLocalVar);
	_SimProtectCode();
	_SimPrintString("Attempting to write 0xDEAD to every word of memory...\n");
	_SimPrintWord((unsigned int)&MyGlobalVar+sizeof(MyGlobalVar));
	i=0; do {
		*(unsigned int*)i=0xDEAD;
	} while(i<=0xFFFF);
	_SimPrintString("Completed.\n");
}

_SimProtectedCodeEnds
