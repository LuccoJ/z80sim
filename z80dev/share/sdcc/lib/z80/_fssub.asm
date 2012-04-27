;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:27 2003

;--------------------------------------------------------
	.module _fssub
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fssub
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
;_fssub.c:28: float __fssub (float a1, float a2)
;	genLabel
;	genFunction
;	---------------------------------
; Function __fssub
; ---------------------------------
___fssub_start::
___fssub:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-14
	add	hl,sp
	ld	sp,hl
;_fssub.c:32: fl1.f = a1;
;	genAddrOf
	ld	hl,#0x000A
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
;_fssub.c:33: fl2.f = a2;
;	genAddrOf
	ld	hl,#0x0006
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
;_fssub.c:36: if (!fl2.l)
;	genAddrOf
	ld	hl,#0x0006
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
;	genIfx
	ld	a,c
	or	a,b
	or	a,e
	or	a,d
	jp	nz,00102$
;_fssub.c:37: return (fl1.f);
;	genAddrOf
	ld	hl,#0x000A
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
;	genRet
; Dump of IC_LEFT: type AOP_REG size 4
;	 reg = debc
	ld	l,c
	ld	h,b
	jp	00105$
;	genLabel
00102$:
;_fssub.c:38: if (!fl1.l)
;	genAddrOf
	ld	hl,#0x000A
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
;	genIfx
	ld	a,c
	or	a,b
	or	a,e
	or	a,d
	jp	nz,00104$
;_fssub.c:39: return (-fl2.f);
;	genAddrOf
	ld	hl,#0x0006
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
	jp	00105$
;	genLabel
00104$:
;_fssub.c:42: fl2.l ^= SIGNBIT;
;	genAddrOf
;	AOP_STK for ___fssub__1_0
	ld	hl,#0x0006
	add	hl,sp
	ld	-10(ix),l
	ld	-9(ix),h
;	genAddrOf
	ld	hl,#0x0006
	add	hl,sp
; Removed redundent load
; Removed redundent load
;	genPointerGet
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
;	genXor
	ld	a,#0x80
	xor	a,b
	ld	b,a
;	genAssign (pointer)
;	AOP_STK for ___fssub__1_0
;	isBitvar = 0
	ld	l,-10(ix)
	ld	h,-9(ix)
	ld	(hl),e
	inc	hl
	ld	(hl),d
	inc	hl
	ld	(hl),c
	inc	hl
	ld	(hl),b
;_fssub.c:43: return fl1.f + fl2.f; 
;	genAddrOf
	ld	hl,#0x000A
	add	hl,sp
; Removed redundent load
; Removed redundent load
;	genPointerGet
;	AOP_STK for ___fssub__1_0
	ld	a,(hl)
	ld	-14(ix),a
	inc	hl
	ld	a,(hl)
	ld	-13(ix),a
	inc	hl
	ld	a,(hl)
	ld	-12(ix),a
	inc	hl
	ld	a,(hl)
	ld	-11(ix),a
;	genAddrOf
	ld	hl,#0x0006
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
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	de
	push    bc
;	genIpush
;	AOP_STK for ___fssub__1_0
	ld	l,-12(ix)
	ld	h,-11(ix)
	push	hl
	ld	l,-14(ix)
	ld	h,-13(ix)
	push	hl
;	genCall
	call	___fsadd
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
	pop	af
	pop	af
;	genRet
; Dump of IC_LEFT: type AOP_REG size 4
;	 reg = debc
	ld	l,c
	ld	h,b
;	genLabel
00105$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
___fssub_end::
	.area _CODE
