;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:27 2003

;--------------------------------------------------------
	.module _fslt
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fslt
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
;_fslt.c:28: char __fslt (float a1, float a2)
;	genLabel
;	genFunction
;	---------------------------------
; Function __fslt
; ---------------------------------
___fslt_start::
___fslt:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-12
	add	hl,sp
	ld	sp,hl
;_fslt.c:32: fl1.f = a1;
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
;_fslt.c:33: fl2.f = a2;
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
;_fslt.c:35: if (fl1.l<0 && fl2.l<0) {
;	genAddrOf
	ld	hl,#0x0008
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
;	genCmpLt
	ld	a,d
	bit	7,a
	jp	z,00104$
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
;	genCmpLt
	ld	a,d
	bit	7,a
	jp	z,00104$
;_fslt.c:36: if (fl2.l < fl1.l)
;	genAddrOf
	ld	hl,#0x0004
	add	hl,sp
; Removed redundent load
; Removed redundent load
;	genPointerGet
;	AOP_STK for ___fslt__1_0
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
	ld	hl,#0x0008
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
;	genCmpLt
;	AOP_STK for ___fslt__1_0
	ld	a,-12(ix)
	sub	a,c
	ld	a,-11(ix)
	sbc	a,b
	ld	a,-10(ix)
	sbc	a,e
	ld	a,-9(ix)
	sbc	a,d
	jp	p,00102$
;_fslt.c:37: return (1);
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x01
	jp	00108$
;	genLabel
00102$:
;_fslt.c:38: return (0);
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x00
	jp	00108$
;	genLabel
00104$:
;_fslt.c:41: if (fl1.l < fl2.l)
;	genAddrOf
	ld	hl,#0x0008
	add	hl,sp
; Removed redundent load
; Removed redundent load
;	genPointerGet
;	AOP_STK for ___fslt__1_0
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
;	genCmpLt
;	AOP_STK for ___fslt__1_0
	ld	a,-12(ix)
	sub	a,c
	ld	a,-11(ix)
	sbc	a,b
	ld	a,-10(ix)
	sbc	a,e
	ld	a,-9(ix)
	sbc	a,d
	jp	p,00107$
;_fslt.c:42: return (1);
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x01
	jp	00108$
;	genLabel
00107$:
;_fslt.c:43: return (0);
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x00
;	genLabel
00108$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
___fslt_end::
	.area _CODE
