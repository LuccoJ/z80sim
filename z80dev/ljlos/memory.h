#ifndef H_MEMORY
#define H_MEMORY

typedef enum {
	memSTACK,
	memHEAP
} memType;

void MemoryInit();
void* MemoryAllocate(unsigned int, memType);
void MemoryFree(void*);
void MemoryCopy(void* Destination, void* Source, unsigned int Length);

#endif
