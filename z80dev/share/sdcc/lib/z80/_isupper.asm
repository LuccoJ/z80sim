;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:24 2003

;--------------------------------------------------------
	.module _isupper
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _isupper
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
;_isupper.c:24: char isupper (unsigned char c) 
;	genLabel
;	genFunction
;	---------------------------------
; Function isupper
; ---------------------------------
_isupper_start::
_isupper:
	push	ix
	ld	ix,#0
	add	ix,sp
;_isupper.c:27: if ( c >= 'A' && c <= 'Z') 	
;	genCmpLt
;	AOP_STK for 
	ld	a,4(ix)
	sub	a,#0x41
	jp	c,00102$
;	genCmpGt
;	AOP_STK for 
	ld	a,#0x5A
	sub	a,4(ix)
	jp	c,00102$
;_isupper.c:28: return 1;
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x01
	jp	00104$
;	genLabel
00102$:
;_isupper.c:29: return 0;
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x00
;	genLabel
00104$:
;	genEndFunction
	pop	ix
	ret
_isupper_end::
	.area _CODE
