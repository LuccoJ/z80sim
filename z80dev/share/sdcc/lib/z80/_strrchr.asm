;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:25 2003

;--------------------------------------------------------
	.module _strrchr
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strrchr
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
;_strrchr.c:26: char * strrchr (
;	genLabel
;	genFunction
;	---------------------------------
; Function strrchr
; ---------------------------------
_strrchr_start::
_strrchr:
	push	ix
	ld	ix,#0
	add	ix,sp
;_strrchr.c:31: char * start = string;
;	genAssign
;	AOP_STK for 
	ld	c,4(ix)
	ld	b,5(ix)
;_strrchr.c:33: while (*string++)                       /* find end of string */
;	genAssign
	ld	e,c
	ld	d,b
;	genLabel
00101$:
;	genPointerGet
	ld	a,(de)
	ld	l,a
;	genPlus
;	genPlusIncr
	inc	de
;	genAssign
;	AOP_STK for 
	ld	4(ix),e
	ld	5(ix),d
;	genIfx
	xor	a,a
	or	a,l
	jp	nz,00101$
;_strrchr.c:36: while (--string != start && *string != ch)
;	genLabel
00105$:
;	genMinus
;	AOP_STK for 
	ld	e,4(ix)
	ld	d,5(ix)
	dec	de
;	genAssign
;	AOP_STK for 
	ld	4(ix),e
	ld	5(ix),d
;	genCmpEq
; genCmpEq: left 2, right 2, result 0
	ld	a,e
	cp	c
	jp	nz,00116$
	ld	a,d
	cp	b
	jp	z,00107$
00116$:
;	genPointerGet
	ld	a,(de)
	ld	l,a
;	genCmpEq
;	AOP_STK for 
; genCmpEq: left 1, right 1, result 0
	ld	a,6(ix)
	cp	l
	jp	z,00118$
00117$:
	jp	00105$
00118$:
;	genLabel
00107$:
;_strrchr.c:39: if (*string == ch)                /* char found ? */
;	genPointerGet
	ld	a,(de)
	ld	l,a
;	genCmpEq
;	AOP_STK for 
; genCmpEq: left 1, right 1, result 0
	ld	a,6(ix)
	cp	l
	jp	z,00120$
00119$:
	jp	00109$
00120$:
;_strrchr.c:40: return( (char *)string );
;	genRet
; Dump of IC_LEFT: type AOP_REG size 2
;	 reg = de
	ld	l,e
	ld	h,d
	jp	00110$
;	genLabel
00109$:
;_strrchr.c:42: return (NULL) ;
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 2
	ld	hl,#0x0000
;	genLabel
00110$:
;	genEndFunction
	pop	ix
	ret
_strrchr_end::
	.area _CODE
