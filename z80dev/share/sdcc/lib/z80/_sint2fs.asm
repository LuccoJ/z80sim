;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:27 2003

;--------------------------------------------------------
	.module _sint2fs
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___sint2fs
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
;_sint2fs.c:4: float __sint2fs (signed int si) {
;	genLabel
;	genFunction
;	---------------------------------
; Function __sint2fs
; ---------------------------------
___sint2fs_start::
___sint2fs:
	push	ix
	ld	ix,#0
	add	ix,sp
;_sint2fs.c:5: return __slong2fs(si);
;	genCast
;	AOP_STK for 
	ld	c,4(ix)
	ld	b,5(ix)
	ld	a,5(ix)
	rla	
	sbc	a,a
	ld	e,a
	ld	d,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	de
	push    bc
;	genCall
	call	___slong2fs
; Removed redundent load
; Removed redundent load
	ld	b,h
	ld	c,l
	pop	af
	pop	af
;	genRet
; Dump of IC_LEFT: type AOP_REG size 4
;	 reg = debc
	ld	l,c
	ld	h,b
;	genLabel
00101$:
;	genEndFunction
	pop	ix
	ret
___sint2fs_end::
	.area _CODE
