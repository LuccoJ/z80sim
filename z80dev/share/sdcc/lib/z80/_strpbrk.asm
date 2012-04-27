;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:25 2003

;--------------------------------------------------------
	.module _strpbrk
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strpbrk
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
;_strpbrk.c:26: char * strpbrk ( 
;	genLabel
;	genFunction
;	---------------------------------
; Function strpbrk
; ---------------------------------
_strpbrk_start::
_strpbrk:
	push	ix
	ld	ix,#0
	add	ix,sp
;_strpbrk.c:33: while ( ch = *string ) {
;	genAssign
;	AOP_STK for 
	ld	c,4(ix)
	ld	b,5(ix)
;	genLabel
00103$:
;	genPointerGet
	ld	a,(bc)
	ld	l,a
;	genAssign
	ld	e,l
;	genIfx
	xor	a,a
	or	a,l
	jp	z,00105$
;_strpbrk.c:34: if (strchr (control, ch ))
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,e
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
	pop	bc
;	genIfx
	ld	a,l
	or	a,h
	jp	z,00103$
;_strpbrk.c:35: return string ;
;	genRet
; Dump of IC_LEFT: type AOP_REG size 2
;	 reg = bc
	ld	l,c
	ld	h,b
	jp	00106$
;	genLabel
00105$:
;_strpbrk.c:38: return (NULL);
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 2
	ld	hl,#0x0000
;	genLabel
00106$:
;	genEndFunction
	pop	ix
	ret
_strpbrk_end::
	.area _CODE
