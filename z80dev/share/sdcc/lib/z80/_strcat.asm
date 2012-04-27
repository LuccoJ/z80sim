;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:25 2003

;--------------------------------------------------------
	.module _strcat
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strcat
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
;_strcat.c:26: char * strcat (
;	genLabel
;	genFunction
;	---------------------------------
; Function strcat
; ---------------------------------
_strcat_start::
_strcat:
	push	ix
	ld	ix,#0
	add	ix,sp
;_strcat.c:31: char * cp = dst;
;	genAssign
;	AOP_STK for 
	ld	c,4(ix)
	ld	b,5(ix)
;_strcat.c:33: while( *cp )
;	genAssign
;	(registers are the same)
;	genLabel
00101$:
;	genPointerGet
	ld	a,(bc)
;	genIfx
	or	a,a
	jp	z,00111$
;_strcat.c:34: cp++;                   /* find end of dst */
;	genPlus
;	genPlusIncr
	inc	bc
;	genGoto
	jp	00101$
;_strcat.c:36: while( *cp++ = *src++ ) ;       /* Copy src to end of dst */
;	genLabel
00111$:
;	genAssign
;	AOP_STK for 
	ld	e,6(ix)
	ld	d,7(ix)
;	genAssign
;	(registers are the same)
;	genLabel
00104$:
;	genPointerGet
	ld	a,(de)
;	genPlus
;	genPlusIncr
	inc	de
;	genAssign (pointer)
;	isBitvar = 0
	ld	(bc),a
;	genPlus
;	genPlusIncr
	inc	bc
;	genIfx
	or	a,a
	jp	nz,00104$
;_strcat.c:38: return( dst );                  /* return dst */
;	genRet
;	AOP_STK for 
; Dump of IC_LEFT: type AOP_STK size 2
;	 aop_stk 4
	ld	l,4(ix)
	ld	h,5(ix)
;	genLabel
00107$:
;	genEndFunction
	pop	ix
	ret
_strcat_end::
	.area _CODE
