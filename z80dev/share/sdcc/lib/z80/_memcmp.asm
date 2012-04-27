;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:24 2003

;--------------------------------------------------------
	.module _memcmp
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memcmp
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
;_memcmp.c:26: int memcmp (
;	genLabel
;	genFunction
;	---------------------------------
; Function memcmp
; ---------------------------------
_memcmp_start::
_memcmp:
	push	ix
	ld	ix,#0
	add	ix,sp
;_memcmp.c:32: if (!count)
;	genIfx
;	AOP_STK for 
	ld	a,8(ix)
	or	a,9(ix)
	jp	nz,00104$
;_memcmp.c:33: return(0);
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 2
	ld	hl,#0x0000
	jp	00107$
;_memcmp.c:35: while ( --count && *((char *)buf1) == *((char *)buf2) ) {
;	genLabel
00104$:
;	genMinus
;	AOP_STK for 
	ld	l,8(ix)
	ld	h,9(ix)
	dec	hl
;	genAssign
;	AOP_STK for 
	ld	8(ix),l
	ld	9(ix),h
;	genIfx
	ld	a,l
	or	a,h
	jp	z,00106$
;	genAssign
;	AOP_STK for 
	ld	c,4(ix)
	ld	b,5(ix)
;	genPointerGet
	ld	a,(bc)
	ld	e,a
;	genAssign
;	AOP_STK for 
	ld	l,6(ix)
	ld	h,7(ix)
;	genPointerGet
	ld	d,(hl)
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	a,e
	cp	d
	jp	z,00114$
00113$:
	jp	00106$
00114$:
;_memcmp.c:36: buf1 = (char *)buf1 + 1;
;	genAssign
;	(registers are the same)
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
;_memcmp.c:37: buf2 = (char *)buf2 + 1;
;	genAssign
;	genPlus
;	AOP_STK for 
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,l
	add	a,#0x01
	ld	6(ix),a
	ld	a,h
	adc	a,#0x00
	ld	7(ix),a
;	genGoto
	jp	00104$
;	genLabel
00106$:
;_memcmp.c:40: return( *((unsigned char *)buf1) - *((unsigned char *)buf2) );
;	genAssign
;	AOP_STK for 
	ld	l,4(ix)
	ld	h,5(ix)
;	genPointerGet
	ld	l,(hl)
;	genCast
	ld	c,l
	ld	b,#0x00
;	genAssign
;	AOP_STK for 
	ld	l,6(ix)
	ld	h,7(ix)
;	genPointerGet
	ld	l,(hl)
;	genCast
; Removed redundent load
	ld	h,#0x00
;	genMinus
	ld	a,c
	sub	a,l
	ld	l,a
	ld	a,b
	sbc	a,h
	ld	h,a
;	genRet
; Dump of IC_LEFT: type AOP_STR size 2
;	genLabel
00107$:
;	genEndFunction
	pop	ix
	ret
_memcmp_end::
	.area _CODE
