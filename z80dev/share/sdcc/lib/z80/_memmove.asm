;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:24 2003

;--------------------------------------------------------
	.module _memmove
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memmove
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
;_memmove.c:35: void * memmove (
;	genLabel
;	genFunction
;	---------------------------------
; Function memmove
; ---------------------------------
_memmove_start::
_memmove:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-4
	add	hl,sp
	ld	sp,hl
;_memmove.c:48: int count = -(acount >> 2);
;	genRightShift
;	AOP_STK for 
	ld	c,8(ix)
	ld	b,9(ix)
	srl	b
	rr	c
	srl	b
	rr	c
;	genUminus
	xor     a,a
	sbc	a,c
	ld	l,a
	ld	a,#0x00
	sbc	a,b
	ld	h,a
;	genAssign
;	AOP_STK for _memmove_count_1_1
	ld	-4(ix),l
	ld	-3(ix),h
;_memmove.c:50: if (((int)src < (int)dst) && ((((int)src)+acount) > (int)dst)) {
;	genCast
;	AOP_STK for 
	ld	l,6(ix)
	ld	h,7(ix)
;	genCast
;	AOP_STK for 
	ld	e,4(ix)
	ld	d,5(ix)
;	genCmpLt
	ld	a,l
	sub	a,e
	ld	a,h
	sbc	a,d
	jp	p,00116$
;	genPlus
;	AOP_STK for 
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,l
	add	a,8(ix)
	ld	l,a
	ld	a,h
	adc	a,9(ix)
	ld	h,a
;	genAssign
;	(registers are the same)
;	genCmpGt
	ld	a,e
	sub	a,l
	ld	a,d
	sbc	a,h
	jp	nc,00116$
;_memmove.c:54: d = ((char *)dst)+acount-1;
;	genAssign
;	AOP_STK for 
	ld	l,4(ix)
	ld	h,5(ix)
;	genPlus
;	AOP_STK for 
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,l
	add	a,8(ix)
	ld	l,a
	ld	a,h
	adc	a,9(ix)
	ld	h,a
;	genMinus
;	AOP_STK for _memmove_d_1_1
	ld	a,l
	add	a,#0xFF
	ld	-2(ix),a
	ld	a,h
	adc	a,#0xFF
	ld	-1(ix),a
;_memmove.c:55: s = ((char *)src)+acount-1;
;	genAssign
;	AOP_STK for 
	ld	l,6(ix)
	ld	h,7(ix)
;	genPlus
;	AOP_STK for 
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,l
	add	a,8(ix)
	ld	l,a
	ld	a,h
	adc	a,9(ix)
	ld	h,a
;	genMinus
	ld	c,l
	ld	b,h
	dec	bc
;_memmove.c:56: while (count) {
;	genLabel
00101$:
;	genIfx
;	AOP_STK for _memmove_count_1_1
	ld	a,-4(ix)
	or	a,-3(ix)
	jp	z,00103$
;_memmove.c:57: *d-- = *s--;
;	genPointerGet
	ld	a,(bc)
	ld	e,a
;	genMinus
	dec	bc
;	genAssign (pointer)
;	AOP_STK for _memmove_d_1_1
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),e
;	genMinus
;	AOP_STK for _memmove_d_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	dec	hl
	ld	-2(ix),l
	ld	-1(ix),h
;_memmove.c:58: *d-- = *s--;
;	genPointerGet
	ld	a,(bc)
	ld	e,a
;	genMinus
	dec	bc
;	genAssign (pointer)
;	AOP_STK for _memmove_d_1_1
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),e
;	genMinus
;	AOP_STK for _memmove_d_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	dec	hl
	ld	-2(ix),l
	ld	-1(ix),h
;_memmove.c:59: *d-- = *s--;
;	genPointerGet
	ld	a,(bc)
	ld	e,a
;	genMinus
	dec	bc
;	genAssign (pointer)
;	AOP_STK for _memmove_d_1_1
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),e
;	genMinus
;	AOP_STK for _memmove_d_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	dec	hl
	ld	-2(ix),l
	ld	-1(ix),h
;_memmove.c:60: *d-- = *s--;
;	genPointerGet
	ld	a,(bc)
	ld	e,a
;	genMinus
	dec	bc
;	genAssign (pointer)
;	AOP_STK for _memmove_d_1_1
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),e
;	genMinus
;	AOP_STK for _memmove_d_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	dec	hl
	ld	-2(ix),l
	ld	-1(ix),h
;_memmove.c:61: count++;
;	genPlus
;	AOP_STK for _memmove_count_1_1
;	genPlusIncr
	inc	-4(ix)
	jp	nz,00133$
	inc	-3(ix)
00133$:
;	genGoto
	jp	00101$
;	genLabel
00103$:
;_memmove.c:64: if (acount & 2) {
;	genAnd
;	AOP_STK for 
	ld	a,8(ix)
	and	a,#0x02
	jp	z,00105$
00134$:
;_memmove.c:65: *d-- = *s--;
;	genPointerGet
	ld	a,(bc)
	ld	e,a
;	genMinus
	dec	bc
;	genAssign (pointer)
;	AOP_STK for _memmove_d_1_1
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),e
;	genMinus
;	AOP_STK for _memmove_d_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	dec	hl
	ld	-2(ix),l
	ld	-1(ix),h
