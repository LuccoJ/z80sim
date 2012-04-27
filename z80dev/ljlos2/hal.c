void* Temp1, Temp2, Temp3;

void SetISR(void* Routine) {
	ISR=Routine;
}

void InterruptService() {
	_asm
	di
	exx
	_endasm;
	ISR();
	_asm
	exx
	ei
	_endasm;
}

void SaveState(void* StackPointer) {
	Temp1=StackPointer;
	_asm
	ld SP, _Temp2
	ld _Temp1, SP
	exx
	push AF
	push BC
	push DE
	push HL
	exx
	ld _Temp2, SP
	_endasm;
}

void LoadState(void* StackPointer) {
	Temp1=StackPointer;
	_asm
	ld SP, Temp2
	ld _Temp1, SP
	exx
	pop HL
	pop DE
	pop BC
	pop AF
	exx
	ld _Temp2, SP
	_endasm;
}
