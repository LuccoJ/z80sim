#include "locks.h"

#include "types.h"
#include "scheduling.h"
#include "exceptions.h"
#include "z80.h"

#include "simulator.h"

bool Locks[MAX_LOCKS];
unsigned short LockCount;

bool LocksInited; void LocksInit() {
	if(!LocksInited) {
		LockCount=0;
		SchedulingInit();
		LocksInited=TRUE;
		_SimPrintString("Locks initialized\n");
	}
}

lock LockCreate() {
	lock NewLock;
	Pause();
	NewLock=LockCount;
	Locks[NewLock]=FALSE;
	LockCount++;
	Resume();
	return NewLock;

}

void LockObtain(lock Handle) {
	if(!IsMultitasking() && LockQuery(Handle)) Halt("DEADLOCK IN KERNEL MODE");
	while(LockQuery(Handle)) AwaitEvent(EVENT_UNLOCK);
	Pause();
	Locks[Handle]=TRUE;
	Resume();
}

void LockRelease(lock Handle) {
	Pause();
	if(Locks[Handle]) {
		Locks[Handle]=FALSE;
		Resume();
		//BroadcastEvent(EVENT_UNLOCK, Handle);
	} else Resume();
}

bool LockQuery(lock Handle) {
	bool State;
	Pause();
	State=Locks[Handle];
	Resume();
	return State;
}
