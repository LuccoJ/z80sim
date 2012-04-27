;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Fri Apr 27 12:30:18 2012

;--------------------------------------------------------
	.module exceptions
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _Alert
	.globl _GetRegister
	.globl _RegValue
	.globl _SavedIY
	.globl _SavedIX
	.globl _SavedPC
	.globl _SystemLock
	.globl _Halt
	.globl _Break
	.globl _SystemMonitor
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
G$SystemLock$0$0==.
_SystemLock::
	.ds 1
G$SavedPC$0$0==.
_SavedPC::
	.ds 2
G$SavedIX$0$0==.
_SavedIX::
	.ds 2
G$SavedIY$0$0==.
_SavedIY::
	.ds 2
G$RegValue$0$0==.
_RegValue::
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
;exceptions.c:18: unsigned int GetRegister(enum {PC, SP, A, BC, DE, HL, IX, IY} Reg) {
;	genLabel
;	genFunction
;	---------------------------------
; Function GetRegister
; ---------------------------------
_GetRegister_start::
_GetRegister:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
;exceptions.c:19: switch(Reg) {
;	genCmpLt
;	AOP_STK for 
	ld	a,4(ix)
	sub	a,#0x01
	jp	m,00108$
;	genCmpGt
;	AOP_STK for 
	ld	a,#0x07
	sub	a,4(ix)
	jp	m,00108$
;	genMinus
;	AOP_STK for 
	ld	a,4(ix)
	add	a,#0xFF
	ld	c,a
;	genJumpTab
	push	de
	ld	e,c
	ld	d,#0x00
	ld	hl,#00114$
	add	hl,de
	add	hl,de
	add	hl,de
	pop	de
	jp	(hl)
00114$:
	jp	00101$
	jp	00102$
	jp	00103$
	jp	00104$
	jp	00105$
	jp	00106$
	jp	00107$
;exceptions.c:25: _endasm;
;	genLabel
00101$:
;	genInline
;
		               exx
		               ld (_RegValue),sp
		               exx
		               
;exceptions.c:26: break;
;	genGoto
	jp	00109$
;exceptions.c:32: _endasm;
;	genLabel
00102$:
;	genInline
;
		               ex af,af
		               ld (_RegValue),a
		               ex af,af
		               
;exceptions.c:33: break;
;	genGoto
	jp	00109$
;exceptions.c:39: _endasm;
;	genLabel
00103$:
;	genInline
;
		               exx
		               ld (_RegValue),de
		               exx
		               
;exceptions.c:40: break;
;	genGoto
	jp	00109$
;exceptions.c:46: _endasm;
;	genLabel
00104$:
;	genInline
;
		               exx
		               ld (_RegValue),de
		               exx
		               
;exceptions.c:47: break;
;	genGoto
	jp	00109$
;exceptions.c:53: _endasm;
;	genLabel
00105$:
;	genInline
;
		               exx
		               ld (_RegValue),hl
		               exx
		               
;exceptions.c:54: break;
;	genGoto
	jp	00109$
;exceptions.c:60: _endasm;
;	genLabel
00106$:
;	genInline
;
		               exx
		               ld (_RegValue),ix
		               exx
		               
;exceptions.c:61: break;
;	genGoto
	jp	00109$
;exceptions.c:67: _endasm;
;	genLabel
00107$:
;	genInline
;
		               exx
		               ld (_RegValue),iy
		               exx
		               
;exceptions.c:68: break;
;	genGoto
	jp	00109$
;exceptions.c:70: RegValue=0;
;	genLabel
00108$:
;	genAssign
	ld	iy,#_RegValue
	ld	0(iy),#0x00
	ld	1(iy),#0x00
;exceptions.c:71: }
;	genLabel
00109$:
;exceptions.c:76: _endasm;
;	genInline
;
		       ld hl,(_RegValue)
		       pop ix
		       ret
		       
;exceptions.c:77: return RegValue;
;	genRet
; Dump of IC_LEFT: type AOP_IY size 2
	ld	hl,(_RegValue)
;	genLabel
00110$:
;	genEndFunction
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_GetRegister_end::
;exceptions.c:81: void Alert(enum {alertHalt, alertBreak} Type, char* Message) {
;	genLabel
;	genFunction
;	---------------------------------
; Function Alert
; ---------------------------------
_Alert_start::
_Alert:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-16
	add	hl,sp
	ld	sp,hl
;exceptions.c:83: Pause();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_Pause
;exceptions.c:85: _SimPrintString("-------------------\n");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_0
	push	hl
;	genCall
	call	__Z80SimPrintString
	pop	af
;exceptions.c:86: if(Type==alertBreak) {
;	genCmpEq
;	AOP_STK for 
; genCmpEq: left 1, right 1, result 1
;4
	ld	a,4(ix)
	cp	a,#0x01
	jp	nz,00117$
	ld	a,#0x01
	jp	00118$
00117$:
	xor	a,a
00118$:
;6
	ld	c,a
;	genIfx
	xor	a,a
	or	a,c
	jp	z,00102$
;exceptions.c:87: _SimPrintString("BREAK: ");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#__str_1
	push	hl
;	genCall
	call	__Z80SimPrintString
	pop	af
	pop	bc
;exceptions.c:88: _SimPrintString(Message);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
;	AOP_STK for 
	ld	l,5(ix)
	ld	h,6(ix)
	push	hl
;	genCall
	call	__Z80SimPrintString
	pop	af
	pop	bc
;exceptions.c:89: _SimPrintString("\n");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#__str_2
	push	hl
;	genCall
	call	__Z80SimPrintString
	pop	af
	pop	bc
;exceptions.c:90: _SimPrintString("-------------------\n");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#__str_0
	push	hl
;	genCall
	call	__Z80SimPrintString
	pop	af
	pop	bc
;exceptions.c:91: _SimDumpRegs();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	call	__SimDumpRegs
	pop	bc
;exceptions.c:92: _SimPrintString("-------------------\n");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#__str_0
	push	hl
;	genCall
	call	__Z80SimPrintString
	pop	af
	pop	bc
;	genGoto
	jp	00103$
;	genLabel
00102$:
;exceptions.c:94: _SimPrintString("HALT: ");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#__str_3
	push	hl
;	genCall
	call	__Z80SimPrintString
	pop	af
	pop	bc
;exceptions.c:95: _SimPrintString(Message);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
;	AOP_STK for 
	ld	l,5(ix)
	ld	h,6(ix)
	push	hl
;	genCall
	call	__Z80SimPrintString
	pop	af
	pop	bc
;exceptions.c:96: _SimPrintString("\n");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#__str_2
	push	hl
;	genCall
	call	__Z80SimPrintString
	pop	af
	pop	bc
;exceptions.c:97: _SimPrintString("-------------------\n");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#__str_0
	push	hl
;	genCall
	call	__Z80SimPrintString
	pop	af
	pop	bc
;exceptions.c:98: _SimDumpRegs();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	call	__SimDumpRegs
	pop	bc
;exceptions.c:99: _SimPrintString("-------------------\n");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#__str_0
	push	hl
;	genCall
	call	__Z80SimPrintString
	pop	af
	pop	bc
;exceptions.c:100: _SimTerminate();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	call	__Z80SimTerminate
	pop	bc
;	genLabel
00103$:
;exceptions.c:104: PutString("\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4", 18, 0);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0012
	push	hl
;	genIpush
	ld	hl,#__str_4
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;exceptions.c:105: PutString("                                ", 19, 0);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0013
	push	hl
;	genIpush
	ld	hl,#__str_5
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;exceptions.c:106: PutString("\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4", 20, 0);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0014
	push	hl
;	genIpush
	ld	hl,#__str_4
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;exceptions.c:107: PutString("                                ", 21, 0);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0015
	push	hl
;	genIpush
	ld	hl,#__str_5
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;exceptions.c:108: PutString("                                ", 22, 0);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0016
	push	hl
;	genIpush
	ld	hl,#__str_5
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;exceptions.c:109: PutString("                                ", 23, 0);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0017
	push	hl
;	genIpush
	ld	hl,#__str_5
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;exceptions.c:110: SetAttrib(SCRATTR_FLASH|SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 1);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0113
	push	hl
;	genIpush
	ld	a,#0xB9
	push	af
	inc	sp
;	genCall
	call	_SetAttrib
	pop	af
	inc	sp
	pop	bc
;exceptions.c:111: SetAttrib(SCRATTR_FLASH|SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 2);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0213
	push	hl
;	genIpush
	ld	a,#0xB9
	push	af
	inc	sp
;	genCall
	call	_SetAttrib
	pop	af
	inc	sp
	pop	bc
;exceptions.c:112: SetAttrib(SCRATTR_FLASH|SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 3);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0313
	push	hl
;	genIpush
	ld	a,#0xB9
	push	af
	inc	sp
;	genCall
	call	_SetAttrib
	pop	af
	inc	sp
	pop	bc
;exceptions.c:113: SetAttrib(SCRATTR_FLASH|SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 4);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0413
	push	hl
;	genIpush
	ld	a,#0xB9
	push	af
	inc	sp
;	genCall
	call	_SetAttrib
	pop	af
	inc	sp
	pop	bc
;exceptions.c:114: if(Type==alertBreak) {
;	genIfx
	xor	a,a
	or	a,c
	jp	z,00105$
;exceptions.c:115: SetAttrib(SCRATTR_FLASH|SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 5);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0513
	push	hl
;	genIpush
	ld	a,#0xB9
	push	af
	inc	sp
;	genCall
	call	_SetAttrib
	pop	af
	inc	sp
;exceptions.c:116: PutString(" BREAK ", 19, 0);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0013
	push	hl
;	genIpush
	ld	hl,#__str_6
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
;exceptions.c:117: PutString(Message, 19, 7);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0713
	push	hl
;	genIpush
;	AOP_STK for 
	ld	l,5(ix)
	ld	h,6(ix)
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
;	genGoto
	jp	00106$
;	genLabel
00105$:
;exceptions.c:119: PutString(" HALT ", 19, 0);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0013
	push	hl
;	genIpush
	ld	hl,#__str_7
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
;exceptions.c:120: PutString(Message, 19, 6);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0613
	push	hl
;	genIpush
;	AOP_STK for 
	ld	l,5(ix)
	ld	h,6(ix)
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
;	genLabel
00106$:
;exceptions.c:123: PutString(" A", 21, 2);	WordToHex(GetRegister(A), Value); PutString(Value, 21, 5);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0215
	push	hl
;	genIpush
	ld	hl,#__str_8
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
;	genAddrOf
	ld	hl,#0x0000
	add	hl,sp
	ld	c,l
	ld	b,h
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,#0x02
	push	af
	inc	sp
;	genCall
	call	_GetRegister
	ld	d,h
	ld	e,l
	inc	sp
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	push	bc
;	genIpush
	push	de
;	genCall
	call	_WordToHex
	pop	af
	pop	af
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0515
	push	hl
;	genIpush
	push	bc
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;exceptions.c:124: PutString("BC", 21, 12); WordToHex(GetRegister(BC), Value); PutString(Value, 21, 15);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0C15
	push	hl
;	genIpush
	ld	hl,#__str_9
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,#0x03
	push	af
	inc	sp
;	genCall
	call	_GetRegister
	ld	d,h
	ld	e,l
	inc	sp
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	push	bc
;	genIpush
	push	de
;	genCall
	call	_WordToHex
	pop	af
	pop	af
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0F15
	push	hl
;	genIpush
	push	bc
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;exceptions.c:125: PutString("DE", 21, 22); WordToHex(GetRegister(DE), Value); PutString(Value, 21, 25);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x1615
	push	hl
;	genIpush
	ld	hl,#__str_10
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,#0x04
	push	af
	inc	sp
;	genCall
	call	_GetRegister
	ld	d,h
	ld	e,l
	inc	sp
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	push	bc
;	genIpush
	push	de
;	genCall
	call	_WordToHex
	pop	af
	pop	af
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x1915
	push	hl
;	genIpush
	push	bc
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;exceptions.c:127: PutString("HL", 22, 2); WordToHex(GetRegister(HL), Value); PutString(Value, 22, 5);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0216
	push	hl
;	genIpush
	ld	hl,#__str_11
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,#0x05
	push	af
	inc	sp
;	genCall
	call	_GetRegister
	ld	d,h
	ld	e,l
	inc	sp
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	push	bc
;	genIpush
	push	de
;	genCall
	call	_WordToHex
	pop	af
	pop	af
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0516
	push	hl
;	genIpush
	push	bc
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;exceptions.c:128: PutString("IX", 22, 12); WordToHex(SavedIX, Value); PutString(Value, 22, 15);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0C16
	push	hl
;	genIpush
	ld	hl,#__str_12
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	push	bc
;	genIpush
	ld	hl,(_SavedIX)
	push	hl
;	genCall
	call	_WordToHex
	pop	af
	pop	af
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0F16
	push	hl
;	genIpush
	push	bc
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;exceptions.c:129: PutString("IY", 22, 22); WordToHex(SavedIY, Value); PutString(Value, 22, 25);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x1616
	push	hl
;	genIpush
	ld	hl,#__str_13
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	push	bc
;	genIpush
	ld	hl,(_SavedIY)
	push	hl
;	genCall
	call	_WordToHex
	pop	af
	pop	af
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x1916
	push	hl
;	genIpush
	push	bc
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;exceptions.c:131: PutString("SP", 23, 2); WordToHex(GetRegister(SP), Value); PutString(Value, 23, 5);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0217
	push	hl
;	genIpush
	ld	hl,#__str_14
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,#0x01
	push	af
	inc	sp
;	genCall
	call	_GetRegister
	ld	d,h
	ld	e,l
	inc	sp
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	push	bc
;	genIpush
	push	de
;	genCall
	call	_WordToHex
	pop	af
	pop	af
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0517
	push	hl
;	genIpush
	push	bc
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;exceptions.c:132: PutString("PC", 23, 12); WordToHex(SavedPC, Value); PutString(Value, 23, 15);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x0C17
	push	hl
;	genIpush
	ld	hl,#__str_15
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	push	bc
;	genIpush
	ld	hl,(_SavedPC)
	push	hl
;	genCall
	call	_WordToHex
	pop	af
	pop	af
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0F17
	push	hl
;	genIpush
	push	bc
;	genCall
	call	_PutString
	pop	af
	pop	af
;exceptions.c:134: Beep();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_Beep
;exceptions.c:136: Resume();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_Resume
;exceptions.c:138: Sleep(350);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x015E
	push	hl
;	genCall
	call	_Sleep
	pop	af
	pop	af
;exceptions.c:139: if(Type==alertHalt) for(;;);
;	genCmpEq
;	AOP_STK for 
; genCmpEq: left 1, right 1, result 0
	ld	a,4(ix)
	or	a,a
	jp	z,00120$
00119$:
	jp	00108$
00120$:
;	genLabel
00110$:
;	genGoto
	jp	00110$
;	genLabel
00108$:
;exceptions.c:140: PutString("                                ", 18, 0);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0012
	push	hl
;	genIpush
	ld	hl,#__str_5
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
;exceptions.c:141: PutString("                                ", 19, 0);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0013
	push	hl
;	genIpush
	ld	hl,#__str_5
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
;exceptions.c:142: PutString("                                ", 20, 0);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0014
	push	hl
;	genIpush
	ld	hl,#__str_5
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
;exceptions.c:143: PutString("                                ", 21, 0);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0015
	push	hl
;	genIpush
	ld	hl,#__str_5
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
;exceptions.c:144: PutString("                                ", 22, 0);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0016
	push	hl
;	genIpush
	ld	hl,#__str_5
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
;exceptions.c:145: PutString("                                ", 23, 0);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0017
	push	hl
;	genIpush
	ld	hl,#__str_5
	push	hl
;	genCall
	call	_PutString
	pop	af
	pop	af
;exceptions.c:146: SetAttrib(SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 1);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0113
	push	hl
;	genIpush
	ld	a,#0x39
	push	af
	inc	sp
;	genCall
	call	_SetAttrib
	pop	af
	inc	sp
;exceptions.c:147: SetAttrib(SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 2);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0213
	push	hl
;	genIpush
	ld	a,#0x39
	push	af
	inc	sp
;	genCall
	call	_SetAttrib
	pop	af
	inc	sp
;exceptions.c:148: SetAttrib(SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 3);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0313
	push	hl
;	genIpush
	ld	a,#0x39
	push	af
	inc	sp
;	genCall
	call	_SetAttrib
	pop	af
	inc	sp
;exceptions.c:149: SetAttrib(SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 4);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0413
	push	hl
;	genIpush
	ld	a,#0x39
	push	af
	inc	sp
;	genCall
	call	_SetAttrib
	pop	af
	inc	sp
;exceptions.c:150: SetAttrib(SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 5);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0513
	push	hl
;	genIpush
	ld	a,#0x39
	push	af
	inc	sp
;	genCall
	call	_SetAttrib
	pop	af
	inc	sp
;	genLabel
00112$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_Alert_end::
Fexceptions$_str_0$0$0 == .
__str_0:
	.ascii "-------------------"
	.db 0x0A
	.db 0x00
Fexceptions$_str_1$0$0 == .
__str_1:
	.ascii "BREAK: "
	.db 0x00
Fexceptions$_str_2$0$0 == .
__str_2:
	.db 0x0A
	.db 0x00
Fexceptions$_str_3$0$0 == .
__str_3:
	.ascii "HALT: "
	.db 0x00
Fexceptions$_str_4$0$0 == .
__str_4:
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0xC4
	.db 0x00
Fexceptions$_str_5$0$0 == .
__str_5:
	.ascii "                                "
	.db 0x00
Fexceptions$_str_6$0$0 == .
__str_6:
	.ascii " BREAK "
	.db 0x00
Fexceptions$_str_7$0$0 == .
__str_7:
	.ascii " HALT "
	.db 0x00
Fexceptions$_str_8$0$0 == .
__str_8:
	.ascii " A"
	.db 0x00
Fexceptions$_str_9$0$0 == .
__str_9:
	.ascii "BC"
	.db 0x00
Fexceptions$_str_10$0$0 == .
__str_10:
	.ascii "DE"
	.db 0x00
Fexceptions$_str_11$0$0 == .
__str_11:
	.ascii "HL"
	.db 0x00
Fexceptions$_str_12$0$0 == .
__str_12:
	.ascii "IX"
	.db 0x00
Fexceptions$_str_13$0$0 == .
__str_13:
	.ascii "IY"
	.db 0x00
Fexceptions$_str_14$0$0 == .
__str_14:
	.ascii "SP"
	.db 0x00
Fexceptions$_str_15$0$0 == .
__str_15:
	.ascii "PC"
	.db 0x00
;exceptions.c:153: void Halt(char* ErrorMessage) {
;	genLabel
;	genFunction
;	---------------------------------
; Function Halt
; ---------------------------------
_Halt_start::
_Halt:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
;exceptions.c:155: Alert(alertHalt, ErrorMessage);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
;	AOP_STK for 
	ld	l,4(ix)
	ld	h,5(ix)
	push	hl
;	genIpush
	ld	a,#0x00
	push	af
	inc	sp
;	genCall
	call	_Alert
	pop	af
	inc	sp
;	genLabel
00101$:
;	genEndFunction
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_Halt_end::
;exceptions.c:158: void Break(char* Message) {
;	genLabel
;	genFunction
;	---------------------------------
; Function Break
; ---------------------------------
_Break_start::
_Break:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
;exceptions.c:159: LockObtain(SystemLock);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,(_SystemLock)
	push	af
	inc	sp
;	genCall
	call	_LockObtain
	inc	sp
;exceptions.c:170: _endasm;
;	genInline
;
		       ld (_SavedIY),iy
		       pop bc
		       ld (_SavedIX),hl
		       pop hl
		       pop de
		       ld (_SavedPC),de
		       push de
		       push hl
		       push bc
		       
;exceptions.c:171: ExchangeRegs();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_ExchangeRegs
;exceptions.c:172: Alert(alertBreak, Message);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
;	AOP_STK for 
	ld	l,4(ix)
	ld	h,5(ix)
	push	hl
;	genIpush
	ld	a,#0x01
	push	af
	inc	sp
;	genCall
	call	_Alert
	pop	af
	inc	sp
;exceptions.c:173: ExchangeRegs();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_ExchangeRegs
;exceptions.c:174: LockRelease(SystemLock);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,(_SystemLock)
	push	af
	inc	sp
;	genCall
	call	_LockRelease
	inc	sp
;	genLabel
00101$:
;	genEndFunction
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_Break_end::
;exceptions.c:177: void SystemMonitor() {
;	genLabel
;	genFunction
;	---------------------------------
; Function SystemMonitor
; ---------------------------------
_SystemMonitor_start::
_SystemMonitor:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-256
	add	hl,sp
	ld	sp,hl
;exceptions.c:179: ConsoleWrite("SYSTEM MONITOR\n");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_16
	push	hl
;	genCall
	call	_ConsoleWrite
	pop	af
;exceptions.c:180: do {
;	genLabel
00105$:
;exceptions.c:181: ConsoleWrite(") ");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_17
	push	hl
;	genCall
	call	_ConsoleWrite
	pop	af
;exceptions.c:182: ConsoleReadLine(CommandLine);
;	genAddrOf
	ld	hl,#0x0000
	add	hl,sp
	ld	c,l
	ld	b,h
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	push	bc
;	genCall
	call	_ConsoleReadLine
	pop	af
	pop	bc
;exceptions.c:183: if(!IsMultitasking()) Halt("PAUSE WITHOUT RESUME");
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	call	_IsMultitasking
	pop	bc
;	genIfx
	xor	a,a
	or	a,l
	jp	nz,00102$
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#__str_18
	push	hl
;	genCall
	call	_Halt
	pop	af
	pop	bc
;	genLabel
00102$:
;exceptions.c:184: if(SameString("HELP", CommandLine)) {
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	bc
;	genIpush
	ld	hl,#__str_19
	push	hl
;	genCall
	call	_SameString
	pop	af
	pop	af
;	genIfx
	xor	a,a
	or	a,l
	jp	z,00105$
;exceptions.c:185: ConsoleWrite("THIS IS THE SYSTEM MONITOR OF\nLJL OS. THERE IS NO HELP SYSTEM\nAT THE MOMENT.\n");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_20
	push	hl
;	genCall
	call	_ConsoleWrite
	pop	af
;exceptions.c:187: } while(1);
;	genGoto
	jp	00105$
;	genLabel
00108$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_SystemMonitor_end::
Fexceptions$_str_16$0$0 == .
__str_16:
	.ascii "SYSTEM MONITOR"
	.db 0x0A
	.db 0x00
Fexceptions$_str_17$0$0 == .
__str_17:
	.ascii ") "
	.db 0x00
Fexceptions$_str_18$0$0 == .
__str_18:
	.ascii "PAUSE WITHOUT RESUME"
	.db 0x00
Fexceptions$_str_19$0$0 == .
__str_19:
	.ascii "HELP"
	.db 0x00
Fexceptions$_str_20$0$0 == .
__str_20:
	.ascii "THIS IS THE SYSTEM MONITOR OF"
	.db 0x0A
	.ascii "LJL OS. THERE IS NO HELP SYSTE"
	.ascii "M"
	.db 0x0A
	.ascii "AT THE MOMENT."
	.db 0x0A
	.db 0x00
	.area _CODE
