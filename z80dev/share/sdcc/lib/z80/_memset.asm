;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:25 2003

;--------------------------------------------------------
	.module _memset
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memset
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
;_memset.c:26: void * memset (
;	genLabel
;	genFunction
;	---------------------------------
; Function memset
; ---------------------------------
_memset_start::
_memset:
	push	ix
	ld	ix,#0
	add	ix,sp
;_memset.c:31: register unsigned char * ret = buf;
;	genAssign
;	(operands are equal 3)
;_memset.c:33: while (count--) {
;	genAssign
;	AOP_STK for 
	ld	e,4(ix)
	ld	d,5(ix)
;	genAssign
;	AOP_STK for 
	ld	c,7(ix)
	ld	b,8(ix)
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
;_memset.c:34: *(unsigned char *) ret = ch;
;	genAssign (pointer)
;	AOP_STK for 
;	isBitvar = 0
	ld	a,6(ix)
	ld	(de),a
;_memset.c:35: ret = ((unsigned char *) ret) + 1;
;	genPlus
;	genPlusIncr
	inc	de
;	genGoto
	jp	00101$
;	genLabel
00103$:
;_memset.c:38: return buf ;
;	genRet
;	AOP_STK for 
; Dump of IC_LEFT: type AOP_STK size 2
;	 aop_stk 4
	ld	l,4(ix)
	ld	h,5(ix)
;	genLabel
00104$:
;	genEndFunction
	pop	ix
	ret
_memset_end::
	.area _CODE
