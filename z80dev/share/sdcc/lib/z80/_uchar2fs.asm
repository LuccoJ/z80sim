;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:27 2003

;--------------------------------------------------------
	.module _uchar2fs
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___uchar2fs
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
;_uchar2fs.c:4: float __uchar2fs (unsigned char uc) {
;	genLabel
;	genFunction
;	---------------------------------
; Function __uchar2fs
; ---------------------------------
___uchar2fs_start::
___uchar2fs:
	push	ix
	ld	ix,#0
	add	ix,sp
;_uchar2fs.c:5: return __ulong2fs(uc);
;	genCast
;	AOP_STK for 
	ld	c,4(ix)
	ld	b,#0x00
	ld      de,#0x0000
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	de
	push    bc
;	genCall
	call	___ulong2fs
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
___uchar2fs_end::
	.area _CODE
