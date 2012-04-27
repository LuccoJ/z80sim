;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:24 2003

;--------------------------------------------------------
	.module _atof
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _atof
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
;_atof.c:22: float atof(char * s)
;	genLabel
;	genFunction
;	---------------------------------
; Function atof
; ---------------------------------
_atof_start::
_atof:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-14
	add	hl,sp
	ld	sp,hl
;_atof.c:33: while (isspace(*s)) s++;
;	genAssign
;	AOP_STK for 
	ld	c,4(ix)
	ld	b,5(ix)
;	genLabel
00101$:
;	genPointerGet
	ld	a,(bc)
	ld	l,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_isspace
	inc	sp
	pop	bc
;	genAssign
;	AOP_STK for 
	ld	4(ix),c
	ld	5(ix),b
;	genIfx
	xor	a,a
	or	a,l
	jp	z,00103$
;	genPlus
;	genPlusIncr
	inc	bc
;	genGoto
	jp	00101$
;	genLabel
00103$:
;_atof.c:36: if (*s == '-')
;	genPointerGet
	ld	a,(bc)
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	l,a
	cp	a,#0x2D
	jp	z,00149$
00148$:
	jp	00107$
00149$:
;_atof.c:38: sign=1;
;	genAssign
;	AOP_STK for _atof_sign_1_1
	ld	-10(ix),#0x01
;_atof.c:39: s++;
;	genPlus
;	AOP_STK for 
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,c
	add	a,#0x01
	ld	4(ix),a
	ld	a,b
	adc	a,#0x00
	ld	5(ix),a
;	genGoto
	jp	00108$
;	genLabel
00107$:
;_atof.c:43: sign=0;
;	genAssign
;	AOP_STK for _atof_sign_1_1
	ld	-10(ix),#0x00
;_atof.c:44: if (*s == '+') s++;
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	a,l
	cp	a,#0x2B
	jp	z,00151$
00150$:
	jp	00108$
00151$:
;	genPlus
;	AOP_STK for 
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,c
	add	a,#0x01
	ld	4(ix),a
	ld	a,b
	adc	a,#0x00
	ld	5(ix),a
;	genLabel
00108$:
;_atof.c:48: for (value=0.0; isdigit(*s); s++)
;	genAssign
;	AOP_STK for _atof_value_1_1
	ld	-4(ix),#0x00
	ld	-3(ix),#0x00
	ld	-2(ix),#0x00
	ld	-1(ix),#0x00
