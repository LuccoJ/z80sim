;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:24 2003

;--------------------------------------------------------
	.module _iscntrl
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _iscntrl
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
;_iscntrl.c:27: char  iscntrl(unsigned char c) 
;	genLabel
;	genFunction
;	---------------------------------
; Function iscntrl
; ---------------------------------
_iscntrl_start::
_iscntrl:
	push	ix
	ld	ix,#0
	add	ix,sp
;_iscntrl.c:30: if  ( c <= '\x1F' || c == '\x7f') 
;	genCmpGt
;	AOP_STK for 
	ld	a,#0x1F
	sub	a,4(ix)
	jp	nc,00101$
;	genCmpEq
;	AOP_STK for 
; genCmpEq: left 1, right 1, result 0
	ld	a,4(ix)
	cp	a,#0x7F
	jp	z,00108$
00107$:
	jp	00102$
00108$:
;	genLabel
00101$:
;_iscntrl.c:31: return 1;
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x01
	jp	00104$
;	genLabel
00102$:
;_iscntrl.c:32: return 0;
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x00
;	genLabel
00104$:
;	genEndFunction
	pop	ix
	ret
_iscntrl_end::
	.area _CODE
