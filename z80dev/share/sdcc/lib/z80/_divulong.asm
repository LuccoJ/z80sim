;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:26 2003

;--------------------------------------------------------
	.module _divulong
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __divulong
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
;_divulong.c:327: _divulong (unsigned long a, unsigned long b)
;	genLabel
;	genFunction
;	---------------------------------
; Function _divulong
; ---------------------------------
__divulong_start::
__divulong:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-6
	add	hl,sp
	ld	sp,hl
;_divulong.c:329: unsigned long reste = 0L;
;	genAssign
;	AOP_STK for __divulong_reste_1_1
	xor	a,a
	ld	-4(ix),a
	ld	-3(ix),a
	ld	-2(ix),a
	ld	-1(ix),a
;_divulong.c:337: do
;	genAssign
;	AOP_STK for __divulong_count_1_1
	ld	-5(ix),#0x20
;	genLabel
00105$:
;_divulong.c:340: c = MSB_SET(a);
;	genGetHBIT
;	AOP_STK for 
	ld	a,7(ix)
	rlc	a
	and	a,#0x01
	ld	c,a
;	genAssign
;	AOP_STK for __divulong_c_1_1
	ld	-6(ix),c
;_divulong.c:341: a <<= 1;
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,#0x01
	push	af
	inc	sp
;	genIpush
;	AOP_STK for 
	ld	l,6(ix)
	ld	h,7(ix)
	push	hl
	ld	l,4(ix)
	ld	h,5(ix)
	push	hl
;	genCall
	call	__rlulong_rrx_s
;	AOP_STK for 
	ld	7(ix),d
	ld	6(ix),e
	ld	5(ix),h
	ld	4(ix),l
	pop	af
	pop	af
	inc	sp
;	genAssign
;	(operands are equal 4)
;_divulong.c:342: reste <<= 1;
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,#0x01
	push	af
	inc	sp
;	genIpush
;	AOP_STK for __divulong_reste_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	push	hl
	ld	l,-4(ix)
	ld	h,-3(ix)
	push	hl
;	genCall
	call	__rlulong_rrx_s
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
	inc	sp
;	genAssign
;	AOP_STK for __divulong_reste_1_1
	ld	-4(ix),c
	ld	-3(ix),b
	ld	-2(ix),e
	ld	-1(ix),d
;_divulong.c:343: if (c)
;	genIfx
;	AOP_STK for __divulong_c_1_1
	xor	a,a
	or	a,-6(ix)
	jp	z,00102$
;_divulong.c:344: reste |= 1L;
;	genOr
;	AOP_STK for __divulong_reste_1_1
	ld	a,-4(ix)
	or	a,#0x01
	ld	-4(ix),a
;	genLabel
00102$:
;_divulong.c:346: if (reste >= b)
;	genCmpLt
;	AOP_STK for __divulong_reste_1_1
;	AOP_STK for 
	ld	a,-4(ix)
	sub	a,8(ix)
	ld	a,-3(ix)
	sbc	a,9(ix)
	ld	a,-2(ix)
	sbc	a,10(ix)
	ld	a,-1(ix)
	sbc	a,11(ix)
	jp	c,00106$
;_divulong.c:348: reste -= b;
;	genMinus
;	AOP_STK for __divulong_reste_1_1
;	AOP_STK for 
	ld	a,-4(ix)
	sub	a,8(ix)
	ld	-4(ix),a
	ld	a,-3(ix)
	sbc	a,9(ix)
	ld	-3(ix),a
	ld	a,-2(ix)
	sbc	a,10(ix)
	ld	-2(ix),a
	ld	a,-1(ix)
	sbc	a,11(ix)
	ld	-1(ix),a
;_divulong.c:350: a |= 1L;
;	genOr
;	AOP_STK for 
	ld	a,4(ix)
	or	a,#0x01
	ld	4(ix),a
;	genLabel
00106$:
;_divulong.c:353: while (--count);
;	genMinus
;	AOP_STK for __divulong_count_1_1
	dec	-5(ix)
;	genIfx
;	AOP_STK for __divulong_count_1_1
	xor	a,a
	or	a,-5(ix)
	jp	nz,00105$
;_divulong.c:354: return a;
;	genRet
;	AOP_STK for 
; Dump of IC_LEFT: type AOP_STK size 4
;	 aop_stk 4
	ld	l,4(ix)
	ld	h,5(ix)
	ld	e,6(ix)
	ld	d,7(ix)
;	genLabel
00108$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
__divulong_end::
	.area _CODE
