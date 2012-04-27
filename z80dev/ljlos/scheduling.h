#ifndef H_SCHEDULING
#define H_SCHEDULING

#include "locks.h"

#define EVENT_RUNTASK 0
#define EVENT_UNLOCK 1

typedef struct {
	void* StackFrameTop;
	void* StackFrameBottom;
        int* SP;
	int RegisteredEvents;
	short EventId;
} task;

lock SystemLock;

void SchedulingInit();

void SetScheduler(void (*SchedulerFunction)());
void Scheduler(void* SP);
void DefaultScheduler();
void NullScheduler();

task* CreateTask(void* EntryPoint, unsigned int AssignedStack);
void ScheduleTask(task*);

void Switch();
void BroadcastEvent(int EventClass, short EventId);
short AwaitEvent(int EventClass);

void SupervisorMode();
void UserMode();
void Pause();
void Resume();
bool IsMultitasking();

void ExchangeRegs();

#endif
