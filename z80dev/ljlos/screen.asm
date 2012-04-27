;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Feb  3 2010) (UNIX)
; This file was generated Fri Apr 27 12:42:17 2012
;--------------------------------------------------------
	.module screen
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _SystemLock
	.globl _CharacterSet
	.globl _ScreenClear
	.globl _SetAttrib
	.globl _PutCharacter
	.globl _PutString
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
G$SystemLock$0$0==.
_SystemLock::
	.ds 1
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
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	G$ScreenClear$0$0	= .
	.globl	G$ScreenClear$0$0
	C$screen.c$178$0$0	= .
	.globl	C$screen.c$178$0$0
;screen.c:178: void ScreenClear(color Paper, color Ink) {
;	---------------------------------
; Function ScreenClear
; ---------------------------------
_ScreenClear_start::
_ScreenClear:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	C$screen.c$180$1$1	= .
	.globl	C$screen.c$180$1$1
;screen.c:180: _SimUnprotect(0x4000, 0x5fff);
	ld	hl,#0x5FFF
	push	hl
	ld	hl,#0x4000
	push	hl
	call	__Z80SimUnprotect
	pop	af
	pop	af
	C$screen.c$181$1$1	= .
	.globl	C$screen.c$181$1$1
;screen.c:181: for(i=0; i<0x1800; i++) {
	ld	bc,#0x0000
00101$:
	ld	a,c
	sub	a,#0x00
	ld	a,b
	sbc	a,#0x18
	jp	P,00104$
	C$screen.c$182$2$2	= .
	.globl	C$screen.c$182$2$2
;screen.c:182: ScreenMemory[i]=0;
	ld	hl,#0x4000
	add	hl,bc
	ex	de,hl
	ld	a,#0x00
	ld	(de),a
	C$screen.c$181$1$1	= .
	.globl	C$screen.c$181$1$1
;screen.c:181: for(i=0; i<0x1800; i++) {
	inc	bc
	jr	00101$
00104$:
	C$screen.c$184$2$3	= .
	.globl	C$screen.c$184$2$3
;screen.c:184: for(i=0; i<0x0300; i++) {
	ld	a,4 (ix)
	rlca
	rlca
	rlca
	and	a,#0xF8
	or	a,5 (ix)
	ld	c,a
	ld	-2 (ix),#0x00
	ld	-1 (ix),#0x00
00105$:
	ld	a,-2 (ix)
	sub	a,#0x00
	ld	a,-1 (ix)
	sbc	a,#0x03
	jp	P,00108$
	C$screen.c$185$2$3	= .
	.globl	C$screen.c$185$2$3
;screen.c:185: AttribMemory[i]=Paper<<3|Ink;
	ld	a,-2 (ix)
	add	a,#0x00
	ld	l, a
	ld	a, -1 (ix)
	adc	a, #0x58
	ld	h,a
	ld	(hl),c
	C$screen.c$184$1$1	= .
	.globl	C$screen.c$184$1$1
;screen.c:184: for(i=0; i<0x0300; i++) {
	inc	-2 (ix)
	jr	NZ,00117$
	inc	-1 (ix)
00117$:
	jr	00105$
00108$:
	C$screen.c$187$1$1	= .
	.globl	C$screen.c$187$1$1
;screen.c:187: _SimPrintString("Screen cleared\n");
	ld	hl,#__str_0
	push	hl
	call	__Z80SimPrintString
	pop	af
	C$screen.c$188$1$1	= .
	.globl	C$screen.c$188$1$1
;screen.c:188: _SimRWProtect(0x4000, 0x5fff);
	ld	hl,#0x5FFF
	push	hl
	ld	hl,#0x4000
	push	hl
	call	__Z80SimRWProtect
	pop	af
	pop	af
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	C$screen.c$189$1$1	= .
	.globl	C$screen.c$189$1$1
	XG$ScreenClear$0$0	= .
	.globl	XG$ScreenClear$0$0
	ret
_ScreenClear_end::
G$CharacterSet$0$0 == .
_CharacterSet:
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x08
	.db #0x08
	.db #0x08
	.db #0x08
	.db #0x08
	.db #0x00
	.db #0x08
	.db #0x00
	.db #0x14
	.db #0x14
	.db #0x28
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x24
	.db #0x7E
	.db #0x24
	.db #0x24
	.db #0x24
	.db #0x7E
	.db #0x24
	.db #0x00
	.db #0x08
	.db #0x3C
	.db #0x48
	.db #0x3C
	.db #0x0A
	.db #0x2A
	.db #0x1C
	.db #0x08
	.db #0x22
	.db #0x74
	.db #0x28
	.db #0x18
	.db #0x14
	.db #0x2E
	.db #0x44
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x08
	.db #0x10
	.db #0x10
	.db #0x10
	.db #0x10
	.db #0x10
	.db #0x08
	.db #0x00
	.db #0x10
	.db #0x08
	.db #0x08
	.db #0x08
	.db #0x08
	.db #0x08
	.db #0x10
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x18
	.db #0x18
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x18
	.db #0x18
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x3C
	.db #0x46
	.db #0x4A
	.db #0x5A
	.db #0x52
	.db #0x62
	.db #0x3C
	.db #0x00
	.db #0x08
	.db #0x18
	.db #0x28
	.db #0x08
	.db #0x08
	.db #0x08
	.db #0x08
	.db #0x00
	.db #0x3C
	.db #0x42
	.db #0x02
	.db #0x04
	.db #0x18
	.db #0x20
	.db #0x7E
	.db #0x00
	.db #0x7C
	.db #0x02
	.db #0x02
	.db #0x3C
	.db #0x02
	.db #0x02
	.db #0x7C
	.db #0x00
	.db #0x04
	.db #0x0C
	.db #0x14
	.db #0x24
	.db #0x44
	.db #0x7E
	.db #0x04
	.db #0x00
	.db #0x7E
	.db #0x40
	.db #0x40
	.db #0x7C
	.db #0x02
	.db #0x02
	.db #0x7C
	.db #0x00
	.db #0x3C
	.db #0x42
	.db #0x40
	.db #0x7C
	.db #0x42
	.db #0x42
	.db #0x3C
	.db #0x00
	.db #0x7E
	.db #0x02
	.db #0x02
	.db #0x04
	.db #0x04
	.db #0x08
	.db #0x08
	.db #0x00
	.db #0x3C
	.db #0x42
	.db #0x42
	.db #0x3C
	.db #0x42
	.db #0x42
	.db #0x3C
	.db #0x00
	.db #0x3C
	.db #0x42
	.db #0x42
	.db #0x3E
	.db #0x02
	.db #0x42
	.db #0x3C
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x3C
	.db #0x42
	.db #0x42
	.db #0x7E
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x00
	.db #0x7C
	.db #0x42
	.db #0x42
	.db #0x7C
	.db #0x42
	.db #0x42
	.db #0x7C
	.db #0x00
	.db #0x3C
	.db #0x42
	.db #0x40
	.db #0x40
	.db #0x40
	.db #0x42
	.db #0x3C
	.db #0x00
	.db #0x7C
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x7C
	.db #0x00
	.db #0x7E
	.db #0x40
	.db #0x40
	.db #0x78
	.db #0x40
	.db #0x40
	.db #0x7E
	.db #0x00
	.db #0x7E
	.db #0x40
	.db #0x40
	.db #0x78
	.db #0x40
	.db #0x40
	.db #0x40
	.db #0x00
	.db #0x3E
	.db #0x40
	.db #0x40
	.db #0x4E
	.db #0x42
	.db #0x42
	.db #0x3C
	.db #0x00
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x7E
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x00
	.db #0x38
	.db #0x10
	.db #0x10
	.db #0x10
	.db #0x10
	.db #0x10
	.db #0x38
	.db #0x00
	.db #0x18
	.db #0x08
	.db #0x08
	.db #0x08
	.db #0x08
	.db #0x08
	.db #0x30
	.db #0x00
	.db #0x42
	.db #0x44
	.db #0x48
	.db #0x7C
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x00
	.db #0x40
	.db #0x40
	.db #0x40
	.db #0x40
	.db #0x40
	.db #0x40
	.db #0x7E
	.db #0x00
	.db #0x42
	.db #0x66
	.db #0x5A
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x00
	.db #0x42
	.db #0x62
	.db #0x52
	.db #0x4A
	.db #0x46
	.db #0x42
	.db #0x42
	.db #0x00
	.db #0x3C
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x3C
	.db #0x00
	.db #0x7C
	.db #0x42
	.db #0x42
	.db #0x7C
	.db #0x40
	.db #0x40
	.db #0x40
	.db #0x00
	.db #0x3C
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x46
	.db #0x3E
	.db #0x00
	.db #0x7C
	.db #0x42
	.db #0x42
	.db #0x7C
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x00
	.db #0x3E
	.db #0x40
	.db #0x40
	.db #0x3C
	.db #0x02
	.db #0x02
	.db #0x7C
	.db #0x00
	.db #0x7C
	.db #0x10
	.db #0x10
	.db #0x10
	.db #0x10
	.db #0x10
	.db #0x10
	.db #0x00
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x3C
	.db #0x00
	.db #0x44
	.db #0x44
	.db #0x44
	.db #0x44
	.db #0x44
	.db #0x28
	.db #0x10
	.db #0x00
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x42
	.db #0x5A
	.db #0x66
	.db #0x42
	.db #0x00
	.db #0x42
	.db #0x42
	.db #0x24
	.db #0x18
	.db #0x24
	.db #0x42
	.db #0x42
	.db #0x00
	.db #0x42
	.db #0x42
	.db #0x3E
	.db #0x02
	.db #0x02
	.db #0x42
	.db #0x3C
	.db #0x00
	.db #0x7E
	.db #0x02
	.db #0x04
	.db #0x08
	.db #0x10
	.db #0x20
	.db #0x7E
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0xFF
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
Fscreen$_str_0$0$0 == .
__str_0:
	.ascii "Screen cleared"
	.db 0x0A
	.db 0x00
	G$SetAttrib$0$0	= .
	.globl	G$SetAttrib$0$0
	C$screen.c$191$1$1	= .
	.globl	C$screen.c$191$1$1
;screen.c:191: void SetAttrib(char Attrib, short Row, short Column) {
;	---------------------------------
; Function SetAttrib
; ---------------------------------
_SetAttrib_start::
_SetAttrib:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	C$screen.c$192$1$1	= .
	.globl	C$screen.c$192$1$1
;screen.c:192: _SimUnprotect(0x4000, 0x5fff);
	ld	hl,#0x5FFF
	push	hl
	ld	hl,#0x4000
	push	hl
	call	__Z80SimUnprotect
	pop	af
	pop	af
	C$screen.c$193$1$1	= .
	.globl	C$screen.c$193$1$1
;screen.c:193: AttribMemory[Column+(Row<<5)]=Attrib;
	ld	c,6 (ix)
	ld	a,6 (ix)
	rla	
	sbc	a,a
	ld	b,a
	ld	e,5 (ix)
	ld	a,5 (ix)
	rla	
	sbc	a,a
	ld	d,a
	sla	e
	rl	d
	sla	e
	rl	d
	sla	e
	rl	d
	sla	e
	rl	d
	sla	e
	rl	d
	ld	a,c
	add	a,e
	ld	c,a
	ld	a,b
	adc	a,d
	ld	b,a
	ld	hl,#0x5800
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	a,4 (ix)
	ld	(bc),a
	C$screen.c$194$1$1	= .
	.globl	C$screen.c$194$1$1
;screen.c:194: _SimRWProtect(0x4000, 0x5fff);
	ld	hl,#0x5FFF
	push	hl
	ld	hl,#0x4000
	push	hl
	call	__Z80SimRWProtect
	pop	af
	pop	af
	pop	ix
	ld	a,#4
	rst	0x08
	C$screen.c$195$1$1	= .
	.globl	C$screen.c$195$1$1
	XG$SetAttrib$0$0	= .
	.globl	XG$SetAttrib$0$0
	ret
_SetAttrib_end::
	G$PutCharacter$0$0	= .
	.globl	G$PutCharacter$0$0
	C$screen.c$197$1$1	= .
	.globl	C$screen.c$197$1$1
;screen.c:197: void PutCharacter(char AsciiCode, short Row, short Column) {
;	---------------------------------
; Function PutCharacter
; ---------------------------------
_PutCharacter_start::
_PutCharacter:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-5
	add	hl,sp
	ld	sp,hl
	C$screen.c$201$1$1	= .
	.globl	C$screen.c$201$1$1
;screen.c:201: _SimUnprotect(0x4000, 0x5fff);
	ld	hl,#0x5FFF
	push	hl
	ld	hl,#0x4000
	push	hl
	call	__Z80SimUnprotect
	pop	af
	pop	af
	C$screen.c$202$1$1	= .
	.globl	C$screen.c$202$1$1
;screen.c:202: SectionStart=0; SectionOffset=Row;
	ld	c,5 (ix)
	C$screen.c$203$1$1	= .
	.globl	C$screen.c$203$1$1
;screen.c:203: while(SectionOffset>=8) {
	ld	-3 (ix),#0x00
	ld	-2 (ix),#0x00
00101$:
	C$screen.c$204$2$2	= .
	.globl	C$screen.c$204$2$2
;screen.c:204: SectionOffset-=8;
	ld	a,c
	cp	a,#0x08
	jp	M,00103$
	add	a,#0xF8
	ld	c,a
	C$screen.c$205$2$2	= .
	.globl	C$screen.c$205$2$2
;screen.c:205: SectionStart+=2048;
	ld	a,-3 (ix)
	add	a,#0x00
	ld	-3 (ix),a
	ld	a,-2 (ix)
	adc	a,#0x08
	ld	-2 (ix),a
	jr	00101$
00103$:
	C$screen.c$207$1$1	= .
	.globl	C$screen.c$207$1$1
;screen.c:207: CharStart=SectionStart+Column+((int)SectionOffset<<5);
	ld	b,6 (ix)
	ld	a,6 (ix)
	rla	
	sbc	a,a
	ld	e,a
	ld	a,-3 (ix)
	add	a,b
	ld	b,a
	ld	a,-2 (ix)
	adc	a,e
	ld	e,a
	ld	a,c
	rla	
	sbc	a,a
	ld	d,a
	sla	c
	rl	d
	sla	c
	rl	d
	sla	c
	rl	d
	sla	c
	rl	d
	sla	c
	rl	d
	ld	a,b
	add	a,c
	ld	b,a
	ld	a,e
	adc	a,d
	ld	e,a
	ld	-5 (ix),b
	ld	-4 (ix),e
	C$screen.c$208$2$3	= .
	.globl	C$screen.c$208$2$3
;screen.c:208: for(i=0; i<8; i++) {
	ld	-1 (ix),#0x00
00104$:
	ld	a,-1 (ix)
	sub	a,#0x08
	jp	P,00107$
	C$screen.c$209$2$3	= .
	.globl	C$screen.c$209$2$3
;screen.c:209: ScreenMemory[CharStart+((int)i<<8)]=CharacterSet[AsciiCode-' '][i];
	ld	d,-1 (ix)
	ld	a,-1 (ix)
	rla	
	sbc	a,a
	ld	c,d
	ld	d,#0x00
	ld	a,-5 (ix)
	add	a,d
	ld	d,a
	ld	a,-4 (ix)
	adc	a,c
	add	a,#0x40
	ld	c,a
	ld	b,4 (ix)
	ld	a,4 (ix)
	rla	
	sbc	a,a
	ld	e,a
	ld	a,b
	add	a,#0xE0
	ld	b,a
	ld	a,e
	adc	a,#0xFF
	ld	e,a
	sla	b
	rl	e
	sla	b
	rl	e
	sla	b
	rl	e
	ld	a,#<_CharacterSet
	add	a,b
	ld	b,a
	ld	a,#>_CharacterSet
	adc	a,e
	ld	e,a
	ld	a,b
	add	a,-1 (ix)
	ld	l,a
	ld	a,e
	adc	a,#0x00
	ld	h,a
	ld	a,(hl)
	ld	l,d
	ld	h,c
	ld	(hl),a
	C$screen.c$208$1$1	= .
	.globl	C$screen.c$208$1$1
;screen.c:208: for(i=0; i<8; i++) {
	inc	-1 (ix)
	jp	00104$
00107$:
	C$screen.c$211$1$1	= .
	.globl	C$screen.c$211$1$1
;screen.c:211: _SimRWProtect(0x4000, 0x5fff);
	ld	hl,#0x5FFF
	push	hl
	ld	hl,#0x4000
	push	hl
	call	__Z80SimRWProtect
	pop	af
	pop	af
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	C$screen.c$212$1$1	= .
	.globl	C$screen.c$212$1$1
	XG$PutCharacter$0$0	= .
	.globl	XG$PutCharacter$0$0
	ret
_PutCharacter_end::
	G$PutString$0$0	= .
	.globl	G$PutString$0$0
	C$screen.c$214$1$1	= .
	.globl	C$screen.c$214$1$1
;screen.c:214: void PutString(char* String, short Row, short Column) {
;	---------------------------------
; Function PutString
; ---------------------------------
_PutString_start::
_PutString:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
	C$screen.c$217$1$1	= .
	.globl	C$screen.c$217$1$1
;screen.c:217: Length=StringLength(String);
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_StringLength
	pop	af
	ld	-1 (ix),l
	C$screen.c$218$1$1	= .
	.globl	C$screen.c$218$1$1
;screen.c:218: for(i=0; i<Length; i++) {
	ld	b,#0x00
00101$:
	ld	a,b
	sub	a,-1 (ix)
	jp	P,00104$
	C$screen.c$219$2$2	= .
	.globl	C$screen.c$219$2$2
;screen.c:219: PutCharacter(String[i], Row, Column+i);
	ld	a,7 (ix)
	add	a,b
	ld	e,a
	ld	a,4 (ix)
	add	a,b
	ld	d,a
	ld	a,5 (ix)
	adc	a,#0x00
	ld	c,a
	ld	l,d
	ld	h,a
	ld	d,(hl)
	push	bc
	ld	a,e
	push	af
	inc	sp
	ld	a,6 (ix)
	push	af
	inc	sp
	push	de
	inc	sp
	call	_PutCharacter
	pop	af
	inc	sp
	pop	bc
	C$screen.c$218$1$1	= .
	.globl	C$screen.c$218$1$1
;screen.c:218: for(i=0; i<Length; i++) {
	inc	b
	jr	00101$
00104$:
	C$screen.c$221$1$1	= .
	.globl	C$screen.c$221$1$1
;screen.c:221: _SimPrintString("String: ");
	ld	hl,#__str_1
	push	hl
	call	__Z80SimPrintString
	pop	af
	C$screen.c$222$1$1	= .
	.globl	C$screen.c$222$1$1
;screen.c:222: _SimPrintString(String);
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	__Z80SimPrintString
	pop	af
	C$screen.c$223$1$1	= .
	.globl	C$screen.c$223$1$1
;screen.c:223: _SimPrintCharacter('\n');
	ld	a,#0x0A
	push	af
	inc	sp
	call	__Z80SimPrintCharacter
	inc	sp
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	C$screen.c$224$1$1	= .
	.globl	C$screen.c$224$1$1
	XG$PutString$0$0	= .
	.globl	XG$PutString$0$0
	ret
_PutString_end::
Fscreen$_str_1$0$0 == .
__str_1:
	.ascii "String: "
	.db 0x00
	.area _CODE
	.area _CABS