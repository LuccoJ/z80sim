;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Fri Apr 27 12:30:18 2012

;--------------------------------------------------------
	.module time
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _TickCounter
	.globl _TimeInit
	.globl _Tick
	.globl _Sleep
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
G$TickCounter$0$0==.
_TickCounter::
	.ds 4
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
;time.c:7: void TimeInit() {
;	genLabel
;	genFunction
;	---------------------------------
; Function TimeInit
; ---------------------------------
_TimeInit_start::
_TimeInit:
	ld	a,#3
	rst	0x08
;time.c:8: TickCounter=0;
;	genAssign
	xor	a,a
	ld	iy,#_TickCounter
	ld	0(iy),a
	ld	1(iy),a
	ld	2(iy),a
	ld	3(iy),a
;time.c:9: _SimPrintString("Time services initialized\n");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_0
	push	hl
;	genCall
	call	__Z80SimPrintString
	pop	af
;	genLabel
00101$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
_TimeInit_end::
Ftime$_str_0$0$0 == .
__str_0:
	.ascii "Time services initialized"
	.db 0x0A
	.db 0x00
;time.c:12: void Tick() {
;	genLabel
;	genFunction
;	---------------------------------
; Function Tick
; ---------------------------------
_Tick_start::
_Tick:
	ld	a,#3
	rst	0x08
;time.c:13: TickCounter++;
;	genPlus
;	genPlusIncr
	ld	iy,#_TickCounter
	inc	0(iy)
	jp	nz,00103$
	inc	1(iy)
	jp	nz,00103$
	inc	2(iy)
	jp	nz,00103$
	inc	3(iy)
00103$:
;	genLabel
00101$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
_Tick_end::
;time.c:16: void Sleep(long Ticks) {
;	genLabel
;	genFunction
;	---------------------------------
; Function Sleep
; ---------------------------------
_Sleep_start::
_Sleep:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-4
	add	hl,sp
	ld	sp,hl
;time.c:18: Start=TickCounter;
;	genAssign
	ld	iy,#_TickCounter
	ld	c,0(iy)
	ld	b,1(iy)
	ld	e,2(iy)
	ld	d,3(iy)
;time.c:19: while(TickCounter-Start<Ticks);
;	genLabel
00101$:
;	genMinus
;	AOP_STK for _Sleep__1_0
	ld	iy,#_TickCounter
	ld	a,0(iy)
	sub	a,c
	ld	-4(ix),a
	ld	a,1(iy)
	sbc	a,b
	ld	-3(ix),a
	ld	a,2(iy)
	sbc	a,e
	ld	-2(ix),a
	ld	a,3(iy)
	sbc	a,d
	ld	-1(ix),a
;	genCmpLt
;	AOP_STK for _Sleep__1_0
;	AOP_STK for 
	ld	a,-4(ix)
	sub	a,4(ix)
	ld	a,-3(ix)
	sbc	a,5(ix)
	ld	a,-2(ix)
	sbc	a,6(ix)
	ld	a,-1(ix)
	sbc	a,7(ix)
	jp	m,00101$
;	genLabel
00104$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_Sleep_end::
	.area _CODE
