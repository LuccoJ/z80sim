;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:26 2003

;--------------------------------------------------------
	.module _fs2slong
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fs2slong
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
;_fs2slong.c:4: signed long __fs2slong (float f) {
;	genLabel
;	genFunction
;	---------------------------------
; Function __fs2slong
; ---------------------------------
___fs2slong_start::
___fs2slong:
	push	ix
	ld	ix,#0
	add	ix,sp
;_fs2slong.c:6: if (!f)
;	genIfx
;	AOP_STK for 
	ld	a,4(ix)
	or	a,5(ix)
	or	a,6(ix)
	or	a,7(ix)
	jp	nz,00102$
;_fs2slong.c:7: return 0;
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 4
	ld      hl,#0x0000
	ld      de,#0x0000
	jp	00106$
;	genLabel
00102$:
;_fs2slong.c:9: if (f<0) {
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0000
	push	hl
;	genIpush
;	AOP_STK for 
	ld	l,6(ix)
	ld	h,7(ix)
	push	hl
	ld	l,4(ix)
	ld	h,5(ix)
	push	hl
;	genCall
	call	___fslt
	ld	c,l
	pop	af
	pop	af
	pop	af
	pop	af
;	genIfx
	xor	a,a
	or	a,c
	jp	z,00104$
;_fs2slong.c:10: return -__fs2ulong(-f);
;	genUminus
;	AOP_STK for 
;	genUminusFloat
	ld	a,7(ix)
	xor	a,#0x80
	ld	d,a
	ld	c,4(ix)
	ld	b,5(ix)
	ld	e,6(ix)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	de
	push    bc
;	genCall
	call	___fs2ulong
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
;	genUminus
	xor     a,a
	sbc	a,c
	ld	c,a
	ld	a,#0x00
	sbc	a,b
	ld	b,a
	ld	a,#0x00
	sbc	a,e
	ld	e,a
	ld	a,#0x00
	sbc	a,d
	ld	d,a
;	genRet
; Dump of IC_LEFT: type AOP_REG size 4
;	 reg = debc
	ld	l,c
	ld	h,b
	jp	00106$
;	genLabel
00104$:
;_fs2slong.c:12: return __fs2ulong(f);
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
;	genRet
; Dump of IC_LEFT: type AOP_REG size 4
;	 reg = debc
	ld	l,c
	ld	h,b
;	genLabel
00106$:
;	genEndFunction
	pop	ix
	ret
___fs2slong_end::
	.area _CODE
