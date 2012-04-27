#include "hardware.h"
#include "memory.h"
#include "screen.h"
#include "console.h"
#include "strings.h"
#include "locks.h"
#include "scheduling.h"
#include "exceptions.h"
#include "keyboard.h"
#include "time.h"

#include "tape.h"
#include "simulator.h"

void TestMemory();

void (*MainEntry)();

char PrintReg;

#ifndef NDEBUG
extern int ControlRequests;
#endif

void PrintNumber(unsigned int n) {
	char Temp[16];
	WordToString(n, Temp);
	ConsoleWrite(Temp);
}

void SystemInit() {
}

void Task1() {
        while(1) {
		if(!IsMultitasking()) {
			Halt("INTS DISABLED PRC1");
		}
		ConsoleWrite("1");
		_SimPrintString("1");
	}
}

void Task2() {
        while(1) {
                if(!IsMultitasking()) {
			Halt("INTS DISABLED PRC2");
		}
                ConsoleWrite("2");
		_SimPrintString("2");
        }
}

void SystemTask() {
	if(!IsMultitasking()) Halt("PAUSE WITHOUT RESUME");
	SystemMonitor();
}

void main() {
	task* TI1;
	task* TI2;
	char* Data;
	char* Encoded;

	register unsigned int i;

        _asm;
        di
        ld sp,#0xffff
        ld a,#0x0
        ld bc,#0x0
        ld de,#0x0
        ld hl,#0x0
        ld ix,#0x0
        ld iy,#0x0
        _endasm;

	_SimWriteProtect((void*)0x0000, (void*)0x3fff);

        _SimPrintString("\n-------------------\n");
        _SimPrintString("System reset\n");
        _SimPrintString("-------------------\n");

	IntsOff();

	_SimPrintString("Interrupts disabled. Booting...\n");

	TestMemory();
	HardwareInit();
        LocksInit();
        SchedulingInit();
	SupervisorMode();
	TimeInit();
	SystemInit();
	MemoryInit();
	//KeyboardInit();
	//TapeInit();
	ConsoleInit();
	ConsoleWrite("LJL OS 0.1 FOR ZX SPECTRUM 48\n");
	ConsoleWrite("\nCONSOLE OUTPUT\n\n");
/*
        TapeSave((void*)0x4000, (void*)0x5800);
	TapeLoad((void*)0x4000, (void*)0x5800);
	for(i=0; i<0x4000; i+=0x100) {
		ConsoleWrite(".");
		SaveBlock((void*)i);
	}
	Halt("Saved");
*/
	MainEntry=Task1;
	TI1=CreateTask(MainEntry, 100);
	MainEntry=Task2;
	TI2=CreateTask(MainEntry, 100);
	ConsoleWrite("TASKS CREATED\n");
	SetScheduler(DefaultScheduler);
	ConsoleWrite("SCHEDULER SET\n");
        Resume();
	//ConsoleWrite("RESUMING\n");
	//if(!IsMultitasking()) Halt("NOT MULTITASKING");
	for(;;);
	Halt("SYSTEM SHUTDOWN");
}

void TestMemory()
{
        register unsigned char* i;
	PutString("TESTING MEMORY A", 1, 1);
        _SimUnprotect(0x4000, 0x5fff);
        for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
                *i=0xAA;
        }
	for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
		if(*i!=0xAA) {
			PutString("BAD MEMORY", 1, 1);
			Halt("BAD MEMORY");
		}
	}
        PutString("TESTING MEMORY B", 2, 1);
        _SimUnprotect(0x4000, 0x5fff);
        for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
                *i=(~0xAA);
        }
        for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
                if(*i!=(~0xAA)) Halt("BAD MEMORY");
        }
        PutString("MEMORY TEST COMPLETE", 3, 1);
        _SimUnprotect(0x4000, 0x5fff);
        for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
                *i=0;
        }
	_SimPrintString("Memory test completed\n");
}
