;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:25 2003

;--------------------------------------------------------
	.module _strspn
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strspn
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
;_strspn.c:26: int strspn (
;	genLabel
;	genFunction
;	---------------------------------
; Function strspn
; ---------------------------------
_strspn_start::
_strspn:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-2
	add	hl,sp
	ld	sp,hl
;_strspn.c:34: while (ch = *string) {
;	genAssign
;	AOP_STK for _strspn_count_1_1
	ld	-2(ix),#0x00
	ld	-1(ix),#0x00
;	genAssign
;	AOP_STK for 
	ld	e,4(ix)
	ld	d,5(ix)
;	genLabel
00104$:
;	genPointerGet
	ld	a,(de)
	ld	l,a
;	genAssign
	ld	c,l
;	genIfx
	xor	a,a
	or	a,l
	jp	z,00106$
;_strspn.c:35: if ( strchr(control,ch) )
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	ld	a,c
	push	af
	inc	sp
;	genIpush
;	AOP_STK for 
	ld	l,6(ix)
	ld	h,7(ix)
	push	hl
;	genCall
	call	_strchr
	pop	af
	inc	sp
	pop	de
;	genIfx
	ld	a,l
	or	a,h
	jp	z,00106$
;_strspn.c:36: count++ ;
;	genPlus
;	AOP_STK for _strspn_count_1_1
;	genPlusIncr
	inc	-2(ix)
	jp	nz,00112$
	inc	-1(ix)
00112$:
;_strspn.c:39: string++ ;
;	genPlus
;	genPlusIncr
	inc	de
;	genGoto
	jp	00104$
;	genLabel
00106$:
;_strspn.c:42: return count ;
;	genRet
;	AOP_STK for _strspn_count_1_1
; Dump of IC_LEFT: type AOP_STK size 2
;	 aop_stk -2
	ld	l,-2(ix)
	ld	h,-1(ix)
;	genLabel
00107$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
_strspn_end::
	.area _CODE
