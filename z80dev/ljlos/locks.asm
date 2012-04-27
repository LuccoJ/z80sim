;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Feb  3 2010) (UNIX)
; This file was generated Fri Apr 27 12:42:17 2012
;--------------------------------------------------------
	.module locks
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _LocksInited
	.globl _LockCount
	.globl _Locks
	.globl _SystemLock
	.globl _LocksInit
	.globl _LockCreate
	.globl _LockObtain
	.globl _LockRelease
	.globl _LockQuery
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
G$Locks$0$0==.
_Locks::
	.ds 256
G$LockCount$0$0==.
_LockCount::
	.ds 1
G$LocksInited$0$0==.
_LocksInited::
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
	G$LocksInit$0$0	= .
	.globl	G$LocksInit$0$0
	C$locks.c$13$0$0	= .
	.globl	C$locks.c$13$0$0
;locks.c:13: bool LocksInited; void LocksInit() {
;	---------------------------------
; Function LocksInit
; ---------------------------------
_LocksInit_start::
_LocksInit:
	ld	a,#3
	rst	0x08
	C$locks.c$14$1$1	= .
	.globl	C$locks.c$14$1$1
;locks.c:14: if(!LocksInited) {
	xor	a,a
	ld	hl,#_LocksInited + 0
	or	a,(hl)
	jr	NZ,00103$
	C$locks.c$15$2$2	= .
	.globl	C$locks.c$15$2$2
;locks.c:15: LockCount=0;
	ld	hl,#_LockCount + 0
	ld	(hl), #0x00
	C$locks.c$16$2$2	= .
	.globl	C$locks.c$16$2$2
;locks.c:16: SchedulingInit();
	call	_SchedulingInit
	C$locks.c$17$2$2	= .
	.globl	C$locks.c$17$2$2
;locks.c:17: LocksInited=TRUE;
	ld	hl,#_LocksInited + 0
	ld	(hl), #0x01
	C$locks.c$18$2$2	= .
	.globl	C$locks.c$18$2$2
;locks.c:18: _SimPrintString("Locks initialized\n");
	ld	hl,#__str_0
	push	hl
	call	__Z80SimPrintString
	pop	af
00103$:
	ld	a,#4
	rst	0x08
	C$locks.c$20$2$1	= .
	.globl	C$locks.c$20$2$1
	XG$LocksInit$0$0	= .
	.globl	XG$LocksInit$0$0
	ret
_LocksInit_end::
Flocks$_str_0$0$0 == .
__str_0:
	.ascii "Locks initialized"
	.db 0x0A
	.db 0x00
	G$LockCreate$0$0	= .
	.globl	G$LockCreate$0$0
	C$locks.c$22$2$1	= .
	.globl	C$locks.c$22$2$1
;locks.c:22: lock LockCreate() {
;	---------------------------------
; Function LockCreate
; ---------------------------------
_LockCreate_start::
_LockCreate:
	ld	a,#3
	rst	0x08
	C$locks.c$24$1$1	= .
	.globl	C$locks.c$24$1$1
;locks.c:24: Pause();
	call	_Pause
	C$locks.c$25$1$1	= .
	.globl	C$locks.c$25$1$1
;locks.c:25: NewLock=LockCount;
	ld	hl,#_LockCount + 0
	ld	c,(hl)
	C$locks.c$26$1$1	= .
	.globl	C$locks.c$26$1$1
;locks.c:26: Locks[NewLock]=FALSE;
	ld	a,#<_Locks
	add	a,c
	ld	e,a
	ld	a,#>_Locks
	adc	a,#0x00
	ld	d,a
	ld	a,#0x00
	ld	(de),a
	C$locks.c$27$1$1	= .
	.globl	C$locks.c$27$1$1
;locks.c:27: LockCount++;
	ld	iy,#_LockCount
	inc	0 (iy)
	C$locks.c$28$1$1	= .
	.globl	C$locks.c$28$1$1
;locks.c:28: Resume();
	push	bc
	call	_Resume
	pop	bc
	C$locks.c$29$1$1	= .
	.globl	C$locks.c$29$1$1
;locks.c:29: return NewLock;
	ld	l,c
	ld	a,#4
	rst	0x08
	C$locks.c$31$1$1	= .
	.globl	C$locks.c$31$1$1
	XG$LockCreate$0$0	= .
	.globl	XG$LockCreate$0$0
	ret
_LockCreate_end::
	G$LockObtain$0$0	= .
	.globl	G$LockObtain$0$0
	C$locks.c$33$1$1	= .
	.globl	C$locks.c$33$1$1
;locks.c:33: void LockObtain(lock Handle) {
;	---------------------------------
; Function LockObtain
; ---------------------------------
_LockObtain_start::
_LockObtain:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	C$locks.c$34$1$1	= .
	.globl	C$locks.c$34$1$1
;locks.c:34: if(!IsMultitasking() && LockQuery(Handle)) Halt("DEADLOCK IN KERNEL MODE");
	call	_IsMultitasking
	xor	a,a
	or	a,l
	jr	NZ,00104$
	ld	a,4 (ix)
	push	af
	inc	sp
	call	_LockQuery
	inc	sp
	xor	a,a
	or	a,l
	jr	Z,00104$
	ld	hl,#__str_1
	push	hl
	call	_Halt
	pop	af
	C$locks.c$35$1$1	= .
	.globl	C$locks.c$35$1$1
;locks.c:35: while(LockQuery(Handle)) AwaitEvent(EVENT_UNLOCK);
00104$:
	ld	a,4 (ix)
	push	af
	inc	sp
	call	_LockQuery
	inc	sp
	xor	a,a
	or	a,l
	jr	Z,00106$
	ld	hl,#0x0001
	push	hl
	call	_AwaitEvent
	pop	af
	jr	00104$
00106$:
	C$locks.c$36$1$1	= .
	.globl	C$locks.c$36$1$1
;locks.c:36: Pause();
	call	_Pause
	C$locks.c$37$1$1	= .
	.globl	C$locks.c$37$1$1
;locks.c:37: Locks[Handle]=TRUE;
	ld	a,#<_Locks
	add	a,4 (ix)
	ld	c,a
	ld	a,#>_Locks
	adc	a,#0x00
	ld	b,a
	ld	a,#0x01
	ld	(bc),a
	C$locks.c$38$1$1	= .
	.globl	C$locks.c$38$1$1
;locks.c:38: Resume();
	call	_Resume
	pop	ix
	ld	a,#4
	rst	0x08
	C$locks.c$39$1$1	= .
	.globl	C$locks.c$39$1$1
	XG$LockObtain$0$0	= .
	.globl	XG$LockObtain$0$0
	ret
_LockObtain_end::
Flocks$_str_1$0$0 == .
__str_1:
	.ascii "DEADLOCK IN KERNEL MODE"
	.db 0x00
	G$LockRelease$0$0	= .
	.globl	G$LockRelease$0$0
	C$locks.c$41$1$1	= .
	.globl	C$locks.c$41$1$1
;locks.c:41: void LockRelease(lock Handle) {
;	---------------------------------
; Function LockRelease
; ---------------------------------
_LockRelease_start::
_LockRelease:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	C$locks.c$42$1$1	= .
	.globl	C$locks.c$42$1$1
;locks.c:42: Pause();
	call	_Pause
	C$locks.c$43$1$1	= .
	.globl	C$locks.c$43$1$1
;locks.c:43: if(Locks[Handle]) {
	ld	a,#<_Locks
	add	a,4 (ix)
	ld	c,a
	ld	a,#>_Locks
	adc	a,#0x00
	ld	b,a
	ld	a,(bc)
	or	a,a
	jr	Z,00102$
	C$locks.c$44$2$2	= .
	.globl	C$locks.c$44$2$2
;locks.c:44: Locks[Handle]=FALSE;
	ld	a,#0x00
	ld	(bc),a
	C$locks.c$45$2$2	= .
	.globl	C$locks.c$45$2$2
;locks.c:45: Resume();
	call	_Resume
	jr	00104$
00102$:
	C$locks.c$47$1$1	= .
	.globl	C$locks.c$47$1$1
;locks.c:47: } else Resume();
	call	_Resume
00104$:
	pop	ix
	ld	a,#4
	rst	0x08
	C$locks.c$48$1$1	= .
	.globl	C$locks.c$48$1$1
	XG$LockRelease$0$0	= .
	.globl	XG$LockRelease$0$0
	ret
_LockRelease_end::
	G$LockQuery$0$0	= .
	.globl	G$LockQuery$0$0
	C$locks.c$50$1$1	= .
	.globl	C$locks.c$50$1$1
;locks.c:50: bool LockQuery(lock Handle) {
;	---------------------------------
; Function LockQuery
; ---------------------------------
_LockQuery_start::
_LockQuery:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	C$locks.c$52$1$1	= .
	.globl	C$locks.c$52$1$1
;locks.c:52: Pause();
	call	_Pause
	C$locks.c$53$1$1	= .
	.globl	C$locks.c$53$1$1
;locks.c:53: State=Locks[Handle];
	ld	a,#<_Locks
	add	a,4 (ix)
	ld	c,a
	ld	a,#>_Locks
	adc	a,#0x00
	ld	b,a
	ld	a,(bc)
	ld	c,a
	C$locks.c$54$1$1	= .
	.globl	C$locks.c$54$1$1
;locks.c:54: Resume();
	push	bc
	call	_Resume
	pop	bc
	C$locks.c$55$1$1	= .
	.globl	C$locks.c$55$1$1
;locks.c:55: return State;
	ld	l,c
	pop	ix
	ld	a,#4
	rst	0x08
	C$locks.c$56$1$1	= .
	.globl	C$locks.c$56$1$1
	XG$LockQuery$0$0	= .
	.globl	XG$LockQuery$0$0
	ret
_LockQuery_end::
	.area _CODE
	.area _CABS
