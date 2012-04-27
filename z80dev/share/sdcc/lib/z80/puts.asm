;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:25 2003

;--------------------------------------------------------
	.module puts
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _puts
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
;puts.c:27: int puts (char *s)
;	genLabel
;	genFunction
;	---------------------------------
; Function puts
; ---------------------------------
_puts_start::
_puts:
	push	ix
	ld	ix,#0
	add	ix,sp
;puts.c:30: while (*s){
;	genAssign
;	AOP_STK for 
	ld	c,4(ix)
	ld	b,5(ix)
;	genAssign
	ld	de,#0x0000
;	genLabel
00101$:
;	genPointerGet
	ld	a,(bc)
	ld	l,a
;	genIfx
	xor	a,a
	or	a,l
	jp	z,00103$
;puts.c:31: putchar(*s++);
;	genPlus
;	genPlusIncr
	inc	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_putchar
	inc	sp
	pop	de
	pop	bc
;puts.c:32: i++;
;	genPlus
;	genPlusIncr
	inc	de
;	genGoto
	jp	00101$
;	genLabel
00103$:
;puts.c:34: putchar('\n');
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
	push	de
	ld	a,#0x0A
	push	af
	inc	sp
;	genCall
	call	_putchar
	inc	sp
	pop	de
;puts.c:35: return i+1;
;	genPlus
;	genPlusIncr
	ld	l,e
	ld	h,d
	inc	hl
;	genRet
; Dump of IC_LEFT: type AOP_STR size 2
;	genLabel
00104$:
;	genEndFunction
	pop	ix
	ret
_puts_end::
	.area _CODE
