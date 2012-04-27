typedef struct {
	void* StackPointer;
} task;

typedef struct tTasks {
	task* Element;
	struct tTasks* Next;
} * tasks;

void ScheduleTask(task* Task) {
	tasks Probe=QueuedTasks;
	while(Probe->Next!=NULL) {
		if(Probe->Next->Element->Priority>Task->Priority) break;
	}
	Task
	

void IntHandler() {
	SaveState(CurrentTask->SP);
	ScheduleTask(CurrentTask);
	CurrentTask=QueuedTasks->Element;
	LoadState(CurrentTask->SP);
	QueuedTasks=QueuedTasks->Next;
}
