;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Wed Oct 15 22:42:09 2003

;--------------------------------------------------------
	.module rslib
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _rsdecode
	.globl _errnum
	.globl _syndrome
	.globl _evalpoly
	.globl _rsencode
	.globl _g
	.globl _polysolve
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
;ecc/rslib.c:43: void rsencode (unsigned char m[249], unsigned char c[255]) {
;	genLabel
;	genFunction
;	---------------------------------
; Function rsencode
; ---------------------------------
_rsencode_start::
_rsencode:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-22
	add	hl,sp
	ld	sp,hl
;ecc/rslib.c:47: for(i=0; i<6; i++) r[i]=0;
;	genAddrOf
;	AOP_STK for _rsencode__1_0
	ld	hl,#0x0010
	add	hl,sp
	ld	-16(ix),l
	ld	-15(ix),h
;	genAssign
	ld	de,#0x0000
;	genLabel
00101$:
;	genCmpLt
	ld	a,e
	sub	a,#0x06
	ld	a,d
	sbc	a,#0x00
	jp	p,00124$
;	genPlus
;	AOP_STK for _rsencode__1_0
;	Can't optimise plus by inc, falling back to the normal way
	ld	l,-16(ix)
	ld	h,-15(ix)
	add	hl,de
;	genAssign (pointer)
;	isBitvar = 0
	ld	(hl),#0x00
;	genPlus
;	genPlusIncr
	inc	de
;	genGoto
	jp	00101$
;ecc/rslib.c:49: for(i=0; i<249; i++) {
;	genLabel
00124$:
;	genPlus
;	AOP_STK for _rsencode__1_0
;	AOP_STK for _rsencode__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-16(ix)
	add	a,#0x05
	ld	-12(ix),a
	ld	a,-15(ix)
	adc	a,#0x00
	ld	-11(ix),a
;	genAssign
;	AOP_STK for _rsencode_i_1_1
	ld	-8(ix),#0x00
	ld	-7(ix),#0x00
;	genLabel
00109$:
;	genAssign
;	AOP_STK for _rsencode_i_1_1
	ld	l,-8(ix)
	ld	h,-7(ix)
;	genCmpLt
	ld	a,l
	sub	a,#0xF9
	ld	a,h
	sbc	a,#0x00
	jp	nc,00126$
;ecc/rslib.c:50: c[254-i] = m[i];
;	genMinus
;	AOP_STK for _rsencode_i_1_1
	ld	a,#0xFE
	sub	a,-8(ix)
	ld	l,a
	ld	a,#0x00
	sbc	a,-7(ix)
	ld	h,a
;	genPlus
;	AOP_STK for 
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,6(ix)
	add	a,l
	ld	c,a
	ld	a,7(ix)
	adc	a,h
	ld	b,a
;	genPlus
;	AOP_STK for 
;	AOP_STK for _rsencode_i_1_1
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,4(ix)
	add	a,-8(ix)
	ld	l,a
	ld	a,5(ix)
	adc	a,-7(ix)
	ld	h,a
;	genPointerGet
	ld	e,(hl)
;	genAssign (pointer)
;	isBitvar = 0
	ld	a,e
	ld	(bc),a
;ecc/rslib.c:51: rtmp=gfadd(m[i], r[5]);
;	genPointerGet
;	AOP_STK for _rsencode__1_0
	ld	l,-12(ix)
	ld	h,-11(ix)
	ld	d,(hl)
;	genXor
	ld	a,d
	xor	a,e
	ld	e,a
;	genAssign
	ld	d,e
;ecc/rslib.c:52: for(j=5;j>0; j--) {
;	genAssign
;	AOP_STK for _rsencode_j_1_1
	ld	-10(ix),#0x05
	ld	-9(ix),#0x00
;	genLabel
00105$:
;	genCmpGt
;	AOP_STK for _rsencode_j_1_1
	ld	a,#0x00
	sub	a,-10(ix)
	ld	a,#0x00
	sbc	a,-9(ix)
	rlca
;	genIfx
	and     a,#0x01
	jp	z,00108$
;ecc/rslib.c:53: r[j]=gfadd(gfmul(rtmp, g[j]), r[j-1]);
;	genPlus
;	AOP_STK for _rsencode__1_0
;	AOP_STK for _rsencode_j_1_1
;	AOP_STK for _rsencode__1_0
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-16(ix)
	add	a,-10(ix)
	ld	-14(ix),a
	ld	a,-15(ix)
	adc	a,-9(ix)
	ld	-13(ix),a
;	genPlus
;	AOP_STK for _rsencode_j_1_1
;	AOP_STK for _rsencode__1_0
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<_g
	add	a,-10(ix)
	ld	-20(ix),a
	ld	a,#>_g
	adc	a,-9(ix)
	ld	-19(ix),a
;	genPointerGet
;	AOP_STK for _rsencode__1_0
;	AOP_STK for _rsencode__1_0
	ld	l,-20(ix)
	ld	h,-19(ix)
	ld	a,(hl)
	ld	-18(ix),a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
;	AOP_STK for _rsencode__1_0
	ld	a,-18(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
;	AOP_STK for _rsencode__1_0
	ld	-17(ix),l
	pop	af
	pop	de
;	genMinus
;	AOP_STK for _rsencode_j_1_1
;	AOP_STK for _rsencode__1_0
	ld	a,-10(ix)
	add	a,#0xFF
	ld	-22(ix),a
	ld	a,-9(ix)
	adc	a,#0xFF
	ld	-21(ix),a
;	genPlus
;	AOP_STK for _rsencode__1_0
;	AOP_STK for _rsencode__1_0
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-16(ix)
	add	a,-22(ix)
	ld	c,a
	ld	a,-15(ix)
	adc	a,-21(ix)
	ld	b,a
;	genPointerGet
	ld	a,(bc)
;	genXor
;	AOP_STK for _rsencode__1_0
	ld	e,a
	xor	a,-17(ix)
;	genAssign (pointer)
;	AOP_STK for _rsencode__1_0
;	isBitvar = 0
	ld	l,-14(ix)
	ld	h,-13(ix)
	ld	(hl),a
;ecc/rslib.c:52: for(j=5;j>0; j--) {
;	genAssign
;	AOP_STK for _rsencode__1_0
	ld	l,-22(ix)
	ld	h,-21(ix)
;	genAssign
;	AOP_STK for _rsencode_j_1_1
	ld	-10(ix),l
	ld	-9(ix),h
;	genGoto
	jp	00105$
;	genLabel
00108$:
;ecc/rslib.c:55: r[0]=gfmul(rtmp, g[0]);
;	genPointerGet
	ld	hl,#_g
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,l
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	c,l
	pop	af
;	genAssign (pointer)
;	AOP_STK for _rsencode__1_0
;	isBitvar = 0
	ld	l,-16(ix)
	ld	h,-15(ix)
	ld	(hl),c
;ecc/rslib.c:49: for(i=0; i<249; i++) {
;	genPlus
;	AOP_STK for _rsencode_i_1_1
;	genPlusIncr
	inc	-8(ix)
	jp	nz,00127$
	inc	-7(ix)
00127$:
;	genGoto
	jp	00109$
;ecc/rslib.c:58: for(i=0; i<6; i++) {
;	genLabel
00126$:
;	genAssign
	ld	bc,#0x0000
;	genLabel
00113$:
;	genCmpLt
	ld	a,c
	sub	a,#0x06
	ld	a,b
	sbc	a,#0x00
	jp	p,00117$
;ecc/rslib.c:59: c[i]=r[i];
;	genPlus
;	AOP_STK for 
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,6(ix)
	add	a,c
	ld	e,a
	ld	a,7(ix)
	adc	a,b
	ld	d,a
;	genPlus
;	AOP_STK for _rsencode__1_0
;	Can't optimise plus by inc, falling back to the normal way
	ld	l,-16(ix)
	ld	h,-15(ix)
	add	hl,bc
;	genPointerGet
	ld	a,(hl)
;	genAssign (pointer)
;	isBitvar = 0
	ld	(de),a
;ecc/rslib.c:58: for(i=0; i<6; i++) {
;	genPlus
;	genPlusIncr
	inc	bc
;	genGoto
	jp	00113$
;	genLabel
00117$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
_rsencode_end::
_g:
	.db #0x75
	.db #0x31
	.db #0x3A
	.db #0x9E
	.db #0x04
	.db #0x7E
;ecc/rslib.c:69: evalpoly (unsigned char p[255], unsigned char x)
;	genLabel
;	genFunction
;	---------------------------------
; Function evalpoly
; ---------------------------------
_evalpoly_start::
_evalpoly:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-1
	add	hl,sp
	ld	sp,hl
;ecc/rslib.c:75: y=0;
;	genAssign
;	AOP_STK for _evalpoly_y_1_1
	ld	-1(ix),#0x00
;ecc/rslib.c:77: for (i = 0; i < 255; i++) {
;	genAssign
	ld	de,#0x0000
;	genLabel
00101$:
;	genAssign
	ld	l,e
	ld	h,d
;	genCmpLt
	ld	a,l
	sub	a,#0xFF
	ld	a,h
	sbc	a,#0x00
	jp	nc,00104$
;ecc/rslib.c:78: y=gfadd(y, gfmul (p[i], gfexp (x, i)));
;	genCast
	ld	l,e
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	ld	a,l
	push	af
	inc	sp
;	genIpush
;	AOP_STK for 
	ld	a,6(ix)
	push	af
	inc	sp
;	genCall
	call	_gfexp
	ld	b,l
	pop	af
	pop	de
;	genPlus
;	AOP_STK for 
;	Can't optimise plus by inc, falling back to the normal way
	ld	l,4(ix)
	ld	h,5(ix)
	add	hl,de
;	genPointerGet
	ld	c,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	push    bc
	inc     sp
;	genIpush
	ld	a,c
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	c,l
	pop	af
	pop	de
;	genXor
;	AOP_STK for _evalpoly_y_1_1
	ld	a,c
	xor	a,-1(ix)
	ld	-1(ix),a
;ecc/rslib.c:77: for (i = 0; i < 255; i++) {
;	genPlus
;	genPlusIncr
	inc	de
;	genGoto
	jp	00101$
;	genLabel
00104$:
;ecc/rslib.c:80: return (y);
;	genRet
;	AOP_STK for _evalpoly_y_1_1
; Dump of IC_LEFT: type AOP_STK size 1
;	 aop_stk -1
	ld	l,-1(ix)
;	genLabel
00105$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
_evalpoly_end::
;ecc/rslib.c:90: void syndrome (unsigned char c[255], unsigned char s[7])
;	genLabel
;	genFunction
;	---------------------------------
; Function syndrome
; ---------------------------------
_syndrome_start::
_syndrome:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-4
	add	hl,sp
	ld	sp,hl
;ecc/rslib.c:95: s[0] = 0;
;	genAssign
;	AOP_STK for 
	ld	c,6(ix)
	ld	b,7(ix)
;	genAssign (pointer)
;	isBitvar = 0
	ld	a,#0x00
	ld	(bc),a
;ecc/rslib.c:96: for (i = 1; i < 7; i++)
;	genAssign
;	AOP_STK for _syndrome_i_1_1
	ld	-2(ix),#0x01
	ld	-1(ix),#0x00
;	genLabel
00101$:
;	genCmpLt
;	AOP_STK for _syndrome_i_1_1
	ld	a,-2(ix)
	sub	a,#0x07
	ld	a,-1(ix)
	sbc	a,#0x00
	jp	p,00105$
;ecc/rslib.c:98: s[i] = evalpoly (c, e2v[i]);
;	genPlus
;	AOP_STK for _syndrome_i_1_1
;	AOP_STK for _syndrome__1_0
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,c
	add	a,-2(ix)
	ld	-4(ix),a
	ld	a,b
	adc	a,-1(ix)
	ld	-3(ix),a
;	genPlus
;	AOP_STK for _syndrome_i_1_1
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<_e2v
	add	a,-2(ix)
	ld	l,a
	ld	a,#>_e2v
	adc	a,-1(ix)
	ld	h,a
;	genPointerGet
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genIpush
;	AOP_STK for 
	ld	l,4(ix)
	ld	h,5(ix)
	push	hl
;	genCall
	call	_evalpoly
	ld	e,l
	pop	af
	inc	sp
	pop	bc
;	genAssign (pointer)
;	AOP_STK for _syndrome__1_0
;	isBitvar = 0
	ld	l,-4(ix)
	ld	h,-3(ix)
	ld	(hl),e
;ecc/rslib.c:99: s[0] = s[0] | s[i];
;	genPointerGet
	ld	a,(bc)
;	genOr
	ld	d,a
	or	a,e
;	genAssign (pointer)
;	isBitvar = 0
	ld	(bc),a
;ecc/rslib.c:96: for (i = 1; i < 7; i++)
;	genPlus
;	AOP_STK for _syndrome_i_1_1
;	genPlusIncr
	inc	-2(ix)
	jp	nz,00109$
	inc	-1(ix)
00109$:
;	genGoto
	jp	00101$
;	genLabel
00105$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
_syndrome_end::
;ecc/rslib.c:111: void errnum (unsigned char s[7], unsigned char* det, int* errs)
;	genLabel
;	genFunction
;	---------------------------------
; Function errnum
; ---------------------------------
_errnum_start::
_errnum:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-9
	add	hl,sp
	ld	sp,hl
;ecc/rslib.c:115: *det = gfmul (s[2], gfmul (s[4], s[6]));
;	genAssign
;	AOP_STK for 
;	AOP_STK for _errnum__1_0
	ld	a,6(ix)
	ld	-2(ix),a
	ld	a,7(ix)
	ld	-1(ix),a
;	genPlus
;	AOP_STK for 
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,4(ix)
	add	a,#0x06
	ld	e,a
	ld	a,5(ix)
	adc	a,#0x00
	ld	d,a
;	genPointerGet
	ld	a,(de)
	ld	c,a
;	genPlus
;	AOP_STK for 
;	AOP_STK for _errnum__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,4(ix)
	add	a,#0x04
	ld	-4(ix),a
	ld	a,5(ix)
	adc	a,#0x00
	ld	-3(ix),a
;	genPointerGet
;	AOP_STK for _errnum__1_0
	ld	l,-4(ix)
	ld	h,-3(ix)
	ld	b,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	ld	a,c
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfmul
	ld	c,l
	pop	af
	pop	de
;	genPlus
;	AOP_STK for 
;	AOP_STK for _errnum__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,4(ix)
	add	a,#0x02
	ld	-6(ix),a
	ld	a,5(ix)
	adc	a,#0x00
	ld	-5(ix),a
;	genPointerGet
;	AOP_STK for _errnum__1_0
	ld	l,-6(ix)
	ld	h,-5(ix)
	ld	b,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	ld	a,c
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfmul
	ld	c,l
	pop	af
	pop	de
;	genAssign (pointer)
;	AOP_STK for _errnum__1_0
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),c
;ecc/rslib.c:116: *det = gfadd (*det, gfmul (s[2], gfmul (s[5], s[5])));
;	genPlus
;	AOP_STK for 
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,4(ix)
	add	a,#0x05
	ld	l,a
	ld	a,5(ix)
	adc	a,#0x00
	ld	h,a
;	genPointerGet
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,l
	push	af
	inc	sp
;	genIpush
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_gfmul
;	AOP_STK for _errnum__1_0
	ld	-7(ix),l
	pop	af
	pop	de
	pop	bc
;	genPointerGet
;	AOP_STK for _errnum__1_0
	ld	l,-6(ix)
	ld	h,-5(ix)
	ld	b,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _errnum__1_0
	ld	a,-7(ix)
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfmul
	ld	b,l
	pop	af
	pop	de
	ld	a,b
	pop	bc
;	genXor
	ld	b,a
	xor	a,c
	ld	c,a
;	genAssign (pointer)
;	AOP_STK for _errnum__1_0
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),c
;ecc/rslib.c:117: *det = gfadd (*det, gfmul (s[6], gfmul (s[3], s[3])));
;	genPlus
;	AOP_STK for 
;	AOP_STK for _errnum__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,4(ix)
	add	a,#0x03
	ld	-9(ix),a
	ld	a,5(ix)
	adc	a,#0x00
	ld	-8(ix),a
;	genPointerGet
;	AOP_STK for _errnum__1_0
	ld	l,-9(ix)
	ld	h,-8(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,l
	push	af
	inc	sp
;	genIpush
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	b,l
	pop	af
	pop	de
	ld	a,b
	pop	bc
	ld	b,a
;	genPointerGet
	ld	a,(de)
	ld	e,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	push    bc
	inc     sp
;	genIpush
	ld	a,e
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	b,l
	pop	af
	ld	a,b
	pop	bc
;	genXor
	ld	b,a
	xor	a,c
	ld	c,a
;	genAssign (pointer)
;	AOP_STK for _errnum__1_0
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),c
;ecc/rslib.c:118: *det = gfadd (*det, gfmul (s[4], gfmul (s[4], s[4])));
;	genPointerGet
;	AOP_STK for _errnum__1_0
	ld	l,-4(ix)
	ld	h,-3(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genIpush
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	b,l
	pop	af
	ld	a,b
	pop	bc
	ld	b,a
;	genPointerGet
;	AOP_STK for _errnum__1_0
	ld	l,-4(ix)
	ld	h,-3(ix)
	ld	e,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	push    bc
	inc     sp
;	genIpush
	ld	a,e
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	b,l
	pop	af
	ld	a,b
	pop	bc
;	genXor
	ld	b,a
	xor	a,c
	ld	c,a
;	genAssign (pointer)
;	AOP_STK for _errnum__1_0
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),c
;ecc/rslib.c:119: *errs = 3;
;	genAssign
;	AOP_STK for 
	ld	e,8(ix)
	ld	d,9(ix)
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,e
	ld	h,d
	ld	(hl),#0x03
	inc	hl
	ld	(hl),#0x00
;ecc/rslib.c:121: if (*det != 0)
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	a,c
	or	a,a
;ecc/rslib.c:122: return;
;	genRet
;	genLabel
	jp	z,00102$
00112$:
	jp	00107$
00102$:
;ecc/rslib.c:124: *det = gfadd (gfmul (s[2], s[4]), gfexp (s[3], 2));
;	genPointerGet
;	AOP_STK for _errnum__1_0
	ld	l,-4(ix)
	ld	h,-3(ix)
	ld	c,(hl)
;	genPointerGet
;	AOP_STK for _errnum__1_0
	ld	l,-6(ix)
	ld	h,-5(ix)
	ld	b,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	ld	a,c
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfmul
	ld	c,l
	pop	af
	pop	de
;	genPointerGet
;	AOP_STK for _errnum__1_0
	ld	l,-9(ix)
	ld	h,-8(ix)
	ld	b,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,#0x02
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfexp
	ld	b,l
	pop	af
	pop	de
	ld	a,b
	pop	bc
;	genXor
	ld	b,a
	xor	a,c
	ld	c,a
;	genAssign (pointer)
;	AOP_STK for _errnum__1_0
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),c
;ecc/rslib.c:125: *errs = 2;
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,e
	ld	h,d
	ld	(hl),#0x02
	inc	hl
	ld	(hl),#0x00
;ecc/rslib.c:126: if (*det != 0)
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	a,c
	or	a,a
;ecc/rslib.c:127: return;
;	genRet
;	genLabel
	jp	z,00104$
00113$:
	jp	00107$
00104$:
;ecc/rslib.c:129: *det = s[1];
;	genPlus
;	AOP_STK for 
;	genPlusIncr
	ld	l,4(ix)
	ld	h,5(ix)
	inc	hl
;	genPointerGet
	ld	c,(hl)
;	genAssign (pointer)
;	AOP_STK for _errnum__1_0
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),c
;ecc/rslib.c:130: *errs = 1;
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,e
	ld	h,d
	ld	(hl),#0x01
	inc	hl
	ld	(hl),#0x00
;ecc/rslib.c:131: if (*det != 0)
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	a,c
	or	a,a
;ecc/rslib.c:132: return;
;	genRet
;	genLabel
	jp	z,00106$
00114$:
	jp	00107$
00106$:
;ecc/rslib.c:134: *errs = 4;
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,e
	ld	h,d
	ld	(hl),#0x04
	inc	hl
	ld	(hl),#0x00
;	genLabel
00107$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
_errnum_end::
;ecc/rslib.c:144: void rsdecode (unsigned char code[255], unsigned char mesg[249], int* errcode) {
;	genLabel
;	genFunction
;	---------------------------------
; Function rsdecode
; ---------------------------------
_rsdecode_start::
_rsdecode:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-44
	add	hl,sp
	ld	sp,hl
;ecc/rslib.c:150: *errcode = 0;
;	genAssign
;	AOP_STK for 
;	AOP_STK for _rsdecode__1_0
	ld	a,8(ix)
	ld	-27(ix),a
	ld	a,9(ix)
	ld	-26(ix),a
;	genAssign (pointer)
;	AOP_STK for _rsdecode__1_0
;	isBitvar = 0
	ld	l,-27(ix)
	ld	h,-26(ix)
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;ecc/rslib.c:156: for (i=0; i<249; i++) mesg[i]=code[j--];
;	genAssign
	ld	b,#0xFE
;	genAssign
	ld	d,#0x00
;	genLabel
00126$:
;	genCmpLt
	ld	a,d
	sub	a,#0xF9
	jp	nc,00129$
;	genPlus
;	AOP_STK for 
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,6(ix)
	add	a,d
	ld	e,a
	ld	a,7(ix)
	adc	a,#0x00
	ld	c,a
;	genAssign
	ld	l,b
;	genMinus
	dec	b
;	genPlus
;	AOP_STK for 
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,4(ix)
	add	a,l
	ld	l,a
	ld	a,5(ix)
	adc	a,#0x00
	ld	h,a
;	genPointerGet
	ld	a,(hl)
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,e
	ld	h,c
	ld	(hl),a
;	genPlus
;	genPlusIncr
; Removed redundent load
	inc	d
;	genGoto
	jp	00126$
;	genLabel
00129$:
;ecc/rslib.c:158: syndrome (code, syn);
;	genAddrOf
;	AOP_STK for _rsdecode__1_0
	ld	hl,#0x0025
	add	hl,sp
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
;	AOP_STK for _rsdecode__1_0
	ld	-32(ix),l
	ld	-31(ix),h
	push	hl
;	genIpush
;	AOP_STK for 
	ld	l,4(ix)
	ld	h,5(ix)
	push	hl
;	genCall
	call	_syndrome
	pop	af
	pop	af
;ecc/rslib.c:160: if(syn[0]==0) return;
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-32(ix)
	ld	h,-31(ix)
	ld	l,(hl)
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	a,l
	or	a,a
	jp	z,00148$
00147$:
	jp	00102$
00148$:
;	genRet
	jp	00130$
;	genLabel
00102$:
;ecc/rslib.c:166: errnum (syn, &deter, errcode);
;	genAddrOf
	ld	hl,#0x0024
	add	hl,sp
	ld	e,l
	ld	d,h
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
;	AOP_STK for _rsdecode__1_0
	ld	l,-27(ix)
	ld	h,-26(ix)
	push	hl
;	genIpush
	push	de
;	genIpush
;	AOP_STK for _rsdecode__1_0
	ld	l,-32(ix)
	ld	h,-31(ix)
	push	hl
;	genCall
	call	_errnum
	pop	af
	pop	af
	pop	af
;ecc/rslib.c:168: if(*errcode==4) return;
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-27(ix)
	ld	h,-26(ix)
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
;	genCmpEq
; genCmpEq: left 2, right 2, result 0
	ld	l,a
	cp	a,#0x04
	jp	nz,00149$
	ld	a,h
	or	a,a
	jp	z,00150$
00149$:
	jp	00104$
00150$:
;	genRet
	jp	00130$
;	genLabel
00104$:
;ecc/rslib.c:175: switch (*errcode)
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-27(ix)
	ld	h,-26(ix)
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
;	genCmpEq
; genCmpEq: left 2, right 2, result 0
	ld	l,a
	cp	a,#0x01
	jp	nz,00151$
	ld	a,h
	or	a,a
	jp	z,00105$
00151$:
;	genCmpEq
; genCmpEq: left 2, right 2, result 0
	ld	a,l
	cp	a,#0x02
	jp	nz,00152$
	ld	a,h
	or	a,a
	jp	z,00108$
00152$:
;	genCmpEq
; genCmpEq: left 2, right 2, result 0
	ld	a,l
	cp	a,#0x03
	jp	nz,00153$
	ld	a,h
	or	a,a
	jp	z,00115$
00153$:
;	genGoto
	jp	00124$
;ecc/rslib.c:180: x0 = gfmul (syn[2], gfinv (syn[1]));
;	genLabel
00105$:
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-32(ix)
	add	a,#0x01
	ld	-29(ix),a
	ld	a,-31(ix)
	adc	a,#0x00
	ld	-28(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-29(ix)
	ld	h,-28(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_gfinv
	ld	b,l
	inc	sp
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-32(ix)
	add	a,#0x02
	ld	d,a
	ld	a,-31(ix)
	adc	a,#0x00
	ld	e,a
;	genPointerGet
	ld	l,d
	ld	h,e
	ld	c,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	push    bc
	inc     sp
;	genIpush
	ld	a,c
	push	af
	inc	sp
;	genCall
	call	_gfmul
	pop	af
	pop	de
;	genAssign
	ld	c,l
;ecc/rslib.c:181: w0 = gfmul (gfexp (syn[1], 2), gfinv (syn[2]));
;	genPointerGet
	ld	l,d
	ld	h,e
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_gfinv
	ld	b,l
	inc	sp
	ld	a,b
	pop	bc
	ld	b,a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-29(ix)
	ld	h,-28(ix)
	ld	e,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,#0x02
	push	af
	inc	sp
;	genIpush
	ld	a,e
	push	af
	inc	sp
;	genCall
	call	_gfexp
	ld	e,l
	pop	af
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	push    bc
	inc     sp
;	genIpush
	ld	a,e
	push	af
	inc	sp
;	genCall
	call	_gfmul
	pop	af
	pop	bc
;	genAssign
;	AOP_STK for _rsdecode_w0_1_1
	ld	-18(ix),l
;ecc/rslib.c:182: if (v2e[x0] > 5)
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<_v2e
	add	a,c
	ld	l,a
	ld	a,#>_v2e
	adc	a,#0x00
	ld	h,a
;	genPointerGet
	ld	l,(hl)
;	genCmpGt
	ld	a,#0x05
	sub	a,l
	jp	nc,00107$
;ecc/rslib.c:183: mesg[254 - v2e[x0]] = gfadd (mesg[254 - v2e[x0]], w0);
;	genMinus
	ld	a,#0xFE
	sub	a,l
	ld	l,a
;	genPlus
;	AOP_STK for 
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,6(ix)
	add	a,l
	ld	e,a
	ld	a,7(ix)
	adc	a,#0x00
	ld	d,a
;	genPointerGet
	ld	a,(de)
	ld	c,a
;	genXor
;	AOP_STK for _rsdecode_w0_1_1
	ld	a,-18(ix)
	xor	a,c
;	genAssign (pointer)
;	isBitvar = 0
	ld	(de),a
;	genLabel
00107$:
;ecc/rslib.c:184: return;
;	genRet
	jp	00130$
;ecc/rslib.c:188: z[0] = gfmul (gfadd (gfmul (syn[1], syn[3]), gfexp (syn[2], 2)), gfinv (deter));
;	genLabel
00108$:
;	genAddrOf
;	AOP_STK for _rsdecode__1_0
	ld	hl,#0x0020
	add	hl,sp
	ld	-29(ix),l
	ld	-28(ix),h
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
;	AOP_STK for _rsdecode_deter_1_1
	ld	a,-8(ix)
	push	af
	inc	sp
;	genCall
	call	_gfinv
	ld	c,l
	inc	sp
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-32(ix)
	add	a,#0x03
	ld	-38(ix),a
	ld	a,-31(ix)
	adc	a,#0x00
	ld	-37(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-38(ix)
	ld	h,-37(ix)
	ld	e,(hl)
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-32(ix)
	add	a,#0x01
	ld	-34(ix),a
	ld	a,-31(ix)
	adc	a,#0x00
	ld	-33(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-34(ix)
	ld	h,-33(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,e
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	e,l
	pop	af
	pop	bc
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-32(ix)
	add	a,#0x02
	ld	-36(ix),a
	ld	a,-31(ix)
	adc	a,#0x00
	ld	-35(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-36(ix)
	ld	h,-35(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,#0x02
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfexp
	ld	d,l
	pop	af
	ld	a,d
	pop	de
	ld	d,a
	pop	bc
;	genXor
	ld	a,d
	xor	a,e
	ld	e,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,c
	push	af
	inc	sp
;	genIpush
	ld	a,e
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	e,l
	pop	af
;	genAssign (pointer)
;	AOP_STK for _rsdecode__1_0
;	isBitvar = 0
	ld	l,-29(ix)
	ld	h,-28(ix)
	ld	(hl),e
;ecc/rslib.c:189: z[1] = gfmul (gfadd (gfmul (syn[2], syn[3]), gfmul (syn[1], syn[4])), gfinv (deter));
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
	ld	e,-29(ix)
	ld	d,-28(ix)
	inc	de
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
;	AOP_STK for _rsdecode_deter_1_1
	ld	a,-8(ix)
	push	af
	inc	sp
;	genCall
	call	_gfinv
	ld	c,l
	inc	sp
	pop	de
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
	ld	l,-38(ix)
	ld	h,-37(ix)
	ld	a,(hl)
	ld	-38(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-36(ix)
	ld	h,-35(ix)
	ld	b,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-38(ix)
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfmul
;	AOP_STK for _rsdecode__1_0
	ld	-38(ix),l
	pop	af
	pop	de
	pop	bc
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-32(ix)
	add	a,#0x04
	ld	l,a
	ld	a,-31(ix)
	adc	a,#0x00
	ld	h,a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	a,(hl)
	ld	-30(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-34(ix)
	ld	h,-33(ix)
	ld	b,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-30(ix)
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfmul
	ld	b,l
	pop	af
	pop	de
	ld	a,b
	pop	bc
	ld	b,a
;	genXor
;	AOP_STK for _rsdecode__1_0
	ld	a,-38(ix)
	xor	a,b
	ld	b,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	ld	a,c
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfmul
	ld	c,l
	pop	af
	pop	de
;	genAssign (pointer)
;	isBitvar = 0
	ld	a,c
	ld	(de),a
;ecc/rslib.c:190: z[2] = 1;
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
	ld	l,-29(ix)
	ld	h,-28(ix)
	inc	hl
	inc	hl
;	genAssign (pointer)
;	isBitvar = 0
	ld	(hl),#0x01
;ecc/rslib.c:191: z[3] = 0;
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-29(ix)
	add	a,#0x03
	ld	l,a
	ld	a,-28(ix)
	adc	a,#0x00
	ld	h,a
;	genAssign (pointer)
;	isBitvar = 0
	ld	(hl),#0x00
;ecc/rslib.c:193: polysolve(z, x, &sols);
;	genAddrOf
	ld	hl,#0x0013
	add	hl,sp
	ld	c,l
	ld	b,h
;	genAddrOf
;	AOP_STK for _rsdecode__1_0
	ld	hl,#0x0015
	add	hl,sp
	ld	-38(ix),l
	ld	-37(ix),h
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	push	bc
;	genIpush
;	AOP_STK for _rsdecode__1_0
	ld	l,-38(ix)
	ld	h,-37(ix)
	push	hl
;	genIpush
;	AOP_STK for _rsdecode__1_0
	ld	l,-29(ix)
	ld	h,-28(ix)
	push	hl
;	genCall
	call	_polysolve
	pop	af
	pop	af
	pop	af
	pop	de
;ecc/rslib.c:194: if (sols!=2) {
;	genCmpEq
;	AOP_STK for _rsdecode_sols_1_1
; genCmpEq: left 2, right 2, result 0
	ld	a,-25(ix)
	cp	a,#0x02
	jp	nz,00154$
	ld	a,-24(ix)
	or	a,a
	jp	z,00110$
00154$:
;ecc/rslib.c:195: *errcode=4;
;	genAssign (pointer)
;	AOP_STK for _rsdecode__1_0
;	isBitvar = 0
	ld	l,-27(ix)
	ld	h,-26(ix)
	ld	(hl),#0x04
	inc	hl
	ld	(hl),#0x00
;ecc/rslib.c:196: return;
;	genRet
	jp	00130$
;	genLabel
00110$:
;ecc/rslib.c:199: w0 = gfmul (z[0], syn[1]);
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-34(ix)
	ld	h,-33(ix)
	ld	c,(hl)
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-29(ix)
	ld	h,-28(ix)
	ld	b,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	ld	a,c
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfmul
	pop	af
	pop	de
;	genAssign
;	AOP_STK for _rsdecode_w0_1_1
	ld	-18(ix),l
;ecc/rslib.c:200: w1 = gfadd (gfmul (z[0], syn[2]), gfmul (z[1], syn[1]));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-36(ix)
	ld	h,-35(ix)
	ld	c,(hl)
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-29(ix)
	ld	h,-28(ix)
	ld	b,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	ld	a,c
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfmul
	ld	c,l
	pop	af
	pop	de
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
	ld	l,-34(ix)
	ld	h,-33(ix)
	ld	a,(hl)
	ld	-36(ix),a
;	genPointerGet
	ld	a,(de)
	ld	b,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-36(ix)
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfmul
	ld	b,l
	pop	af
	pop	de
	ld	a,b
	pop	bc
;	genXor
	ld	b,a
	xor	a,c
	ld	c,a
;	genAssign
;	AOP_STK for _rsdecode_w1_1_1
	ld	-19(ix),c
;ecc/rslib.c:201: n0 = 254 - v2e[gfinv (x[0])];
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-38(ix)
	ld	h,-37(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_gfinv
	inc	sp
	pop	de
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<_v2e
	add	a,l
	ld	l,a
	ld	a,#>_v2e
	adc	a,#0x00
	ld	h,a
;	genPointerGet
	ld	l,(hl)
;	genMinus
;	AOP_STK for _rsdecode_n0_1_1
	ld	a,#0xFE
	sub	a,l
	ld	-15(ix),a
;ecc/rslib.c:202: n1 = 254 - v2e[gfinv (x[1])];
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-38(ix)
	add	a,#0x01
	ld	-36(ix),a
	ld	a,-37(ix)
	adc	a,#0x00
	ld	-35(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-36(ix)
	ld	h,-35(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_gfinv
	inc	sp
	pop	de
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<_v2e
	add	a,l
	ld	l,a
	ld	a,#>_v2e
	adc	a,#0x00
	ld	h,a
;	genPointerGet
	ld	l,(hl)
;	genMinus
;	AOP_STK for _rsdecode_n1_1_1
	ld	a,#0xFE
	sub	a,l
	ld	-16(ix),a
;ecc/rslib.c:203: e0 = gfmul (gfadd (w0, gfmul (w1, x[0])), gfinv (z[1]));
;	genPointerGet
	ld	a,(de)
	ld	l,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_gfinv
	ld	c,l
	inc	sp
	pop	de
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-38(ix)
	ld	h,-37(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,l
	push	af
	inc	sp
;	genIpush
;	AOP_STK for _rsdecode_w1_1_1
	ld	a,-19(ix)
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	b,l
	pop	af
	pop	de
	ld	a,b
	pop	bc
	ld	b,a
;	genXor
;	AOP_STK for _rsdecode_w0_1_1
	ld	a,-18(ix)
	xor	a,b
	ld	b,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	ld	a,c
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfmul
	pop	af
	pop	de
;	genAssign
;	AOP_STK for _rsdecode_e0_1_1
	ld	-13(ix),l
;ecc/rslib.c:204: e1 = gfmul (gfadd (w0, gfmul (w1, x[1])), gfinv (z[1]));
;	genPointerGet
	ld	a,(de)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	l,a
	push	af
	inc	sp
;	genCall
	call	_gfinv
	ld	b,l
	inc	sp
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-36(ix)
	ld	h,-35(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genIpush
;	AOP_STK for _rsdecode_w1_1_1
	ld	a,-19(ix)
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	e,l
	pop	af
	pop	bc
;	genXor
;	AOP_STK for _rsdecode_w0_1_1
	ld	a,-18(ix)
	xor	a,e
	ld	e,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push    bc
	inc     sp
;	genIpush
	ld	a,e
	push	af
	inc	sp
;	genCall
	call	_gfmul
	pop	af
;	genAssign
;	AOP_STK for _rsdecode_e1_1_1
	ld	-14(ix),l
;ecc/rslib.c:206: if (n0 < 249)
;	genCmpLt
;	AOP_STK for _rsdecode_n0_1_1
	ld	a,-15(ix)
	sub	a,#0xF9
	jp	nc,00112$
;ecc/rslib.c:207: mesg[n0] = gfadd (mesg[n0], e0);
;	genPlus
;	AOP_STK for 
;	AOP_STK for _rsdecode_n0_1_1
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,6(ix)
	add	a,-15(ix)
	ld	e,a
	ld	a,7(ix)
	adc	a,#0x00
	ld	d,a
;	genPointerGet
	ld	a,(de)
	ld	b,a
;	genXor
;	AOP_STK for _rsdecode_e0_1_1
	ld	a,-13(ix)
	xor	a,b
;	genAssign (pointer)
;	isBitvar = 0
	ld	(de),a
;	genLabel
00112$:
;ecc/rslib.c:208: if (n1 < 249)
;	genCmpLt
;	AOP_STK for _rsdecode_n1_1_1
	ld	a,-16(ix)
	sub	a,#0xF9
	jp	nc,00114$
;ecc/rslib.c:209: mesg[n1] = gfadd (mesg[n1], e1);
;	genPlus
;	AOP_STK for 
;	AOP_STK for _rsdecode_n1_1_1
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,6(ix)
	add	a,-16(ix)
	ld	e,a
	ld	a,7(ix)
	adc	a,#0x00
	ld	d,a
;	genPointerGet
	ld	a,(de)
	ld	b,a
;	genXor
;	AOP_STK for _rsdecode_e1_1_1
	ld	a,-14(ix)
	xor	a,b
;	genAssign (pointer)
;	isBitvar = 0
	ld	(de),a
;	genLabel
00114$:
;ecc/rslib.c:210: return;
;	genRet
	jp	00130$
;ecc/rslib.c:214: z[3] = 1;
;	genLabel
00115$:
;	genAddrOf
;	AOP_STK for _rsdecode__1_0
	ld	hl,#0x0020
	add	hl,sp
	ld	-36(ix),l
	ld	-35(ix),h
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-36(ix)
	add	a,#0x03
	ld	l,a
	ld	a,-35(ix)
	adc	a,#0x00
	ld	h,a
;	genAssign (pointer)
;	isBitvar = 0
	ld	(hl),#0x01
;ecc/rslib.c:215: z[2] = gfmul (syn[1], gfmul (syn[4], syn[6]));
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-36(ix)
	add	a,#0x02
	ld	-38(ix),a
	ld	a,-35(ix)
	adc	a,#0x00
	ld	-37(ix),a
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-32(ix)
	add	a,#0x06
	ld	-29(ix),a
	ld	a,-31(ix)
	adc	a,#0x00
	ld	-28(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-29(ix)
	ld	h,-28(ix)
	ld	b,(hl)
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-32(ix)
	add	a,#0x04
	ld	-44(ix),a
	ld	a,-31(ix)
	adc	a,#0x00
	ld	-43(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-44(ix)
	ld	h,-43(ix)
	ld	c,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push    bc
	inc     sp
;	genIpush
	ld	a,c
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	c,l
	pop	af
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-32(ix)
	add	a,#0x01
	ld	-34(ix),a
	ld	a,-31(ix)
	adc	a,#0x00
	ld	-33(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-34(ix)
	ld	h,-33(ix)
	ld	b,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,c
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfmul
	ld	e,l
	pop	af
;	genAssign (pointer)
;	AOP_STK for _rsdecode__1_0
;	isBitvar = 0
	ld	l,-38(ix)
	ld	h,-37(ix)
	ld	(hl),e
;ecc/rslib.c:216: z[2] = gfadd (z[2], gfmul (syn[1], gfmul (syn[5], syn[5])));
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-32(ix)
	add	a,#0x05
	ld	-40(ix),a
	ld	a,-31(ix)
	adc	a,#0x00
	ld	-39(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-40(ix)
	ld	h,-39(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	ld	a,l
	push	af
	inc	sp
;	genIpush
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	c,l
	pop	af
	pop	de
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-34(ix)
	ld	h,-33(ix)
	ld	b,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	ld	a,c
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfmul
	ld	c,l
	pop	af
	pop	de
;	genXor
	ld	a,e
	xor	a,c
	ld	c,a
;	genAssign (pointer)
;	AOP_STK for _rsdecode__1_0
;	isBitvar = 0
	ld	l,-38(ix)
	ld	h,-37(ix)
	ld	(hl),c
;ecc/rslib.c:217: z[2] = gfadd (z[2], gfmul (syn[5], gfmul (syn[3], syn[3])));
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-32(ix)
	add	a,#0x03
	ld	-42(ix),a
	ld	a,-31(ix)
	adc	a,#0x00
	ld	-41(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-42(ix)
	ld	h,-41(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genIpush
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	e,l
	pop	af
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-40(ix)
	ld	h,-39(ix)
	ld	b,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,e
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfmul
	ld	b,l
	pop	af
	ld	a,b
	pop	bc
;	genXor
	ld	b,a
	xor	a,c
	ld	c,a
;	genAssign (pointer)
;	AOP_STK for _rsdecode__1_0
;	isBitvar = 0
	ld	l,-38(ix)
	ld	h,-37(ix)
	ld	(hl),c
;ecc/rslib.c:218: z[2] = gfadd (z[2], gfmul (syn[3], gfmul (syn[4], syn[4])));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-44(ix)
	ld	h,-43(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genIpush
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	e,l
	pop	af
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-42(ix)
	ld	h,-41(ix)
	ld	b,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,e
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfmul
	ld	b,l
	pop	af
	ld	a,b
	pop	bc
;	genXor
	ld	b,a
	xor	a,c
	ld	c,a
;	genAssign (pointer)
;	AOP_STK for _rsdecode__1_0
;	isBitvar = 0
	ld	l,-38(ix)
	ld	h,-37(ix)
	ld	(hl),c
;ecc/rslib.c:219: z[2] = gfadd (z[2], gfmul (syn[2], gfmul (syn[5], syn[4])));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-44(ix)
	ld	h,-43(ix)
	ld	e,(hl)
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-40(ix)
	ld	h,-39(ix)
	ld	b,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,e
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfmul
	ld	e,l
	pop	af
	pop	bc
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-32(ix)
	add	a,#0x02
	ld	-32(ix),a
	ld	a,-31(ix)
	adc	a,#0x00
	ld	-31(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-32(ix)
	ld	h,-31(ix)
	ld	b,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,e
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfmul
	ld	b,l
	pop	af
	ld	a,b
	pop	bc
;	genXor
	ld	b,a
	xor	a,c
	ld	c,a
;	genAssign (pointer)
;	AOP_STK for _rsdecode__1_0
;	isBitvar = 0
	ld	l,-38(ix)
	ld	h,-37(ix)
	ld	(hl),c
;ecc/rslib.c:220: z[2] = gfadd (z[2], gfmul (syn[2], gfmul (syn[3], syn[6])));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-29(ix)
	ld	h,-28(ix)
	ld	e,(hl)
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-42(ix)
	ld	h,-41(ix)
	ld	b,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,e
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfmul
	ld	e,l
	pop	af
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-32(ix)
	ld	h,-31(ix)
	ld	b,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,e
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfmul
	ld	b,l
	pop	af
	ld	a,b
	pop	bc
;	genXor
	ld	b,a
	xor	a,c
	ld	c,a
;	genAssign (pointer)
;	AOP_STK for _rsdecode__1_0
;	isBitvar = 0
	ld	l,-38(ix)
	ld	h,-37(ix)
	ld	(hl),c
;ecc/rslib.c:221: z[2] = gfmul (z[2], gfinv (deter));
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
;	AOP_STK for _rsdecode_deter_1_1
	ld	a,-8(ix)
	push	af
	inc	sp
;	genCall
	call	_gfinv
	inc	sp
	pop	bc
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
	call	_gfmul
	ld	c,l
	pop	af
;	genAssign (pointer)
;	AOP_STK for _rsdecode__1_0
;	isBitvar = 0
	ld	l,-38(ix)
	ld	h,-37(ix)
	ld	(hl),c
;ecc/rslib.c:223: z[1] = gfmul (syn[1], gfmul (syn[3], syn[6]));
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
	ld	c,-36(ix)
	ld	b,-35(ix)
	inc	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-29(ix)
	ld	h,-28(ix)
	ld	e,(hl)
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-42(ix)
	ld	h,-41(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,e
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	e,l
	pop	af
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-34(ix)
	ld	h,-33(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,e
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	e,l
	pop	af
	pop	bc
;	genAssign (pointer)
;	isBitvar = 0
	ld	a,e
	ld	(bc),a
;ecc/rslib.c:224: z[1] = gfadd (z[1], gfmul (syn[1], gfmul (syn[5], syn[4])));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
	ld	l,-44(ix)
	ld	h,-43(ix)
	ld	a,(hl)
	ld	-30(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-40(ix)
	ld	h,-39(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-30(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
;	AOP_STK for _rsdecode__1_0
	ld	-30(ix),l
	pop	af
	pop	de
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-34(ix)
	ld	h,-33(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-30(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	d,l
	pop	af
	ld	a,d
	pop	de
	ld	d,a
	pop	bc
;	genXor
	ld	a,d
	xor	a,e
;	genAssign (pointer)
;	isBitvar = 0
	ld	e,a
	ld	(bc),a
;ecc/rslib.c:225: z[1] = gfadd (z[1], gfmul (syn[4], gfmul (syn[3], syn[3])));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-42(ix)
	ld	h,-41(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,l
	push	af
	inc	sp
;	genIpush
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_gfmul
;	AOP_STK for _rsdecode__1_0
	ld	-30(ix),l
	pop	af
	pop	de
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-44(ix)
	ld	h,-43(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-30(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	d,l
	pop	af
	ld	a,d
	pop	de
	ld	d,a
	pop	bc
;	genXor
	ld	a,d
	xor	a,e
;	genAssign (pointer)
;	isBitvar = 0
	ld	e,a
	ld	(bc),a
;ecc/rslib.c:226: z[1] = gfadd (z[1], gfmul (syn[2], gfmul (syn[4], syn[4])));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-44(ix)
	ld	h,-43(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,l
	push	af
	inc	sp
;	genIpush
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_gfmul
;	AOP_STK for _rsdecode__1_0
	ld	-30(ix),l
	pop	af
	pop	de
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-32(ix)
	ld	h,-31(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-30(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	d,l
	pop	af
	ld	a,d
	pop	de
	ld	d,a
	pop	bc
;	genXor
	ld	a,d
	xor	a,e
;	genAssign (pointer)
;	isBitvar = 0
	ld	e,a
	ld	(bc),a
;ecc/rslib.c:227: z[1] = gfadd (z[1], gfmul (syn[2], gfmul (syn[3], syn[5])));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
	ld	l,-40(ix)
	ld	h,-39(ix)
	ld	a,(hl)
	ld	-30(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-42(ix)
	ld	h,-41(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-30(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
;	AOP_STK for _rsdecode__1_0
	ld	-30(ix),l
	pop	af
	pop	de
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-32(ix)
	ld	h,-31(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-30(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	d,l
	pop	af
	ld	a,d
	pop	de
	ld	d,a
	pop	bc
;	genXor
	ld	a,d
	xor	a,e
;	genAssign (pointer)
;	isBitvar = 0
	ld	e,a
	ld	(bc),a
;ecc/rslib.c:228: z[1] = gfadd (z[1], gfmul (syn[2], gfmul (syn[2], syn[6])));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
	ld	l,-29(ix)
	ld	h,-28(ix)
	ld	a,(hl)
	ld	-30(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-32(ix)
	ld	h,-31(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-30(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
;	AOP_STK for _rsdecode__1_0
	ld	-30(ix),l
	pop	af
	pop	de
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-32(ix)
	ld	h,-31(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-30(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	d,l
	pop	af
	ld	a,d
	pop	de
	ld	d,a
	pop	bc
;	genXor
	ld	a,d
	xor	a,e
;	genAssign (pointer)
;	isBitvar = 0
	ld	e,a
	ld	(bc),a
;ecc/rslib.c:229: z[1] = gfmul (z[1], gfinv (deter));
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode_deter_1_1
	ld	a,-8(ix)
	push	af
	inc	sp
;	genCall
	call	_gfinv
	inc	sp
	pop	de
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genIpush
	ld	a,e
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	e,l
	pop	af
	pop	bc
;	genAssign (pointer)
;	isBitvar = 0
	ld	a,e
	ld	(bc),a
;ecc/rslib.c:231: z[0] = gfmul (syn[2], gfmul (syn[3], syn[4]));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-44(ix)
	ld	h,-43(ix)
	ld	e,(hl)
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-42(ix)
	ld	h,-41(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,e
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	e,l
	pop	af
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-32(ix)
	ld	h,-31(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,e
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	e,l
	pop	af
	pop	bc
;	genAssign (pointer)
;	AOP_STK for _rsdecode__1_0
;	isBitvar = 0
	ld	l,-36(ix)
	ld	h,-35(ix)
	ld	(hl),e
;ecc/rslib.c:232: z[0] = gfadd (z[0], gfmul (syn[3], gfmul (syn[2], syn[4])));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
	ld	l,-44(ix)
	ld	h,-43(ix)
	ld	a,(hl)
	ld	-30(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-32(ix)
	ld	h,-31(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-30(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
;	AOP_STK for _rsdecode__1_0
	ld	-30(ix),l
	pop	af
	pop	de
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-42(ix)
	ld	h,-41(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-30(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	d,l
	pop	af
	ld	a,d
	pop	de
	ld	d,a
	pop	bc
;	genXor
	ld	a,d
	xor	a,e
	ld	e,a
;	genAssign (pointer)
;	AOP_STK for _rsdecode__1_0
;	isBitvar = 0
	ld	l,-36(ix)
	ld	h,-35(ix)
	ld	(hl),e
;ecc/rslib.c:233: z[0] = gfadd (z[0], gfmul (syn[3], gfmul (syn[5], syn[1])));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
	ld	l,-34(ix)
	ld	h,-33(ix)
	ld	a,(hl)
	ld	-30(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-40(ix)
	ld	h,-39(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-30(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
;	AOP_STK for _rsdecode__1_0
	ld	-30(ix),l
	pop	af
	pop	de
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-42(ix)
	ld	h,-41(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-30(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	d,l
	pop	af
	ld	a,d
	pop	de
	ld	d,a
	pop	bc
;	genXor
	ld	a,d
	xor	a,e
	ld	e,a
;	genAssign (pointer)
;	AOP_STK for _rsdecode__1_0
;	isBitvar = 0
	ld	l,-36(ix)
	ld	h,-35(ix)
	ld	(hl),e
;ecc/rslib.c:234: z[0] = gfadd (z[0], gfmul (syn[4], gfmul (syn[4], syn[1])));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
	ld	l,-34(ix)
	ld	h,-33(ix)
	ld	a,(hl)
	ld	-30(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-44(ix)
	ld	h,-43(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-30(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
;	AOP_STK for _rsdecode__1_0
	ld	-30(ix),l
	pop	af
	pop	de
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-44(ix)
	ld	h,-43(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-30(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	d,l
	pop	af
	ld	a,d
	pop	de
	ld	d,a
	pop	bc
;	genXor
	ld	a,d
	xor	a,e
	ld	e,a
;	genAssign (pointer)
;	AOP_STK for _rsdecode__1_0
;	isBitvar = 0
	ld	l,-36(ix)
	ld	h,-35(ix)
	ld	(hl),e
;ecc/rslib.c:235: z[0] = gfadd (z[0], gfmul (syn[3], gfmul (syn[3], syn[3])));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-42(ix)
	ld	h,-41(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,l
	push	af
	inc	sp
;	genIpush
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_gfmul
;	AOP_STK for _rsdecode__1_0
	ld	-44(ix),l
	pop	af
	pop	de
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-42(ix)
	ld	h,-41(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-44(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	d,l
	pop	af
	ld	a,d
	pop	de
	ld	d,a
	pop	bc
;	genXor
	ld	a,d
	xor	a,e
	ld	e,a
;	genAssign (pointer)
;	AOP_STK for _rsdecode__1_0
;	isBitvar = 0
	ld	l,-36(ix)
	ld	h,-35(ix)
	ld	(hl),e
;ecc/rslib.c:236: z[0] = gfadd (z[0], gfmul (syn[2], gfmul (syn[2], syn[5])));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
	ld	l,-40(ix)
	ld	h,-39(ix)
	ld	a,(hl)
	ld	-44(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-32(ix)
	ld	h,-31(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-44(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
;	AOP_STK for _rsdecode__1_0
	ld	-44(ix),l
	pop	af
	pop	de
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-32(ix)
	ld	h,-31(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-44(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	d,l
	pop	af
	ld	a,d
	pop	de
	ld	d,a
	pop	bc
;	genXor
	ld	a,d
	xor	a,e
	ld	e,a
;	genAssign (pointer)
;	AOP_STK for _rsdecode__1_0
;	isBitvar = 0
	ld	l,-36(ix)
	ld	h,-35(ix)
	ld	(hl),e
;ecc/rslib.c:237: z[0] = gfmul (z[0], gfinv (deter));
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode_deter_1_1
	ld	a,-8(ix)
	push	af
	inc	sp
;	genCall
	call	_gfinv
	inc	sp
	pop	de
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genIpush
	ld	a,e
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	e,l
	pop	af
	pop	bc
;	genAssign (pointer)
;	AOP_STK for _rsdecode__1_0
;	isBitvar = 0
	ld	l,-36(ix)
	ld	h,-35(ix)
	ld	(hl),e
;ecc/rslib.c:239: polysolve (z, x, &sols);
;	genAddrOf
	ld	hl,#0x0013
	add	hl,sp
	ld	e,l
	ld	d,h
;	genAddrOf
;	AOP_STK for _rsdecode__1_0
	ld	hl,#0x0015
	add	hl,sp
	ld	-44(ix),l
	ld	-43(ix),h
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	genIpush
;	AOP_STK for _rsdecode__1_0
	ld	l,-44(ix)
	ld	h,-43(ix)
	push	hl
;	genIpush
;	AOP_STK for _rsdecode__1_0
	ld	l,-36(ix)
	ld	h,-35(ix)
	push	hl
;	genCall
	call	_polysolve
	pop	af
	pop	af
	pop	af
	pop	bc
;ecc/rslib.c:240: if (sols != 3)
;	genCmpEq
;	AOP_STK for _rsdecode_sols_1_1
; genCmpEq: left 2, right 2, result 0
	ld	a,-25(ix)
	cp	a,#0x03
	jp	nz,00155$
	ld	a,-24(ix)
	or	a,a
	jp	z,00117$
00155$:
;ecc/rslib.c:242: *errcode = 4;
;	genAssign (pointer)
;	AOP_STK for _rsdecode__1_0
;	isBitvar = 0
	ld	l,-27(ix)
	ld	h,-26(ix)
	ld	(hl),#0x04
	inc	hl
	ld	(hl),#0x00
;ecc/rslib.c:243: return;
;	genRet
	jp	00130$
;	genLabel
00117$:
;ecc/rslib.c:246: w0 = gfmul (z[0], syn[1]);
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-34(ix)
	ld	h,-33(ix)
	ld	e,(hl)
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-36(ix)
	ld	h,-35(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,e
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	pop	af
	pop	bc
;	genAssign
;	AOP_STK for _rsdecode_w0_1_1
	ld	-18(ix),l
;ecc/rslib.c:247: w1 = gfadd (gfmul (z[0], syn[2]), gfmul (z[1], syn[1]));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-32(ix)
	ld	h,-31(ix)
	ld	e,(hl)
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-36(ix)
	ld	h,-35(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,e
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	e,l
	pop	af
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
	ld	l,-34(ix)
	ld	h,-33(ix)
	ld	a,(hl)
	ld	-40(ix),a
;	genPointerGet
	ld	a,(bc)
	ld	d,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-40(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	d,l
	pop	af
	ld	a,d
	pop	de
	ld	d,a
	pop	bc
;	genXor
	ld	a,d
	xor	a,e
	ld	e,a
;	genAssign
;	AOP_STK for _rsdecode_w1_1_1
	ld	-19(ix),e
;ecc/rslib.c:248: w2 = gfadd (gfmul (z[0], syn[3]), gfadd (gfmul (z[1], syn[2]), gfmul (z[2], syn[1])));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-42(ix)
	ld	h,-41(ix)
	ld	e,(hl)
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-36(ix)
	ld	h,-35(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,e
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	e,l
	pop	af
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
	ld	l,-32(ix)
	ld	h,-31(ix)
	ld	a,(hl)
	ld	-42(ix),a
;	genPointerGet
	ld	a,(bc)
	ld	d,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-42(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
;	AOP_STK for _rsdecode__1_0
	ld	-42(ix),l
	pop	af
	pop	de
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
	ld	l,-34(ix)
	ld	h,-33(ix)
	ld	a,(hl)
	ld	-40(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-38(ix)
	ld	h,-37(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _rsdecode__1_0
	ld	a,-40(ix)
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfmul
	ld	d,l
	pop	af
	ld	a,d
	pop	de
	ld	d,a
	pop	bc
;	genXor
;	AOP_STK for _rsdecode__1_0
	ld	a,-42(ix)
	xor	a,d
;	genXor
	ld	d,a
	xor	a,e
	ld	e,a
;	genAssign
;	AOP_STK for _rsdecode_w2_1_1
	ld	-20(ix),e
;ecc/rslib.c:250: n0 = 254 - v2e[gfinv (x[0])];
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-44(ix)
	ld	h,-43(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_gfinv
	inc	sp
	pop	bc
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<_v2e
	add	a,l
	ld	l,a
	ld	a,#>_v2e
	adc	a,#0x00
	ld	h,a
;	genPointerGet
	ld	l,(hl)
;	genMinus
;	AOP_STK for _rsdecode_n0_1_1
	ld	a,#0xFE
	sub	a,l
	ld	-15(ix),a
;ecc/rslib.c:251: n1 = 254 - v2e[gfinv (x[1])];
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-44(ix)
	add	a,#0x01
	ld	-42(ix),a
	ld	a,-43(ix)
	adc	a,#0x00
	ld	-41(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-42(ix)
	ld	h,-41(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_gfinv
	inc	sp
	pop	bc
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<_v2e
	add	a,l
	ld	l,a
	ld	a,#>_v2e
	adc	a,#0x00
	ld	h,a
;	genPointerGet
	ld	l,(hl)
;	genMinus
;	AOP_STK for _rsdecode_n1_1_1
	ld	a,#0xFE
	sub	a,l
	ld	-16(ix),a
;ecc/rslib.c:252: n2 = 254 - v2e[gfinv (x[2])];
;	genPlus
;	AOP_STK for _rsdecode__1_0
;	AOP_STK for _rsdecode__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-44(ix)
	add	a,#0x02
	ld	-40(ix),a
	ld	a,-43(ix)
	adc	a,#0x00
	ld	-39(ix),a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-40(ix)
	ld	h,-39(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_gfinv
	inc	sp
	pop	bc
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<_v2e
	add	a,l
	ld	l,a
	ld	a,#>_v2e
	adc	a,#0x00
	ld	h,a
;	genPointerGet
	ld	l,(hl)
;	genMinus
;	AOP_STK for _rsdecode_n2_1_1
	ld	a,#0xFE
	sub	a,l
	ld	-17(ix),a
;ecc/rslib.c:254: e0 = gfadd (w0, gfadd (gfmul (w1, x[0]), gfmul (w2, gfexp (x[0], 2))));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-44(ix)
	ld	h,-43(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genIpush
;	AOP_STK for _rsdecode_w1_1_1
	ld	a,-19(ix)
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	e,l
	pop	af
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-44(ix)
	ld	h,-43(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,#0x02
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfexp
	pop	af
	pop	de
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,l
	push	af
	inc	sp
;	genIpush
;	AOP_STK for _rsdecode_w2_1_1
	ld	a,-20(ix)
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	d,l
	pop	af
	ld	a,d
	pop	de
	ld	d,a
	pop	bc
;	genXor
	ld	a,d
	xor	a,e
	ld	e,a
;	genXor
;	AOP_STK for _rsdecode_w0_1_1
	ld	a,-18(ix)
	xor	a,e
	ld	e,a
;	genAssign
;	AOP_STK for _rsdecode_e0_1_1
	ld	-13(ix),e
;ecc/rslib.c:255: e0 = gfmul (e0, gfinv (gfadd (z[1], gfexp (x[0], 2))));
;	genPointerGet
	ld	a,(bc)
	ld	e,a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-44(ix)
	ld	h,-43(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,#0x02
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfexp
	ld	d,l
	pop	af
	ld	a,d
	pop	de
	ld	d,a
	pop	bc
;	genXor
	ld	a,d
	xor	a,e
	ld	e,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,e
	push	af
	inc	sp
;	genCall
	call	_gfinv
	inc	sp
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genIpush
;	AOP_STK for _rsdecode_e0_1_1
	ld	a,-13(ix)
	push	af
	inc	sp
;	genCall
	call	_gfmul
	pop	af
	pop	bc
;	genAssign
;	AOP_STK for _rsdecode_e0_1_1
	ld	-13(ix),l
;ecc/rslib.c:256: e1 = gfadd (w0, gfadd (gfmul (w1, x[1]), gfmul (w2, gfexp (x[1], 2))));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-42(ix)
	ld	h,-41(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genIpush
;	AOP_STK for _rsdecode_w1_1_1
	ld	a,-19(ix)
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	e,l
	pop	af
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-42(ix)
	ld	h,-41(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,#0x02
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfexp
	pop	af
	pop	de
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,l
	push	af
	inc	sp
;	genIpush
;	AOP_STK for _rsdecode_w2_1_1
	ld	a,-20(ix)
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	d,l
	pop	af
	ld	a,d
	pop	de
	ld	d,a
	pop	bc
;	genXor
	ld	a,d
	xor	a,e
	ld	e,a
;	genXor
;	AOP_STK for _rsdecode_w0_1_1
	ld	a,-18(ix)
	xor	a,e
	ld	e,a
;	genAssign
;	AOP_STK for _rsdecode_e1_1_1
	ld	-14(ix),e
;ecc/rslib.c:257: e1 = gfmul (e1, gfinv (gfadd (z[1], gfexp (x[1], 2))));
;	genPointerGet
	ld	a,(bc)
	ld	e,a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-42(ix)
	ld	h,-41(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,#0x02
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfexp
	ld	d,l
	pop	af
	ld	a,d
	pop	de
	ld	d,a
	pop	bc
;	genXor
	ld	a,d
	xor	a,e
	ld	e,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,e
	push	af
	inc	sp
;	genCall
	call	_gfinv
	inc	sp
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genIpush
;	AOP_STK for _rsdecode_e1_1_1
	ld	a,-14(ix)
	push	af
	inc	sp
;	genCall
	call	_gfmul
	pop	af
	pop	bc
;	genAssign
;	AOP_STK for _rsdecode_e1_1_1
	ld	-14(ix),l
;ecc/rslib.c:258: e2 = gfadd (w0, gfadd (gfmul (w1, x[2]), gfmul (w2, gfexp (x[2], 2))));
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-40(ix)
	ld	h,-39(ix)
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genIpush
;	AOP_STK for _rsdecode_w1_1_1
	ld	a,-19(ix)
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	e,l
	pop	af
	pop	bc
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-40(ix)
	ld	h,-39(ix)
	ld	d,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,#0x02
	push	af
	inc	sp
;	genIpush
	push    de
	inc     sp
;	genCall
	call	_gfexp
	pop	af
	pop	de
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,l
	push	af
	inc	sp
;	genIpush
;	AOP_STK for _rsdecode_w2_1_1
	ld	a,-20(ix)
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	d,l
	pop	af
	ld	a,d
	pop	de
	ld	d,a
	pop	bc
;	genXor
	ld	a,d
	xor	a,e
	ld	e,a
;	genXor
;	AOP_STK for _rsdecode_w0_1_1
	ld	a,-18(ix)
	xor	a,e
	ld	e,a
;	genAssign
;	(registers are the same)
;ecc/rslib.c:259: e2 = gfmul (e2, gfinv (gfadd (z[1], gfexp (x[2], 2))));
;	genPointerGet
	ld	a,(bc)
	ld	c,a
;	genPointerGet
;	AOP_STK for _rsdecode__1_0
	ld	l,-40(ix)
	ld	h,-39(ix)
	ld	b,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,#0x02
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	_gfexp
	ld	b,l
	pop	af
	pop	de
	ld	a,b
	pop	bc
;	genXor
	ld	b,a
	xor	a,c
	ld	c,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	ld	a,c
	push	af
	inc	sp
;	genCall
	call	_gfinv
	inc	sp
	pop	de
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	ld	a,l
	push	af
	inc	sp
;	genIpush
	ld	a,e
	push	af
	inc	sp
;	genCall
	call	_gfmul
	pop	af
	pop	de
;	genAssign
	ld	e,l
;ecc/rslib.c:261: if (n0 < 249)
;	genCmpLt
;	AOP_STK for _rsdecode_n0_1_1
	ld	a,-15(ix)
	sub	a,#0xF9
	jp	nc,00119$
;ecc/rslib.c:262: mesg[n0] = gfadd (mesg[n0], e0);
;	genPlus
;	AOP_STK for 
;	AOP_STK for _rsdecode_n0_1_1
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,6(ix)
	add	a,-15(ix)
	ld	c,a
	ld	a,7(ix)
	adc	a,#0x00
	ld	b,a
;	genPointerGet
	ld	a,(bc)
	ld	d,a
;	genXor
;	AOP_STK for _rsdecode_e0_1_1
	ld	a,-13(ix)
	xor	a,d
;	genAssign (pointer)
;	isBitvar = 0
	ld	(bc),a
;	genLabel
00119$:
;ecc/rslib.c:263: if (n1 < 249)
;	genCmpLt
;	AOP_STK for _rsdecode_n1_1_1
	ld	a,-16(ix)
	sub	a,#0xF9
	jp	nc,00121$
;ecc/rslib.c:264: mesg[n1] = gfadd (mesg[n1], e1);
;	genPlus
;	AOP_STK for 
;	AOP_STK for _rsdecode_n1_1_1
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,6(ix)
	add	a,-16(ix)
	ld	c,a
	ld	a,7(ix)
	adc	a,#0x00
	ld	b,a
;	genPointerGet
	ld	a,(bc)
	ld	d,a
;	genXor
;	AOP_STK for _rsdecode_e1_1_1
	ld	a,-14(ix)
	xor	a,d
;	genAssign (pointer)
;	isBitvar = 0
	ld	(bc),a
;	genLabel
00121$:
;ecc/rslib.c:265: if (n2 < 249)
;	genCmpLt
;	AOP_STK for _rsdecode_n2_1_1
	ld	a,-17(ix)
	sub	a,#0xF9
	jp	nc,00123$
;ecc/rslib.c:266: mesg[n2] = gfadd (mesg[n2], e2);
;	genPlus
;	AOP_STK for 
;	AOP_STK for _rsdecode_n2_1_1
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,6(ix)
	add	a,-17(ix)
	ld	c,a
	ld	a,7(ix)
	adc	a,#0x00
	ld	b,a
;	genPointerGet
	ld	a,(bc)
	ld	d,a
;	genXor
	ld	a,e
	xor	a,d
;	genAssign (pointer)
;	isBitvar = 0
	ld	(bc),a
;	genLabel
00123$:
;ecc/rslib.c:268: return;
;	genRet
	jp	00130$
;ecc/rslib.c:272: *errcode = 4;
;	genLabel
00124$:
;	genAssign (pointer)
;	AOP_STK for _rsdecode__1_0
;	isBitvar = 0
	ld	l,-27(ix)
	ld	h,-26(ix)
	ld	(hl),#0x04
	inc	hl
	ld	(hl),#0x00
;ecc/rslib.c:273: return;
;	genRet
;ecc/rslib.c:275: }
;	genLabel
00130$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
_rsdecode_end::
;ecc/rslib.c:284: void polysolve (unsigned char polynom[4], unsigned char roots[3], int* numsol)
;	genLabel
;	genFunction
;	---------------------------------
; Function polysolve
; ---------------------------------
_polysolve_start::
_polysolve:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-13
	add	hl,sp
	ld	sp,hl
;ecc/rslib.c:290: *numsol = 0;
;	genAssign
;	AOP_STK for 
;	AOP_STK for _polysolve__1_0
	ld	a,8(ix)
	ld	-9(ix),a
	ld	a,9(ix)
	ld	-8(ix),a
;	genAssign (pointer)
;	AOP_STK for _polysolve__1_0
;	isBitvar = 0
	ld	l,-9(ix)
	ld	h,-8(ix)
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;ecc/rslib.c:292: for (i = 0; i < 255; i++)
;	genAssign
;	AOP_STK for _polysolve_i_1_1
	ld	-2(ix),#0x00
	ld	-1(ix),#0x00
;	genLabel
00107$:
;	genAssign
;	AOP_STK for _polysolve_i_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
;	genCmpLt
	ld	a,l
	sub	a,#0xFF
	ld	a,h
	sbc	a,#0x00
	jp	nc,00111$
;ecc/rslib.c:294: y = 0;
;	genAssign
;	AOP_STK for _polysolve_y_1_1
	ld	-5(ix),#0x00
;ecc/rslib.c:295: for (j = 0; j < 4; j++)
;	genPlus
;	AOP_STK for _polysolve_i_1_1
;	AOP_STK for _polysolve__1_0
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<_e2v
	add	a,-2(ix)
	ld	-7(ix),a
	ld	a,#>_e2v
	adc	a,-1(ix)
	ld	-6(ix),a
;	genAssign
;	AOP_STK for _polysolve_j_1_1
	ld	-4(ix),#0x00
	ld	-3(ix),#0x00
;	genLabel
00103$:
;	genCmpLt
;	AOP_STK for _polysolve_j_1_1
	ld	a,-4(ix)
	sub	a,#0x04
	ld	a,-3(ix)
	sbc	a,#0x00
	rlca
;	genIfx
	and     a,#0x01
	jp	z,00106$
;ecc/rslib.c:296: y = gfadd (y, gfmul (polynom[j], gfexp (e2v[i], j)));
;	genCast
;	AOP_STK for _polysolve_j_1_1
;	AOP_STK for _polysolve__1_0
	ld	a,-4(ix)
	ld	-13(ix),a
;	genPointerGet
;	AOP_STK for _polysolve__1_0
;	AOP_STK for _polysolve__1_0
	ld	l,-7(ix)
	ld	h,-6(ix)
	ld	a,(hl)
	ld	-11(ix),a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
;	AOP_STK for _polysolve__1_0
	ld	a,-13(ix)
	push	af
	inc	sp
;	genIpush
;	AOP_STK for _polysolve__1_0
	ld	a,-11(ix)
	push	af
	inc	sp
;	genCall
	call	_gfexp
;	AOP_STK for _polysolve__1_0
	ld	-10(ix),l
	pop	af
;	genPlus
;	AOP_STK for 
;	AOP_STK for _polysolve_j_1_1
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,4(ix)
	add	a,-4(ix)
	ld	d,a
	ld	a,5(ix)
	adc	a,-3(ix)
	ld	e,a
;	genPointerGet
;	AOP_STK for _polysolve__1_0
	ld	l,d
	ld	h,e
	ld	a,(hl)
	ld	-12(ix),a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
;	AOP_STK for _polysolve__1_0
	ld	a,-10(ix)
	push	af
	inc	sp
;	genIpush
;	AOP_STK for _polysolve__1_0
	ld	a,-12(ix)
	push	af
	inc	sp
;	genCall
	call	_gfmul
	ld	b,l
	pop	af
	pop	de
;	genXor
;	AOP_STK for _polysolve_y_1_1
	ld	a,b
	xor	a,-5(ix)
	ld	c,a
;	genAssign
;	AOP_STK for _polysolve_y_1_1
	ld	-5(ix),c
;ecc/rslib.c:295: for (j = 0; j < 4; j++)
;	genPlus
;	AOP_STK for _polysolve_j_1_1
;	genPlusIncr
	inc	-4(ix)
	jp	nz,00118$
	inc	-3(ix)
00118$:
;	genGoto
	jp	00103$
;	genLabel
00106$:
;ecc/rslib.c:297: if (y == 0)
;	genCmpEq
;	AOP_STK for _polysolve_y_1_1
; genCmpEq: left 1, right 1, result 0
	ld	a,-5(ix)
	or	a,a
	jp	z,00120$
00119$:
	jp	00109$
00120$:
;ecc/rslib.c:299: roots[*numsol] = e2v[i];
;	genPointerGet
;	AOP_STK for _polysolve__1_0
	ld	l,-9(ix)
	ld	h,-8(ix)
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
;	genPlus
;	AOP_STK for 
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,6(ix)
	add	a,c
	ld	e,a
	ld	a,7(ix)
	adc	a,b
	ld	d,a
;	genPointerGet
;	AOP_STK for _polysolve__1_0
	ld	l,-7(ix)
	ld	h,-6(ix)
	ld	a,(hl)
;	genAssign (pointer)
;	isBitvar = 0
	ld	(de),a
;ecc/rslib.c:300: *numsol = *numsol + 1;
;	genPlus
;	genPlusIncr
	inc	bc
;	genAssign (pointer)
;	AOP_STK for _polysolve__1_0
;	isBitvar = 0
	ld	l,-9(ix)
	ld	h,-8(ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
;	genLabel
00109$:
;ecc/rslib.c:292: for (i = 0; i < 255; i++)
;	genPlus
;	AOP_STK for _polysolve_i_1_1
;	genPlusIncr
	inc	-2(ix)
	jp	nz,00121$
	inc	-1(ix)
00121$:
;	genGoto
	jp	00107$
;	genLabel
00111$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
_polysolve_end::
	.area _CODE
