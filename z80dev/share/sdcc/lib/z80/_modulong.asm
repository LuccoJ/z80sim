;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:26 2003

;--------------------------------------------------------
	.module _modulong
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __modulong
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
;_modulong.c:340: _modulong (unsigned long a, unsigned long b)
;	genLabel
;	genFunction
;	---------------------------------
; Function _modulong
; ---------------------------------
__modulong_start::
__modulong:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-2
	add	hl,sp
	ld	sp,hl
;_modulong.c:342: unsigned char count = 0;
;	genAssign
;	AOP_STK for __modulong__1_0
	ld	-2(ix),#0x00
;_modulong.c:344: while (!MSB_SET(b))
;	genAssign
;	AOP_STK for __modulong_count_1_1
	ld	-1(ix),#0x00
;	genLabel
00103$:
;	genGetHBIT
;	AOP_STK for 
	ld	a,11(ix)
	rlc	a
;	genIfx
	and     a,#0x01
	jp	nz,00117$
;_modulong.c:346: b <<= 1;
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,#0x01
	push	af
	inc	sp
;	genIpush
;	AOP_STK for 
	ld	l,10(ix)
	ld	h,11(ix)
	push	hl
	ld	l,8(ix)
	ld	h,9(ix)
	push	hl
;	genCall
	call	__rlulong_rrx_s
	ld	c,d
	ld	b,e
	ld	d,h
	ld	e,l
	pop	af
	pop	af
	inc	sp
;	genAssign
;	AOP_STK for 
	ld	8(ix),e
	ld	9(ix),d
	ld	10(ix),b
	ld	11(ix),c
;_modulong.c:347: if (b > a)
;	genCmpGt
;	AOP_STK for 
	ld	a,4(ix)
	sub	a,e
	ld	a,5(ix)
	sbc	a,d
	ld	a,6(ix)
	sbc	a,b
	ld	a,7(ix)
	sbc	a,c
	jp	nc,00102$
;_modulong.c:349: b >>=1;
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,#0x01
	push	af
	inc	sp
;	genIpush
	ld	l,b
	ld	h,c
	push	hl
	ld	l,e
	ld	h,d
	push	hl
;	genCall
	call	__rrulong_rrx_s
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
	inc	sp
;	genAssign
;	AOP_STK for 
	ld	8(ix),c
	ld	9(ix),b
	ld	10(ix),e
	ld	11(ix),d
;_modulong.c:350: break;
;	genGoto
	jp	00117$
;	genLabel
00102$:
;_modulong.c:352: count++;
;	genPlus
;	AOP_STK for __modulong_count_1_1
;	genPlusIncr
	inc	-1(ix)
;	genAssign
;	AOP_STK for __modulong_count_1_1
;	AOP_STK for __modulong__1_0
	ld	a,-1(ix)
	ld	-2(ix),a
;	genGoto
	jp	00103$
;_modulong.c:354: do
;	genLabel
00117$:
;	genAssign
;	AOP_STK for __modulong__1_0
	ld	c,-2(ix)
;	genLabel
00108$:
;_modulong.c:356: if (a >= b)
;	genCmpLt
;	AOP_STK for 
;	AOP_STK for 
	ld	a,4(ix)
	sub	a,8(ix)
	ld	a,5(ix)
	sbc	a,9(ix)
	ld	a,6(ix)
	sbc	a,10(ix)
	ld	a,7(ix)
	sbc	a,11(ix)
	jp	c,00107$
;_modulong.c:357: a -= b;
;	genMinus
;	AOP_STK for 
;	AOP_STK for 
	ld	a,4(ix)
	sub	a,8(ix)
	ld	4(ix),a
	ld	a,5(ix)
	sbc	a,9(ix)
	ld	5(ix),a
	ld	a,6(ix)
	sbc	a,10(ix)
	ld	6(ix),a
	ld	a,7(ix)
	sbc	a,11(ix)
	ld	7(ix),a
;	genLabel
00107$:
;_modulong.c:358: b >>= 1;
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,#0x01
	push	af
	inc	sp
;	genIpush
;	AOP_STK for 
	ld	l,10(ix)
	ld	h,11(ix)
	push	hl
	ld	l,8(ix)
	ld	h,9(ix)
	push	hl
;	genCall
	call	__rrulong_rrx_s
;	AOP_STK for 
	ld	11(ix),d
	ld	10(ix),e
	ld	9(ix),h
	ld	8(ix),l
	pop	af
	pop	af
	inc	sp
	pop	bc
;	genAssign
;	(operands are equal 4)
;_modulong.c:360: while (count--);
;	genAssign
	ld	l,c
;	genMinus
	dec	c
;	genIfx
	xor	a,a
	or	a,l
	jp	nz,00108$
;_modulong.c:362: return a;
;	genRet
;	AOP_STK for 
; Dump of IC_LEFT: type AOP_STK size 4
;	 aop_stk 4
	ld	l,4(ix)
	ld	h,5(ix)
	ld	e,6(ix)
	ld	d,7(ix)
;	genLabel
00111$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
__modulong_end::
	.area _CODE
