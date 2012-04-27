;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:24 2003

;--------------------------------------------------------
	.module _islower
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _islower
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
;_islower.c:25: char islower(unsigned char c) 
;	genLabel
;	genFunction
;	---------------------------------
; Function islower
; ---------------------------------
_islower_start::
_islower:
	push	ix
	ld	ix,#0
	add	ix,sp
;_islower.c:28: if  ( c >= 'a' && c <= 'z' ) 
;	genCmpLt
;	AOP_STK for 
	ld	a,4(ix)
	sub	a,#0x61
	jp	c,00102$
;	genCmpGt
;	AOP_STK for 
	ld	a,#0x7A
	sub	a,4(ix)
	jp	c,00102$
;_islower.c:29: return 1;
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x01
	jp	00104$
;	genLabel
00102$:
;_islower.c:30: return 0;
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x00
;	genLabel
00104$:
;	genEndFunction
	pop	ix
	ret
_islower_end::
	.area _CODE
