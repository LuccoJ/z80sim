;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:25 2003

;--------------------------------------------------------
	.module _strncat
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strncat
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
;_strncat.c:26: char * strncat (
;	genLabel
;	genFunction
;	---------------------------------
; Function strncat
; ---------------------------------
_strncat_start::
_strncat:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-2
	add	hl,sp
	ld	sp,hl
;_strncat.c:32: char *start = front;
;	genAssign
;	AOP_STK for 
;	AOP_STK for _strncat_start_1_1
	ld	a,4(ix)
	ld	-2(ix),a
	ld	a,5(ix)
	ld	-1(ix),a
;_strncat.c:34: while (*front++);
;	genLabel
00101$:
;	genAssign
;	AOP_STK for 
	ld	l,4(ix)
	ld	h,5(ix)
;	genPointerGet
	ld	e,(hl)
;	genPlus
;	genPlusIncr
; Removed redundent load
; Removed redundent load
	inc	hl
;	genAssign
;	AOP_STK for 
	ld	4(ix),l
	ld	5(ix),h
;	genIfx
	xor	a,a
	or	a,e
	jp	nz,00101$
;_strncat.c:36: front--;
;	genMinus
; Removed redundent load
; Removed redundent load
	dec	hl
;	genAssign
;	AOP_STK for 
	ld	4(ix),l
	ld	5(ix),h
;_strncat.c:38: while (count--)
;	genAssign
;	(operands are equal 3)
;	genAssign
	ld	c,l
	ld	b,h
;	genAssign
;	(operands are equal 3)
;	genLabel
00106$:
;	genAssign
;	AOP_STK for 
	ld	l,8(ix)
	ld	h,9(ix)
;	genMinus
;	AOP_STK for 
	ld	l,8(ix)
	ld	h,9(ix)
	dec	hl
	ld	8(ix),l
	ld	9(ix),h
;	genIfx
	ld	a,l
	or	a,h
	jp	z,00108$
;_strncat.c:39: if (!(*front++ = *back++))
;	genPointerGet
;	AOP_STK for 
	ld	l,6(ix)
	ld	h,7(ix)
	ld	e,(hl)
;	genPlus
;	AOP_STK for 
;	genPlusIncr
	inc	6(ix)
	jp	nz,00116$
	inc	7(ix)
00116$:
;	genAssign (pointer)
;	isBitvar = 0
	ld	a,e
	ld	(bc),a
;	genPlus
;	genPlusIncr
	inc	bc
;	genAssign
;	AOP_STK for 
	ld	4(ix),c
	ld	5(ix),b
;	genIfx
	xor	a,a
	or	a,e
	jp	nz,00106$
;_strncat.c:40: return(start);
;	genRet
;	AOP_STK for _strncat_start_1_1
; Dump of IC_LEFT: type AOP_STK size 2
;	 aop_stk -2
	ld	l,-2(ix)
	ld	h,-1(ix)
	jp	00109$
;	genLabel
00108$:
;_strncat.c:42: *front = '\0';
;	genAssign
;	AOP_STK for 
	ld	l,4(ix)
	ld	h,5(ix)
;	genAssign (pointer)
;	isBitvar = 0
	ld	(hl),#0x00
;_strncat.c:43: return(start);
;	genRet
;	AOP_STK for _strncat_start_1_1
; Dump of IC_LEFT: type AOP_STK size 2
;	 aop_stk -2
	ld	l,-2(ix)
	ld	h,-1(ix)
;	genLabel
00109$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
_strncat_end::
	.area _CODE
