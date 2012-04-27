#include "profile.h"

void _Z80SimTerminate() {
	_asm
	ld a,#0
	rst 0x08
	_endasm;
}

void _Z80SimReturn() {
	_asm
	ld a,#4
	rst 0x08
	_endasm;
}

void _Z80SimPrintCharacter(char Character) {
	Character;
	_asm;
	ld a,4(ix)
	push hl
	ld l,a
	ld a,#1
	rst 0x08
	pop hl
	_endasm;
}

void _Z80SimPrintString(char* String) {
	int i;
	i=0;
	while(String[i]!='\0') {
		_Z80SimPrintCharacter(String[i]);
		i++;
	}
}

void _Z80SimPrintWord(unsigned int Word) {
	Word;
	_asm;
	push af
	push hl
	ld l,4(ix)
	ld h,5(ix)
	ld a,#7
	rst 0x08
	pop hl
	pop af
	_endasm;
}

void _Z80SimEnterProfile() {
	_asm
	push af
	ld a,#3
	rst 0x08
	pop af
	_endasm;
}

void _Z80SimExitProfile() {
        _asm
	push af
        ld a,#4
        rst 0x08
	pop af
        _endasm;
}

void _Z80SimDumpRegs() {
	_asm
	push af
	ld a,#6
	rst 0x08
	pop af
	_endasm;
}

void _Z80SimWriteProtect(void* Start, void* End) {
	Start; End;
	_asm
	push af
	push hl
	push de
	ld a,#0x8
	ld l,4(ix)
	ld h,5(ix)
	ld e,6(ix)
	ld d,7(ix)
	rst 0x08
	pop de
	pop hl
	pop af
	_endasm;
}

void _Z80SimReadProtect(void* Start, void* End) {
        Start; End;
        _asm
        push af
        push hl
        push de
        ld a,#0x9
        ld l,4(ix)
        ld h,5(ix)
        ld e,6(ix)
        ld d,7(ix)
        rst 0x08
        pop de
        pop hl
        pop af
        _endasm;
}

void _Z80SimRWProtect(void* Start, void* End) {
        Start; End;
        _asm
        push af
        push hl
        push de
        ld a,#0xa
        ld l,4(ix)
        ld h,5(ix)
        ld e,6(ix)
        ld d,7(ix)
        rst 0x08
        pop de
        pop hl
        pop af
        _endasm;
}

void _Z80SimUnprotect(void* Start, void* End) {
        Start; End;
        _asm
        push af
        push hl
        push de
        ld a,#0xb
        ld l,4(ix)
        ld h,5(ix)
        ld e,6(ix)
        ld d,7(ix)
        rst 0x08
        pop de
        pop hl
        pop af
        _endasm;
}
