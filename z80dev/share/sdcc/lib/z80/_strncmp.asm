;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:25 2003

;--------------------------------------------------------
	.module _strncmp
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strncmp
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
;_strncmp.c:26: int strncmp (
;	genLabel
;	genFunction
;	---------------------------------
; Function strncmp
; ---------------------------------
_strncmp_start::
_strncmp:
	push	ix
	ld	ix,#0
	add	ix,sp
;_strncmp.c:32: if (!count)
;	genIfx
;	AOP_STK for 
	ld	a,8(ix)
	or	a,9(ix)
	jp	nz,00114$
;_strncmp.c:33: return(0);
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 2
	ld	hl,#0x0000
	jp	00108$
;_strncmp.c:35: while (--count && *first && *first == *last) {
;	genLabel
00114$:
;	genAssign
;	AOP_STK for 
	ld	c,4(ix)
	ld	b,5(ix)
;	genAssign
;	(operands are equal 3)
;	genLabel
00105$:
;	genMinus
;	AOP_STK for 
	ld	l,8(ix)
	ld	h,9(ix)
	dec	hl
;	genAssign
;	AOP_STK for 
	ld	8(ix),l
	ld	9(ix),h
;	genIfx
	ld	a,l
	or	a,h
	jp	z,00107$
;	genPointerGet
	ld	a,(bc)
	ld	e,a
;	genIfx
	xor	a,a
	or	a,e
	jp	z,00107$
;	genPointerGet
;	AOP_STK for 
	ld	l,6(ix)
	ld	h,7(ix)
	ld	l,(hl)
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	a,l
	cp	e
	jp	z,00116$
00115$:
	jp	00107$
00116$:
;_strncmp.c:36: first++;
;	genPlus
;	genPlusIncr
	inc	bc
;_strncmp.c:37: last++;
;	genPlus
;	AOP_STK for 
;	genPlusIncr
	inc	6(ix)
	jp	nz,00117$
	inc	7(ix)
00117$:
;	genGoto
	jp	00105$
;	genLabel
00107$:
;_strncmp.c:40: return( *first - *last );
;	genPointerGet
	ld	a,(bc)
	ld	l,a
;	genCast
	ld	c,l
	ld	a,l
	rla	
	sbc	a,a
	ld	b,a
;	genPointerGet
;	AOP_STK for 
	ld	l,6(ix)
	ld	h,7(ix)
	ld	l,(hl)
;	genCast
; Removed redundent load
	ld	a,l
	rla	
	sbc	a,a
	ld	h,a
;	genMinus
	ld	a,c
	sub	a,l
	ld	l,a
	ld	a,b
	sbc	a,h
	ld	h,a
;	genRet
; Dump of IC_LEFT: type AOP_STR size 2
;	genLabel
00108$:
;	genEndFunction
	pop	ix
	ret
_strncmp_end::
	.area _CODE
