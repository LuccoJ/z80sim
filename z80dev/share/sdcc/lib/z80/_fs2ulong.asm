;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:26 2003

;--------------------------------------------------------
	.module _fs2ulong
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fs2ulong
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
;_fs2ulong.c:29: __fs2ulong (float a1)
;	genLabel
;	genFunction
;	---------------------------------
; Function __fs2ulong
; ---------------------------------
___fs2ulong_start::
___fs2ulong:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-10
	add	hl,sp
	ld	sp,hl
;_fs2ulong.c:35: fl1.f = a1;
;	genAddrOf
	ld	hl,#0x0006
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
;_fs2ulong.c:37: if (!fl1.l || SIGN(fl1.l))
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
	jp	z,00101$
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
;	genGetHBIT
	ld	a,d
	rlc	a
;	genIfx
	and     a,#0x01
	jp	z,00102$
;	genLabel
00101$:
;_fs2ulong.c:38: return (0);
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 4
	ld      hl,#0x0000
	ld      de,#0x0000
	jp	00104$
;	genLabel
00102$:
;_fs2ulong.c:40: exp = EXP (fl1.l) - EXCESS - 24;
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
	ld	b,#0x00
	ld      de,#0x0000
;	genMinus
	ld	a,c
	add	a,#0x6A
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
;	AOP_STK for ___fs2ulong_exp_1_1
	ld	-6(ix),c
	ld	-5(ix),b
;_fs2ulong.c:41: l = MANT (fl1.l);
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
;	genAnd
	ld	a,e
	and	a,#0x7F
	ld	e,a
	ld	d,#0x00
;	genOr
;	AOP_STK for ___fs2ulong_l_1_1
	ld	-10(ix),c
	ld	-9(ix),b
	ld	a,e
	or	a,#0x80
	ld	-8(ix),a
	ld	-7(ix),d
;_fs2ulong.c:43: l >>= -exp;
;	genUminus
;	AOP_STK for ___fs2ulong_exp_1_1
	xor     a,a
	sbc	a,-6(ix)
	ld	l,a
	ld	a,#0x00
	sbc	a,-5(ix)
	ld	h,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	hl
;	genIpush
;	AOP_STK for ___fs2ulong_l_1_1
	ld	l,-8(ix)
	ld	h,-7(ix)
	push	hl
	ld	l,-10(ix)
	ld	h,-9(ix)
	push	hl
;	genCall
	call	__rrslong_rrx_s
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
	pop	af
;	genAssign
;	AOP_STK for ___fs2ulong_l_1_1
	ld	-10(ix),c
	ld	-9(ix),b
	ld	-8(ix),e
	ld	-7(ix),d
;_fs2ulong.c:45: return l;
;	genAssign
;	AOP_STK for ___fs2ulong_l_1_1
	ld	c,-10(ix)
	ld	b,-9(ix)
	ld	e,-8(ix)
	ld	d,-7(ix)
;	genRet
; Dump of IC_LEFT: type AOP_REG size 4
;	 reg = debc
	ld	l,c
	ld	h,b
;	genLabel
00104$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
___fs2ulong_end::
	.area _CODE
