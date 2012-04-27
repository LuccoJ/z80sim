#include "time.h"

#include "simulator.h"

long TickCounter;

void TimeInit() {
	TickCounter=0;
        _SimPrintString("Time services initialized\n");
}

void Tick() {
	TickCounter++;
}

void Sleep(long Ticks) {
	long Start;
	Start=TickCounter;
	while(TickCounter-Start<Ticks);
}
