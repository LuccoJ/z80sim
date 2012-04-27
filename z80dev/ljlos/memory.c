#include "memory.h"

#include "types.h"
#include "exceptions.h"

#include "simulator.h"

char* NextFreeBlock;

bool MemoryInited; void MemoryInit() {
	if(!MemoryInited) {
		NextFreeBlock=(char*)0xe000;
		MemoryInited=TRUE;
		_SimRWProtect((void*)0x8600, 0xffd0);
                _SimPrintString("Memory initialized\n");
	}
}

void MemoryCopy(void* Destination, void* Source, unsigned int Length) {
	register unsigned int i;
	for(i=0; i<Length; i++) {
		*((char*)Destination+i)=*((char*)Source+i);
	}
}

void* MemoryAllocate(unsigned int Bytes, memType Type) {
	char* Pointer;
	if(NextFreeBlock<(char*)0x9000) Halt("OUT OF MEMORY");
	Pointer=NextFreeBlock;
	NextFreeBlock=NextFreeBlock-Bytes;
	_SimUnprotect(NextFreeBlock, Pointer);
	if(Type==memSTACK) {
		return (void*)Pointer;
	} else {
		return (void*)NextFreeBlock;
	}
}

void MemoryFree(void* Pointer) {
	// dummy function
	Pointer;
}
