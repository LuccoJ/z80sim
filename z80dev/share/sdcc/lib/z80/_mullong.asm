;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:26 2003

;--------------------------------------------------------
	.module _mullong
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __mullong
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
;_mullong.c:534: _mullong (long a, long b)
;	genLabel
;	genFunction
;	---------------------------------
; Function _mullong
; ---------------------------------
__mullong_start::
__mullong:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-27
	add	hl,sp
	ld	sp,hl
;_mullong.c:538: t.i.hi = bcast(a)->b.b0 * bcast(b)->b.b2;       // A
;	genAddrOf
;	AOP_STK for __mullong__1_0
	ld	hl,#0x0017
	add	hl,sp
	ld	-8(ix),l
	ld	-7(ix),h
;	genPlus
;	AOP_STK for __mullong__1_0
;	AOP_STK for __mullong__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-8(ix)
	add	a,#0x02
	ld	-6(ix),a
	ld	a,-7(ix)
	adc	a,#0x00
	ld	-5(ix),a
;	genAddrOf
;	AOP_STK for __mullong__1_0
	ld	hl,#0x001F
	add	hl,sp
;	genPointerGet
;	AOP_STK for __mullong__1_0
;	AOP_STK for __mullong__1_0
	ld	-11(ix),l
	ld	-10(ix),h
	ld	a,(hl)
	ld	-9(ix),a
;	genAddrOf
;	AOP_STK for __mullong__1_0
	ld	hl,#0x0023
	add	hl,sp
	ld	-16(ix),l
	ld	-15(ix),h
;	genPlus
;	AOP_STK for __mullong__1_0
;	AOP_STK for __mullong__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-16(ix)
	add	a,#0x02
	ld	-13(ix),a
	ld	a,-15(ix)
	adc	a,#0x00
	ld	-12(ix),a
