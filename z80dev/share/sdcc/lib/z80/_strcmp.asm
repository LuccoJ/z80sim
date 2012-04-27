;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:25 2003

;--------------------------------------------------------
	.module _strcmp
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strcmp
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
;_strcmp.c:29: int strcmp (
;	genLabel
;	genFunction
;	---------------------------------
; Function strcmp
; ---------------------------------
_strcmp_start::
_strcmp:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-2
	add	hl,sp
	ld	sp,hl
;_strcmp.c:38: char * src = asrc;
;	genAssign
;	AOP_STK for 
	ld	c,4(ix)
	ld	b,5(ix)
;_strcmp.c:39: char * dst = adst;
;	genAssign
;	AOP_STK for 
;	AOP_STK for _strcmp_dst_1_1
	ld	a,6(ix)
	ld	-2(ix),a
	ld	a,7(ix)
	ld	-1(ix),a
;_strcmp.c:41: while( ! (*src - *dst) && *dst)
;	genLabel
00102$:
;	genPointerGet
	ld	a,(bc)
	ld	e,a
;	genPointerGet
;	AOP_STK for _strcmp_dst_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	l,(hl)
;	genMinus
	ld	a,e
	sub	a,l
;	genIfx
	or	a,a
	jp	nz,00104$
;	genIfx
	xor	a,a
	or	a,l
	jp	z,00104$
;_strcmp.c:42: ++src, ++dst;
;	genPlus
;	genPlusIncr
	inc	bc
;	genPlus
;	AOP_STK for _strcmp_dst_1_1
;	genPlusIncr
	inc	-2(ix)
	jp	nz,00110$
	inc	-1(ix)
00110$:
;	genGoto
	jp	00102$
;	genLabel
00104$:
;_strcmp.c:44: return *src - *dst;
;	genCast
; Removed redundent load
	ld	a,e
	rla	
	sbc	a,a
	ld	c,a
;	genCast
; Removed redundent load
	ld	a,l
	rla	
	sbc	a,a
	ld	h,a
;	genMinus
	ld	a,e
	sub	a,l
	ld	l,a
	ld	a,c
	sbc	a,h
	ld	h,a
;	genRet
; Dump of IC_LEFT: type AOP_STR size 2
;	genLabel
00105$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
_strcmp_end::
	.area _CODE
