;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:26 2003

;--------------------------------------------------------
	.module _fs2uint
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fs2uint
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
;_fs2uint.c:6: unsigned int __fs2uint (float f) {
;	genLabel
;	genFunction
;	---------------------------------
; Function __fs2uint
; ---------------------------------
___fs2uint_start::
___fs2uint:
	push	ix
	ld	ix,#0
	add	ix,sp
;_fs2uint.c:7: unsigned long ul=__fs2ulong(f);
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
;_fs2uint.c:8: if (ul>=UINT_MAX) return UINT_MAX;
;	genCmpLt
	ld	a,c
	sub	a,#0xFF
	ld	a,b
	sbc	a,#0xFF
	ld	a,e
	sbc	a,#0x00
	ld	a,d
	sbc	a,#0x00
	jp	c,00102$
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 2
	ld	hl,#0xFFFF
	jp	00103$
;	genLabel
00102$:
;_fs2uint.c:9: return ul;
;	genCast
	ld	l,c
	ld	h,b
;	genRet
; Dump of IC_LEFT: type AOP_STR size 2
;	genLabel
00103$:
;	genEndFunction
	pop	ix
	ret
___fs2uint_end::
	.area _CODE
