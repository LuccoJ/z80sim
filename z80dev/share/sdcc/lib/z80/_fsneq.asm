;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:27 2003

;--------------------------------------------------------
	.module _fsneq
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fsneq
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
;_fsneq.c:28: char __fsneq (float a1, float a2)
;	genLabel
;	genFunction
;	---------------------------------
; Function __fsneq
; ---------------------------------
___fsneq_start::
___fsneq:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-12
	add	hl,sp
	ld	sp,hl
;_fsneq.c:32: fl1.f = a1;
;	genAddrOf
	ld	hl,#0x0008
	add	hl,sp
; Removed redundent load
; Removed redundent load
;	genAssign (pointer)
;	AOP_STK for 
;	isBitvar = 0
	ld	a,4(ix)
	ld	(hl),a
	inc	hl
	ld	a,5(ix)
	ld	(hl),a
	inc	hl
	ld	a,6(ix)
	ld	(hl),a
	inc	hl
	ld	a,7(ix)
	ld	(hl),a
;_fsneq.c:33: fl2.f = a2;
;	genAddrOf
	ld	hl,#0x0004
	add	hl,sp
; Removed redundent load
; Removed redundent load
;	genAssign (pointer)
;	AOP_STK for 
;	isBitvar = 0
	ld	a,8(ix)
	ld	(hl),a
	inc	hl
	ld	a,9(ix)
	ld	(hl),a
	inc	hl
	ld	a,10(ix)
	ld	(hl),a
	inc	hl
	ld	a,11(ix)
	ld	(hl),a
;_fsneq.c:43: if (fl1.l == fl2.l)
;	genAddrOf
	ld	hl,#0x0008
	add	hl,sp
; Removed redundent load
; Removed redundent load
;	genPointerGet
;	AOP_STK for ___fsneq__1_0
	ld	a,(hl)
	ld	-12(ix),a
	inc	hl
	ld	a,(hl)
	ld	-11(ix),a
	inc	hl
	ld	a,(hl)
	ld	-10(ix),a
	inc	hl
	ld	a,(hl)
	ld	-9(ix),a
;	genAddrOf
	ld	hl,#0x0004
	add	hl,sp
; Removed redundent load
; Removed redundent load
;	genPointerGet
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
;	genCmpEq
;	AOP_STK for ___fsneq__1_0
; genCmpEq: left 4, right 4, result 0
	ld	a,-12(ix)
	cp	c
	jp	nz,00106$
	ld	a,-11(ix)
	cp	b
	jp	nz,00106$
	ld	a,-10(ix)
	cp	e
	jp	nz,00106$
	ld	a,-9(ix)
	cp	d
	jp	z,00107$
00106$:
	jp	00102$
00107$:
;_fsneq.c:44: return (0);
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x00
	jp	00103$
;	genLabel
00102$:
;_fsneq.c:45: return (1);
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x01
;	genLabel
00103$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
___fsneq_end::
	.area _CODE
