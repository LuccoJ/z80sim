#include "exceptions.h"

#include "scheduling.h"
#include "console.h"
#include "strings.h"
#include "screen.h"
#include "locks.h"
#include "time.h"
#include "sound.h"

#include "simulator.h"

volatile unsigned int SavedPC;
volatile unsigned int SavedIX;
volatile unsigned int SavedIY;

volatile unsigned int RegValue;
unsigned int GetRegister(enum {PC, SP, A, BC, DE, HL, IX, IY} Reg) {
	switch(Reg) {
	case SP:
		_asm;
		exx
		ld (_RegValue),sp
		exx
		_endasm;
		break;
	case A:
		_asm;
		ex af,af
		ld (_RegValue),a
		ex af,af
		_endasm;
		break;
        case BC:
                _asm;
                exx
                ld (_RegValue),de
                exx
                _endasm;
                break;
        case DE:
                _asm;
                exx
                ld (_RegValue),de
                exx
                _endasm;
                break;
        case HL:
                _asm;
                exx
                ld (_RegValue),hl
                exx
                _endasm;
                break;
        case IX:
                _asm;
                exx
                ld (_RegValue),ix
                exx
                _endasm;
                break;
        case IY:
                _asm;
                exx
                ld (_RegValue),iy
                exx
                _endasm;
                break;
	default:
		RegValue=0;
	}
	_asm;
	ld hl,(_RegValue)
	pop ix
	ret
	_endasm;
	return RegValue;
}


void Alert(enum {alertHalt, alertBreak} Type, char* Message) {
	char Value[16];
	Pause();
#ifndef NDEBUG
        _SimPrintString("-------------------\n");
	if(Type==alertBreak) {
                _SimPrintString("BREAK: ");
                _SimPrintString(Message);
                _SimPrintString("\n");
                _SimPrintString("-------------------\n");
		_SimDumpRegs();
                _SimPrintString("-------------------\n");
	} else {
                _SimPrintString("HALT: ");
                _SimPrintString(Message);
                _SimPrintString("\n");
                _SimPrintString("-------------------\n");
		_SimDumpRegs();
                _SimPrintString("-------------------\n");
                _SimTerminate();
	}
#endif

        PutString("\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4", 18, 0);
        PutString("                                ", 19, 0);
        PutString("\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4", 20, 0);
        PutString("                                ", 21, 0);
        PutString("                                ", 22, 0);
        PutString("                                ", 23, 0);
        SetAttrib(SCRATTR_FLASH|SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 1);
        SetAttrib(SCRATTR_FLASH|SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 2);
        SetAttrib(SCRATTR_FLASH|SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 3);
        SetAttrib(SCRATTR_FLASH|SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 4);
	if(Type==alertBreak) {
		SetAttrib(SCRATTR_FLASH|SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 5);
	        PutString(" BREAK ", 19, 0);
	        PutString(Message, 19, 7);
	} else {
	        PutString(" HALT ", 19, 0);
	        PutString(Message, 19, 6);
	}
	
	PutString(" A", 21, 2);	WordToHex(GetRegister(A), Value); PutString(Value, 21, 5);
        PutString("BC", 21, 12); WordToHex(GetRegister(BC), Value); PutString(Value, 21, 15);
        PutString("DE", 21, 22); WordToHex(GetRegister(DE), Value); PutString(Value, 21, 25);

        PutString("HL", 22, 2); WordToHex(GetRegister(HL), Value); PutString(Value, 22, 5);
        PutString("IX", 22, 12); WordToHex(SavedIX, Value); PutString(Value, 22, 15);
        PutString("IY", 22, 22); WordToHex(SavedIY, Value); PutString(Value, 22, 25);

        PutString("SP", 23, 2); WordToHex(GetRegister(SP), Value); PutString(Value, 23, 5);
        PutString("PC", 23, 12); WordToHex(SavedPC, Value); PutString(Value, 23, 15);

	Beep();

	Resume();

        Sleep(350);
	if(Type==alertHalt) for(;;);
        PutString("                                ", 18, 0);
        PutString("                                ", 19, 0);
        PutString("                                ", 20, 0);
        PutString("                                ", 21, 0);
        PutString("                                ", 22, 0);
        PutString("                                ", 23, 0);
        SetAttrib(SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 1);
        SetAttrib(SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 2);
        SetAttrib(SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 3);
        SetAttrib(SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 4);
        SetAttrib(SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 5);
}

void Halt(char* ErrorMessage) {
	//SupervisorMode();
	Alert(alertHalt, ErrorMessage);
}

void Break(char* Message) {
        LockObtain(SystemLock);
	_asm;
	ld (_SavedIY),iy
	pop bc
	ld (_SavedIX),hl
	pop hl
	pop de
	ld (_SavedPC),de
	push de
	push hl
	push bc
	_endasm;
	ExchangeRegs();
        Alert(alertBreak, Message);
	ExchangeRegs();
	LockRelease(SystemLock);
}

void SystemMonitor() {
        char CommandLine[256];
        ConsoleWrite("SYSTEM MONITOR\n");
        do {
                ConsoleWrite(") ");
                ConsoleReadLine(CommandLine);
		if(!IsMultitasking()) Halt("PAUSE WITHOUT RESUME");
		if(SameString("HELP", CommandLine)) {
			ConsoleWrite("THIS IS THE SYSTEM MONITOR OF\nLJL OS. THERE IS NO HELP SYSTEM\nAT THE MOMENT.\n");
		}
        } while(1);
}

