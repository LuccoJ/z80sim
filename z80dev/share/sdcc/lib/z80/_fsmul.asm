;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:27 2003

;--------------------------------------------------------
	.module _fsmul
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fsmul
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
;_fsmul.c:28: float __fsmul (float a1, float a2) {
;	genLabel
;	genFunction
;	---------------------------------
; Function __fsmul
; ---------------------------------
___fsmul_start::
___fsmul:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-22
	add	hl,sp
	ld	sp,hl
;_fsmul.c:34: fl1.f = a1;
;	genAddrOf
	ld	hl,#0x0012
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
;_fsmul.c:35: fl2.f = a2;
;	genAddrOf
	ld	hl,#0x000E
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
;_fsmul.c:37: if (!fl1.l || !fl2.l)
;	genAddrOf
	ld	hl,#0x0012
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
	jp	z,00101$
;	genAddrOf
	ld	hl,#0x000E
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
;	genLabel
00101$:
;_fsmul.c:38: return (0);
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 4
	ld      hl,#0x0000
	ld      de,#0x0000
	jp	00107$
;	genLabel
00102$:
;_fsmul.c:41: sign = SIGN (fl1.l) ^ SIGN (fl2.l);
;	genAddrOf
	ld	hl,#0x0012
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
;	genGetHBIT
;	AOP_STK for ___fsmul__1_0
	ld	a,d
	rlc	a
	and	a,#0x01
	ld	-16(ix),a
;	genAddrOf
	ld	hl,#0x000E
	add	hl,sp
; Removed redundent load
; Removed redundent load
;	genPointerGet
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
;	genGetHBIT
	ld	a,c
	rlc	a
	and	a,#0x01
	ld	b,a
;	genXor
;	AOP_STK for ___fsmul__1_0
	ld	a,-16(ix)
	xor	a,b
	ld	b,a
;	genAssign
;	AOP_STK for ___fsmul_sign_1_1
	ld	-15(ix),b
;_fsmul.c:42: exp = EXP (fl1.l) - EXCESS;
;	genAddrOf
	ld	hl,#0x0012
	add	hl,sp
; Removed redundent load
; Removed redundent load
;	genPointerGet
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,#0x17
	push	af
	inc	sp
;	genIpush
	ld	l,d
	ld	h,c
	push	hl
	ld	l,b
	ld	h,e
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
;	genAnd
	ld	b,#0x00
	ld      de,#0x0000
;	genMinus
	ld	a,c
	add	a,#0x82
	ld	c,a
	ld	a,b
	adc	a,#0xFF
	ld	b,a
	ld	a,e
	adc	a,#0xFF
	ld	e,a
	ld	a,d
	adc	a,#0xFF
	ld	d,a
;	genCast
;	AOP_STK for ___fsmul_exp_1_1
	ld	-14(ix),c
	ld	-13(ix),b
;_fsmul.c:43: exp += EXP (fl2.l);
;	genAddrOf
	ld	hl,#0x000E
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
	ld	a,#0x17
	push	af
	inc	sp
;	genIpush
	push	de
	push    bc
;	genCall
	call	__rrulong_rrx_s
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
	inc	sp
;	genAnd
;	AOP_STK for ___fsmul__1_0
	ld	-20(ix),c
	ld	-19(ix),#0x00
	ld	-18(ix),#0x00
	ld	-17(ix),#0x00
;	genCast
;	AOP_STK for ___fsmul_exp_1_1
	ld	c,-14(ix)
	ld	b,-13(ix)
	ld	a,-13(ix)
	rla	
	sbc	a,a
	ld	e,a
	ld	d,a
;	genPlus
;	AOP_STK for ___fsmul__1_0
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,c
	add	a,-20(ix)
	ld	c,a
	ld	a,b
	adc	a,-19(ix)
	ld	b,a
	ld	a,e
	adc	a,-18(ix)
	ld	e,a
	ld	a,d
	adc	a,-17(ix)
	ld	d,a
;	genCast
;	AOP_STK for ___fsmul_exp_1_1
	ld	-14(ix),c
	ld	-13(ix),b
;_fsmul.c:45: fl1.l = MANT (fl1.l);
;	genAddrOf
;	AOP_STK for ___fsmul__1_0
	ld	hl,#0x0012
	add	hl,sp
	ld	-20(ix),l
	ld	-19(ix),h
;	genAddrOf
	ld	hl,#0x0012
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
;	genAnd
	ld	a,c
	and	a,#0x7F
	ld	c,a
	ld	b,#0x00
;	genOr
	ld	a,c
	or	a,#0x80
	ld	c,a
;	genAssign (pointer)
;	AOP_STK for ___fsmul__1_0
;	isBitvar = 0
	ld	l,-20(ix)
	ld	h,-19(ix)
	ld	(hl),e
	inc	hl
	ld	(hl),d
	inc	hl
	ld	(hl),c
	inc	hl
	ld	(hl),b
;_fsmul.c:46: fl2.l = MANT (fl2.l);
;	genAddrOf
;	AOP_STK for ___fsmul__1_0
	ld	hl,#0x000E
	add	hl,sp
	ld	-20(ix),l
	ld	-19(ix),h
;	genAddrOf
	ld	hl,#0x000E
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
;	genAnd
	ld	a,c
	and	a,#0x7F
	ld	c,a
	ld	b,#0x00
;	genOr
	ld	a,c
	or	a,#0x80
	ld	c,a
;	genAssign (pointer)
;	AOP_STK for ___fsmul__1_0
;	isBitvar = 0
	ld	l,-20(ix)
	ld	h,-19(ix)
	ld	(hl),e
	inc	hl
	ld	(hl),d
	inc	hl
	ld	(hl),c
	inc	hl
	ld	(hl),b
;_fsmul.c:49: result = (fl1.l >> 8) * (fl2.l >> 8);
;	genAddrOf
	ld	hl,#0x0012
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
	ld	a,#0x08
	push	af
	inc	sp
;	genIpush
	push	de
	push    bc
;	genCall
	call	__rrulong_rrx_s
;	AOP_STK for ___fsmul__1_0
	ld	-17(ix),d
	ld	-18(ix),e
	ld	-19(ix),h
	ld	-20(ix),l
	pop	af
	pop	af
	inc	sp
;	genAddrOf
	ld	hl,#0x000E
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
	ld	a,#0x08
	push	af
	inc	sp
;	genIpush
	push	de
	push    bc
;	genCall
	call	__rrulong_rrx_s
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
	inc	sp
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	de
	push    bc
;	genIpush
;	AOP_STK for ___fsmul__1_0
	ld	l,-18(ix)
	ld	h,-17(ix)
	push	hl
	ld	l,-20(ix)
	ld	h,-19(ix)
	push	hl
;	genCall
	call	__mullong_rrx_s
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
	pop	af
	pop	af
;	genAssign
;	AOP_STK for ___fsmul_result_1_1
	ld	-12(ix),c
	ld	-11(ix),b
	ld	-10(ix),e
	ld	-9(ix),d
;_fsmul.c:50: result += ((fl1.l & (unsigned long) 0xFF) * (fl2.l >> 8)) >> 8;
;	genAddrOf
	ld	hl,#0x0012
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
;	genAnd
;	AOP_STK for ___fsmul__1_0
	ld	-20(ix),c
	ld	-19(ix),#0x00
	ld	-18(ix),#0x00
	ld	-17(ix),#0x00
;	genAddrOf
	ld	hl,#0x000E
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
	ld	a,#0x08
	push	af
	inc	sp
;	genIpush
	push	de
	push    bc
;	genCall
	call	__rrulong_rrx_s
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
	inc	sp
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	de
	push    bc
;	genIpush
;	AOP_STK for ___fsmul__1_0
	ld	l,-18(ix)
	ld	h,-17(ix)
	push	hl
	ld	l,-20(ix)
	ld	h,-19(ix)
	push	hl
;	genCall
	call	__mullong_rrx_s
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
	pop	af
	pop	af
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,#0x08
	push	af
	inc	sp
;	genIpush
	push	de
	push    bc
;	genCall
	call	__rrulong_rrx_s
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
	inc	sp
;	genPlus
;	AOP_STK for ___fsmul_result_1_1
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-12(ix)
	add	a,c
	ld	-12(ix),a
	ld	a,-11(ix)
	adc	a,b
	ld	-11(ix),a
	ld	a,-10(ix)
	adc	a,e
	ld	-10(ix),a
	ld	a,-9(ix)
	adc	a,d
	ld	-9(ix),a
;_fsmul.c:51: result += ((fl2.l & (unsigned long) 0xFF) * (fl1.l >> 8)) >> 8;
;	genAddrOf
	ld	hl,#0x000E
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
;	genAnd
;	AOP_STK for ___fsmul__1_0
	ld	-20(ix),c
	ld	-19(ix),#0x00
	ld	-18(ix),#0x00
	ld	-17(ix),#0x00
;	genAddrOf
	ld	hl,#0x0012
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
	ld	a,#0x08
	push	af
	inc	sp
;	genIpush
	push	de
	push    bc
;	genCall
	call	__rrulong_rrx_s
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
	inc	sp
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	de
	push    bc
;	genIpush
;	AOP_STK for ___fsmul__1_0
	ld	l,-18(ix)
	ld	h,-17(ix)
	push	hl
	ld	l,-20(ix)
	ld	h,-19(ix)
	push	hl
;	genCall
	call	__mullong_rrx_s
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
	pop	af
	pop	af
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,#0x08
	push	af
	inc	sp
;	genIpush
	push	de
	push    bc
;	genCall
	call	__rrulong_rrx_s
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
	inc	sp
;	genPlus
;	AOP_STK for ___fsmul_result_1_1
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-12(ix)
	add	a,c
	ld	-12(ix),a
	ld	a,-11(ix)
	adc	a,b
	ld	-11(ix),a
	ld	a,-10(ix)
	adc	a,e
	ld	-10(ix),a
	ld	a,-9(ix)
	adc	a,d
;_fsmul.c:53: if (result & SIGNBIT)
;	genAnd
;	AOP_STK for ___fsmul_result_1_1
	ld	-9(ix),a
	and	a,#0x80
	jp	z,00105$
00114$:
;_fsmul.c:56: result += 0x80;
;	genPlus
;	AOP_STK for ___fsmul_result_1_1
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-12(ix)
	add	a,#0x80
	ld	-12(ix),a
	ld	a,-11(ix)
	adc	a,#0x00
	ld	-11(ix),a
	ld	a,-10(ix)
	adc	a,#0x00
	ld	-10(ix),a
	ld	a,-9(ix)
	adc	a,#0x00
	ld	-9(ix),a
;_fsmul.c:57: result >>= 8;
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,#0x08
	push	af
	inc	sp
;	genIpush
;	AOP_STK for ___fsmul_result_1_1
	ld	l,-10(ix)
	ld	h,-9(ix)
	push	hl
	ld	l,-12(ix)
	ld	h,-11(ix)
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
;	AOP_STK for ___fsmul_result_1_1
	ld	-12(ix),c
	ld	-11(ix),b
	ld	-10(ix),e
	ld	-9(ix),d
;	genGoto
	jp	00106$
;	genLabel
00105$:
;_fsmul.c:62: result += 0x40;
;	genPlus
;	AOP_STK for ___fsmul_result_1_1
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-12(ix)
	add	a,#0x40
	ld	-12(ix),a
	ld	a,-11(ix)
	adc	a,#0x00
	ld	-11(ix),a
	ld	a,-10(ix)
	adc	a,#0x00
	ld	-10(ix),a
	ld	a,-9(ix)
	adc	a,#0x00
	ld	-9(ix),a
;_fsmul.c:63: result >>= 7;
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,#0x07
	push	af
	inc	sp
;	genIpush
;	AOP_STK for ___fsmul_result_1_1
	ld	l,-10(ix)
	ld	h,-9(ix)
	push	hl
	ld	l,-12(ix)
	ld	h,-11(ix)
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
;	AOP_STK for ___fsmul_result_1_1
	ld	-12(ix),c
	ld	-11(ix),b
	ld	-10(ix),e
	ld	-9(ix),d
;_fsmul.c:64: exp--;
;	genMinus
;	AOP_STK for ___fsmul_exp_1_1
	ld	l,-14(ix)
	ld	h,-13(ix)
	dec	hl
	ld	-14(ix),l
	ld	-13(ix),h
;	genLabel
00106$:
;_fsmul.c:67: result &= ~HIDDEN;
;	genAnd
;	AOP_STK for ___fsmul_result_1_1
	ld	a,-10(ix)
	and	a,#0x7F
	ld	-10(ix),a
;_fsmul.c:70: fl1.l = PACK (sign ? SIGNBIT : 0 , (unsigned long)exp, result);  
;	genAddrOf
;	AOP_STK for ___fsmul__1_0
	ld	hl,#0x0012
	add	hl,sp
	ld	-22(ix),l
	ld	-21(ix),h
;	genIfx
;	AOP_STK for ___fsmul_sign_1_1
	xor	a,a
	or	a,-15(ix)
	jp	z,00109$
;	genAssign
;	AOP_STK for ___fsmul__1_0
	ld	-20(ix),#0x00
	ld	-19(ix),#0x00
	ld	-18(ix),#0x00
	ld	-17(ix),#0x80
;	genGoto
	jp	00110$
;	genLabel
00109$:
;	genAssign
;	AOP_STK for ___fsmul__1_0
	xor	a,a
	ld	-20(ix),a
	ld	-19(ix),a
	ld	-18(ix),a
	ld	-17(ix),a
;	genLabel
00110$:
;	genCast
;	AOP_STK for ___fsmul_exp_1_1
	ld	e,-14(ix)
	ld	d,-13(ix)
	ld	a,-13(ix)
	rla	
	sbc	a,a
	ld	c,a
	ld	b,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,#0x17
	push	af
	inc	sp
;	genIpush
	ld	l,c
	ld	h,b
	push	hl
	ld	l,e
	ld	h,d
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
;	genOr
;	AOP_STK for ___fsmul__1_0
	ld	a,c
	or	a,-20(ix)
	ld	c,a
	ld	a,b
	or	a,-19(ix)
	ld	b,a
	ld	a,e
	or	a,-18(ix)
	ld	e,a
	ld	a,d
	or	a,-17(ix)
	ld	d,a
;	genOr
;	AOP_STK for ___fsmul_result_1_1
	ld	a,c
	or	a,-12(ix)
	ld	c,a
	ld	a,b
	or	a,-11(ix)
	ld	b,a
	ld	a,e
	or	a,-10(ix)
	ld	e,a
	ld	a,d
	or	a,-9(ix)
	ld	d,a
;	genAssign (pointer)
;	AOP_STK for ___fsmul__1_0
;	isBitvar = 0
	ld	l,-22(ix)
	ld	h,-21(ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
;_fsmul.c:71: return (fl1.f);
;	genAddrOf
	ld	hl,#0x0012
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
;	genLabel
00107$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
___fsmul_end::
	.area _CODE