;_memmove.c:66: *d-- = *s--;
;	genPointerGet
	ld	a,(bc)
	ld	e,a
;	genMinus
	dec	bc
;	genAssign (pointer)
;	AOP_STK for _memmove_d_1_1
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),e
;	genMinus
;	AOP_STK for _memmove_d_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	dec	hl
	ld	-2(ix),l
	ld	-1(ix),h
;	genLabel
00105$:
;_memmove.c:68: if (acount & 1) {
;	genAnd
;	AOP_STK for 
	ld	a,8(ix)
	and	a,#0x01
	jp	z,00117$
00135$:
;_memmove.c:69: *d-- = *s--;
;	genPointerGet
	ld	a,(bc)
;	genAssign (pointer)
;	AOP_STK for _memmove_d_1_1
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),a
;	genGoto
	jp	00117$
;	genLabel
00116$:
;_memmove.c:76: d = dst;
;	genAssign
;	AOP_STK for 
	ld	l,4(ix)
	ld	h,5(ix)
;	genAssign
;	AOP_STK for _memmove_d_1_1
	ld	-2(ix),l
	ld	-1(ix),h
;_memmove.c:77: s = src;
;	genAssign
;	AOP_STK for 
	ld	l,6(ix)
	ld	h,7(ix)
;	genAssign
	ld	c,l
	ld	b,h
;_memmove.c:78: while (count) {
;	genLabel
00108$:
;	genIfx
;	AOP_STK for _memmove_count_1_1
	ld	a,-4(ix)
	or	a,-3(ix)
	jp	z,00110$
;_memmove.c:79: *d++ = *s++;
;	genPointerGet
	ld	a,(bc)
;	genPlus
;	genPlusIncr
	inc	bc
;	genAssign (pointer)
;	AOP_STK for _memmove_d_1_1
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),a
;	genPlus
;	AOP_STK for _memmove_d_1_1
;	genPlusIncr
	inc	-2(ix)
	jp	nz,00136$
	inc	-1(ix)
00136$:
;_memmove.c:80: *d++ = *s++;
;	genPointerGet
	ld	a,(bc)
;	genPlus
;	genPlusIncr
	inc	bc
;	genAssign (pointer)
;	AOP_STK for _memmove_d_1_1
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),a
;	genPlus
;	AOP_STK for _memmove_d_1_1
;	genPlusIncr
	inc	-2(ix)
	jp	nz,00137$
	inc	-1(ix)
00137$:
;_memmove.c:81: *d++ = *s++;
;	genPointerGet
	ld	a,(bc)
;	genPlus
;	genPlusIncr
	inc	bc
;	genAssign (pointer)
;	AOP_STK for _memmove_d_1_1
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),a
;	genPlus
;	AOP_STK for _memmove_d_1_1
;	genPlusIncr
	inc	-2(ix)
	jp	nz,00138$
	inc	-1(ix)
00138$:
;_memmove.c:82: *d++ = *s++;
;	genPointerGet
	ld	a,(bc)
;	genPlus
;	genPlusIncr
	inc	bc
;	genAssign (pointer)
;	AOP_STK for _memmove_d_1_1
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),a
;	genPlus
;	AOP_STK for _memmove_d_1_1
;	genPlusIncr
	inc	-2(ix)
	jp	nz,00139$
	inc	-1(ix)
00139$:
;_memmove.c:83: count++;
;	genPlus
;	AOP_STK for _memmove_count_1_1
;	genPlusIncr
	inc	-4(ix)
	jp	nz,00140$
	inc	-3(ix)
00140$:
;	genGoto
	jp	00108$
;	genLabel
00110$:
;_memmove.c:86: if (acount & 2) {
;	genAnd
;	AOP_STK for 
	ld	a,8(ix)
	and	a,#0x02
	jp	z,00112$
00141$:
;_memmove.c:87: *d++ = *s++; 
;	genPointerGet
	ld	a,(bc)
;	genPlus
;	genPlusIncr
	inc	bc
;	genAssign (pointer)
;	AOP_STK for _memmove_d_1_1
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),a
;	genPlus
;	AOP_STK for _memmove_d_1_1
;	genPlusIncr
	inc	-2(ix)
	jp	nz,00142$
	inc	-1(ix)
00142$:
;_memmove.c:88: *d++ = *s++;
;	genPointerGet
	ld	a,(bc)
;	genPlus
;	genPlusIncr
	inc	bc
;	genAssign (pointer)
;	AOP_STK for _memmove_d_1_1
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),a
;	genPlus
;	AOP_STK for _memmove_d_1_1
;	genPlusIncr
	inc	-2(ix)
	jp	nz,00143$
	inc	-1(ix)
00143$:
;	genLabel
00112$:
;_memmove.c:90: if (acount & 1) {
;	genAnd
;	AOP_STK for 
	ld	a,8(ix)
	and	a,#0x01
	jp	z,00117$
00144$:
;_memmove.c:91: *d++ = *s++;
;	genPointerGet
	ld	a,(bc)
;	genAssign (pointer)
;	AOP_STK for _memmove_d_1_1
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),a
;	genLabel
00117$:
;_memmove.c:94: return dst;
;	genRet
;	AOP_STK for 
; Dump of IC_LEFT: type AOP_STK size 2
;	 aop_stk 4
	ld	l,4(ix)
	ld	h,5(ix)
;	genLabel
00119$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
_memmove_end::
	.area _CODE
