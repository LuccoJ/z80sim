;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:24 2003

;--------------------------------------------------------
	.module _ispunct
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ispunct
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
;_ispunct.c:25: char ispunct (unsigned char c) 
;	genLabel
;	genFunction
;	---------------------------------
; Function ispunct
; ---------------------------------
_ispunct_start::
_ispunct:
	push	ix
	ld	ix,#0
	add	ix,sp
;_ispunct.c:28: if (isprint (c)    && 
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
;	AOP_STK for 
	ld	a,4(ix)
	push	af
	inc	sp
;	genCall
	call	_isprint
	inc	sp
;	genIfx
	xor	a,a
	or	a,l
	jp	z,00102$
;_ispunct.c:29: !islower(c)     && 
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
;	AOP_STK for 
	ld	a,4(ix)
	push	af
	inc	sp
;	genCall
	call	_islower
	inc	sp
;	genIfx
	xor	a,a
	or	a,l
	jp	nz,00102$
;_ispunct.c:30: !isupper(c)     &&
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
;	AOP_STK for 
	ld	a,4(ix)
	push	af
	inc	sp
;	genCall
	call	_isupper
	inc	sp
;	genIfx
	xor	a,a
	or	a,l
	jp	nz,00102$
;_ispunct.c:31: c != ' '        &&
;	genCmpEq
;	AOP_STK for 
; genCmpEq: left 1, right 1, result 0
	ld	a,4(ix)
	cp	a,#0x20
	jp	z,00102$
00114$:
;_ispunct.c:32: !isdigit(c)) 
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
;	AOP_STK for 
	ld	a,4(ix)
	push	af
	inc	sp
;	genCall
	call	_isdigit
	inc	sp
;	genIfx
	xor	a,a
	or	a,l
	jp	nz,00102$
;_ispunct.c:33: return 1;
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x01
	jp	00107$
;	genLabel
00102$:
;_ispunct.c:34: return 0;
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x00
;	genLabel
00107$:
;	genEndFunction
	pop	ix
	ret
_ispunct_end::
	.area _CODE
