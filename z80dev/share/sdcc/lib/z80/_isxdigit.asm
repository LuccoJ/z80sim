;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:24 2003

;--------------------------------------------------------
	.module _isxdigit
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _isxdigit
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
;_isxdigit.c:24: char isxdigit (unsigned char c) 
;	genLabel
;	genFunction
;	---------------------------------
; Function isxdigit
; ---------------------------------
_isxdigit_start::
_isxdigit:
	push	ix
	ld	ix,#0
	add	ix,sp
;_isxdigit.c:27: if (( c >= '0' && c <= '9')  ||
;	genCmpLt
;	AOP_STK for 
	ld	a,4(ix)
	sub	a,#0x30
	jp	c,00105$
;	genCmpGt
;	AOP_STK for 
	ld	a,#0x39
	sub	a,4(ix)
	jp	nc,00101$
;	genLabel
00105$:
;_isxdigit.c:28: ( c >= 'a' && c <= 'f')  ||
;	genCmpLt
;	AOP_STK for 
	ld	a,4(ix)
	sub	a,#0x61
	jp	c,00107$
;	genCmpGt
;	AOP_STK for 
	ld	a,#0x66
	sub	a,4(ix)
	jp	nc,00101$
;	genLabel
00107$:
;_isxdigit.c:29: ( c >= 'A' && c <= 'F')) 
;	genCmpLt
;	AOP_STK for 
	ld	a,4(ix)
	sub	a,#0x41
	jp	c,00102$
;	genCmpGt
;	AOP_STK for 
	ld	a,#0x46
	sub	a,4(ix)
	jp	c,00102$
;	genLabel
00101$:
;_isxdigit.c:30: return 1;
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x01
	jp	00108$
;	genLabel
00102$:
;_isxdigit.c:31: return 0;
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x00
;	genLabel
00108$:
;	genEndFunction
	pop	ix
	ret
_isxdigit_end::
	.area _CODE
