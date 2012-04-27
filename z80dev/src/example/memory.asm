;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Nov 29 23:14:22 2003

;--------------------------------------------------------
	.module memory
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _MyGlobalVar
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
G$MyGlobalVar$0$0==.
_MyGlobalVar::
	.ds 258
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
;memory.c:20: _SimProtectedCodeBegins
;	genLabel
;	genFunction
;	---------------------------------
; Function _Z80SimProtectedCodeBegins
; ---------------------------------
__Z80SimProtectedCodeBegins_start::
__Z80SimProtectedCodeBegins:
	ld	a,#3
	rst	0x08
;	genLabel
00101$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
__Z80SimProtectedCodeBegins_end::
;memory.c:22: void main() {
;	genLabel
;	genFunction
;	---------------------------------
; Function main
; ---------------------------------
_main_start::
_main:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-258
	add	hl,sp
	ld	sp,hl
;memory.c:25: _SimPrintString("Z80Sim memory protection demo by LjL\n");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_0
	push	hl
;	genCall
	call	__Z80SimPrintString
	pop	af
;memory.c:26: _SimPrintString("Protecting ...\n");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_1
	push	hl
;	genCall
	call	__Z80SimPrintString
	pop	af
;memory.c:27: _SimWriteProtectVar(MyGlobalVar);
;	genCast
	ld	l,#<_MyGlobalVar
	ld	h,#>_MyGlobalVar
;	genPlus
;	genPlusIncr
	ld	bc,#0x0102
	add	hl,bc
;	genCast
; Removed redundent load
; Removed redundent load
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	hl
;	genIpush
	ld	hl,#_MyGlobalVar
	push	hl
;	genCall
	call	__Z80SimWriteProtect
	pop	af
	pop	af
;memory.c:28: _SimPrintString("Protecting program code...\n");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_2
	push	hl
;	genCall
	call	__Z80SimPrintString
	pop	af
;memory.c:29: _SimWriteProtectVar(MyLocalVar);
;	genAddrOf
	ld	hl,#0x0000
	add	hl,sp
;	genCast
	ld	c,l
	ld	b,h
;	genPlus
;	genPlusIncr
	ld	de,#0x0102
	add	hl,de
;	genCast
; Removed redundent load
; Removed redundent load
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	hl
;	genIpush
	push	bc
;	genCall
	call	__Z80SimWriteProtect
	pop	af
	pop	af
;memory.c:30: _SimProtectCode();
;	genAssign
	ld	hl,#__Z80SimProtectedCodeEnds
;	genAssign
	ld	bc,#__Z80SimProtectedCodeBegins
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	hl
;	genIpush
	push	bc
;	genCall
	call	__Z80SimWriteProtect
	pop	af
	pop	af
;memory.c:31: _SimPrintString("Attempting to write 0xDEAD to every word of memory...\n");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_3
	push	hl
;	genCall
	call	__Z80SimPrintString
	pop	af
;memory.c:32: _SimPrintWord((unsigned int)&MyGlobalVar+sizeof(MyGlobalVar));
;	genCast
	ld	l,#<_MyGlobalVar
	ld	h,#>_MyGlobalVar
;	genPlus
;	genPlusIncr
	ld	bc,#0x0102
	add	hl,bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	hl
;	genCall
	call	__Z80SimPrintWord
	pop	af
;memory.c:33: i=0; do {
;	genAssign
	ld	hl,#0x0000
;	genLabel
00101$:
;memory.c:34: *(unsigned int*)i=0xDEAD;
;	genAssign (pointer)
;	isBitvar = 0
	ld	(hl),#0xAD
	inc	hl
	ld	(hl),#0xDE
;memory.c:35: } while(i<=0xFFFF);
;	genGoto
	jp	00101$
;memory.c:36: _SimPrintString("Completed.\n");
;	genLabel
00104$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_main_end::
Fmemory$_str_0$0$0 == .
__str_0:
	.ascii "Z80Sim memory protection demo by LjL"
	.db 0x0A
	.db 0x00
Fmemory$_str_1$0$0 == .
__str_1:
	.ascii "Protecting ..."
	.db 0x0A
	.db 0x00
Fmemory$_str_2$0$0 == .
__str_2:
	.ascii "Protecting program code..."
	.db 0x0A
	.db 0x00
Fmemory$_str_3$0$0 == .
__str_3:
	.ascii "Attempting to write 0xDEAD to every word of memory..."
	.db 0x0A
	.db 0x00
Fmemory$_str_4$0$0 == .
__str_4:
	.ascii "Completed."
	.db 0x0A
	.db 0x00
;memory.c:39: _SimProtectedCodeEnds
;	genLabel
;	genFunction
;	---------------------------------
; Function _Z80SimProtectedCodeEnds
; ---------------------------------
__Z80SimProtectedCodeEnds_start::
__Z80SimProtectedCodeEnds:
	ld	a,#3
	rst	0x08
;	genLabel
00101$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
__Z80SimProtectedCodeEnds_end::
	.area _CODE
