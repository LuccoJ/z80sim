;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:25 2003

;--------------------------------------------------------
	.module _strchr
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strchr
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
;_strchr.c:26: char * strchr (
;	genLabel
;	genFunction
;	---------------------------------
; Function strchr
; ---------------------------------
_strchr_start::
_strchr:
	push	ix
	ld	ix,#0
	add	ix,sp
;_strchr.c:31: while (*string && *string != ch)
;	genAssign
;	AOP_STK for 
	ld	c,4(ix)
	ld	b,5(ix)
;	genLabel
00102$:
;	genPointerGet
	ld	a,(bc)
	ld	l,a
;	genIfx
	xor	a,a
	or	a,l
	jp	z,00104$
;	genCmpEq
;	AOP_STK for 
; genCmpEq: left 1, right 1, result 0
	ld	a,6(ix)
	cp	l
	jp	z,00104$
00113$:
;_strchr.c:32: string++;
;	genPlus
;	genPlusIncr
	inc	bc
;	genGoto
	jp	00102$
;	genLabel
00104$:
;_strchr.c:34: if (*string == ch)
;	genCmpEq
;	AOP_STK for 
; genCmpEq: left 1, right 1, result 0
	ld	a,6(ix)
	cp	l
	jp	z,00115$
00114$:
	jp	00106$
00115$:
;_strchr.c:35: return(string);
;	genRet
; Dump of IC_LEFT: type AOP_REG size 2
;	 reg = bc
	ld	l,c
	ld	h,b
	jp	00107$
;	genLabel
00106$:
;_strchr.c:36: return ( NULL );
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 2
	ld	hl,#0x0000
;	genLabel
00107$:
;	genEndFunction
	pop	ix
	ret
_strchr_end::
	.area _CODE
