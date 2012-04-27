#ifndef H_LOCKS
#define H_LOCKS

#include "types.h"

#define MAX_LOCKS 256

typedef unsigned char lock;

void LocksInit();
lock LockCreate();
void LockObtain(lock Handle);
void LockRelease(lock Handle);
bool LockQuery(lock Handle);

#endif
