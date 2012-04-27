;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:25 2003

;--------------------------------------------------------
	.module gets
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gets
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
;gets.c:3: char * gets(const char *str) {
;	genLabel
;	genFunction
;	---------------------------------
; Function gets
; ---------------------------------
_gets_start::
_gets:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-2
	add	hl,sp
	ld	sp,hl
;gets.c:4: char *s=str;
;	genAssign
;	AOP_STK for 
	ld	c,4(ix)
	ld	b,5(ix)
;gets.c:6: unsigned int count=0;
;	genAssign
;	AOP_STK for _gets_count_1_1
	ld	-2(ix),#0x00
	ld	-1(ix),#0x00
;gets.c:8: while (1) {
;	genLabel
00109$:
;gets.c:9: c=getchar();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	call	_getchar
	pop	bc
;	genAssign
	ld	e,l
;gets.c:10: switch(c) {
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	a,e
	cp	a,#0x08
	jp	z,00103$
00118$:
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	a,e
	cp	a,#0x0A
	jp	z,00104$
00119$:
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	a,e
	cp	a,#0x0D
	jp	z,00104$
00120$:
;	genGoto
	jp	00106$
;gets.c:19: break;
;	genLabel
00103$:
;gets.c:12: if (count) {
;	genIfx
;	AOP_STK for _gets_count_1_1
	ld	a,-2(ix)
	or	a,-1(ix)
	jp	z,00109$
;gets.c:13: putchar ('\b');
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,#0x08
	push	af
	inc	sp
;	genCall
	call	_putchar
	inc	sp
	pop	de
	pop	bc
;gets.c:14: putchar (' ');
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,#0x20
	push	af
	inc	sp
;	genCall
	call	_putchar
	inc	sp
	pop	de
	pop	bc
;gets.c:15: putchar ('\b');
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,#0x08
	push	af
	inc	sp
;	genCall
	call	_putchar
	inc	sp
	pop	de
	pop	bc
;gets.c:16: s--;
;	genMinus
	dec	bc
;gets.c:17: count--;
;	genMinus
;	AOP_STK for _gets_count_1_1
	ld	l,-2(ix)
	ld	h,-1(ix)
	dec	hl
	ld	-2(ix),l
	ld	-1(ix),h
;gets.c:19: break;
;	genGoto
	jp	00109$
;gets.c:22: putchar('\r');
;	genLabel
00104$:
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,#0x0D
	push	af
	inc	sp
;	genCall
	call	_putchar
	inc	sp
	pop	de
	pop	bc
;gets.c:23: putchar('\n');
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	a,#0x0A
	push	af
	inc	sp
;	genCall
	call	_putchar
	inc	sp
	pop	de
	pop	bc
;gets.c:24: *s=0;
;	genAssign (pointer)
;	isBitvar = 0
	ld	a,#0x00
	ld	(bc),a
;gets.c:25: return str;
;	genRet
;	AOP_STK for 
; Dump of IC_LEFT: type AOP_STK size 2
;	 aop_stk 4
	ld	l,4(ix)
	ld	h,5(ix)
	jp	00111$
;gets.c:27: *s++=c;
;	genLabel
00106$:
;	genAssign (pointer)
;	isBitvar = 0
	ld	a,e
	ld	(bc),a
;	genPlus
;	genPlusIncr
	inc	bc
;gets.c:28: count++;
;	genPlus
;	AOP_STK for _gets_count_1_1
;	genPlusIncr
	inc	-2(ix)
	jp	nz,00121$
	inc	-1(ix)
00121$:
;gets.c:29: putchar(c);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,e
	push	af
	inc	sp
;	genCall
	call	_putchar
	inc	sp
	pop	bc
;gets.c:31: }
;	genGoto
	jp	00109$
;	genLabel
00111$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
_gets_end::
	.area _CODE
