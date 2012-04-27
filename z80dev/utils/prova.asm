;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sun Oct  5 23:40:55 2003

;--------------------------------------------------------
	.module prova
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
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
;prova.c:5: void main() {
;	genLabel
;	genFunction
;	---------------------------------
; Function main
; ---------------------------------
_main_start::
_main:
;prova.c:6: SimulatorWriteString("Hello, world!\n\n");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_0
	push	hl
;	genCall
	call	_SimulatorWriteString
	pop	af
;prova.c:7: SimulatorTerminate();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_SimulatorTerminate
;	genLabel
00101$:
;	genEndFunction
	ret
_main_end::
__str_0:
	.ascii "Hello, world!"
	.db 0x0A
	.db 0x0A
	.db 0x00
	.area _CODE
