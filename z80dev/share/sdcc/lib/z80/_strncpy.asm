;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:25 2003

;--------------------------------------------------------
	.module _strncpy
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strncpy
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
;_strncpy.c:26: char *strncpy (
;	genLabel
;	genFunction
;	---------------------------------
; Function strncpy
; ---------------------------------
_strncpy_start::
_strncpy:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-2
	add	hl,sp
	ld	sp,hl
;_strncpy.c:31: register char * d1 =  d;
;	genAssign
;	AOP_STK for 
;	AOP_STK for _strncpy_d1_1_1
	ld	a,4(ix)
	ld	-2(ix),a
	ld	a,5(ix)
	ld	-1(ix),a
;_strncpy.c:33: while ( n-- )
;	genAssign
;	(operands are equal 3)
;	genAssign
;	AOP_STK for _strncpy_d1_1_1
	ld	e,-2(ix)
	ld	d,-1(ix)
;	genAssign
;	AOP_STK for 
	ld	c,8(ix)
	ld	b,9(ix)
;	genLabel
00101$:
;	genAssign
	ld	l,c
	ld	h,b
;	genMinus
	dec	bc
;	genIfx
	ld	a,l
	or	a,h
	jp	z,00103$
;_strncpy.c:34: *d++ = *s++ ;
;	genPointerGet
;	AOP_STK for 
	ld	l,6(ix)
	ld	h,7(ix)
	ld	a,(hl)
;	genPlus
;	AOP_STK for 
;	genPlusIncr
	inc	6(ix)
	jp	nz,00108$
	inc	7(ix)
00108$:
;	genAssign (pointer)
;	isBitvar = 0
	ld	(de),a
;	genPlus
;	genPlusIncr
	inc	de
;	genGoto
	jp	00101$
;	genLabel
00103$:
;_strncpy.c:35: return d1;
;	genRet
;	AOP_STK for _strncpy_d1_1_1
; Dump of IC_LEFT: type AOP_STK size 2
;	 aop_stk -2
	ld	l,-2(ix)
	ld	h,-1(ix)
;	genLabel
00104$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
_strncpy_end::
	.area _CODE
