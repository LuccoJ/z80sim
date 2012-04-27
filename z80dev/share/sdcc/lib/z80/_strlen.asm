;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:25 2003

;--------------------------------------------------------
	.module _strlen
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strlen
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
;_strlen.c:26: int strlen ( char * str ) 
;	genLabel
;	genFunction
;	---------------------------------
; Function strlen
; ---------------------------------
_strlen_start::
_strlen:
	push	ix
	ld	ix,#0
	add	ix,sp
;_strlen.c:30: while (*str++) 
;	genAssign
	ld	bc,#0x0000
;	genAssign
;	AOP_STK for 
	ld	e,4(ix)
	ld	d,5(ix)
;	genLabel
00101$:
;	genPointerGet
	ld	a,(de)
;	genPlus
;	genPlusIncr
	inc	de
;	genIfx
	or	a,a
	jp	z,00103$
;_strlen.c:31: i++ ;
;	genPlus
;	genPlusIncr
	inc	bc
;	genGoto
	jp	00101$
;	genLabel
00103$:
;_strlen.c:33: return i;
;	genRet
; Dump of IC_LEFT: type AOP_REG size 2
;	 reg = bc
	ld	l,c
	ld	h,b
;	genLabel
00104$:
;	genEndFunction
	pop	ix
	ret
_strlen_end::
	.area _CODE
