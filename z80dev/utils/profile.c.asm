;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sun Oct  5 22:44:33 2003

;--------------------------------------------------------
	.module profile
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _test
	.globl _SimulatorTerminate
	.globl _SimulatorWriteCharacter
	.globl _SimulatorWriteString
	.globl _SimulatorEnterProfile
	.globl _SimulatorExitProfile
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
_test::
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
;profile.c:5: void SimulatorTerminate() {
;	genLabel
;	genFunction
;	---------------------------------
; Function SimulatorTerminate
; ---------------------------------
_SimulatorTerminate_start::
_SimulatorTerminate:
;profile.c:9: _endasm;
;	genInline
	
		       ld a,#0
		       rst 0x08
		       
;	genLabel
00101$:
;	genEndFunction
	ret
_SimulatorTerminate_end::
;profile.c:12: void SimulatorWriteCharacter(char Character) {
;	genLabel
;	genFunction
;	---------------------------------
; Function SimulatorWriteCharacter
; ---------------------------------
_SimulatorWriteCharacter_start::
_SimulatorWriteCharacter:
	push	ix
	ld	ix,#0
	add	ix,sp
;profile.c:21: _endasm;
;	genInline
;
		       ld a,4(ix)
		       push hl
		       ld l,a
		       ld a,#1
		       rst 0x08
		       pop hl
		       
;	genLabel
00101$:
;	genEndFunction
	pop	ix
	ret
_SimulatorWriteCharacter_end::
;profile.c:24: void SimulatorWriteString(char* String) {
;	genLabel
;	genFunction
;	---------------------------------
; Function SimulatorWriteString
; ---------------------------------
_SimulatorWriteString_start::
_SimulatorWriteString:
	push	ix
	ld	ix,#0
	add	ix,sp
;profile.c:27: while(String[i]!='\0') {
;	genAssign
	ld	bc,#0x0000
;	genLabel
00101$:
;	genPlus
;	AOP_STK for 
;	Can't optimise plus by inc, falling back to the normal way
	ld	l,4(ix)
	ld	h,5(ix)
	add	hl,bc
;	genPointerGet
	ld	l,(hl)
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	a,l
	or	a,a
	jp	z,00104$
00108$:
;profile.c:28: SimulatorWriteCharacter(String[i]);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,l
	push	af
	inc	sp
;	genCall
	call	_SimulatorWriteCharacter
	inc	sp
	pop	bc
;profile.c:29: i++;
;	genPlus
;	genPlusIncr
	inc	bc
;	genGoto
	jp	00101$
;	genLabel
00104$:
;	genEndFunction
	pop	ix
	ret
_SimulatorWriteString_end::
;profile.c:33: void SimulatorEnterProfile() {
;	genLabel
;	genFunction
;	---------------------------------
; Function SimulatorEnterProfile
; ---------------------------------
_SimulatorEnterProfile_start::
_SimulatorEnterProfile:
;profile.c:37: _endasm;
;	genInline
	
		       ld a,#3
		       rst 0x08
		       
;	genLabel
00101$:
;	genEndFunction
	ret
_SimulatorEnterProfile_end::
;profile.c:40: void SimulatorExitProfile() {
;	genLabel
;	genFunction
;	---------------------------------
; Function SimulatorExitProfile
; ---------------------------------
_SimulatorExitProfile_start::
_SimulatorExitProfile:
;profile.c:44: _endasm;
;	genInline
	
		       ld a,#4
		       rst 0x08
		       
;	genLabel
00101$:
;	genEndFunction
	ret
_SimulatorExitProfile_end::
	.area _CODE
