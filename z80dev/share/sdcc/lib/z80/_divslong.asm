;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:26 2003

;--------------------------------------------------------
	.module _divslong
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __divslong
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
;_divslong.c:257: _divslong (long a, long b)
;	genLabel
;	genFunction
;	---------------------------------
; Function _divslong
; ---------------------------------
__divslong_start::
__divslong:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-6
	add	hl,sp
	ld	sp,hl
;_divslong.c:262: (b < 0 ? -b : b));
;	genCmpLt
;	AOP_STK for 
;	AOP_STK for __divslong__1_0
	ld	a,11(ix)
	rlca
	and     a,#0x01
	ld	-6(ix),a
;	genIfx
;	AOP_STK for __divslong__1_0
	xor	a,a
	or	a,-6(ix)
	jp	z,00106$
;	genUminus
;	AOP_STK for 
	xor     a,a
	sbc	a,8(ix)
	ld	c,a
	ld	a,#0x00
	sbc	a,9(ix)
	ld	b,a
	ld	a,#0x00
	sbc	a,10(ix)
	ld	e,a
	ld	a,#0x00
	sbc	a,11(ix)
	ld	d,a
;	genGoto
	jp	00107$
;	genLabel
00106$:
;	genAssign
;	AOP_STK for 
	ld	c,8(ix)
	ld	b,9(ix)
	ld	e,10(ix)
	ld	d,11(ix)
;	genLabel
00107$:
;	genAssign
;	(registers are the same)
;_divslong.c:261: r = _divulong((a < 0 ? -a : a),
;	genCmpLt
;	AOP_STK for 
;	AOP_STK for __divslong__1_0
	ld	a,7(ix)
	rlca
	and     a,#0x01
	ld	-5(ix),a
;	genIfx
;	AOP_STK for __divslong__1_0
	xor	a,a
	or	a,-5(ix)
	jp	z,00108$
;	genUminus
;	AOP_STK for 
;	AOP_STK for __divslong__1_0
	xor     a,a
	sbc	a,4(ix)
	ld	-4(ix),a
	ld	a,#0x00
	sbc	a,5(ix)
	ld	-3(ix),a
	ld	a,#0x00
	sbc	a,6(ix)
	ld	-2(ix),a
	ld	a,#0x00
	sbc	a,7(ix)
	ld	-1(ix),a
;	genGoto
	jp	00109$
;	genLabel
00108$:
;	genAssign
;	AOP_STK for 
;	AOP_STK for __divslong__1_0
	ld	a,4(ix)
	ld	-4(ix),a
	ld	a,5(ix)
	ld	-3(ix),a
	ld	a,6(ix)
	ld	-2(ix),a
	ld	a,7(ix)
	ld	-1(ix),a
;	genLabel
00109$:
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	de
	push    bc
;	genIpush
;	AOP_STK for __divslong__1_0
	ld	l,-2(ix)
	ld	h,-1(ix)
	push	hl
	ld	l,-4(ix)
	ld	h,-3(ix)
	push	hl
;	genCall
	call	__divulong
	ld	c,d
	ld	b,e
	ld	d,h
	ld	e,l
	pop	af
	pop	af
	pop	af
	pop	af
;	genAssign
;	(registers are the same)
;	genAssign
;	(registers are the same)
;_divslong.c:263: if ( (a < 0) ^ (b < 0))
;	genXor
;	AOP_STK for __divslong__1_0
;	AOP_STK for __divslong__1_0
	ld	a,-6(ix)
	xor	a,-5(ix)
;	genIfx
	or	a,a
	jp	z,00102$
;_divslong.c:264: return -r;
;	genUminus
;	AOP_STK for __divslong__1_0
	xor     a,a
	sbc	a,e
	ld	-4(ix),a
	ld	a,#0x00
	sbc	a,d
	ld	-3(ix),a
	ld	a,#0x00
	sbc	a,b
	ld	-2(ix),a
	ld	a,#0x00
	sbc	a,c
	ld	-1(ix),a
;	genRet
;	AOP_STK for __divslong__1_0
; Dump of IC_LEFT: type AOP_STK size 4
;	 aop_stk -4
	ld	l,-4(ix)
	ld	h,-3(ix)
	ld	e,-2(ix)
	ld	d,-1(ix)
	jp	00104$
;	genLabel
00102$:
;_divslong.c:266: return r;
;	genRet
; Dump of IC_LEFT: type AOP_REG size 4
;	 reg = cbde
	ld	l,e
	ld	h,d
	ld	e,b
	ld	d,c
;	genLabel
00104$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
__divslong_end::
	.area _CODE
