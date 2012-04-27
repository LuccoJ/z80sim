;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:27 2003

;--------------------------------------------------------
	.module _slong2fs
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___slong2fs
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
;_slong2fs.c:4: float __slong2fs (signed long sl) {
;	genLabel
;	genFunction
;	---------------------------------
; Function __slong2fs
; ---------------------------------
___slong2fs_start::
___slong2fs:
	push	ix
	ld	ix,#0
	add	ix,sp
;_slong2fs.c:5: if (sl<0) 
;	genCmpLt
;	AOP_STK for 
	ld	a,7(ix)
	bit	7,a
	jp	z,00102$
;_slong2fs.c:6: return -__ulong2fs(-sl);
;	genUminus
;	AOP_STK for 
	xor     a,a
	sbc	a,4(ix)
	ld	c,a
	ld	a,#0x00
	sbc	a,5(ix)
	ld	b,a
	ld	a,#0x00
	sbc	a,6(ix)
	ld	e,a
	ld	a,#0x00
	sbc	a,7(ix)
	ld	d,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	de
	push    bc
;	genCall
	call	___ulong2fs
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
;	genUminus
;	genUminusFloat
	ld	a,d
	xor	a,#0x80
	ld	d,a
; Removed redundent load
; Removed redundent load
; Removed redundent load
;	genRet
; Dump of IC_LEFT: type AOP_REG size 4
;	 reg = debc
	ld	l,c
	ld	h,b
	jp	00104$
;	genLabel
00102$:
;_slong2fs.c:8: return __ulong2fs(sl);
;	genAssign
;	AOP_STK for 
	ld	c,4(ix)
	ld	b,5(ix)
	ld	e,6(ix)
	ld	d,7(ix)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	de
	push    bc
;	genCall
	call	___ulong2fs
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
;	genRet
; Dump of IC_LEFT: type AOP_REG size 4
;	 reg = debc
	ld	l,c
	ld	h,b
;	genLabel
00104$:
;	genEndFunction
	pop	ix
	ret
___slong2fs_end::
	.area _CODE
