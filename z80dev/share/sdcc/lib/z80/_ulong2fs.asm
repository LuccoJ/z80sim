;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:27 2003

;--------------------------------------------------------
	.module _ulong2fs
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___ulong2fs
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
;_ulong2fs.c:27: float __ulong2fs (unsigned long a )
;	genLabel
;	genFunction
;	---------------------------------
; Function __ulong2fs
; ---------------------------------
___ulong2fs_start::
___ulong2fs:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-10
	add	hl,sp
	ld	sp,hl
;_ulong2fs.c:32: if (!a)
;	genIfx
;	AOP_STK for 
	ld	a,4(ix)
	or	a,5(ix)
	or	a,6(ix)
	or	a,7(ix)
	jp	nz,00115$
;_ulong2fs.c:34: return 0.0;
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 4
	ld      hl,#0x0000
	ld      de,#0x0000
	jp	00111$
;_ulong2fs.c:37: while (a & NORM) 
;	genLabel
00115$:
;	genAssign
	ld	bc,#0x0096
;	genLabel
00103$:
;	genAnd
;	AOP_STK for 
	ld	a,7(ix)
	or	a,a
	jp	z,00117$
00119$:
;_ulong2fs.c:40: a >>= 1;
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
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
	call	__rrulong_rrx_s
;	AOP_STK for 
	ld	7(ix),d
	ld	6(ix),e
	ld	5(ix),h
	ld	4(ix),l
	pop	af
	pop	af
	inc	sp
	pop	bc
;	genAssign
;	(operands are equal 4)
;_ulong2fs.c:41: exp++;
;	genPlus
;	genPlusIncr
	inc	bc
;	genGoto
	jp	00103$
;_ulong2fs.c:44: while (a < HIDDEN)
;	genLabel
00117$:
;	genAssign
;	AOP_STK for ___ulong2fs_exp_1_1
	ld	-2(ix),c
	ld	-1(ix),b
;	genLabel
00106$:
;	genCmpLt
;	AOP_STK for 
	ld	a,4(ix)
	sub	a,#0x00
	ld	a,5(ix)
	sbc	a,#0x00
	ld	a,6(ix)
	sbc	a,#0x80
	ld	a,7(ix)
	sbc	a,#0x00
	ld	a,#0x00
	rla
	ld	l,a
;	genAssign
;	AOP_STK for ___ulong2fs_exp_1_1
;	AOP_STK for ___ulong2fs__1_0
	ld	a,-2(ix)
	ld	-8(ix),a
	ld	a,-1(ix)
	ld	-7(ix),a
;	genIfx
	xor	a,a
	or	a,l
	jp	z,00108$
;_ulong2fs.c:46: a <<= 1;
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
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
	inc	sp
;	genAssign
;	AOP_STK for 
	ld	4(ix),c
	ld	5(ix),b
	ld	6(ix),e
	ld	7(ix),d
;_ulong2fs.c:47: exp--;
;	genMinus
;	AOP_STK for ___ulong2fs_exp_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	dec	hl
	ld	-2(ix),l
	ld	-1(ix),h
;	genGoto
	jp	00106$
;	genLabel
00108$:
;_ulong2fs.c:51: if ((a&0x7fffff)==0x7fffff) {
;	genAnd
;	AOP_STK for 
	ld	c,4(ix)
	ld	b,5(ix)
	ld	a,6(ix)
	and	a,#0x7F
	ld	e,a
	ld	d,#0x00
;	genCmpEq
; genCmpEq: left 4, right 4, result 0
	ld	a,c
	cp	a,#0xFF
	jp	nz,00120$
	ld	a,b
	cp	a,#0xFF
	jp	nz,00120$
	ld	a,e
	cp	a,#0x7F
	jp	nz,00120$
	ld	a,d
	or	a,a
	jp	z,00121$
00120$:
	jp	00110$
00121$:
;_ulong2fs.c:52: a=0;
;	genAssign
;	AOP_STK for 
	xor	a,a
	ld	4(ix),a
	ld	5(ix),a
	ld	6(ix),a
	ld	7(ix),a
;_ulong2fs.c:53: exp++;
;	genPlus
;	AOP_STK for ___ulong2fs_exp_1_1
;	AOP_STK for ___ulong2fs__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-2(ix)
	add	a,#0x01
	ld	-8(ix),a
	ld	a,-1(ix)
	adc	a,#0x00
	ld	-7(ix),a
;	genLabel
00110$:
;_ulong2fs.c:57: a &= ~HIDDEN ;
;	genAnd
;	AOP_STK for 
	ld	a,6(ix)
	and	a,#0x7F
	ld	6(ix),a
;_ulong2fs.c:59: fl.l = PACK(0,(unsigned long)exp, a);
;	genAddrOf
;	AOP_STK for ___ulong2fs__1_0
	ld	hl,#0x0004
	add	hl,sp
	ld	-10(ix),l
	ld	-9(ix),h
;	genCast
;	AOP_STK for ___ulong2fs__1_0
	ld	e,-8(ix)
	ld	d,-7(ix)
	ld	a,-7(ix)
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
;	AOP_STK for 
	ld	a,c
	or	a,4(ix)
	ld	c,a
	ld	a,b
	or	a,5(ix)
	ld	b,a
	ld	a,e
	or	a,6(ix)
	ld	e,a
	ld	a,d
	or	a,7(ix)
	ld	d,a
;	genAssign (pointer)
;	AOP_STK for ___ulong2fs__1_0
;	isBitvar = 0
	ld	l,-10(ix)
	ld	h,-9(ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
;_ulong2fs.c:61: return (fl.f);
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
;	genRet
; Dump of IC_LEFT: type AOP_REG size 4
;	 reg = debc
	ld	l,c
	ld	h,b
;	genLabel
00111$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
___ulong2fs_end::
	.area _CODE
