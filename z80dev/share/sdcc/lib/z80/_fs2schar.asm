;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:26 2003

;--------------------------------------------------------
	.module _fs2schar
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fs2schar
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
;_fs2schar.c:4: signed char __fs2schar (float f) {
;	genLabel
;	genFunction
;	---------------------------------
; Function __fs2schar
; ---------------------------------
___fs2schar_start::
___fs2schar:
	push	ix
	ld	ix,#0
	add	ix,sp
;_fs2schar.c:5: signed long sl=__fs2slong(f);
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
	call	___fs2slong
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
;	genAssign
;	(registers are the same)
;_fs2schar.c:6: if (sl>=CHAR_MAX)
;	genCmpLt
	ld	a,c
	sub	a,#0x7F
	ld	a,b
	sbc	a,#0x00
	ld	a,e
	sbc	a,#0x00
	ld	a,d
	sbc	a,#0x00
	jp	m,00102$
;_fs2schar.c:7: return CHAR_MAX;
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x7F
	jp	00105$
;	genLabel
00102$:
;_fs2schar.c:8: if (sl<=CHAR_MIN) 
;	genCmpGt
	ld	a,#0x80
	sub	a,c
	ld	a,#0xFF
	sbc	a,b
	ld	a,#0xFF
	sbc	a,e
	ld	a,#0xFF
	sbc	a,d
	jp	m,00104$
;_fs2schar.c:9: return -CHAR_MIN;
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x80
	jp	00105$
;	genLabel
00104$:
;_fs2schar.c:10: return sl;
;	genCast
	ld	l,c
;	genRet
; Dump of IC_LEFT: type AOP_STR size 1
;	genLabel
00105$:
;	genEndFunction
	pop	ix
	ret
___fs2schar_end::
	.area _CODE
