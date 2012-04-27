#include "types.h"
#include "ecc/rslib.h"

short TapeMeanWaveLength;
short TapeHalfWaveLength;

bool TapeInited; void TapeInit() {
	if(!TapeInited) {
		TapeHalfWaveLength=60;
		TapeMeanWaveLength=(TapeHalfWaveLength*3)/2;
		TapeInited=TRUE;
	}
}

void PortOutput(char PortNumber, char Value) {
	_asm
	ld c,4(ix)
	ld d,5(ix)
	out (c),d
	_endasm;
}

void TapeSaveC(void *Start, void* End) {
	void* i;
	short j;
	char Byte;
	bool Condition;
	for(i=Start; i<End; i++) {
		Byte=*((char*)i);
		for(j=0; j<8; j++) {
			Byte=Byte>>1;
			Condition=Byte&1;
			if(Condition) PortOutput(0xfe, 0x02);
			if(!Condition) PortOutput(0xfe, 0x0d);
		}
	}
}

void TapeSaveManchester(void *StartPosition, void* StopPosition) {
	_asm

	ManchesterLoadByte:
	ld b,(hl)
	ld c,#7
	inc hl
        ld a,h
        cp a,7(ix)
	jp nz,ManchesterDoBit
	ld a,l
	cp a,6(ix)
	jp z,ManchesterEnd

	ManchesterDoBit:
	sla b			; 8
	jp nc,Manchester0	; 10
	
	Manchester1:
	ld a,£0x02		; 7
	jp ManchesterWriteBit	; 10

	Manchester0:
	ld a,£0x0d
	jp ManchesterWriteBit

	ManchesterWriteBit:
	out (0xfe),a
	xor a,£0x11 ; cambiare
	
	out (0xfe),a

	ManchesterEndLoop:
        dec c			; 4
        jp z,ManchesterLoadByte	; 10
	; just wait
	jp ManchesterNext	; 10
	ManchesterNext:
	jp ManchesterDoBit	; 10

	ManchesterEnd:
	_endasm;
}

void TapeLoad(void* StartPosition, void* StopPosition) {
	_asm
	ld l,4(ix)
	ld h,5(ix)
	ld e,6(ix)
	ld d,7(ix)

	ld b,£7

	WaitBit:
	ld c,£0

	WaitTrigger1:
	inc c
	in a,(0xfe)
	bit 6,a
	jp nz, WaitTrigger1

	ld a,£10
	cp a,c
	jp p,WaitTrigger1

	Border1:
	ld a,£0x01
	out (0xfe),a

	WaitTrigger2:
	inc c
	in a,(0xfe)
	bit 6,a
	jp z, WaitTrigger2

        ld a,£20
        cp a,c
        jp p,WaitTrigger2

	Border2:
	ld a,£0x05
	out (0xfe),a

	dec b
	jp nz,DoBit
	
	ld b,£7
	inc hl

	DoBit:
	sla (hl)

	ld a,(_TapeMeanWaveLength)
	cp a,c
	jp nc,EndBit

	inc (hl)
	
	EndBit:
	ld a,h
	cp a,d
	jp nz,WaitBit
	ld a,l
	cp a,e
	jp nz,WaitBit
	_endasm;
}

void TapeSave(void* StartPosition, void* EndPosition) {
	_asm
        ld l,4(ix)
        ld h,5(ix)
        ld e,6(ix)
        ld d,7(ix)

	ld b,£7

	SaveStart:
	ld a,(_TapeHalfWaveLength)
	ld d,a

        dec b
        jp nz,SaveDoBit

        ld b,£7
        inc hl

	SaveDoBit:
	sla (hl)
	jp nc, SaveWriteBit

	sla d

	SaveWriteBit:
	ld c,d

	SaveWriteTrigger1:
	nop nop nop add a,#0
	dec c
        jp nz, SaveWriteTrigger1

        ld a,£0x0d
        out (0xfe),a

	ld c,d

        SaveWriteTrigger2:
        nop nop nop add a,#0
        dec c
        jp nz, SaveWriteTrigger2

        ld a,£0x02
        out (0xfe),a

        ld a,h
        cp a,7(ix)
        jp nz,SaveStart
        ld a,l
        cp a,6(ix)
        jp nz,SaveStart
	_endasm;
}


void SaveBlock(void* BlockStart) {
	_asm;
	ld l,4(ix)
	ld h,5(ix)
	ld b,6(ix)

	ld de,#0x0010

	Sync:
	ld b,#0xff		; 7
	ld a,#0x0d		; 7
	out (0xfe),a		; 11
	W1: djnz W1
	ld bc,#0xDEAD		; 10
	ld b,#0xff		; 7
	ld a,#0x02		; 7
        ld a,#0x02              ; 7
        ld a,#0x02              ; 7
	out (0xfe),a		; 11
	W2: djnz W2
	dec de			; 6
	ld a,e			; 4
	or d			; 4
	jp nz,Sync		; 10
	
	ld e,l

	FetchByte:
	ld c,#7			; 7
	ld d,(hl)		; 7
	inc hl			; 4
	ld a,e			; 4
	cp a,l			; 4
	jp z,BlockSaved		; 10

	ProcessBit:
	rl d			; 8
	jp c, Bit0		; 10

	Bit1:
	ld b,#16
	jp BitWrite

	Bit0:
	ld b,#8
	jp BitWrite

	BitWrite:
	ld a,£0x02		; 7
	out (0xfe),a		; 11
	ld a,b
	W3: djnz W3
	ld b,a

        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop

	ld a,£0x0d		; 7
	out (0xfe),a		; 11
	W4: djnz W4

	dec c			; 4
	jp z,FetchByte		; 10

	nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop ; 36

	jp ProcessBit		; 10

	BlockSaved:
	_endasm;
}
