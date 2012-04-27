#include "scheduling.h"

#include "hardware.h"
#include "types.h"
#include "memory.h"
#include "exceptions.h"
#include "time.h"

#include "strings.h"
#include "console.h"
#include "simulator.h"

typedef struct t_taskElement {
        task Value;
        struct t_taskElement *Next;
} taskElement;

typedef taskElement* taskList;

taskElement* CurrentTask;
taskList SystemTasks;

void** CurrentSP;
void* OldSP;
void* TempSP;

void (*ActiveScheduler)();

short ControlRequests;

void (*InterruptVector[256])();
short InterruptVectorCount;

void RegisterInterrupt(void (*InterruptFunction)()) {
        InterruptVector[InterruptVectorCount++]=InterruptFunction;
}

void* UserSP;
void _InterruptService() {
        register short i;
        ExchangeRegs();
        GetStackPointerASM(_UserSP);
        SaveIndexes();
	if(ControlRequests<0) Halt("NEGATIVE CONTROLREQUESTS");
        if(!IsMultitasking()) Halt("INTERRUPT IN KERNEL MODE");
	ControlRequests++;
        Tick();
        for(i=0; i<InterruptVectorCount; i++) {
                (InterruptVector[i])();
        }
        Scheduler(UserSP);
        Halt("OUT OF REACH");
}

bool SchedulingInited; void SchedulingInit() {
	if(!SchedulingInited) {
		MemoryInit();
		TimeInit();
		ControlRequests=1;
	        CurrentTask=SystemTasks=NULL;
		ActiveScheduler=NullScheduler;
	        InterruptVectorCount=0;
		SystemLock=LockCreate();
		//CurrentSP=NULL;
		SchedulingInited=TRUE;
	}
}

void SetScheduler(void (*SchedulerFunction)()) {
	ActiveScheduler=SchedulerFunction;
}

void Scheduler(void* SP) {
	OldSP=SP;
	if(ControlRequests>10) Halt("TOO MANY REQUESTS");
	ActiveScheduler();
}

void NullScheduler() {
	ControlRequests--;
	SetStackPointerASM(_OldSP);
	ExchangeRegs();
        ReloadIndexes();
	IntsOn();
}

void DoNothingScheduler() {
}

void DefaultScheduler() {
	if(LockQuery(SystemLock)) {
		Halt("SYSTEM LOCKED SCH");
		NullScheduler();
		return;
	}
        if(SystemTasks==NULL) Break("SCHEDULING NO TASK");
        if(CurrentTask==NULL) {
                CurrentTask=SystemTasks;
        } else {
                CurrentSP=&(CurrentTask->Value.SP);
		//if(CurrentSP==0) Halt("ERRONEOUS STACK POINPOINTER");
		//if(*CurrentSP<(void*)0x8000) for(;;); //Halt("ERRONEOUS STACK POINTER");
        }
	do {
        	if(CurrentTask->Next==NULL) {
                	CurrentTask=SystemTasks;
        	} else {
                	CurrentTask=CurrentTask->Next;
        	}
	} while(CurrentTask->Value.RegisteredEvents!=EVENT_RUNTASK);
        ScheduleTask(&(CurrentTask->Value));
}

task* CreateTask(void* EntryPoint, unsigned int AssignedStack) {
        taskElement* NewTask;
        task* TaskInfo;
        // Add task to tasklist
        NewTask=MemoryAllocate(sizeof(taskElement), memHEAP);
        NewTask->Next=SystemTasks;
        SystemTasks=NewTask;
        // Set up task
        TaskInfo=&(NewTask->Value);
        TaskInfo->StackFrameTop=MemoryAllocate(AssignedStack, memSTACK);
	TaskInfo->StackFrameBottom=(void*)((unsigned int)TaskInfo->StackFrameTop-AssignedStack);
        TaskInfo->SP=TaskInfo->StackFrameTop;
	TaskInfo->SP--; *(void**)(TaskInfo->SP)=EntryPoint;
        TaskInfo->SP--; *TaskInfo->SP=0; // AF
        TaskInfo->SP--; *TaskInfo->SP=0; // BC
        TaskInfo->SP--; *TaskInfo->SP=0; // DE
        TaskInfo->SP--; *TaskInfo->SP=0; // HL
        TaskInfo->SP--; *TaskInfo->SP=0; // IX
        TaskInfo->SP--; *TaskInfo->SP=0; // IY
	TaskInfo->RegisteredEvents=EVENT_RUNTASK;
	TaskInfo->EventId=0;
        return TaskInfo;
}

void SupervisorMode() {
	IntsOff();
	ExchangeRegs();
}

void UserMode() {
	ExchangeRegs();
	IntsOn();
}

void Pause() {
	IntsOff();
	ControlRequests++;
        if(ControlRequests==1) ExchangeRegs();
}

void Resume() {
        if(ControlRequests>0) {
	        ControlRequests--;
                if(ControlRequests==0) {
			UserMode();
		}
        } else {
		Halt("RESUME WITHOUT PAUSE");
	}
}

void BroadcastEvent(int EventClass, short EventId) {
	taskElement* Task;
	Pause();
	Task=SystemTasks;
	while(Task!=NULL) {
		if(Task->Value.RegisteredEvents&EventClass) {
			Task->Value.RegisteredEvents=EVENT_RUNTASK;
			Task->Value.EventId=EventId;
		}
		Task=Task->Next;
	}
	Resume();
	//if(ControlRequests!=0) for(;;);
	//Switch();
}

short AwaitEvent(int EventClass) {
	Pause();
	CurrentTask->Value.RegisteredEvents|=EventClass;
	Resume();
	Switch();
	return CurrentTask->Value.EventId;
}

void Switch() {
/*	if(ControlRequests!=0) {
		char String[16];
		IntToString(ControlRequests, String);
		Break(String);
	} */
        IntsOff();
	ExchangeRegs();
	ControlRequests++;
        GetStackPointerASM(_OldSP);
	SaveIndexes();
	Scheduler(OldSP);
}

void NewContext(int* SP) {
	// SP for next task to go (arg #1) goes into HL
	SP; FunctionArgToReg(H, L);
	
	// Restores usermode status
        SetStackPointerASM(_OldSP);
	ExchangeRegs();
	ReloadIndexes();
	
	SaveContext();

	// Switches to the process with stack in SP
	ExchangeRegs();
	GetStackPointerASM(_TempSP);
	SetStackPointerREG(HL);
        *CurrentSP=TempSP;

	ExchangeRegs();
	
	LoadContext();

	if(ControlRequests==0) Halt("ISR IN USER MODE");
	ControlRequests--;
	IntsOn();
	ImmediateReturn();
}

void ScheduleTask(task* Task) {
	_SimPrintString("Context switch\n");
	NewContext(Task->SP);
}

bool IsMultitasking() {
	if(ControlRequests==0) return TRUE; else return FALSE;
}
