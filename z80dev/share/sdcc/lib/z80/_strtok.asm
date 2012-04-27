;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:25 2003

;--------------------------------------------------------
	.module _strtok
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strtok
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
_strtok_s_1_1:
	.ds 2
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
;_strtok.c:31: char * strtok (
;	genLabel
;	genFunction
;	---------------------------------
; Function strtok
; ---------------------------------
_strtok_start::
_strtok:
	push	ix
	ld	ix,#0
	add	ix,sp
;_strtok.c:38: if ( str )
;	genIfx
;	AOP_STK for 
	ld	a,4(ix)
	or	a,5(ix)
	jp	z,00102$
;_strtok.c:39: s = str ;
;	genAssign
;	AOP_STK for 
	ld	a,4(ix)
	ld	iy,#_strtok_s_1_1
	ld	0(iy),a
	ld	a,5(ix)
	ld	1(iy),a
;	genLabel
00102$:
;_strtok.c:40: if ( !s )
;	genIfx
	ld	iy,#_strtok_s_1_1
	ld	a,0(iy)
	or	a,1(iy)
	jp	nz,00108$
;_strtok.c:41: return NULL;
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 2
	ld	hl,#0x0000
	jp	00119$
;_strtok.c:43: while (*s) {
;	genLabel
00108$:
;	genAssign
	ld	hl,(_strtok_s_1_1)
;	genPointerGet
	ld	a,(hl)
;	genIfx
	or	a,a
	jp	z,00110$
;_strtok.c:44: if (strchr(control,*s))
;	genAssign
	ld	hl,(_strtok_s_1_1)
;	genPointerGet
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,l
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
;	genIfx
	ld	a,l
	or	a,h
	jp	z,00110$
;_strtok.c:45: s++;
;	genPlus
;	genPlusIncr
	ld	iy,#_strtok_s_1_1
	inc	0(iy)
	jp	nz,00130$
	inc	1(iy)
00130$:
;	genGoto
	jp	00108$
;_strtok.c:47: break;
;	genLabel
00110$:
;_strtok.c:50: s1 = s ;
;	genAssign
	ld	bc,(_strtok_s_1_1)
;_strtok.c:52: while (*s) {
;	genLabel
00113$:
;	genAssign
	ld	hl,(_strtok_s_1_1)
;	genPointerGet
	ld	a,(hl)
;	genIfx
	or	a,a
	jp	z,00115$
;_strtok.c:53: if (strchr(control,*s)) {
;	genAssign
	ld	hl,(_strtok_s_1_1)
;	genPointerGet
	ld	l,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
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
	jp	z,00112$
;_strtok.c:54: *s++ = '\0';
;	genAssign
	ld	hl,(_strtok_s_1_1)
;	genAssign (pointer)
;	isBitvar = 0
	ld	(hl),#0x00
;	genPlus
;	genPlusIncr
	ld	iy,#_strtok_s_1_1
	inc	0(iy)
	jp	nz,00131$
	inc	1(iy)
00131$:
;_strtok.c:55: return s1 ;
;	genRet
; Dump of IC_LEFT: type AOP_REG size 2
;	 reg = bc
	ld	l,c
	ld	h,b
	jp	00119$
;	genLabel
00112$:
;_strtok.c:57: s++ ;
;	genPlus
;	genPlusIncr
	ld	iy,#_strtok_s_1_1
	inc	0(iy)
	jp	nz,00132$
	inc	1(iy)
00132$:
;	genGoto
	jp	00113$
;	genLabel
00115$:
;_strtok.c:60: s = NULL;
;	genAssign
	ld	iy,#_strtok_s_1_1
	ld	0(iy),#0x00
	ld	1(iy),#0x00
;_strtok.c:62: if (*s1)
;	genPointerGet
	ld	a,(bc)
;	genIfx
	or	a,a
	jp	z,00117$
;_strtok.c:63: return s1;
;	genRet
; Dump of IC_LEFT: type AOP_REG size 2
;	 reg = bc
	ld	l,c
	ld	h,b
	jp	00119$
;	genLabel
00117$:
;_strtok.c:65: return NULL;
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 2
	ld	hl,#0x0000
;	genLabel
00119$:
;	genEndFunction
	pop	ix
	ret
_strtok_end::
	.area _CODE
