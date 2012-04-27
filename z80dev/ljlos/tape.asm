;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Fri Apr 27 12:30:19 2012

;--------------------------------------------------------
	.module tape
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _SaveBlock
	.globl _TapeSave
	.globl _TapeLoad
	.globl _TapeSaveManchester
	.globl _TapeSaveC
	.globl _PortOutput
	.globl _TapeInit
	.globl _TapeInited
	.globl _TapeHalfWaveLength
	.globl _TapeMeanWaveLength
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
G$TapeMeanWaveLength$0$0==.
_TapeMeanWaveLength::
	.ds 1
G$TapeHalfWaveLength$0$0==.
_TapeHalfWaveLength::
	.ds 1
G$TapeInited$0$0==.
_TapeInited::
	.ds 1
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area _OVERLAY
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _CODE
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;tape.c:7: bool TapeInited; void TapeInit() {
;	genLabel
;	genFunction
;	---------------------------------
; Function TapeInit
; ---------------------------------
_TapeInit_start::
_TapeInit:
	ld	a,#3
	rst	0x08
;tape.c:8: if(!TapeInited) {
;	genIfx
	xor	a,a
	ld	iy,#_TapeInited
	or	a,0(iy)
	jp	nz,00103$
;tape.c:9: TapeHalfWaveLength=60;
;	genAssign
	ld	iy,#_TapeHalfWaveLength
	ld	0(iy),#0x3C
;tape.c:10: TapeMeanWaveLength=(TapeHalfWaveLength*3)/2;
;	genAssign
	ld	iy,#_TapeMeanWaveLength
	ld	0(iy),#0x5A
;tape.c:11: TapeInited=TRUE;
;	genAssign
	ld	iy,#_TapeInited
	ld	0(iy),#0x01
;	genLabel
00103$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
_TapeInit_end::
;tape.c:15: void PortOutput(char PortNumber, char Value) {
;	genLabel
;	genFunction
;	---------------------------------
; Function PortOutput
; ---------------------------------
_PortOutput_start::
_PortOutput:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
;tape.c:20: _endasm;
;	genInline
	
		       ld c,4(ix)
		       ld d,5(ix)
		       out (c),d
		       
;	genLabel
00101$:
;	genEndFunction
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_PortOutput_end::
;tape.c:23: void TapeSaveC(void *Start, void* End) {
;	genLabel
;	genFunction
;	---------------------------------
; Function TapeSaveC
; ---------------------------------
_TapeSaveC_start::
_TapeSaveC:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-4
	add	hl,sp
	ld	sp,hl
;tape.c:28: for(i=Start; i<End; i++) {
;	genAssign
;	AOP_STK for 
;	AOP_STK for _TapeSaveC_i_1_1
	ld	a,4(ix)
	ld	-2(ix),a
	ld	a,5(ix)
	ld	-1(ix),a
;	genCmpLt
;	AOP_STK for _TapeSaveC_i_1_1
;	AOP_STK for 
	ld	a,-2(ix)
	sub	a,6(ix)
	ld	a,-1(ix)
	sbc	a,7(ix)
	rlca
	and     a,#0x01
	ld	e,a
;	genLabel
00108$:
;	genIfx
	xor	a,a
	or	a,e
	jp	z,00112$
;tape.c:29: Byte=*((char*)i);
;	genPointerGet
;	AOP_STK for _TapeSaveC_i_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	l,(hl)
;	genAssign
	ld	d,l
;tape.c:30: for(j=0; j<8; j++) {
;	genAssign
;	AOP_STK for _TapeSaveC_j_1_1
	ld	-3(ix),#0x08
;	genLabel
00107$:
;tape.c:31: Byte=Byte>>1;
;	genRightShift
	ld	b,d
	sra	b
;	genAssign
	ld	d,b
;tape.c:32: Condition=Byte&1;
;	genAnd
;	AOP_STK for _TapeSaveC__1_0
	ld	a,d
	and	a,#0x01
	ld	-4(ix),a
;	genAssign
;	AOP_STK for _TapeSaveC__1_0
	ld	c,-4(ix)
;tape.c:33: if(Condition) PortOutput(0xfe, 0x02);
;	genIfx
	xor	a,a
	or	a,c
	jp	z,00102$
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	hl,#0x02FE
	push	hl
;	genCall
	call	_PortOutput
	pop	af
	pop	de
	pop	bc
;	genLabel
00102$:
;tape.c:34: if(!Condition) PortOutput(0xfe, 0x0d);
;	genIfx
	xor	a,a
	or	a,c
	jp	nz,00104$
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	hl,#0x0DFE
	push	hl
;	genCall
	call	_PortOutput
	pop	af
	pop	de
	pop	bc
;	genLabel
00104$:
;	genMinus
;	AOP_STK for _TapeSaveC_j_1_1
	dec	-3(ix)
;tape.c:30: for(j=0; j<8; j++) {
;	genIfx
;	AOP_STK for _TapeSaveC_j_1_1
	xor	a,a
	or	a,-3(ix)
	jp	nz,00107$
;tape.c:28: for(i=Start; i<End; i++) {
;	genGoto
	jp	00108$
;	genLabel
00112$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_TapeSaveC_end::
;tape.c:39: void TapeSaveManchester(void *StartPosition, void* StopPosition) {
;	genLabel
;	genFunction
;	---------------------------------
; Function TapeSaveManchester
; ---------------------------------
_TapeSaveManchester_start::
_TapeSaveManchester:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
;tape.c:80: _endasm;
;	genInline
	
	
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
		       sla b ; 8
		       jp nc,Manchester0 ; 10
	
        Manchester1:
		       ld a,£0x02 ; 7
		       jp ManchesterWriteBit ; 10
	
        Manchester0:
		       ld a,£0x0d
		       jp ManchesterWriteBit
	
        ManchesterWriteBit:
		       out (0xfe),a
		       xor a,£0x11 ; cambiare
	
		       out (0xfe),a
	
        ManchesterEndLoop:
		       dec c ; 4
		       jp z,ManchesterLoadByte ; 10
		       ; just wait
		       jp ManchesterNext ; 10
        ManchesterNext:
		       jp ManchesterDoBit ; 10
	
        ManchesterEnd:
		       
;	genLabel
00101$:
;	genEndFunction
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_TapeSaveManchester_end::
;tape.c:83: void TapeLoad(void* StartPosition, void* StopPosition) {
;	genLabel
;	genFunction
;	---------------------------------
; Function TapeLoad
; ---------------------------------
_TapeLoad_start::
_TapeLoad:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
;tape.c:145: _endasm;
;	genInline
	
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
		       
;	genLabel
00101$:
;	genEndFunction
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_TapeLoad_end::
;tape.c:148: void TapeSave(void* StartPosition, void* EndPosition) {
;	genLabel
;	genFunction
;	---------------------------------
; Function TapeSave
; ---------------------------------
_TapeSave_start::
_TapeSave:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
;tape.c:200: _endasm;
;	genInline
	
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
		       
;	genLabel
00101$:
;	genEndFunction
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_TapeSave_end::
;tape.c:204: void SaveBlock(void* BlockStart) {
;	genLabel
;	genFunction
;	---------------------------------
; Function SaveBlock
; ---------------------------------
_SaveBlock_start::
_SaveBlock:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
;tape.c:299: _endasm;
;	genInline
;
		       ld l,4(ix)
		       ld h,5(ix)
		       ld b,6(ix)
	
		       ld de,#0x0010
	
        Sync:
		       ld b,#0xff ; 7
		       ld a,#0x0d ; 7
		       out (0xfe),a ; 11
        W1:
	djnz	W1
		       ld bc,#0xDEAD ; 10
		       ld b,#0xff ; 7
		       ld a,#0x02 ; 7
		       ld a,#0x02 ; 7
		       ld a,#0x02 ; 7
		       out (0xfe),a ; 11
        W2:
	djnz	W2
		       dec de ; 6
		       ld a,e ; 4
		       or d ; 4
		       jp nz,Sync ; 10
	
		       ld e,l
	
        FetchByte:
		       ld c,#7 ; 7
		       ld d,(hl) ; 7
		       inc hl ; 4
		       ld a,e ; 4
		       cp a,l ; 4
		       jp z,BlockSaved ; 10
	
        ProcessBit:
		       rl d ; 8
		       jp c, Bit0 ; 10
	
        Bit1:
		       ld b,#16
		       jp BitWrite
	
        Bit0:
		       ld b,#8
		       jp BitWrite
	
        BitWrite:
		       ld a,£0x02 ; 7
		       out (0xfe),a ; 11
		       ld a,b
        W3:
	djnz	W3
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
	
		       ld a,£0x0d ; 7
		       out (0xfe),a ; 11
        W4:
	djnz	W4
	
		       dec c ; 4
		       jp z,FetchByte ; 10
	
		       nop
		       nop
		       nop
		       nop
		       nop
		       nop
		       nop
		       nop
		       nop ; 36
	
		       jp ProcessBit ; 10
	
        BlockSaved:
		       
;	genLabel
00101$:
;	genEndFunction
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_SaveBlock_end::
	.area _CODE
