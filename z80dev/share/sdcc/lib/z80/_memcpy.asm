;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:24 2003

;--------------------------------------------------------
	.module _memcpy
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memcpy
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
;_memcpy.c:29: void * memcpy (
;	genLabel
;	genFunction
;	---------------------------------
; Function memcpy
; ---------------------------------
_memcpy_start::
_memcpy:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-2
	add	hl,sp
	ld	sp,hl
;_memcpy.c:39: char * d = dst;
;	genAssign
;	(operands are equal 3)
;	genAssign
;	AOP_STK for 
	ld	e,4(ix)
	ld	d,5(ix)
;_memcpy.c:40: char * s = src;
;	genAssign
;	AOP_STK for 
	ld	l,6(ix)
	ld	h,7(ix)
;	genAssign
;	AOP_STK for _memcpy_s_1_1
	ld	-2(ix),l
	ld	-1(ix),h
;_memcpy.c:42: int count = -(acount >> 2);
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
	ld	c,l
	ld	b,h
;_memcpy.c:44: while (count) {
;	genLabel
00101$:
;	genIfx
	ld	a,c
	or	a,b
	jp	z,00103$
;_memcpy.c:45: *d++ = *s++;
;	genPointerGet
;	AOP_STK for _memcpy_s_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	a,(hl)
;	genPlus
;	AOP_STK for _memcpy_s_1_1
;	genPlusIncr
	inc	-2(ix)
	jp	nz,00116$
	inc	-1(ix)
00116$:
;	genAssign (pointer)
;	isBitvar = 0
	ld	(de),a
;	genPlus
;	genPlusIncr
	inc	de
;_memcpy.c:46: *d++ = *s++;
;	genPointerGet
;	AOP_STK for _memcpy_s_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	a,(hl)
;	genPlus
;	AOP_STK for _memcpy_s_1_1
;	genPlusIncr
	inc	-2(ix)
	jp	nz,00117$
	inc	-1(ix)
00117$:
;	genAssign (pointer)
;	isBitvar = 0
	ld	(de),a
;	genPlus
;	genPlusIncr
	inc	de
;_memcpy.c:47: *d++ = *s++;
;	genPointerGet
;	AOP_STK for _memcpy_s_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	a,(hl)
;	genPlus
;	AOP_STK for _memcpy_s_1_1
;	genPlusIncr
	inc	-2(ix)
	jp	nz,00118$
	inc	-1(ix)
00118$:
;	genAssign (pointer)
;	isBitvar = 0
	ld	(de),a
;	genPlus
;	genPlusIncr
	inc	de
;_memcpy.c:48: *d++ = *s++;
;	genPointerGet
;	AOP_STK for _memcpy_s_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	a,(hl)
;	genPlus
;	AOP_STK for _memcpy_s_1_1
;	genPlusIncr
	inc	-2(ix)
	jp	nz,00119$
	inc	-1(ix)
00119$:
;	genAssign (pointer)
;	isBitvar = 0
	ld	(de),a
;	genPlus
;	genPlusIncr
	inc	de
;_memcpy.c:49: count++;
;	genPlus
;	genPlusIncr
	inc	bc
;	genGoto
	jp	00101$
;	genLabel
00103$:
;_memcpy.c:52: if (acount & 2) {
;	genAnd
;	AOP_STK for 
	ld	a,8(ix)
	and	a,#0x02
	jp	z,00105$
00120$:
;_memcpy.c:53: *d++ = *s++; 
;	genPointerGet
;	AOP_STK for _memcpy_s_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	a,(hl)
;	genPlus
;	AOP_STK for _memcpy_s_1_1
;	genPlusIncr
	inc	-2(ix)
	jp	nz,00121$
	inc	-1(ix)
00121$:
;	genAssign (pointer)
;	isBitvar = 0
	ld	(de),a
;	genPlus
;	genPlusIncr
	inc	de
;_memcpy.c:54: *d++ = *s++;
;	genPointerGet
;	AOP_STK for _memcpy_s_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	a,(hl)
;	genPlus
;	AOP_STK for _memcpy_s_1_1
;	genPlusIncr
	inc	-2(ix)
	jp	nz,00122$
	inc	-1(ix)
00122$:
;	genAssign (pointer)
;	isBitvar = 0
	ld	(de),a
;	genPlus
;	genPlusIncr
	inc	de
;	genLabel
00105$:
;_memcpy.c:56: if (acount & 1) {
;	genAnd
;	AOP_STK for 
	ld	a,8(ix)
	and	a,#0x01
	jp	z,00107$
00123$:
;_memcpy.c:57: *d++ = *s++;
;	genPointerGet
;	AOP_STK for _memcpy_s_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	a,(hl)
;	genAssign (pointer)
;	isBitvar = 0
	ld	(de),a
;	genLabel
00107$:
;_memcpy.c:59: return dst;
;	genRet
;	AOP_STK for 
; Dump of IC_LEFT: type AOP_STK size 2
;	 aop_stk 4
	ld	l,4(ix)
	ld	h,5(ix)
;	genLabel
00108$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
_memcpy_end::
	.area _CODE
