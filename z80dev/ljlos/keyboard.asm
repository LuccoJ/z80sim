;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Fri Apr 27 12:30:19 2012

;--------------------------------------------------------
	.module keyboard
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _KeyboardInited
	.globl _KeyboardPollCount
	.globl _KeyboardBufferCount
	.globl _KeyboardBuffer
	.globl _KeyTable
	.globl _SystemLock
	.globl _KeyboardInit
	.globl _PollKeyboard
	.globl _GetKeypress
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
G$SystemLock$0$0==.
_SystemLock::
	.ds 1
G$KeyTable$0$0==.
_KeyTable::
	.ds 8
G$KeyboardBuffer$0$0==.
_KeyboardBuffer::
	.ds 32
G$KeyboardBufferCount$0$0==.
_KeyboardBufferCount::
	.ds 1
G$KeyboardPollCount$0$0==.
_KeyboardPollCount::
	.ds 1
G$KeyboardInited$0$0==.
_KeyboardInited::
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
;keyboard.c:19: bool KeyboardInited; void KeyboardInit() {
;	genLabel
;	genFunction
;	---------------------------------
; Function KeyboardInit
; ---------------------------------
_KeyboardInit_start::
_KeyboardInit:
	ld	a,#3
	rst	0x08
;keyboard.c:20: if(!KeyboardInited) {
;	genIfx
	xor	a,a
	ld	iy,#_KeyboardInited
	or	a,0(iy)
	jp	nz,00103$
;keyboard.c:21: RegisterInterrupt(PollKeyboard);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#_PollKeyboard
	push	hl
;	genCall
	call	_RegisterInterrupt
	pop	af
;keyboard.c:22: KeyboardBufferCount=0;
;	genAssign
	ld	iy,#_KeyboardBufferCount
	ld	0(iy),#0x00
;keyboard.c:23: KeyboardPollCount=0;
;	genAssign
	ld	iy,#_KeyboardPollCount
	ld	0(iy),#0x00
;keyboard.c:24: _SimPrintString("Keyboard initialized\n");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_0
	push	hl
;	genCall
	call	__Z80SimPrintString
	pop	af
;	genLabel
00103$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
_KeyboardInit_end::
Fkeyboard$_str_0$0$0 == .
__str_0:
	.ascii "Keyboard initialized"
	.db 0x0A
	.db 0x00
;keyboard.c:28: void PollKeyboard() {
;	genLabel
;	genFunction
;	---------------------------------
; Function PollKeyboard
; ---------------------------------
_PollKeyboard_start::
_PollKeyboard:
	ld	a,#3
	rst	0x08
;keyboard.c:46: _endasm;
;	genInline
;
		       push af
		       push bc
		       push hl
		       ld bc,#0xfefe
		       ld hl,#_KeyTable
        KeyboardLoop:
		       in a,(c)
		       cpl
		       ld (hl),a
		       inc hl
		       rlc b
		       jp c,KeyboardLoop
		       pop af
		       pop bc
		       pop hl
		       
;keyboard.c:47: if(KeyboardPollCount>0) {
;	genCmpGt
	ld	a,#0x00
	ld	iy,#_KeyboardPollCount
	sub	a,0(iy)
	jp	p,00221$
;keyboard.c:48: KeyboardPollCount--;
;	genMinus
	dec	0(iy)
;	genGoto
	jp	00223$
;	genLabel
00221$:
;keyboard.c:50: Char='\0';
;	genAssign
	ld	c,#0x00
;keyboard.c:51: if(KeyTable[0]&0x02) Char='z';
;	genPointerGet
	ld	hl,#_KeyTable
	ld	b,(hl)
;	genAnd
	ld	a,b
	and	a,#0x02
	jp	z,00110$
00270$:
;	genAssign
	ld	c,#0x7A
;	genGoto
	jp	00111$
;	genLabel
00110$:
;keyboard.c:52: else if(KeyTable[0]&0x04) Char='x';
;	genAnd
	ld	a,b
	and	a,#0x04
	jp	z,00107$
00271$:
;	genAssign
	ld	c,#0x78
;	genGoto
	jp	00111$
;	genLabel
00107$:
;keyboard.c:53: else if(KeyTable[0]&0x08) Char='c';
;	genAnd
	ld	a,b
	and	a,#0x08
	jp	z,00104$
00272$:
;	genAssign
	ld	c,#0x63
;	genGoto
	jp	00111$
;	genLabel
00104$:
;keyboard.c:54: else if(KeyTable[0]&0x10) Char='v';
;	genAnd
	ld	a,b
	and	a,#0x10
	jp	z,00111$
00273$:
;	genAssign
	ld	c,#0x76
;	genLabel
00111$:
;keyboard.c:55: if(KeyTable[1]&0x01) Char='a';
;	genPlus
;	genPlusIncr
	ld	hl,#_KeyTable + 1
;	genPointerGet
	ld	e,(hl)
;	genAnd
	ld	a,e
	and	a,#0x01
	jp	z,00124$
00274$:
;	genAssign
	ld	c,#0x61
;	genGoto
	jp	00125$
;	genLabel
00124$:
;keyboard.c:56: else if(KeyTable[1]&0x02) Char='s';
;	genAnd
	ld	a,e
	and	a,#0x02
	jp	z,00121$
00275$:
;	genAssign
	ld	c,#0x73
;	genGoto
	jp	00125$
;	genLabel
00121$:
;keyboard.c:57: else if(KeyTable[1]&0x04) Char='d';
;	genAnd
	ld	a,e
	and	a,#0x04
	jp	z,00118$
00276$:
;	genAssign
	ld	c,#0x64
;	genGoto
	jp	00125$
;	genLabel
00118$:
;keyboard.c:58: else if(KeyTable[1]&0x08) Char='f';
;	genAnd
	ld	a,e
	and	a,#0x08
	jp	z,00115$
00277$:
;	genAssign
	ld	c,#0x66
;	genGoto
	jp	00125$
;	genLabel
00115$:
;keyboard.c:59: else if(KeyTable[1]&0x10) Char='g';
;	genAnd
	ld	a,e
	and	a,#0x10
	jp	z,00125$
00278$:
;	genAssign
	ld	c,#0x67
;	genLabel
00125$:
;keyboard.c:60: if(KeyTable[2]&0x01) Char='q';
;	genPlus
;	genPlusIncr
	ld	hl,#_KeyTable + 2
;	genPointerGet
	ld	e,(hl)
;	genAnd
	ld	a,e
	and	a,#0x01
	jp	z,00138$
00279$:
;	genAssign
	ld	c,#0x71
;	genGoto
	jp	00139$
;	genLabel
00138$:
;keyboard.c:61: else if(KeyTable[2]&0x02) Char='w';
;	genAnd
	ld	a,e
	and	a,#0x02
	jp	z,00135$
00280$:
;	genAssign
	ld	c,#0x77
;	genGoto
	jp	00139$
;	genLabel
00135$:
;keyboard.c:62: else if(KeyTable[2]&0x04) Char='e';
;	genAnd
	ld	a,e
	and	a,#0x04
	jp	z,00132$
00281$:
;	genAssign
	ld	c,#0x65
;	genGoto
	jp	00139$
;	genLabel
00132$:
;keyboard.c:63: else if(KeyTable[2]&0x08) Char='r';
;	genAnd
	ld	a,e
	and	a,#0x08
	jp	z,00129$
00282$:
;	genAssign
	ld	c,#0x72
;	genGoto
	jp	00139$
;	genLabel
00129$:
;keyboard.c:64: else if(KeyTable[2]&0x10) Char='t';
;	genAnd
	ld	a,e
	and	a,#0x10
	jp	z,00139$
00283$:
;	genAssign
	ld	c,#0x74
;	genLabel
00139$:
;keyboard.c:65: if(KeyTable[3]&0x01) Char='1';
;	genPlus
;	genPlusIncr
	ld	hl,#_KeyTable + 3
;	genPointerGet
	ld	e,(hl)
;	genAnd
	ld	a,e
	and	a,#0x01
	jp	z,00152$
00284$:
;	genAssign
	ld	c,#0x31
;	genGoto
	jp	00153$
;	genLabel
00152$:
;keyboard.c:66: else if(KeyTable[3]&0x02) Char='2';
;	genAnd
	ld	a,e
	and	a,#0x02
	jp	z,00149$
00285$:
;	genAssign
	ld	c,#0x32
;	genGoto
	jp	00153$
;	genLabel
00149$:
;keyboard.c:67: else if(KeyTable[3]&0x04) Char='3';
;	genAnd
	ld	a,e
	and	a,#0x04
	jp	z,00146$
00286$:
;	genAssign
	ld	c,#0x33
;	genGoto
	jp	00153$
;	genLabel
00146$:
;keyboard.c:68: else if(KeyTable[3]&0x08) Char='4';
;	genAnd
	ld	a,e
	and	a,#0x08
	jp	z,00143$
00287$:
;	genAssign
	ld	c,#0x34
;	genGoto
	jp	00153$
;	genLabel
00143$:
;keyboard.c:69: else if(KeyTable[3]&0x10) Char='5';
;	genAnd
	ld	a,e
	and	a,#0x10
	jp	z,00153$
00288$:
;	genAssign
	ld	c,#0x35
;	genLabel
00153$:
;keyboard.c:70: if(KeyTable[4]&0x01) Char='0';
;	genPlus
;	genPlusIncr
	ld	hl,#_KeyTable + 4
;	genPointerGet
	ld	e,(hl)
;	genAnd
	ld	a,e
	and	a,#0x01
	jp	z,00166$
00289$:
;	genAssign
	ld	c,#0x30
;	genGoto
	jp	00167$
;	genLabel
00166$:
;keyboard.c:71: else if(KeyTable[4]&0x02) Char='9';
;	genAnd
	ld	a,e
	and	a,#0x02
	jp	z,00163$
00290$:
;	genAssign
	ld	c,#0x39
;	genGoto
	jp	00167$
;	genLabel
00163$:
;keyboard.c:72: else if(KeyTable[4]&0x04) Char='8';
;	genAnd
	ld	a,e
	and	a,#0x04
	jp	z,00160$
00291$:
;	genAssign
	ld	c,#0x38
;	genGoto
	jp	00167$
;	genLabel
00160$:
;keyboard.c:73: else if(KeyTable[4]&0x08) Char='7';
;	genAnd
	ld	a,e
	and	a,#0x08
	jp	z,00157$
00292$:
;	genAssign
	ld	c,#0x37
;	genGoto
	jp	00167$
;	genLabel
00157$:
;keyboard.c:74: else if(KeyTable[4]&0x10) Char='6';
;	genAnd
	ld	a,e
	and	a,#0x10
	jp	z,00167$
00293$:
;	genAssign
	ld	c,#0x36
;	genLabel
00167$:
;keyboard.c:75: if(KeyTable[5]&0x01) Char='p';
;	genPlus
;	genPlusIncr
	ld	hl,#_KeyTable + 5
;	genPointerGet
	ld	e,(hl)
;	genAnd
	ld	a,e
	and	a,#0x01
	jp	z,00180$
00294$:
;	genAssign
	ld	c,#0x70
;	genGoto
	jp	00181$
;	genLabel
00180$:
;keyboard.c:76: else if(KeyTable[5]&0x02) Char='o';
;	genAnd
	ld	a,e
	and	a,#0x02
	jp	z,00177$
00295$:
;	genAssign
	ld	c,#0x6F
;	genGoto
	jp	00181$
;	genLabel
00177$:
;keyboard.c:77: else if(KeyTable[5]&0x04) Char='i';
;	genAnd
	ld	a,e
	and	a,#0x04
	jp	z,00174$
00296$:
;	genAssign
	ld	c,#0x69
;	genGoto
	jp	00181$
;	genLabel
00174$:
;keyboard.c:78: else if(KeyTable[5]&0x08) Char='u';
;	genAnd
	ld	a,e
	and	a,#0x08
	jp	z,00171$
00297$:
;	genAssign
	ld	c,#0x75
;	genGoto
	jp	00181$
;	genLabel
00171$:
;keyboard.c:79: else if(KeyTable[5]&0x10) Char='y';
;	genAnd
	ld	a,e
	and	a,#0x10
	jp	z,00181$
00298$:
;	genAssign
	ld	c,#0x79
;	genLabel
00181$:
;keyboard.c:80: if(KeyTable[6]&0x01) Char='\n';
;	genPlus
;	genPlusIncr
	ld	hl,#_KeyTable + 6
;	genPointerGet
	ld	e,(hl)
;	genAnd
	ld	a,e
	and	a,#0x01
	jp	z,00194$
00299$:
;	genAssign
	ld	c,#0x0A
;	genGoto
	jp	00195$
;	genLabel
00194$:
;keyboard.c:81: else if(KeyTable[6]&0x02) Char='l';
;	genAnd
	ld	a,e
	and	a,#0x02
	jp	z,00191$
00300$:
;	genAssign
	ld	c,#0x6C
;	genGoto
	jp	00195$
;	genLabel
00191$:
;keyboard.c:82: else if(KeyTable[6]&0x04) Char='k';
;	genAnd
	ld	a,e
	and	a,#0x04
	jp	z,00188$
00301$:
;	genAssign
	ld	c,#0x6B
;	genGoto
	jp	00195$
;	genLabel
00188$:
;keyboard.c:83: else if(KeyTable[6]&0x08) Char='j';
;	genAnd
	ld	a,e
	and	a,#0x08
	jp	z,00185$
00302$:
;	genAssign
	ld	c,#0x6A
;	genGoto
	jp	00195$
;	genLabel
00185$:
;keyboard.c:84: else if(KeyTable[6]&0x10) Char='h';
;	genAnd
	ld	a,e
	and	a,#0x10
	jp	z,00195$
00303$:
;	genAssign
	ld	c,#0x68
;	genLabel
00195$:
;keyboard.c:85: if(KeyTable[7]&0x01) Char=' ';
;	genPlus
;	genPlusIncr
	ld	hl,#_KeyTable + 7
;	genPointerGet
	ld	e,(hl)
;	genAnd
	ld	a,e
	and	a,#0x01
	jp	z,00208$
00304$:
;	genAssign
	ld	c,#0x20
;	genGoto
	jp	00209$
;	genLabel
00208$:
;keyboard.c:86: else if(KeyTable[7]&0x02) Char=' ';
;	genAnd
	ld	a,e
	and	a,#0x02
	jp	z,00205$
00305$:
;	genAssign
	ld	c,#0x20
;	genGoto
	jp	00209$
;	genLabel
00205$:
;keyboard.c:87: else if(KeyTable[7]&0x04) Char='m';
;	genAnd
	ld	a,e
	and	a,#0x04
	jp	z,00202$
00306$:
;	genAssign
	ld	c,#0x6D
;	genGoto
	jp	00209$
;	genLabel
00202$:
;keyboard.c:88: else if(KeyTable[7]&0x08) Char='n';
;	genAnd
	ld	a,e
	and	a,#0x08
	jp	z,00199$
00307$:
;	genAssign
	ld	c,#0x6E
;	genGoto
	jp	00209$
;	genLabel
00199$:
;keyboard.c:89: else if(KeyTable[7]&0x10) Char='b';
;	genAnd
	ld	a,e
	and	a,#0x10
	jp	z,00209$
00308$:
;	genAssign
	ld	c,#0x62
;	genLabel
00209$:
;keyboard.c:90: if(Char>='a' && Char<='z') if(KeyTable[0]&0x01) Char=Char+('A'-'a');
;	genAssign
	ld	l,c
;	genCmpLt
	ld	a,l
	sub	a,#0x61
	jp	c,00213$
;	genAssign
	ld	l,c
;	genCmpGt
	ld	a,#0x7A
	sub	a,l
	jp	c,00213$
;	genAnd
	ld	a,b
	and	a,#0x01
	jp	z,00213$
00309$:
;	genPlus
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,c
	add	a,#0xE0
	ld	c,a
;	genLabel
00213$:
;keyboard.c:91: if(Char!='\0') {
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	a,c
	or	a,a
	jp	z,00223$
00310$:
;keyboard.c:92: if(KeyboardBufferCount>=MAX_KEYBOARDBUFFER) Beep(); else {
;	genCmpLt
	ld	iy,#_KeyboardBufferCount
	ld	a,0(iy)
	sub	a,#0x20
	jp	m,00216$
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	call	_Beep
	pop	bc
;	genGoto
	jp	00223$
;	genLabel
00216$:
;keyboard.c:93: KeyboardBuffer[KeyboardBufferCount]=Char;
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
;	Shift into pair idx 0
	ld	hl,#_KeyboardBufferCount
	ld	a,#<_KeyboardBuffer
	add	a,(hl)
	ld	e,a
	ld	a,#>_KeyboardBuffer
	adc	a,#0x00
	ld	d,a
;	genAssign (pointer)
;	isBitvar = 0
	ld	a,c
	ld	(de),a
;keyboard.c:94: KeyboardBufferCount++;
;	genPlus
;	genPlusIncr
	ld	iy,#_KeyboardBufferCount
	inc	0(iy)
;keyboard.c:95: KeyboardPollCount=6;
;	genAssign
	ld	iy,#_KeyboardPollCount
	ld	0(iy),#0x06
;	genLabel
00223$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
_PollKeyboard_end::
;keyboard.c:101: char GetKeypress() {
;	genLabel
;	genFunction
;	---------------------------------
; Function GetKeypress
; ---------------------------------
_GetKeypress_start::
_GetKeypress:
	ld	a,#3
	rst	0x08
;keyboard.c:104: Pause();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_Pause
;keyboard.c:105: if(KeyboardBufferCount) {
;	genIfx
	xor	a,a
	ld	iy,#_KeyboardBufferCount
	or	a,0(iy)
	jp	z,00102$
;keyboard.c:106: Keypress=KeyboardBuffer[0];
;	genPointerGet
	ld	hl,#_KeyboardBuffer
	ld	l,(hl)
;	genAssign
	ld	c,l
;keyboard.c:107: for(i=1; i<KeyboardBufferCount; i++) KeyboardBuffer[i-1]=KeyboardBuffer[i];
;	genAssign
	ld	b,#0x01
;	genLabel
00104$:
;	genCmpLt
	ld	a,b
	ld	iy,#_KeyboardBufferCount
	sub	a,0(iy)
	jp	p,00107$
;	genMinus
	ld	a,b
	add	a,#0xFF
	ld	l,a
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<_KeyboardBuffer
	add	a,l
	ld	e,a
	ld	a,#>_KeyboardBuffer
	adc	a,#0x00
	ld	d,a
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<_KeyboardBuffer
	add	a,b
	ld	l,a
	ld	a,#>_KeyboardBuffer
	adc	a,#0x00
	ld	h,a
;	genPointerGet
	ld	a,(hl)
;	genAssign (pointer)
;	isBitvar = 0
	ld	(de),a
;	genPlus
;	genPlusIncr
; Removed redundent load
	inc	b
;	genGoto
	jp	00104$
;	genLabel
00107$:
;keyboard.c:108: KeyboardBufferCount--;
;	genMinus
	ld	iy,#_KeyboardBufferCount
	dec	0(iy)
;	genGoto
	jp	00103$
;	genLabel
00102$:
;keyboard.c:110: Keypress='\0';
;	genAssign
	ld	c,#0x00
;	genLabel
00103$:
;keyboard.c:112: Resume();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	call	_Resume
	pop	bc
;keyboard.c:113: return Keypress;
;	genRet
; Dump of IC_LEFT: type AOP_REG size 1
;	 reg = c
	ld	l,c
;	genLabel
00108$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
_GetKeypress_end::
	.area _CODE
