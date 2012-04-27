;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Feb  3 2010) (UNIX)
; This file was generated Fri Apr 27 12:42:17 2012
;--------------------------------------------------------
	.module z80
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ActiveRegBank
	.globl _HardwareInit
	.globl _ExchangeRegs
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
G$ActiveRegBank$0$0==.
_ActiveRegBank::
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
	G$HardwareInit$0$0	= .
	.globl	G$HardwareInit$0$0
	C$z80.c$5$0$0	= .
	.globl	C$z80.c$5$0$0
;z80.c:5: void HardwareInit() {
;	---------------------------------
; Function HardwareInit
; ---------------------------------
_HardwareInit_start::
_HardwareInit:
	ld	a,#3
	rst	0x08
	C$z80.c$6$1$1	= .
	.globl	C$z80.c$6$1$1
;z80.c:6: ActiveRegBank=0;
	ld	hl,#_ActiveRegBank + 0
	ld	(hl), #0x00
	ld	a,#4
	rst	0x08
	C$z80.c$7$1$1	= .
	.globl	C$z80.c$7$1$1
	XG$HardwareInit$0$0	= .
	.globl	XG$HardwareInit$0$0
	ret
_HardwareInit_end::
	G$ExchangeRegs$0$0	= .
	.globl	G$ExchangeRegs$0$0
	C$z80.c$9$1$1	= .
	.globl	C$z80.c$9$1$1
;z80.c:9: void ExchangeRegs() {
;	---------------------------------
; Function ExchangeRegs
; ---------------------------------
_ExchangeRegs_start::
_ExchangeRegs:
	ld	a,#3
	rst	0x08
	C$z80.c$18$1$1	= .
	.globl	C$z80.c$18$1$1
;z80.c:18: _endasm;
;
		       push af
		       ld a,(_ActiveRegBank)
		       cpl
		       ld (_ActiveRegBank),a
		       pop af
		       exx
		       ex af,af
		       
	ld	a,#4
	rst	0x08
	C$z80.c$19$1$1	= .
	.globl	C$z80.c$19$1$1
	XG$ExchangeRegs$0$0	= .
	.globl	XG$ExchangeRegs$0$0
	ret
_ExchangeRegs_end::
	.area _CODE
	.area _CABS
