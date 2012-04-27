;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Feb  3 2010) (UNIX)
; This file was generated Fri Apr 27 12:42:17 2012
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _SystemTask
	.globl _Task2
	.globl _Task1
	.globl _SystemInit
	.globl _PrintNumber
	.globl _PrintReg
	.globl _MainEntry
	.globl _SystemLock
	.globl _TestMemory
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
G$MainEntry$0$0==.
_MainEntry::
	.ds 2
G$PrintReg$0$0==.
_PrintReg::
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
	G$PrintNumber$0$0	= .
	.globl	G$PrintNumber$0$0
	C$main.c$25$0$0	= .
	.globl	C$main.c$25$0$0
;main.c:25: void PrintNumber(unsigned int n) {
;	---------------------------------
; Function PrintNumber
; ---------------------------------
_PrintNumber_start::
_PrintNumber:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-16
	add	hl,sp
	ld	sp,hl
	C$main.c$27$1$1	= .
	.globl	C$main.c$27$1$1
;main.c:27: WordToString(n, Temp);
	ld	hl,#0x0000
	add	hl,sp
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_WordToString
	pop	af
	pop	af
	C$main.c$28$1$1	= .
	.globl	C$main.c$28$1$1
;main.c:28: ConsoleWrite(Temp);
	ld	hl,#0x0000
	add	hl,sp
	push	hl
	call	_ConsoleWrite
	pop	af
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	C$main.c$29$1$1	= .
	.globl	C$main.c$29$1$1
	XG$PrintNumber$0$0	= .
	.globl	XG$PrintNumber$0$0
	ret
_PrintNumber_end::
	G$SystemInit$0$0	= .
	.globl	G$SystemInit$0$0
	C$main.c$31$1$1	= .
	.globl	C$main.c$31$1$1
;main.c:31: void SystemInit() {
;	---------------------------------
; Function SystemInit
; ---------------------------------
_SystemInit_start::
_SystemInit:
	ld	a,#3
	rst	0x08
	C$main.c$32$1$1	= .
	.globl	C$main.c$32$1$1
;main.c:32: }
	ld	a,#4
	rst	0x08
	C$main.c$32$1$1	= .
	.globl	C$main.c$32$1$1
	XG$SystemInit$0$0	= .
	.globl	XG$SystemInit$0$0
	ret
_SystemInit_end::
	G$Task1$0$0	= .
	.globl	G$Task1$0$0
	C$main.c$34$1$1	= .
	.globl	C$main.c$34$1$1
;main.c:34: void Task1() {
;	---------------------------------
; Function Task1
; ---------------------------------
_Task1_start::
_Task1:
	ld	a,#3
	rst	0x08
	C$main.c$35$1$1	= .
	.globl	C$main.c$35$1$1
;main.c:35: while(1) {
00104$:
	C$main.c$36$2$2	= .
	.globl	C$main.c$36$2$2
;main.c:36: if(!IsMultitasking()) {
	call	_IsMultitasking
	xor	a,a
	or	a,l
	jr	NZ,00102$
	C$main.c$37$3$3	= .
	.globl	C$main.c$37$3$3
;main.c:37: Halt("INTS DISABLED PRC1");
	ld	hl,#__str_0
	push	hl
	call	_Halt
	pop	af
00102$:
	C$main.c$39$2$2	= .
	.globl	C$main.c$39$2$2
;main.c:39: ConsoleWrite("1");
	ld	hl,#__str_1
	push	hl
	call	_ConsoleWrite
	pop	af
	C$main.c$40$2$2	= .
	.globl	C$main.c$40$2$2
;main.c:40: _SimPrintString("1");
	ld	hl,#__str_1
	push	hl
	call	__Z80SimPrintString
	pop	af
	jr	00104$
	ld	a,#4
	rst	0x08
	C$main.c$42$1$1	= .
	.globl	C$main.c$42$1$1
	XG$Task1$0$0	= .
	.globl	XG$Task1$0$0
	ret
_Task1_end::
Fmain$_str_0$0$0 == .
__str_0:
	.ascii "INTS DISABLED PRC1"
	.db 0x00
Fmain$_str_1$0$0 == .
__str_1:
	.ascii "1"
	.db 0x00
	G$Task2$0$0	= .
	.globl	G$Task2$0$0
	C$main.c$44$1$1	= .
	.globl	C$main.c$44$1$1
;main.c:44: void Task2() {
;	---------------------------------
; Function Task2
; ---------------------------------
_Task2_start::
_Task2:
	ld	a,#3
	rst	0x08
	C$main.c$45$1$1	= .
	.globl	C$main.c$45$1$1
;main.c:45: while(1) {
00104$:
	C$main.c$46$2$2	= .
	.globl	C$main.c$46$2$2
;main.c:46: if(!IsMultitasking()) {
	call	_IsMultitasking
	xor	a,a
	or	a,l
	jr	NZ,00102$
	C$main.c$47$3$3	= .
	.globl	C$main.c$47$3$3
;main.c:47: Halt("INTS DISABLED PRC2");
	ld	hl,#__str_2
	push	hl
	call	_Halt
	pop	af
00102$:
	C$main.c$49$2$2	= .
	.globl	C$main.c$49$2$2
;main.c:49: ConsoleWrite("2");
	ld	hl,#__str_3
	push	hl
	call	_ConsoleWrite
	pop	af
	C$main.c$50$2$2	= .
	.globl	C$main.c$50$2$2
;main.c:50: _SimPrintString("2");
	ld	hl,#__str_3
	push	hl
	call	__Z80SimPrintString
	pop	af
	jr	00104$
	ld	a,#4
	rst	0x08
	C$main.c$52$1$1	= .
	.globl	C$main.c$52$1$1
	XG$Task2$0$0	= .
	.globl	XG$Task2$0$0
	ret
_Task2_end::
Fmain$_str_2$0$0 == .
__str_2:
	.ascii "INTS DISABLED PRC2"
	.db 0x00
Fmain$_str_3$0$0 == .
__str_3:
	.ascii "2"
	.db 0x00
	G$SystemTask$0$0	= .
	.globl	G$SystemTask$0$0
	C$main.c$54$1$1	= .
	.globl	C$main.c$54$1$1
;main.c:54: void SystemTask() {
;	---------------------------------
; Function SystemTask
; ---------------------------------
_SystemTask_start::
_SystemTask:
	ld	a,#3
	rst	0x08
	C$main.c$55$1$1	= .
	.globl	C$main.c$55$1$1
;main.c:55: if(!IsMultitasking()) Halt("PAUSE WITHOUT RESUME");
	call	_IsMultitasking
	xor	a,a
	or	a,l
	jr	NZ,00102$
	ld	hl,#__str_4
	push	hl
	call	_Halt
	pop	af
00102$:
	C$main.c$56$1$1	= .
	.globl	C$main.c$56$1$1
;main.c:56: SystemMonitor();
	call	_SystemMonitor
	ld	a,#4
	rst	0x08
	C$main.c$57$1$1	= .
	.globl	C$main.c$57$1$1
	XG$SystemTask$0$0	= .
	.globl	XG$SystemTask$0$0
	ret
_SystemTask_end::
Fmain$_str_4$0$0 == .
__str_4:
	.ascii "PAUSE WITHOUT RESUME"
	.db 0x00
	G$main$0$0	= .
	.globl	G$main$0$0
	C$main.c$59$1$1	= .
	.globl	C$main.c$59$1$1
;main.c:59: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main_start::
_main:
	ld	a,#3
	rst	0x08
	C$main.c$76$1$1	= .
	.globl	C$main.c$76$1$1
;main.c:76: _endasm;
;
		       di
		       ld sp,#0xffff
		       ld a,#0x0
		       ld bc,#0x0
		       ld de,#0x0
		       ld hl,#0x0
		       ld ix,#0x0
		       ld iy,#0x0
		       
	C$main.c$78$1$1	= .
	.globl	C$main.c$78$1$1
;main.c:78: _SimWriteProtect((void*)0x0000, (void*)0x3fff);
	ld	hl,#0x3FFF
	push	hl
	ld	hl,#0x0000
	push	hl
	call	__Z80SimWriteProtect
	pop	af
	pop	af
	C$main.c$80$1$1	= .
	.globl	C$main.c$80$1$1
;main.c:80: _SimPrintString("\n-------------------\n");
	ld	hl,#__str_5
	push	hl
	call	__Z80SimPrintString
	pop	af
	C$main.c$81$1$1	= .
	.globl	C$main.c$81$1$1
;main.c:81: _SimPrintString("System reset\n");
	ld	hl,#__str_6
	push	hl
	call	__Z80SimPrintString
	pop	af
	C$main.c$82$1$1	= .
	.globl	C$main.c$82$1$1
;main.c:82: _SimPrintString("-------------------\n");
	ld	hl,#__str_7
	push	hl
	call	__Z80SimPrintString
	pop	af
	C$main.c$84$1$1	= .
	.globl	C$main.c$84$1$1
;main.c:84: IntsOff();
		di 
	C$main.c$86$1$1	= .
	.globl	C$main.c$86$1$1
;main.c:86: _SimPrintString("Interrupts disabled. Booting...\n");
	ld	hl,#__str_8
	push	hl
	call	__Z80SimPrintString
	pop	af
	C$main.c$88$1$1	= .
	.globl	C$main.c$88$1$1
;main.c:88: TestMemory();
	call	_TestMemory
	C$main.c$89$1$1	= .
	.globl	C$main.c$89$1$1
;main.c:89: HardwareInit();
	call	_HardwareInit
	C$main.c$90$1$1	= .
	.globl	C$main.c$90$1$1
;main.c:90: LocksInit();
	call	_LocksInit
	C$main.c$91$1$1	= .
	.globl	C$main.c$91$1$1
;main.c:91: SchedulingInit();
	call	_SchedulingInit
	C$main.c$92$1$1	= .
	.globl	C$main.c$92$1$1
;main.c:92: SupervisorMode();
	call	_SupervisorMode
	C$main.c$93$1$1	= .
	.globl	C$main.c$93$1$1
;main.c:93: TimeInit();
	call	_TimeInit
	C$main.c$94$1$1	= .
	.globl	C$main.c$94$1$1
;main.c:94: SystemInit();
	call	_SystemInit
	C$main.c$95$1$1	= .
	.globl	C$main.c$95$1$1
;main.c:95: MemoryInit();
	call	_MemoryInit
	C$main.c$98$1$1	= .
	.globl	C$main.c$98$1$1
;main.c:98: ConsoleInit();
	call	_ConsoleInit
	C$main.c$99$1$1	= .
	.globl	C$main.c$99$1$1
;main.c:99: ConsoleWrite("LJL OS 0.1 FOR ZX SPECTRUM 48\n");
	ld	hl,#__str_9
	push	hl
	call	_ConsoleWrite
	pop	af
	C$main.c$100$1$1	= .
	.globl	C$main.c$100$1$1
;main.c:100: ConsoleWrite("\nCONSOLE OUTPUT\n\n");
	ld	hl,#__str_10
	push	hl
	call	_ConsoleWrite
	pop	af
	C$main.c$110$1$1	= .
	.globl	C$main.c$110$1$1
;main.c:110: MainEntry=Task1;
	ld	hl,#_MainEntry + 0
	ld	(hl), #<_Task1
	ld	hl,#_MainEntry + 1
	ld	(hl), #>_Task1
	C$main.c$111$1$1	= .
	.globl	C$main.c$111$1$1
;main.c:111: TI1=CreateTask(MainEntry, 100);
	ld	bc,(_MainEntry)
	ld	hl,#0x0064
	push	hl
	push	bc
	call	_CreateTask
	pop	af
	pop	af
	C$main.c$112$1$1	= .
	.globl	C$main.c$112$1$1
;main.c:112: MainEntry=Task2;
	ld	hl,#_MainEntry + 0
	ld	(hl), #<_Task2
	ld	hl,#_MainEntry + 1
	ld	(hl), #>_Task2
	C$main.c$113$1$1	= .
	.globl	C$main.c$113$1$1
;main.c:113: TI2=CreateTask(MainEntry, 100);
	ld	bc,(_MainEntry)
	ld	hl,#0x0064
	push	hl
	push	bc
	call	_CreateTask
	pop	af
	pop	af
	C$main.c$114$1$1	= .
	.globl	C$main.c$114$1$1
;main.c:114: ConsoleWrite("TASKS CREATED\n");
	ld	hl,#__str_11
	push	hl
	call	_ConsoleWrite
	pop	af
	C$main.c$115$1$1	= .
	.globl	C$main.c$115$1$1
;main.c:115: SetScheduler(DefaultScheduler);
	ld	hl,#_DefaultScheduler
	push	hl
	call	_SetScheduler
	pop	af
	C$main.c$116$1$1	= .
	.globl	C$main.c$116$1$1
;main.c:116: ConsoleWrite("SCHEDULER SET\n");
	ld	hl,#__str_12
	push	hl
	call	_ConsoleWrite
	pop	af
	C$main.c$117$1$1	= .
	.globl	C$main.c$117$1$1
;main.c:117: Resume();
	call	_Resume
00102$:
	jr	00102$
	C$main.c$121$1$1	= .
	.globl	C$main.c$121$1$1
;main.c:121: Halt("SYSTEM SHUTDOWN");
	ld	a,#4
	rst	0x08
	C$main.c$122$1$1	= .
	.globl	C$main.c$122$1$1
	XG$main$0$0	= .
	.globl	XG$main$0$0
	ret
_main_end::
Fmain$_str_5$0$0 == .
__str_5:
	.db 0x0A
	.ascii "-------------------"
	.db 0x0A
	.db 0x00
Fmain$_str_6$0$0 == .
__str_6:
	.ascii "System reset"
	.db 0x0A
	.db 0x00
Fmain$_str_7$0$0 == .
__str_7:
	.ascii "-------------------"
	.db 0x0A
	.db 0x00
Fmain$_str_8$0$0 == .
__str_8:
	.ascii "Interrupts disabled. Booting..."
	.db 0x0A
	.db 0x00
Fmain$_str_9$0$0 == .
__str_9:
	.ascii "LJL OS 0.1 FOR ZX SPECTRUM 48"
	.db 0x0A
	.db 0x00
Fmain$_str_10$0$0 == .
__str_10:
	.db 0x0A
	.ascii "CONSOLE OUTPUT"
	.db 0x0A
	.db 0x0A
	.db 0x00
Fmain$_str_11$0$0 == .
__str_11:
	.ascii "TASKS CREATED"
	.db 0x0A
	.db 0x00
Fmain$_str_12$0$0 == .
__str_12:
	.ascii "SCHEDULER SET"
	.db 0x0A
	.db 0x00
Fmain$_str_13$0$0 == .
__str_13:
	.ascii "SYSTEM SHUTDOWN"
	.db 0x00
	G$TestMemory$0$0	= .
	.globl	G$TestMemory$0$0
	C$main.c$124$1$1	= .
	.globl	C$main.c$124$1$1
;main.c:124: void TestMemory()
;	---------------------------------
; Function TestMemory
; ---------------------------------
_TestMemory_start::
_TestMemory:
	ld	a,#3
	rst	0x08
	C$main.c$127$1$1	= .
	.globl	C$main.c$127$1$1
;main.c:127: PutString("TESTING MEMORY A", 1, 1);
	ld	hl,#0x0101
	push	hl
	ld	hl,#__str_14
	push	hl
	call	_PutString
	pop	af
	pop	af
	C$main.c$128$1$1	= .
	.globl	C$main.c$128$1$1
;main.c:128: _SimUnprotect(0x4000, 0x5fff);
	ld	hl,#0x5FFF
	push	hl
	ld	hl,#0x4000
	push	hl
	call	__Z80SimUnprotect
	pop	af
	pop	af
	C$main.c$129$1$1	= .
	.globl	C$main.c$129$1$1
;main.c:129: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
	ld	bc,#0x4000
00105$:
	ld	e,c
	ld	d,b
	ld	a,e
	sub	a,#0xEA
	ld	a,d
	sbc	a,#0xEE
	jp	P,00108$
	C$main.c$130$2$2	= .
	.globl	C$main.c$130$2$2
;main.c:130: *i=0xAA;
	ld	a,#0xAA
	ld	(bc),a
	C$main.c$129$1$1	= .
	.globl	C$main.c$129$1$1
;main.c:129: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
	inc	bc
	jr	00105$
00108$:
	C$main.c$132$1$1	= .
	.globl	C$main.c$132$1$1
;main.c:132: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
	ld	bc,#0x4000
00109$:
	ld	e,c
	ld	d,b
	ld	a,e
	sub	a,#0xEA
	ld	a,d
	sbc	a,#0xEE
	jp	P,00112$
	C$main.c$133$2$3	= .
	.globl	C$main.c$133$2$3
;main.c:133: if(*i!=0xAA) {
	ld	a,(bc)
	sub	a,#0xAA
	jr	Z,00111$
	C$main.c$134$3$4	= .
	.globl	C$main.c$134$3$4
;main.c:134: PutString("BAD MEMORY", 1, 1);
	push	bc
	ld	hl,#0x0101
	push	hl
	ld	hl,#__str_15
	push	hl
	call	_PutString
	pop	af
	pop	af
	pop	bc
	C$main.c$135$3$4	= .
	.globl	C$main.c$135$3$4
;main.c:135: Halt("BAD MEMORY");
	push	bc
	ld	hl,#__str_15
	push	hl
	call	_Halt
	pop	af
	pop	bc
00111$:
	C$main.c$132$1$1	= .
	.globl	C$main.c$132$1$1
;main.c:132: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
	inc	bc
	jr	00109$
00112$:
	C$main.c$138$1$1	= .
	.globl	C$main.c$138$1$1
;main.c:138: PutString("TESTING MEMORY B", 2, 1);
	ld	hl,#0x0102
	push	hl
	ld	hl,#__str_16
	push	hl
	call	_PutString
	pop	af
	pop	af
	C$main.c$139$1$1	= .
	.globl	C$main.c$139$1$1
;main.c:139: _SimUnprotect(0x4000, 0x5fff);
	ld	hl,#0x5FFF
	push	hl
	ld	hl,#0x4000
	push	hl
	call	__Z80SimUnprotect
	pop	af
	pop	af
	C$main.c$140$1$1	= .
	.globl	C$main.c$140$1$1
;main.c:140: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
	ld	bc,#0x4000
00113$:
	ld	e,c
	ld	d,b
	ld	a,e
	sub	a,#0xEA
	ld	a,d
	sbc	a,#0xEE
	jp	P,00116$
	C$main.c$141$2$5	= .
	.globl	C$main.c$141$2$5
;main.c:141: *i=(~0xAA);
	ld	a,#0x55
	ld	(bc),a
	C$main.c$140$1$1	= .
	.globl	C$main.c$140$1$1
;main.c:140: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
	inc	bc
	jr	00113$
00116$:
	C$main.c$143$1$1	= .
	.globl	C$main.c$143$1$1
;main.c:143: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
	ld	bc,#0x4000
00117$:
	ld	e,c
	ld	d,b
	ld	a,e
	sub	a,#0xEA
	ld	a,d
	sbc	a,#0xEE
	jp	P,00120$
	C$main.c$144$2$6	= .
	.globl	C$main.c$144$2$6
;main.c:144: if(*i!=(~0xAA)) Halt("BAD MEMORY");
	push	bc
	ld	hl,#__str_15
	push	hl
	call	_Halt
	pop	af
	pop	bc
	C$main.c$143$1$1	= .
	.globl	C$main.c$143$1$1
;main.c:143: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
	inc	bc
	jr	00117$
00120$:
	C$main.c$146$1$1	= .
	.globl	C$main.c$146$1$1
;main.c:146: PutString("MEMORY TEST COMPLETE", 3, 1);
	ld	hl,#0x0103
	push	hl
	ld	hl,#__str_17
	push	hl
	call	_PutString
	pop	af
	pop	af
	C$main.c$147$1$1	= .
	.globl	C$main.c$147$1$1
;main.c:147: _SimUnprotect(0x4000, 0x5fff);
	ld	hl,#0x5FFF
	push	hl
	ld	hl,#0x4000
	push	hl
	call	__Z80SimUnprotect
	pop	af
	pop	af
	C$main.c$148$1$1	= .
	.globl	C$main.c$148$1$1
;main.c:148: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
	ld	bc,#0x4000
00121$:
	ld	e,c
	ld	d,b
	ld	a,e
	sub	a,#0xEA
	ld	a,d
	sbc	a,#0xEE
	jp	P,00124$
	C$main.c$149$2$7	= .
	.globl	C$main.c$149$2$7
;main.c:149: *i=0;
	ld	a,#0x00
	ld	(bc),a
	C$main.c$148$1$1	= .
	.globl	C$main.c$148$1$1
;main.c:148: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
	inc	bc
	jr	00121$
00124$:
	C$main.c$151$1$1	= .
	.globl	C$main.c$151$1$1
;main.c:151: _SimPrintString("Memory test completed\n");
	ld	hl,#__str_18
	push	hl
	call	__Z80SimPrintString
	pop	af
	ld	a,#4
	rst	0x08
	C$main.c$152$1$1	= .
	.globl	C$main.c$152$1$1
	XG$TestMemory$0$0	= .
	.globl	XG$TestMemory$0$0
	ret
_TestMemory_end::
Fmain$_str_14$0$0 == .
__str_14:
	.ascii "TESTING MEMORY A"
	.db 0x00
Fmain$_str_15$0$0 == .
__str_15:
	.ascii "BAD MEMORY"
	.db 0x00
Fmain$_str_16$0$0 == .
__str_16:
	.ascii "TESTING MEMORY B"
	.db 0x00
Fmain$_str_17$0$0 == .
__str_17:
	.ascii "MEMORY TEST COMPLETE"
	.db 0x00
Fmain$_str_18$0$0 == .
__str_18:
	.ascii "Memory test completed"
	.db 0x0A
	.db 0x00
	.area _CODE
	.area _CABS
