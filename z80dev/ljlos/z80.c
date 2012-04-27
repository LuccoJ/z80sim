#include "z80.h"

char ActiveRegBank;

void HardwareInit() {
	ActiveRegBank=0;
}

void ExchangeRegs() {
        _asm;
        push af
        ld a,(_ActiveRegBank)
        cpl
        ld (_ActiveRegBank),a
        pop af
        exx
        ex af,af
        _endasm;
}