;	genAssign
;	(operands are equal 3)
;	genLabel
00121$:
;	genPointerGet
;	AOP_STK for 
	ld	l,4(ix)
	ld	h,5(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_isdigit
	inc	sp
;	genAssign
;	(operands are equal 4)
;	genIfx
	xor	a,a
	or	a,l
	jp	z,00124$
;_atof.c:50: value=10.0*value+(*s-'0');
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x4120
	push	hl
	ld	hl,#0x0000
	push	hl
;	genIpush
;	AOP_STK for _atof_value_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	push	hl
	ld	l,-4(ix)
	ld	h,-3(ix)
	push	hl
;	genCall
	call	___fsmul
;	AOP_STK for _atof__1_0
	ld	-11(ix),d
	ld	-12(ix),e
	ld	-13(ix),h
	ld	-14(ix),l
	pop	af
	pop	af
	pop	af
	pop	af
;	genPointerGet
;	AOP_STK for 
	ld	l,4(ix)
	ld	h,5(ix)
	ld	l,(hl)
;	genMinus
	ld	a,l
	add	a,#0xD0
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	l,a
	push	af
	inc	sp
;	genCall
	call	___uchar2fs
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	inc	sp
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	de
	push    bc
;	genIpush
;	AOP_STK for _atof__1_0
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
;	genAssign
;	AOP_STK for _atof_value_1_1
	ld	-4(ix),c
	ld	-3(ix),b
	ld	-2(ix),e
	ld	-1(ix),d
;_atof.c:48: for (value=0.0; isdigit(*s); s++)
;	genPlus
;	AOP_STK for 
;	genPlusIncr
	inc	4(ix)
	jp	nz,00152$
	inc	5(ix)
00152$:
;	genGoto
	jp	00121$
;	genLabel
00124$:
;_atof.c:54: if (*s == '.')
;	genPointerGet
;	AOP_STK for 
	ld	l,4(ix)
	ld	h,5(ix)
	ld	l,(hl)
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	a,l
	cp	a,#0x2E
	jp	z,00154$
00153$:
	jp	00110$
00154$:
;_atof.c:56: s++;
;	genPlus
;	AOP_STK for 
;	genPlusIncr
	ld	l,4(ix)
	ld	h,5(ix)
	inc	hl
;_atof.c:57: for (fraction=0.1; isdigit(*s); s++)
;	genAssign
;	AOP_STK for _atof_fraction_1_1
	ld	-8(ix),#0xCD
	ld	-7(ix),#0xCC
	ld	-6(ix),#0xCC
	ld	-5(ix),#0x3D
;	genAssign
;	AOP_STK for 
	ld	4(ix),l
	ld	5(ix),h
;	genLabel
00125$:
;	genPointerGet
;	AOP_STK for 
	ld	l,4(ix)
	ld	h,5(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_isdigit
	inc	sp
;	genAssign
;	(operands are equal 4)
;	genIfx
	xor	a,a
	or	a,l
	jp	z,00110$
;_atof.c:59: value+=(*s-'0')*fraction;
;	genPointerGet
;	AOP_STK for 
	ld	l,4(ix)
	ld	h,5(ix)
	ld	l,(hl)
;	genMinus
	ld	a,l
	add	a,#0xD0
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	l,a
	push	af
	inc	sp
;	genCall
	call	___uchar2fs
	ld	b,d
	ld	c,e
	ld	d,h
	ld	e,l
	inc	sp
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
;	AOP_STK for _atof_fraction_1_1
	ld	l,-6(ix)
	ld	h,-5(ix)
	push	hl
	ld	l,-8(ix)
	ld	h,-7(ix)
	push	hl
;	genIpush
	ld	l,c
	ld	h,b
	push	hl
	ld	l,e
	ld	h,d
	push	hl
;	genCall
	call	___fsmul
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
	push	de
	push    bc
;	genIpush
;	AOP_STK for _atof_value_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	push	hl
	ld	l,-4(ix)
	ld	h,-3(ix)
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
;	genAssign
;	AOP_STK for _atof_value_1_1
	ld	-4(ix),c
	ld	-3(ix),b
	ld	-2(ix),e
	ld	-1(ix),d
;_atof.c:60: fraction*=0.1;
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x3DCC
	push	hl
	ld	hl,#0xCCCD
	push	hl
;	genIpush
;	AOP_STK for _atof_fraction_1_1
	ld	l,-6(ix)
	ld	h,-5(ix)
	push	hl
	ld	l,-8(ix)
	ld	h,-7(ix)
	push	hl
;	genCall
	call	___fsmul
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
	pop	af
	pop	af
;	genAssign
;	AOP_STK for _atof_fraction_1_1
	ld	-8(ix),c
	ld	-7(ix),b
	ld	-6(ix),e
	ld	-5(ix),d
;_atof.c:57: for (fraction=0.1; isdigit(*s); s++)
;	genPlus
;	AOP_STK for 
;	genPlusIncr
	inc	4(ix)
	jp	nz,00155$
	inc	5(ix)
00155$:
;	genGoto
	jp	00125$
;	genLabel
00110$:
;_atof.c:65: if (toupper(*s)=='E')
;	genAssign
;	AOP_STK for 
	ld	c,4(ix)
	ld	b,5(ix)
;	genPointerGet
	ld	a,(bc)
	ld	l,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_islower
	inc	sp
	pop	bc
;	genIfx
	xor	a,a
	or	a,l
	jp	z,00131$
;	genPointerGet
	ld	a,(bc)
;	genAnd
	ld	e,a
	and	a,#0xDF
	ld	e,a
;	genGoto
	jp	00132$
;	genLabel
00131$:
;	genPointerGet
	ld	a,(bc)
	ld	e,a
;	genLabel
00132$:
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	a,e
	cp	a,#0x45
	jp	z,00157$
00156$:
	jp	00118$
00157$:
;_atof.c:67: s++;
;	genAssign
;	AOP_STK for 
	ld	l,4(ix)
	ld	h,5(ix)
;	genPlus
;	genPlusIncr
; Removed redundent load
; Removed redundent load
	inc	hl
;_atof.c:68: iexp=(char)atoi(s);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	hl
;	genCall
	call	_atoi
	pop	af
;	genCast
;	AOP_STK for _atof_iexp_1_1
	ld	-9(ix),l
;_atof.c:70: while(iexp!=0)
;	genLabel
00114$:
;	genCmpEq
;	AOP_STK for _atof_iexp_1_1
; genCmpEq: left 1, right 1, result 0
	ld	a,-9(ix)
	or	a,a
	jp	z,00118$
00158$:
;_atof.c:72: if(iexp<0)
;	genCmpLt
;	AOP_STK for _atof_iexp_1_1
	ld	a,-9(ix)
	bit	7,a
	jp	z,00112$
;_atof.c:74: value*=0.1;
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x3DCC
	push	hl
	ld	hl,#0xCCCD
	push	hl
;	genIpush
;	AOP_STK for _atof_value_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	push	hl
	ld	l,-4(ix)
	ld	h,-3(ix)
	push	hl
;	genCall
	call	___fsmul
	ld	c,d
	ld	d,e
	ld	e,h
	ld	b,l
	pop	af
	pop	af
	pop	af
	pop	af
;	genAssign
;	AOP_STK for _atof_value_1_1
	ld	-4(ix),b
	ld	-3(ix),e
	ld	-2(ix),d
	ld	-1(ix),c
;_atof.c:75: iexp++;
;	genPlus
;	AOP_STK for _atof_iexp_1_1
;	genPlusIncr
	inc	-9(ix)
;	genGoto
	jp	00114$
;	genLabel
00112$:
;_atof.c:79: value*=10.0;
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x4120
	push	hl
	ld	hl,#0x0000
	push	hl
;	genIpush
;	AOP_STK for _atof_value_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	push	hl
	ld	l,-4(ix)
	ld	h,-3(ix)
	push	hl
;	genCall
	call	___fsmul
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
	pop	af
	pop	af
;	genAssign
;	AOP_STK for _atof_value_1_1
	ld	-4(ix),c
	ld	-3(ix),b
	ld	-2(ix),e
	ld	-1(ix),d
;_atof.c:80: iexp--;
;	genMinus
;	AOP_STK for _atof_iexp_1_1
	dec	-9(ix)
;	genGoto
	jp	00114$
;	genLabel
00118$:
;_atof.c:86: if(sign) value*=-1.0;
;	genIfx
;	AOP_STK for _atof_sign_1_1
	xor	a,a
	or	a,-10(ix)
	jp	z,00120$
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0xBF80
	push	hl
	ld	hl,#0x0000
	push	hl
;	genIpush
;	AOP_STK for _atof_value_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	push	hl
	ld	l,-4(ix)
	ld	h,-3(ix)
	push	hl
;	genCall
	call	___fsmul
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
	pop	af
	pop	af
;	genAssign
;	AOP_STK for _atof_value_1_1
	ld	-4(ix),c
	ld	-3(ix),b
	ld	-2(ix),e
	ld	-1(ix),d
;	genLabel
00120$:
;_atof.c:87: return (value);
;	genRet
;	AOP_STK for _atof_value_1_1
; Dump of IC_LEFT: type AOP_STK size 4
;	 aop_stk -4
	ld	l,-4(ix)
	ld	h,-3(ix)
	ld	e,-2(ix)
	ld	d,-1(ix)
;	genLabel
00129$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
_atof_end::
	.area _CODE
