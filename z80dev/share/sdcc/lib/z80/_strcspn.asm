;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:25 2003

;--------------------------------------------------------
	.module _strcspn
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strcspn
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
;_strcspn.c:26: int strcspn ( 
;	genLabel
;	genFunction
;	---------------------------------
; Function strcspn
; ---------------------------------
_strcspn_start::
_strcspn:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-1
	add	hl,sp
	ld	sp,hl
;_strcspn.c:34: while (ch = *string) {
;	genAssign
;	AOP_STK for 
	ld	c,4(ix)
	ld	b,5(ix)
;	genAssign
	ld	de,#0x0000
;	genLabel
00104$:
;	genPointerGet
	ld	a,(bc)
	ld	l,a
;	genAssign
;	AOP_STK for _strcspn__1_0
	ld	-1(ix),l
;	genIfx
	xor	a,a
	or	a,l
	jp	z,00106$
;_strcspn.c:35: if (strchr(control,ch))
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
;	AOP_STK for _strcspn__1_0
	ld	a,-1(ix)
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
	pop	bc
;	genIfx
	ld	a,l
	or	a,h
	jp	nz,00106$
;_strcspn.c:38: count++ ;
;	genPlus
;	genPlusIncr
	inc	de
;	genGoto
	jp	00104$
;	genLabel
00106$:
;_strcspn.c:41: return count ;
;	genRet
; Dump of IC_LEFT: type AOP_REG size 2
;	 reg = de
	ld	l,e
	ld	h,d
;	genLabel
00107$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
_strcspn_end::
	.area _CODE
