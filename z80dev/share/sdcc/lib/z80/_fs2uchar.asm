;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:26 2003

;--------------------------------------------------------
	.module _fs2uchar
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fs2uchar
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
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
;_fs2uchar.c:4: unsigned char __fs2uchar (float f) {
;	genLabel
;	genFunction
;	---------------------------------
; Function __fs2uchar
; ---------------------------------
___fs2uchar_start::
___fs2uchar:
	push	ix
	ld	ix,#0
	add	ix,sp
;_fs2uchar.c:5: unsigned long ul=__fs2ulong(f);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
;	AOP_STK for 
	ld	l,6(ix)
	ld	h,7(ix)
	push	hl
	ld	l,4(ix)
	ld	h,5(ix)
	push	hl
;	genCall
	call	___fs2ulong
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
;	genAssign
;	(registers are the same)
;_fs2uchar.c:6: if (ul>=UCHAR_MAX) return UCHAR_MAX;
;	genCmpLt
	ld	a,c
	sub	a,#0xFF
	ld	a,b
	sbc	a,#0x00
	ld	a,e
	sbc	a,#0x00
	ld	a,d
	sbc	a,#0x00
	jp	c,00102$
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0xFF
	jp	00103$
;	genLabel
00102$:
;_fs2uchar.c:7: return ul;
;	genCast
	ld	l,c
;	genRet
; Dump of IC_LEFT: type AOP_STR size 1
;	genLabel
00103$:
;	genEndFunction
	pop	ix
	ret
___fs2uchar_end::
	.area _CODE
