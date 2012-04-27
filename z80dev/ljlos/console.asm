;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Feb  3 2010) (UNIX)
; This file was generated Fri Apr 27 12:42:17 2012
;--------------------------------------------------------
	.module console
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ScrollUp
	.globl _CursorUndraw
	.globl _CursorDraw
	.globl _ConsoleInited
	.globl _ConsoleLock
	.globl _CursorColumn
	.globl _CursorRow
	.globl _Column
	.globl _Row
	.globl _SystemLock
	.globl _ConsoleInit
	.globl _ConsoleWrite
	.globl _ConsoleReadLine
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
G$Row$0$0==.
_Row::
	.ds 1
G$Column$0$0==.
_Column::
	.ds 1
G$CursorRow$0$0==.
_CursorRow::
	.ds 1
G$CursorColumn$0$0==.
_CursorColumn::
	.ds 1
G$ConsoleLock$0$0==.
_ConsoleLock::
	.ds 1
G$ConsoleInited$0$0==.
_ConsoleInited::
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
	G$ConsoleInit$0$0	= .
	.globl	G$ConsoleInit$0$0
	C$console.c$18$0$0	= .
	.globl	C$console.c$18$0$0
;console.c:18: bool ConsoleInited; void ConsoleInit() {
;	---------------------------------
; Function ConsoleInit
; ---------------------------------
_ConsoleInit_start::
_ConsoleInit:
	ld	a,#3
	rst	0x08
	C$console.c$19$1$1	= .
	.globl	C$console.c$19$1$1
;console.c:19: if(!ConsoleInited) {
	xor	a,a
	ld	hl,#_ConsoleInited + 0
	or	a,(hl)
	jr	NZ,00103$
	C$console.c$20$2$2	= .
	.globl	C$console.c$20$2$2
;console.c:20: LocksInit();
	call	_LocksInit
	C$console.c$21$2$2	= .
	.globl	C$console.c$21$2$2
;console.c:21: ScreenClear(0, 7);
	ld	hl,#0x0700
	push	hl
	call	_ScreenClear
	pop	af
	C$console.c$22$2$2	= .
	.globl	C$console.c$22$2$2
;console.c:22: Row=0; Column=0;
	ld	hl,#_Row + 0
	ld	(hl), #0x00
	ld	hl,#_Column + 0
	ld	(hl), #0x00
	C$console.c$23$2$2	= .
	.globl	C$console.c$23$2$2
;console.c:23: CursorRow=0; CursorColumn=0;
	ld	hl,#_CursorRow + 0
	ld	(hl), #0x00
	ld	hl,#_CursorColumn + 0
	ld	(hl), #0x00
	C$console.c$24$2$2	= .
	.globl	C$console.c$24$2$2
;console.c:24: ConsoleLock=LockCreate();
	call	_LockCreate
	ld	c,l
	ld	hl,#_ConsoleLock + 0
	ld	(hl), c
	C$console.c$25$2$2	= .
	.globl	C$console.c$25$2$2
;console.c:25: ConsoleWrite("(C) 2003 LORENZO J. LUCCHINI\n\n\n");
	ld	hl,#__str_0
	push	hl
	call	_ConsoleWrite
	pop	af
	C$console.c$26$2$2	= .
	.globl	C$console.c$26$2$2
;console.c:26: ConsoleInited=TRUE;
	ld	hl,#_ConsoleInited + 0
	ld	(hl), #0x01
	C$console.c$27$2$2	= .
	.globl	C$console.c$27$2$2
;console.c:27: _SimPrintString("Console initialized, lock number ");
	ld	hl,#__str_1
	push	hl
	call	__Z80SimPrintString
	pop	af
	C$console.c$28$2$2	= .
	.globl	C$console.c$28$2$2
;console.c:28: _SimPrintWord((unsigned int)ConsoleLock);
	ld	hl,#_ConsoleLock + 0
	ld	c,(hl)
	ld	b,#0x00
	push	bc
	call	__Z80SimPrintWord
	pop	af
	C$console.c$29$2$2	= .
	.globl	C$console.c$29$2$2
;console.c:29: _SimPrintString("\n");
	ld	hl,#__str_2
	push	hl
	call	__Z80SimPrintString
	pop	af
00103$:
	ld	a,#4
	rst	0x08
	C$console.c$31$2$1	= .
	.globl	C$console.c$31$2$1
	XG$ConsoleInit$0$0	= .
	.globl	XG$ConsoleInit$0$0
	ret
_ConsoleInit_end::
Fconsole$_str_0$0$0 == .
__str_0:
	.ascii "(C) 2003 LORENZO J. LUCCHINI"
	.db 0x0A
	.db 0x0A
	.db 0x0A
	.db 0x00
Fconsole$_str_1$0$0 == .
__str_1:
	.ascii "Console initialized, lock number "
	.db 0x00
Fconsole$_str_2$0$0 == .
__str_2:
	.db 0x0A
	.db 0x00
	G$CursorDraw$0$0	= .
	.globl	G$CursorDraw$0$0
	C$console.c$33$2$1	= .
	.globl	C$console.c$33$2$1
;console.c:33: void CursorDraw(short Row, short Column) {
;	---------------------------------
; Function CursorDraw
; ---------------------------------
_CursorDraw_start::
_CursorDraw:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	C$console.c$35$1$1	= .
	.globl	C$console.c$35$1$1
;console.c:35: PutCharacter(' ', Row, Column);
	ld	h,5 (ix)
	ld	l,4 (ix)
	push	hl
	ld	a,#0x20
	push	af
	inc	sp
	call	_PutCharacter
	pop	af
	inc	sp
	C$console.c$36$1$1	= .
	.globl	C$console.c$36$1$1
;console.c:36: SetAttrib((1<<7)|(1<<3)|(7<<0), Row, Column);
	ld	h,5 (ix)
	ld	l,4 (ix)
	push	hl
	ld	a,#0x8F
	push	af
	inc	sp
	call	_SetAttrib
	pop	af
	inc	sp
	pop	ix
	ld	a,#4
	rst	0x08
	C$console.c$37$1$1	= .
	.globl	C$console.c$37$1$1
	XG$CursorDraw$0$0	= .
	.globl	XG$CursorDraw$0$0
	ret
_CursorDraw_end::
	G$CursorUndraw$0$0	= .
	.globl	G$CursorUndraw$0$0
	C$console.c$39$1$1	= .
	.globl	C$console.c$39$1$1
;console.c:39: void CursorUndraw() {
;	---------------------------------
; Function CursorUndraw
; ---------------------------------
_CursorUndraw_start::
_CursorUndraw:
	ld	a,#3
	rst	0x08
	C$console.c$40$1$1	= .
	.globl	C$console.c$40$1$1
;console.c:40: SetAttrib(0, CursorRow, CursorColumn);
	ld	a,(_CursorColumn)
	push	af
	inc	sp
	ld	a,(_CursorRow)
	push	af
	inc	sp
	ld	a,#0x00
	push	af
	inc	sp
	call	_SetAttrib
	pop	af
	inc	sp
	ld	a,#4
	rst	0x08
	C$console.c$41$1$1	= .
	.globl	C$console.c$41$1$1
	XG$CursorUndraw$0$0	= .
	.globl	XG$CursorUndraw$0$0
	ret
_CursorUndraw_end::
	G$ScrollUp$0$0	= .
	.globl	G$ScrollUp$0$0
	C$console.c$229$1$1	= .
	.globl	C$console.c$229$1$1
;console.c:229: void ScrollUp() {
;	---------------------------------
; Function ScrollUp
; ---------------------------------
_ScrollUp_start::
_ScrollUp:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-9
	add	hl,sp
	ld	sp,hl
	C$console.c$233$1$1	= .
	.globl	C$console.c$233$1$1
;console.c:233: for(l=0; l<6114; l+=2048) {
	ld	-6 (ix),#0x00
	ld	-5 (ix),#0x00
00121$:
	ld	a,-6 (ix)
	sub	a,#0xE2
	ld	a,-5 (ix)
	sbc	a,#0x17
	jp	NC,00125$
	C$console.c$234$1$1	= .
	.globl	C$console.c$234$1$1
;console.c:234: for(k=0; k<224; k+=32) {
	ld	-4 (ix),#0x00
	ld	-3 (ix),#0x00
00109$:
	ld	a,-4 (ix)
	sub	a,#0xE0
	ld	a,-3 (ix)
	sbc	a,#0x00
	jp	NC,00112$
	C$console.c$235$1$1	= .
	.globl	C$console.c$235$1$1
;console.c:235: for(j=0; j<2048; j+=256) {
	ld	-2 (ix),#0x00
	ld	-1 (ix),#0x00
00105$:
	ld	a,-2 (ix)
	sub	a,#0x00
	ld	a,-1 (ix)
	sbc	a,#0x08
	jp	NC,00111$
	C$console.c$236$4$4	= .
	.globl	C$console.c$236$4$4
;console.c:236: Sum=j+k+l;
	ld	a,-2 (ix)
	add	a,-4 (ix)
	ld	e,a
	ld	a,-1 (ix)
	adc	a,-3 (ix)
	ld	d,a
	ld	a,e
	add	a,-6 (ix)
	ld	e,a
	ld	a,d
	adc	a,-5 (ix)
	ld	d,a
	ld	-9 (ix),e
	ld	-8 (ix),d
	C$console.c$237$1$1	= .
	.globl	C$console.c$237$1$1
;console.c:237: for(i=0; i<32; i++) {
	ld	-7 (ix),#0x00
00101$:
	ld	a,-7 (ix)
	sub	a,#0x20
	jr	NC,00107$
	C$console.c$238$5$5	= .
	.globl	C$console.c$238$5$5
;console.c:238: ScreenMemory[i+Sum]=ScreenMemory[32+i+Sum];
	ld	d,-7 (ix)
	ld	c,#0x00
	ld	a,d
	add	a,-9 (ix)
	ld	b,a
	ld	a,c
	adc	a,-8 (ix)
	add	a,#0x40
	ld	e,a
	ld	a,d
	add	a,#0x20
	ld	d,a
	ld	a,c
	adc	a,#0x00
	ld	c,a
	ld	a,d
	add	a,-9 (ix)
	ld	d,a
	ld	a,c
	adc	a,-8 (ix)
	add	a,#0x40
	ld	l,d
	ld	h,a
	ld	a,(hl)
	ld	l,b
	ld	h,e
	ld	(hl),a
	C$console.c$237$4$4	= .
	.globl	C$console.c$237$4$4
;console.c:237: for(i=0; i<32; i++) {
	inc	-7 (ix)
	jr	00101$
00107$:
	C$console.c$235$3$3	= .
	.globl	C$console.c$235$3$3
;console.c:235: for(j=0; j<2048; j+=256) {
	ld	a,-2 (ix)
	add	a,#0x00
	ld	-2 (ix),a
	ld	a,-1 (ix)
	adc	a,#0x01
	ld	-1 (ix),a
	jp	00105$
00111$:
	C$console.c$234$2$2	= .
	.globl	C$console.c$234$2$2
;console.c:234: for(k=0; k<224; k+=32) {
	ld	a,-4 (ix)
	add	a,#0x20
	ld	-4 (ix),a
	ld	a,-3 (ix)
	adc	a,#0x00
	ld	-3 (ix),a
	jp	00109$
00112$:
	C$console.c$242$1$1	= .
	.globl	C$console.c$242$1$1
;console.c:242: for(j=0; j<2048; j+=256) {
	ld	-2 (ix),#0x00
	ld	-1 (ix),#0x00
00117$:
	ld	a,-2 (ix)
	sub	a,#0x00
	ld	a,-1 (ix)
	sbc	a,#0x08
	jp	NC,00123$
	C$console.c$243$1$1	= .
	.globl	C$console.c$243$1$1
;console.c:243: for(i=0; i<32; i++) {
	ld	-7 (ix),#0x00
00113$:
	ld	a,-7 (ix)
	sub	a,#0x20
	jp	NC,00119$
	C$console.c$244$4$7	= .
	.globl	C$console.c$244$4$7
;console.c:244: ScreenMemory[i+j+224+l]=ScreenMemory[32+i+j+0+l+2048];
	ld	e,-7 (ix)
	ld	d,#0x00
	ld	a,e
	add	a,-2 (ix)
	ld	c,a
	ld	a,d
	adc	a,-1 (ix)
	ld	b,a
	ld	hl,#0x00E0
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	a,c
	add	a,-6 (ix)
	ld	c,a
	ld	a,b
	adc	a,-5 (ix)
	ld	b,a
	ld	hl,#0x4000
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	hl,#0x0820
	add	hl,de
	ex	de,hl
	ld	a,e
	add	a,-6 (ix)
	ld	e,a
	ld	a,d
	adc	a,-5 (ix)
	ld	d,a
	ld	a,-2 (ix)
	add	a,e
	ld	e,a
	ld	a,-1 (ix)
	adc	a,d
	ld	d,a
	ld	hl,#0x4000
	add	hl,de
	ld	a,(hl)
	ld	(bc),a
	C$console.c$243$3$6	= .
	.globl	C$console.c$243$3$6
;console.c:243: for(i=0; i<32; i++) {
	inc	-7 (ix)
	jp	00113$
00119$:
	C$console.c$242$2$2	= .
	.globl	C$console.c$242$2$2
;console.c:242: for(j=0; j<2048; j+=256) {
	ld	a,-2 (ix)
	add	a,#0x00
	ld	-2 (ix),a
	ld	a,-1 (ix)
	adc	a,#0x01
	ld	-1 (ix),a
	jp	00117$
00123$:
	C$console.c$233$1$1	= .
	.globl	C$console.c$233$1$1
;console.c:233: for(l=0; l<6114; l+=2048) {
	ld	a,-6 (ix)
	add	a,#0x00
	ld	-6 (ix),a
	ld	a,-5 (ix)
	adc	a,#0x08
	ld	-5 (ix),a
	jp	00121$
00125$:
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	C$console.c$248$1$1	= .
	.globl	C$console.c$248$1$1
	XG$ScrollUp$0$0	= .
	.globl	XG$ScrollUp$0$0
	ret
_ScrollUp_end::
	G$ConsoleWrite$0$0	= .
	.globl	G$ConsoleWrite$0$0
	C$console.c$250$1$1	= .
	.globl	C$console.c$250$1$1
;console.c:250: void ConsoleWrite(char* String) {
;	---------------------------------
; Function ConsoleWrite
; ---------------------------------
_ConsoleWrite_start::
_ConsoleWrite:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	C$console.c$253$1$1	= .
	.globl	C$console.c$253$1$1
;console.c:253: LockObtain(ConsoleLock);
	ld	a,(_ConsoleLock)
	push	af
	inc	sp
	call	_LockObtain
	inc	sp
	C$console.c$255$1$1	= .
	.globl	C$console.c$255$1$1
;console.c:255: Length=StringLength(String);
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_StringLength
	pop	af
	ld	b,h
	ld	c,l
	ld	-2 (ix),c
	ld	-1 (ix),b
	C$console.c$256$1$1	= .
	.globl	C$console.c$256$1$1
;console.c:256: for(i=0; i<Length; i++) {
	ld	de,#0x0000
00109$:
	ld	a,e
	sub	a,-2 (ix)
	ld	a,d
	sbc	a,-1 (ix)
	jp	P,00112$
	C$console.c$257$2$2	= .
	.globl	C$console.c$257$2$2
;console.c:257: if(Row>23) {
	ld	a,#0x17
	ld	iy,#_Row
	sub	a,0 (iy)
	jp	P,00102$
	C$console.c$258$3$3	= .
	.globl	C$console.c$258$3$3
;console.c:258: Row=23;
	ld	hl,#_Row + 0
	ld	(hl), #0x17
	C$console.c$259$3$3	= .
	.globl	C$console.c$259$3$3
;console.c:259: ScrollUp();
	push	de
	call	_ScrollUp
	pop	de
00102$:
	C$console.c$261$2$2	= .
	.globl	C$console.c$261$2$2
;console.c:261: if(String[i]=='\n') {
	ld	a,4 (ix)
	add	a,e
	ld	c,a
	ld	a,5 (ix)
	adc	a,d
	ld	b,a
	ld	a,(bc)
	ld	c,a
	sub	a,#0x0A
	jr	NZ,00107$
	C$console.c$262$3$4	= .
	.globl	C$console.c$262$3$4
;console.c:262: Row++;
	ld	iy,#_Row
	inc	0 (iy)
	C$console.c$263$3$4	= .
	.globl	C$console.c$263$3$4
;console.c:263: Column=0;
	ld	iy,#_Column
	ld	0 (iy),#0x00
	jr	00111$
00107$:
	C$console.c$265$3$5	= .
	.globl	C$console.c$265$3$5
;console.c:265: PutCharacter(String[i], Row, Column);
	push	de
	ld	a,(_Column)
	push	af
	inc	sp
	ld	a,(_Row)
	ld	b,a
	push	bc
	call	_PutCharacter
	pop	af
	inc	sp
	pop	de
	C$console.c$266$3$5	= .
	.globl	C$console.c$266$3$5
;console.c:266: if(Column==31) {
	ld	a,(#_Column+0)
	sub	a,#0x1F
	jr	NZ,00104$
	C$console.c$267$4$6	= .
	.globl	C$console.c$267$4$6
;console.c:267: Row++;
	ld	iy,#_Row
	inc	0 (iy)
	C$console.c$268$4$6	= .
	.globl	C$console.c$268$4$6
;console.c:268: Column=0;
	ld	iy,#_Column
	ld	0 (iy),#0x00
	jr	00111$
00104$:
	C$console.c$269$3$5	= .
	.globl	C$console.c$269$3$5
;console.c:269: } else Column++;
	ld	iy,#_Column
	inc	0 (iy)
00111$:
	C$console.c$256$1$1	= .
	.globl	C$console.c$256$1$1
;console.c:256: for(i=0; i<Length; i++) {
	inc	de
	jp	00109$
00112$:
	C$console.c$273$1$1	= .
	.globl	C$console.c$273$1$1
;console.c:273: LockRelease(ConsoleLock);
	ld	a,(_ConsoleLock)
	push	af
	inc	sp
	call	_LockRelease
	inc	sp
	C$console.c$274$1$1	= .
	.globl	C$console.c$274$1$1
;console.c:274: _SimPrintString(String);
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	__Z80SimPrintString
	pop	af
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	C$console.c$275$1$1	= .
	.globl	C$console.c$275$1$1
	XG$ConsoleWrite$0$0	= .
	.globl	XG$ConsoleWrite$0$0
	ret
_ConsoleWrite_end::
	G$ConsoleReadLine$0$0	= .
	.globl	G$ConsoleReadLine$0$0
	C$console.c$277$1$1	= .
	.globl	C$console.c$277$1$1
;console.c:277: unsigned short ConsoleReadLine(char* String) {
;	---------------------------------
; Function ConsoleReadLine
; ---------------------------------
_ConsoleReadLine_start::
_ConsoleReadLine:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
	C$console.c$280$1$1	= .
	.globl	C$console.c$280$1$1
;console.c:280: Character[1]='\0';
	ld	hl,#0x0000
	add	hl,sp
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	inc	de
	ld	a,#0x00
	ld	(de),a
	C$console.c$282$1$1	= .
	.globl	C$console.c$282$1$1
;console.c:282: ConsoleWrite("#");
	push	bc
	ld	hl,#__str_3
	push	hl
	call	_ConsoleWrite
	pop	af
	pop	bc
	C$console.c$283$1$1	= .
	.globl	C$console.c$283$1$1
;console.c:283: do {
	ld	-1 (ix),#0x00
00104$:
	C$console.c$284$2$2	= .
	.globl	C$console.c$284$2$2
;console.c:284: Character[0]=GetKeypress();
	push	bc
	call	_GetKeypress
	ld	d,l
	pop	bc
	ld	a,d
	ld	(bc),a
	C$console.c$285$2$2	= .
	.globl	C$console.c$285$2$2
;console.c:285: if(Character[0]!='\0') {
	xor	a,a
	or	a,d
	jr	Z,00105$
	C$console.c$286$3$3	= .
	.globl	C$console.c$286$3$3
;console.c:286: ConsoleWrite(Character);
	push	bc
	push	bc
	call	_ConsoleWrite
	pop	af
	pop	bc
	C$console.c$287$3$3	= .
	.globl	C$console.c$287$3$3
;console.c:287: String[i]=Character[0];
	ld	a,4 (ix)
	add	a,-1 (ix)
	ld	e,a
	ld	a,5 (ix)
	adc	a,#0x00
	ld	d,a
	ld	a,(bc)
	ld	(de),a
	C$console.c$288$3$3	= .
	.globl	C$console.c$288$3$3
;console.c:288: i++;
	inc	-1 (ix)
00105$:
	C$console.c$290$1$1	= .
	.globl	C$console.c$290$1$1
;console.c:290: } while(Character[0]!='\n' && i<256);
	ld	a,(bc)
	sub	a,#0x0A
	jr	NZ,00104$
	C$console.c$291$1$1	= .
	.globl	C$console.c$291$1$1
;console.c:291: String[i-1]='\0';
	ld	c,-1 (ix)
	ld	b,#0x00
	dec	bc
	ld	a,4 (ix)
	add	a,c
	ld	c,a
	ld	a,5 (ix)
	adc	a,b
	ld	b,a
	ld	a,#0x00
	ld	(bc),a
	C$console.c$292$1$1	= .
	.globl	C$console.c$292$1$1
;console.c:292: return i;
	ld	l,-1 (ix)
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	C$console.c$293$1$1	= .
	.globl	C$console.c$293$1$1
	XG$ConsoleReadLine$0$0	= .
	.globl	XG$ConsoleReadLine$0$0
	ret
_ConsoleReadLine_end::
Fconsole$_str_3$0$0 == .
__str_3:
	.ascii "#"
	.db 0x00
	.area _CODE
	.area _CABS