;	genPointerGet
;	AOP_STK for __mullong__1_0
	ld	l,-13(ix)
	ld	h,-12(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,l
	push	af
	inc	sp
;	genIpush
;	AOP_STK for __mullong__1_0
	ld	a,-9(ix)
	push	af
	inc	sp
;	genCall
	call	__muluchar_rrx_s
	ld	d,h
	ld	e,l
	pop	af
;	genAssign (pointer)
;	AOP_STK for __mullong__1_0
;	isBitvar = 0
	ld	l,-6(ix)
	ld	h,-5(ix)
	ld	(hl),e
	inc	hl
	ld	(hl),d
;_mullong.c:539: t.i.lo = bcast(a)->b.b0 * bcast(b)->b.b0;       // A
;	genPointerGet
;	AOP_STK for __mullong__1_0
;	AOP_STK for __mullong__1_0
	ld	l,-16(ix)
	ld	h,-15(ix)
	ld	a,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
;	AOP_STK for __mullong__1_0
	ld	-14(ix),a
	push	af
	inc	sp
;	genIpush
;	AOP_STK for __mullong__1_0
	ld	a,-9(ix)
	push	af
	inc	sp
;	genCall
	call	__muluchar_rrx_s
	ld	e,h
	ld	d,l
	pop	af
;	genAssign (pointer)
;	AOP_STK for __mullong__1_0
;	isBitvar = 0
	ld	l,-8(ix)
	ld	h,-7(ix)
	ld	(hl),d
	inc	hl
	ld	(hl),e
;_mullong.c:540: t.b.b3 += bcast(a)->b.b3 *
;	genPlus
;	AOP_STK for __mullong__1_0
;	AOP_STK for __mullong__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-8(ix)
	add	a,#0x03
	ld	-19(ix),a
	ld	a,-7(ix)
	adc	a,#0x00
	ld	-18(ix),a
;	genPointerGet
;	AOP_STK for __mullong__1_0
	ld	l,-19(ix)
	ld	h,-18(ix)
	ld	c,(hl)
;	genPlus
;	AOP_STK for __mullong__1_0
;	AOP_STK for __mullong__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-11(ix)
	add	a,#0x03
	ld	-21(ix),a
	ld	a,-10(ix)
	adc	a,#0x00
	ld	-20(ix),a
;	genPointerGet
;	AOP_STK for __mullong__1_0
	ld	l,-21(ix)
	ld	h,-20(ix)
	ld	e,(hl)
;_mullong.c:541: bcast(b)->b.b0;       // G
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
;	AOP_STK for __mullong__1_0
	ld	a,-14(ix)
	push	af
	inc	sp
;	genIpush
	ld	a,e
	push	af
	inc	sp
;	genCall
	call	__muluchar_rrx_s
	ld	d,h
	ld	e,l
	pop	af
	pop	bc
;	genCast
	ld	l,c
	ld	h,#0x00
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
	add	hl,de
;	genCast
	ld	a,l
;	genAssign (pointer)
;	AOP_STK for __mullong__1_0
;	isBitvar = 0
	ld	l,-19(ix)
	ld	h,-18(ix)
	ld	(hl),a
;_mullong.c:542: t.b.b3 += bcast(a)->b.b2 *
;	genPointerGet
;	AOP_STK for __mullong__1_0
;	AOP_STK for __mullong__1_0
	ld	l,-19(ix)
	ld	h,-18(ix)
	ld	a,(hl)
	ld	-17(ix),a
;	genPlus
;	AOP_STK for __mullong__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-11(ix)
	add	a,#0x02
	ld	d,a
	ld	a,-10(ix)
	adc	a,#0x00
	ld	e,a
;	genPointerGet
	ld	l,d
	ld	h,e
	ld	c,(hl)
;_mullong.c:543: bcast(b)->b.b1;       // F
;	genPlus
;	AOP_STK for __mullong__1_0
;	AOP_STK for __mullong__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-16(ix)
	add	a,#0x01
	ld	-23(ix),a
	ld	a,-15(ix)
	adc	a,#0x00
	ld	-22(ix),a
;	genPointerGet
;	AOP_STK for __mullong__1_0
	ld	l,-23(ix)
	ld	h,-22(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	ld	a,l
	push	af
	inc	sp
;	genIpush
	ld	a,c
	push	af
	inc	sp
;	genCall
	call	__muluchar_rrx_s
	ld	b,h
	ld	c,l
	pop	af
	pop	de
;	genCast
;	AOP_STK for __mullong__1_0
	ld	l,-17(ix)
	ld	h,#0x00
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
	add	hl,bc
;	genCast
	ld	a,l
;	genAssign (pointer)
;	AOP_STK for __mullong__1_0
;	isBitvar = 0
	ld	l,-19(ix)
	ld	h,-18(ix)
	ld	(hl),a
;_mullong.c:544: t.i.hi += bcast(a)->b.b2 * bcast(b)->b.b0;      // E <- b lost in .lst
;	genPointerGet
;	AOP_STK for __mullong__1_0
	ld	l,-6(ix)
	ld	h,-5(ix)
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
;	genPointerGet
	ld	l,d
	ld	h,e
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
;	AOP_STK for __mullong__1_0
	ld	a,-14(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	__muluchar_rrx_s
	ld	d,h
	ld	e,l
	pop	af
	pop	bc
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,c
	add	a,e
	ld	c,a
	ld	a,b
	adc	a,d
	ld	b,a
;	genAssign (pointer)
;	AOP_STK for __mullong__1_0
;	isBitvar = 0
	ld	l,-6(ix)
	ld	h,-5(ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
;_mullong.c:546: t.i.hi += bcast(a)->b.b1 * bcast(b)->b.b1;      // D <- b lost in .lst
;	genPointerGet
;	AOP_STK for __mullong__1_0
;	AOP_STK for __mullong__1_0
	ld	l,-6(ix)
	ld	h,-5(ix)
	ld	a,(hl)
	ld	-19(ix),a
	inc	hl
	ld	a,(hl)
	ld	-18(ix),a
;	genPlus
;	AOP_STK for __mullong__1_0
;	genPlusIncr
	ld	e,-11(ix)
	ld	d,-10(ix)
	inc	de
;	genPointerGet
	ld	a,(de)
	ld	c,a
;	genPointerGet
;	AOP_STK for __mullong__1_0
	ld	l,-23(ix)
	ld	h,-22(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	ld	a,l
	push	af
	inc	sp
;	genIpush
	ld	a,c
	push	af
	inc	sp
;	genCall
	call	__muluchar_rrx_s
	ld	b,h
	ld	c,l
	pop	af
	pop	de
;	genPlus
;	AOP_STK for __mullong__1_0
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-19(ix)
	add	a,c
	ld	c,a
	ld	a,-18(ix)
	adc	a,b
	ld	b,a
;	genAssign (pointer)
;	AOP_STK for __mullong__1_0
;	isBitvar = 0
	ld	l,-6(ix)
	ld	h,-5(ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
;_mullong.c:548: bcast(a)->bi.b3 = bcast(a)->b.b1 *
;	genPointerGet
	ld	a,(de)
	ld	c,a
;_mullong.c:549: bcast(b)->b.b2;
;	genPointerGet
;	AOP_STK for __mullong__1_0
	ld	l,-13(ix)
	ld	h,-12(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,l
	push	af
	inc	sp
;	genIpush
	ld	a,c
	push	af
	inc	sp
;	genCall
	call	__muluchar_rrx_s
	ld	b,h
	ld	c,l
	pop	af
;	genCast
	ld	a,c
;	genAssign (pointer)
;	AOP_STK for __mullong__1_0
;	isBitvar = 0
	ld	l,-21(ix)
	ld	h,-20(ix)
	ld	(hl),a
;_mullong.c:550: bcast(a)->bi.i12 = bcast(a)->b.b1 *
;	genPlus
;	AOP_STK for __mullong__1_0
;	genPlusIncr
	ld	c,-11(ix)
	ld	b,-10(ix)
	inc	bc
;	genPlus
;	AOP_STK for __mullong__1_0
;	genPlusIncr
	ld	l,-11(ix)
	ld	h,-10(ix)
	inc	hl
;	genPointerGet
	ld	e,(hl)
;_mullong.c:551: bcast(b)->b.b0;              // C
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
;	AOP_STK for __mullong__1_0
	ld	a,-14(ix)
	push	af
	inc	sp
;	genIpush
	ld	a,e
	push	af
	inc	sp
;	genCall
	call	__muluchar_rrx_s
	ld	d,h
	ld	e,l
	pop	af
	pop	bc
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,c
	ld	h,b
	ld	(hl),e
	inc	hl
	ld	(hl),d
;_mullong.c:553: bcast(b)->bi.b3 = bcast(a)->b.b0 *
;	genPlus
;	AOP_STK for __mullong__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-16(ix)
	add	a,#0x03
	ld	c,a
	ld	a,-15(ix)
	adc	a,#0x00
	ld	b,a
;_mullong.c:554: bcast(b)->b.b3;
;	genPointerGet
	ld	a,(bc)
	ld	l,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genIpush
;	AOP_STK for __mullong__1_0
	ld	a,-9(ix)
	push	af
	inc	sp
;	genCall
	call	__muluchar_rrx_s
	ld	d,h
	ld	e,l
	pop	af
	pop	bc
;	genCast
	ld	a,e
;	genAssign (pointer)
;	isBitvar = 0
	ld	(bc),a
;_mullong.c:555: bcast(b)->bi.i12 = bcast(a)->b.b0 *
;	genPlus
;	AOP_STK for __mullong__1_0
;	genPlusIncr
	ld	c,-16(ix)
	ld	b,-15(ix)
	inc	bc
;_mullong.c:556: bcast(b)->b.b1;              // B
;	genPlus
;	AOP_STK for __mullong__1_0
;	genPlusIncr
	ld	l,-16(ix)
	ld	h,-15(ix)
	inc	hl
;	genPointerGet
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genIpush
;	AOP_STK for __mullong__1_0
	ld	a,-9(ix)
	push	af
	inc	sp
;	genCall
	call	__muluchar_rrx_s
	ld	d,h
	ld	e,l
	pop	af
	pop	bc
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,c
	ld	h,b
	ld	(hl),e
	inc	hl
	ld	(hl),d
;_mullong.c:557: bcast(b)->bi.b0 = 0;                            // B
;	genAssign (pointer)
;	AOP_STK for __mullong__1_0
;	isBitvar = 0
	ld	l,-16(ix)
	ld	h,-15(ix)
	ld	(hl),#0x00
;_mullong.c:558: bcast(a)->bi.b0 = 0;                            // C
;	genAssign (pointer)
;	AOP_STK for __mullong__1_0
;	isBitvar = 0
	ld	l,-11(ix)
	ld	h,-10(ix)
	ld	(hl),#0x00
;_mullong.c:559: t.l += a;
;	genPointerGet
;	AOP_STK for __mullong__1_0
;	AOP_STK for __mullong__1_0
	ld	l,-8(ix)
	ld	h,-7(ix)
	ld	a,(hl)
	ld	-27(ix),a
	inc	hl
	ld	a,(hl)
	ld	-26(ix),a
	inc	hl
	ld	a,(hl)
	ld	-25(ix),a
	inc	hl
	ld	a,(hl)
	ld	-24(ix),a
;	genAssign
;	AOP_STK for 
	ld	c,4(ix)
	ld	b,5(ix)
	ld	e,6(ix)
	ld	d,7(ix)
;	genPlus
;	AOP_STK for __mullong__1_0
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-27(ix)
	add	a,c
	ld	c,a
	ld	a,-26(ix)
	adc	a,b
	ld	b,a
	ld	a,-25(ix)
	adc	a,e
	ld	e,a
	ld	a,-24(ix)
	adc	a,d
	ld	d,a
;	genAssign (pointer)
;	AOP_STK for __mullong__1_0
;	isBitvar = 0
	ld	l,-8(ix)
	ld	h,-7(ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
;_mullong.c:561: return t.l + b;
;	genAssign
;	(operands are equal 3)
;	genPlus
;	AOP_STK for 
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,c
	add	a,8(ix)
	ld	c,a
	ld	a,b
	adc	a,9(ix)
	ld	b,a
	ld	a,e
	adc	a,10(ix)
	ld	e,a
	ld	a,d
	adc	a,11(ix)
	ld	d,a
;	genRet
; Dump of IC_LEFT: type AOP_REG size 4
;	 reg = debc
	ld	l,c
	ld	h,b
;	genLabel
00101$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
__mullong_end::
	.area _CODE
