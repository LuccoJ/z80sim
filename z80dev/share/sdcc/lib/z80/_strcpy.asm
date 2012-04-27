;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:25 2003

;--------------------------------------------------------
	.module _strcpy
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strcpy
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
;_strcpy.c:29: char * strcpy (
;	genLabel
;	genFunction
;	---------------------------------
; Function strcpy
; ---------------------------------
_strcpy_start::
_strcpy:
	push	ix
	ld	ix,#0
	add	ix,sp
;_strcpy.c:34: register char * to = d;
;	genAssign
;	AOP_STK for 
	ld	c,4(ix)
	ld	b,5(ix)
;_strcpy.c:35: register char * from = s;
;	genAssign
;	AOP_STK for 
	ld	e,6(ix)
	ld	d,7(ix)
;_strcpy.c:37: while (*to++ = *from++) ;
;	genAssign
;	(registers are the same)
;	genAssign
;	(registers are the same)
;	genLabel
00101$:
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
	jp	nz,00101$
;_strcpy.c:39: return d;
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
_strcpy_end::
	.area _CODE
