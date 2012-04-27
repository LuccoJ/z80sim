;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Fri Apr 27 12:30:18 2012

;--------------------------------------------------------
	.module scheduling
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _NewContext
	.globl _DoNothingScheduler
	.globl __InterruptService
	.globl _RegisterInterrupt
	.globl _SchedulingInited
	.globl _UserSP
	.globl _InterruptVectorCount
	.globl _InterruptVector
	.globl _ControlRequests
	.globl _ActiveScheduler
	.globl _TempSP
	.globl _OldSP
	.globl _CurrentSP
	.globl _SystemTasks
	.globl _CurrentTask
	.globl _SystemLock
	.globl _SchedulingInit
	.globl _SetScheduler
	.globl _Scheduler
	.globl _NullScheduler
	.globl _DefaultScheduler
	.globl _CreateTask
	.globl _SupervisorMode
	.globl _UserMode
	.globl _Pause
	.globl _Resume
	.globl _BroadcastEvent
	.globl _AwaitEvent
	.globl _Switch
	.globl _ScheduleTask
	.globl _IsMultitasking
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
G$SystemLock$0$0==.
_SystemLock::
	.ds 1
G$CurrentTask$0$0==.
_CurrentTask::
	.ds 2
G$SystemTasks$0$0==.
_SystemTasks::
	.ds 2
G$CurrentSP$0$0==.
_CurrentSP::
	.ds 2
G$OldSP$0$0==.
_OldSP::
	.ds 2
G$TempSP$0$0==.
_TempSP::
	.ds 2
G$ActiveScheduler$0$0==.
_ActiveScheduler::
	.ds 2
G$ControlRequests$0$0==.
_ControlRequests::
	.ds 1
G$InterruptVector$0$0==.
_InterruptVector::
	.ds 512
G$InterruptVectorCount$0$0==.
_InterruptVectorCount::
	.ds 1
G$UserSP$0$0==.
_UserSP::
	.ds 2
G$SchedulingInited$0$0==.
_SchedulingInited::
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
;scheduling.c:34: void RegisterInterrupt(void (*InterruptFunction)()) {
;	genLabel
;	genFunction
;	---------------------------------
; Function RegisterInterrupt
; ---------------------------------
_RegisterInterrupt_start::
_RegisterInterrupt:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
;scheduling.c:35: InterruptVector[InterruptVectorCount++]=InterruptFunction;
;	genAssign
	ld	iy,#_InterruptVectorCount
	ld	c,0(iy)
;	genPlus
;	genPlusIncr
	inc	0(iy)
;	genCast
	ld	l,c
	ld	a,c
	rla	
	sbc	a,a
	ld	h,a
;	genLeftShift
; Removed redundent load
; Removed redundent load
	add	hl,hl
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<_InterruptVector
	add	a,l
	ld	l,a
	ld	a,#>_InterruptVector
	adc	a,h
	ld	h,a
;	genAssign (pointer)
;	AOP_STK for 
;	isBitvar = 0
	ld	a,4(ix)
	ld	(hl),a
	inc	hl
	ld	a,5(ix)
	ld	(hl),a
;	genLabel
00101$:
;	genEndFunction
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_RegisterInterrupt_end::
;scheduling.c:39: void _InterruptService() {
;	genLabel
;	genFunction
;	---------------------------------
; Function _InterruptService
; ---------------------------------
__InterruptService_start::
__InterruptService:
	ld	a,#3
	rst	0x08
;scheduling.c:41: ExchangeRegs();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_ExchangeRegs
;scheduling.c:42: GetStackPointerASM(_UserSP);
;	genInline
		ld (_UserSP),sp 
;scheduling.c:43: SaveIndexes();
;	genInline
		ld hl,£0xEFFF ld sp,hl push ix push iy 
;scheduling.c:44: if(ControlRequests<0) Halt("NEGATIVE CONTROLREQUESTS");
;	genCmpLt
	ld	iy,#_ControlRequests
	ld	a,0(iy)
	bit	7,a
	jp	z,00102$
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_0
	push	hl
;	genCall
	call	_Halt
	pop	af
;	genLabel
00102$:
;scheduling.c:45: if(!IsMultitasking()) Halt("INTERRUPT IN KERNEL MODE");
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_IsMultitasking
;	genIfx
	xor	a,a
	or	a,l
	jp	nz,00104$
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_1
	push	hl
;	genCall
	call	_Halt
	pop	af
;	genLabel
00104$:
;scheduling.c:46: ControlRequests++;
;	genPlus
;	genPlusIncr
	ld	iy,#_ControlRequests
	inc	0(iy)
;scheduling.c:47: Tick();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_Tick
;scheduling.c:48: for(i=0; i<InterruptVectorCount; i++) {
;	genAssign
	ld	c,#0x00
;	genLabel
00105$:
;	genCmpLt
	ld	a,c
	ld	iy,#_InterruptVectorCount
	sub	a,0(iy)
	jp	p,00108$
;scheduling.c:49: (InterruptVector[i])();
;	genCast
	ld	l,c
	ld	a,c
	rla	
	sbc	a,a
	ld	h,a
;	genLeftShift
; Removed redundent load
; Removed redundent load
	add	hl,hl
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<_InterruptVector
	add	a,l
	ld	l,a
	ld	a,#>_InterruptVector
	adc	a,h
	ld	h,a
;	genPointerGet
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
;	genPcall
; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
	push	bc
	push	de
	ld	hl,#00115$
	push	hl
	ld	l,e
	ld	h,d
	jp	(hl)
00115$:
	pop	de
	pop	bc
;scheduling.c:48: for(i=0; i<InterruptVectorCount; i++) {
;	genPlus
;	genPlusIncr
; Removed redundent load
	inc	c
;	genGoto
	jp	00105$
;	genLabel
00108$:
;scheduling.c:51: Scheduler(UserSP);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,(_UserSP)
	push	hl
;	genCall
	call	_Scheduler
	pop	af
;scheduling.c:52: Halt("OUT OF REACH");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_2
	push	hl
;	genCall
	call	_Halt
	pop	af
;	genLabel
00109$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
__InterruptService_end::
Fscheduling$_str_0$0$0 == .
__str_0:
	.ascii "NEGATIVE CONTROLREQUESTS"
	.db 0x00
Fscheduling$_str_1$0$0 == .
__str_1:
	.ascii "INTERRUPT IN KERNEL MODE"
	.db 0x00
Fscheduling$_str_2$0$0 == .
__str_2:
	.ascii "OUT OF REACH"
	.db 0x00
;scheduling.c:55: bool SchedulingInited; void SchedulingInit() {
;	genLabel
;	genFunction
;	---------------------------------
; Function SchedulingInit
; ---------------------------------
_SchedulingInit_start::
_SchedulingInit:
	ld	a,#3
	rst	0x08
;scheduling.c:56: if(!SchedulingInited) {
;	genIfx
	xor	a,a
	ld	iy,#_SchedulingInited
	or	a,0(iy)
	jp	nz,00103$
;scheduling.c:57: MemoryInit();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_MemoryInit
;scheduling.c:58: TimeInit();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_TimeInit
;scheduling.c:59: ControlRequests=1;
;	genAssign
	ld	iy,#_ControlRequests
	ld	0(iy),#0x01
;scheduling.c:60: CurrentTask=SystemTasks=NULL;
;	genAssign
	ld	iy,#_SystemTasks
	ld	0(iy),#0x00
	ld	1(iy),#0x00
;	genAssign
	ld	iy,#_CurrentTask
	ld	0(iy),#0x00
	ld	1(iy),#0x00
;scheduling.c:61: ActiveScheduler=NullScheduler;
;	genAssign
	ld	iy,#_ActiveScheduler
	ld	0(iy),#<_NullScheduler
	ld	1(iy),#>_NullScheduler
;scheduling.c:62: InterruptVectorCount=0;
;	genAssign
	ld	iy,#_InterruptVectorCount
	ld	0(iy),#0x00
;scheduling.c:63: SystemLock=LockCreate();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_LockCreate
	ld	c,l
;	genAssign
	ld	iy,#_SystemLock
	ld	0(iy),c
;scheduling.c:65: SchedulingInited=TRUE;
;	genAssign
	ld	iy,#_SchedulingInited
	ld	0(iy),#0x01
;	genLabel
00103$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
_SchedulingInit_end::
;scheduling.c:69: void SetScheduler(void (*SchedulerFunction)()) {
;	genLabel
;	genFunction
;	---------------------------------
; Function SetScheduler
; ---------------------------------
_SetScheduler_start::
_SetScheduler:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
;scheduling.c:70: ActiveScheduler=SchedulerFunction;
;	genAssign
;	AOP_STK for 
	ld	a,4(ix)
	ld	iy,#_ActiveScheduler
	ld	0(iy),a
	ld	a,5(ix)
	ld	1(iy),a
;	genLabel
00101$:
;	genEndFunction
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_SetScheduler_end::
;scheduling.c:73: void Scheduler(void* SP) {
;	genLabel
;	genFunction
;	---------------------------------
; Function Scheduler
; ---------------------------------
_Scheduler_start::
_Scheduler:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
;scheduling.c:74: OldSP=SP;
;	genAssign
;	AOP_STK for 
	ld	a,4(ix)
	ld	iy,#_OldSP
	ld	0(iy),a
	ld	a,5(ix)
	ld	1(iy),a
;scheduling.c:75: if(ControlRequests>10) Halt("TOO MANY REQUESTS");
;	genCmpGt
	ld	a,#0x0A
	ld	iy,#_ControlRequests
	sub	a,0(iy)
	jp	p,00102$
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_3
	push	hl
;	genCall
	call	_Halt
	pop	af
;	genLabel
00102$:
;scheduling.c:76: ActiveScheduler();
;	genPcall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#00106$
	push	hl
	ld	hl,(_ActiveScheduler)
	jp	(hl)
00106$:
;	genLabel
00103$:
;	genEndFunction
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_Scheduler_end::
Fscheduling$_str_3$0$0 == .
__str_3:
	.ascii "TOO MANY REQUESTS"
	.db 0x00
;scheduling.c:79: void NullScheduler() {
;	genLabel
;	genFunction
;	---------------------------------
; Function NullScheduler
; ---------------------------------
_NullScheduler_start::
_NullScheduler:
	ld	a,#3
	rst	0x08
;scheduling.c:80: ControlRequests--;
;	genMinus
	ld	iy,#_ControlRequests
	dec	0(iy)
;scheduling.c:81: SetStackPointerASM(_OldSP);
;	genInline
		ld sp,(_OldSP) 
;scheduling.c:82: ExchangeRegs();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_ExchangeRegs
;scheduling.c:83: ReloadIndexes();
;	genInline
		ld ix,(0xEFFD) ld iy,(0xEFFB) 
;scheduling.c:84: IntsOn();
;	genInline
		im 1 ei 
;	genLabel
00101$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
_NullScheduler_end::
;scheduling.c:87: void DoNothingScheduler() {
;	genLabel
;	genFunction
;	---------------------------------
; Function DoNothingScheduler
; ---------------------------------
_DoNothingScheduler_start::
_DoNothingScheduler:
	ld	a,#3
	rst	0x08
;scheduling.c:88: }
;	genLabel
00101$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
_DoNothingScheduler_end::
;scheduling.c:90: void DefaultScheduler() {
;	genLabel
;	genFunction
;	---------------------------------
; Function DefaultScheduler
; ---------------------------------
_DefaultScheduler_start::
_DefaultScheduler:
	ld	a,#3
	rst	0x08
;scheduling.c:91: if(LockQuery(SystemLock)) {
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,(_SystemLock)
	push	af
	inc	sp
;	genCall
	call	_LockQuery
	inc	sp
;	genIfx
	xor	a,a
	or	a,l
	jp	z,00102$
;scheduling.c:92: Halt("SYSTEM LOCKED SCH");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_4
	push	hl
;	genCall
	call	_Halt
	pop	af
;scheduling.c:93: NullScheduler();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_NullScheduler
;scheduling.c:94: return;
;	genRet
	jp	00114$
;	genLabel
00102$:
;scheduling.c:96: if(SystemTasks==NULL) Break("SCHEDULING NO TASK");
;	genCmpEq
; genCmpEq: left 2, right 2, result 0
	ld	iy,#_SystemTasks
	ld	a,0(iy)
	or	a,1(iy)
	jp	z,00123$
00122$:
	jp	00104$
00123$:
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_5
	push	hl
;	genCall
	call	_Break
	pop	af
;	genLabel
00104$:
;scheduling.c:97: if(CurrentTask==NULL) {
;	genCmpEq
; genCmpEq: left 2, right 2, result 0
	ld	iy,#_CurrentTask
	ld	a,0(iy)
	or	a,1(iy)
	jp	z,00125$
00124$:
	jp	00106$
00125$:
;scheduling.c:98: CurrentTask=SystemTasks;
;	genAssign
	ld	hl,(_SystemTasks)
	ld	iy,#_CurrentTask
	ld	0(iy),l
	ld	1(iy),h
;	genGoto
	jp	00111$
;	genLabel
00106$:
;scheduling.c:100: CurrentSP=&(CurrentTask->Value.SP);
;	genAssign
	ld	bc,(_CurrentTask)
;	genPlus
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
;	Shift into pair idx 0
	ld	hl,#_CurrentSP
	ld	a,c
	add	a,#0x04
	ld	(hl),a
	ld	a,b
	adc	a,#0x00
	inc	hl
	ld	(hl),a
;scheduling.c:104: do {
;	genLabel
00111$:
;scheduling.c:105: if(CurrentTask->Next==NULL) {
;	genAssign
	ld	hl,(_CurrentTask)
;	genPlus
;	genPlusIncr
	ld	bc,#0x0009
	add	hl,bc
;	genPointerGet
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
;	genCmpEq
; genCmpEq: left 2, right 2, result 0
	ld	l,a
	or	a,h
	jp	z,00127$
00126$:
	jp	00109$
00127$:
;scheduling.c:106: CurrentTask=SystemTasks;
;	genAssign
	ld	hl,(_SystemTasks)
	ld	iy,#_CurrentTask
	ld	0(iy),l
	ld	1(iy),h
;	genGoto
	jp	00112$
;	genLabel
00109$:
;scheduling.c:108: CurrentTask=CurrentTask->Next;
;	genAssign
	ld	hl,(_CurrentTask)
;	genPlus
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,l
	add	a,#0x09
	ld	c,a
	ld	a,h
	adc	a,#0x00
	ld	b,a
;	genPointerGet
	ld	l,c
	ld	h,b
	ld	a,(hl)
	ld	iy,#_CurrentTask
	ld	0(iy),a
	inc	hl
	ld	a,(hl)
	ld	1(iy),a
;	genLabel
00112$:
;scheduling.c:110: } while(CurrentTask->Value.RegisteredEvents!=EVENT_RUNTASK);
;	genAssign
	ld	hl,(_CurrentTask)
;	genPlus
;	genPlusIncr
	ld	bc,#0x0006
	add	hl,bc
;	genPointerGet
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
;	genCmpEq
; genCmpEq: left 2, right 2, result 0
	ld	l,a
	or	a,h
	jp	z,00129$
00128$:
	jp	00111$
00129$:
;scheduling.c:111: ScheduleTask(&(CurrentTask->Value));
;	genAssign
	ld	hl,(_CurrentTask)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	hl
;	genCall
	call	_ScheduleTask
	pop	af
;	genLabel
00114$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
_DefaultScheduler_end::
Fscheduling$_str_4$0$0 == .
__str_4:
	.ascii "SYSTEM LOCKED SCH"
	.db 0x00
Fscheduling$_str_5$0$0 == .
__str_5:
	.ascii "SCHEDULING NO TASK"
	.db 0x00
;scheduling.c:114: task* CreateTask(void* EntryPoint, unsigned int AssignedStack) {
;	genLabel
;	genFunction
;	---------------------------------
; Function CreateTask
; ---------------------------------
_CreateTask_start::
_CreateTask:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-2
	add	hl,sp
	ld	sp,hl
;scheduling.c:118: NewTask=MemoryAllocate(sizeof(taskElement), memHEAP);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,#0x01
	push	af
	inc	sp
;	genIpush
	ld	hl,#0x000B
	push	hl
;	genCall
	call	_MemoryAllocate
	pop	af
	inc	sp
;	genAssign
;	genAssign
;	AOP_STK for _CreateTask_NewTask_1_1
	ld	-2(ix),l
	ld	-1(ix),h
;scheduling.c:119: NewTask->Next=SystemTasks;
;	genPlus
;	AOP_STK for _CreateTask_NewTask_1_1
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-2(ix)
	add	a,#0x09
	ld	e,a
	ld	a,-1(ix)
	adc	a,#0x00
	ld	d,a
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,e
	ld	h,d
	ld	iy,#_SystemTasks
	ld	a,0(iy)
	ld	(hl),a
	inc	hl
	ld	a,1(iy)
	ld	(hl),a
;scheduling.c:120: SystemTasks=NewTask;
;	genAssign
;	AOP_STK for _CreateTask_NewTask_1_1
	ld	a,-2(ix)
	ld	0(iy),a
	ld	a,-1(ix)
	ld	1(iy),a
;scheduling.c:123: TaskInfo->StackFrameTop=MemoryAllocate(AssignedStack, memSTACK);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,#0x00
	push	af
	inc	sp
;	genIpush
;	AOP_STK for 
	ld	l,6(ix)
	ld	h,7(ix)
	push	hl
;	genCall
	call	_MemoryAllocate
	ld	d,h
	ld	e,l
	pop	af
	inc	sp
;	genAssign (pointer)
;	AOP_STK for _CreateTask_NewTask_1_1
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),e
	inc	hl
	ld	(hl),d
;scheduling.c:124: TaskInfo->StackFrameBottom=(void*)((unsigned int)TaskInfo->StackFrameTop-AssignedStack);
;	genPlus
;	AOP_STK for _CreateTask_NewTask_1_1
;	genPlusIncr
	ld	l,-2(ix)
	ld	h,-1(ix)
	inc	hl
	inc	hl
;	genCast
	ld	c,e
	ld	b,d
;	genMinus
;	AOP_STK for 
	ld	a,c
	sub	a,6(ix)
	ld	c,a
	ld	a,b
	sbc	a,7(ix)
	ld	b,a
;	genCast
;	genAssign (pointer)
;	isBitvar = 0
	ld	(hl),c
	inc	hl
	ld	(hl),b
;scheduling.c:125: TaskInfo->SP=TaskInfo->StackFrameTop;
;	genPlus
;	AOP_STK for _CreateTask_NewTask_1_1
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-2(ix)
	add	a,#0x04
	ld	c,a
	ld	a,-1(ix)
	adc	a,#0x00
	ld	b,a
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,c
	ld	h,b
	ld	(hl),e
	inc	hl
	ld	(hl),d
;scheduling.c:126: TaskInfo->SP--; *(void**)(TaskInfo->SP)=EntryPoint;
;	genMinus
	dec	de
	dec	de
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,c
	ld	h,b
	ld	(hl),e
	inc	hl
	ld	(hl),d
;	genAssign (pointer)
;	AOP_STK for 
;	isBitvar = 0
	ld	l,e
	ld	h,d
	ld	a,4(ix)
	ld	(hl),a
	inc	hl
	ld	a,5(ix)
	ld	(hl),a
;scheduling.c:127: TaskInfo->SP--; *TaskInfo->SP=0; // AF
;	genMinus
	dec	de
	dec	de
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,c
	ld	h,b
	ld	(hl),e
	inc	hl
	ld	(hl),d
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,e
	ld	h,d
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;scheduling.c:128: TaskInfo->SP--; *TaskInfo->SP=0; // BC
;	genMinus
	dec	de
	dec	de
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,c
	ld	h,b
	ld	(hl),e
	inc	hl
	ld	(hl),d
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,e
	ld	h,d
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;scheduling.c:129: TaskInfo->SP--; *TaskInfo->SP=0; // DE
;	genMinus
	dec	de
	dec	de
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,c
	ld	h,b
	ld	(hl),e
	inc	hl
	ld	(hl),d
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,e
	ld	h,d
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;scheduling.c:130: TaskInfo->SP--; *TaskInfo->SP=0; // HL
;	genMinus
	dec	de
	dec	de
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,c
	ld	h,b
	ld	(hl),e
	inc	hl
	ld	(hl),d
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,e
	ld	h,d
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;scheduling.c:131: TaskInfo->SP--; *TaskInfo->SP=0; // IX
;	genMinus
	dec	de
	dec	de
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,c
	ld	h,b
	ld	(hl),e
	inc	hl
	ld	(hl),d
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,e
	ld	h,d
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;scheduling.c:132: TaskInfo->SP--; *TaskInfo->SP=0; // IY
;	genMinus
	dec	de
	dec	de
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,c
	ld	h,b
	ld	(hl),e
	inc	hl
	ld	(hl),d
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,e
	ld	h,d
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;scheduling.c:133: TaskInfo->RegisteredEvents=EVENT_RUNTASK;
;	genPlus
;	AOP_STK for _CreateTask_NewTask_1_1
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-2(ix)
	add	a,#0x06
	ld	l,a
	ld	a,-1(ix)
	adc	a,#0x00
	ld	h,a
;	genAssign (pointer)
;	isBitvar = 0
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;scheduling.c:134: TaskInfo->EventId=0;
;	genPlus
;	AOP_STK for _CreateTask_NewTask_1_1
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-2(ix)
	add	a,#0x08
	ld	l,a
	ld	a,-1(ix)
	adc	a,#0x00
	ld	h,a
;	genAssign (pointer)
;	isBitvar = 0
	ld	(hl),#0x00
;scheduling.c:135: return TaskInfo;
;	genRet
;	AOP_STK for _CreateTask_NewTask_1_1
; Dump of IC_LEFT: type AOP_STK size 2
;	 aop_stk -2
	ld	l,-2(ix)
	ld	h,-1(ix)
;	genLabel
00101$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_CreateTask_end::
;scheduling.c:138: void SupervisorMode() {
;	genLabel
;	genFunction
;	---------------------------------
; Function SupervisorMode
; ---------------------------------
_SupervisorMode_start::
_SupervisorMode:
	ld	a,#3
	rst	0x08
;scheduling.c:139: IntsOff();
;	genInline
		di 
;scheduling.c:140: ExchangeRegs();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_ExchangeRegs
;	genLabel
00101$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
_SupervisorMode_end::
;scheduling.c:143: void UserMode() {
;	genLabel
;	genFunction
;	---------------------------------
; Function UserMode
; ---------------------------------
_UserMode_start::
_UserMode:
	ld	a,#3
	rst	0x08
;scheduling.c:144: ExchangeRegs();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_ExchangeRegs
;scheduling.c:145: IntsOn();
;	genInline
		im 1 ei 
;	genLabel
00101$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
_UserMode_end::
;scheduling.c:148: void Pause() {
;	genLabel
;	genFunction
;	---------------------------------
; Function Pause
; ---------------------------------
_Pause_start::
_Pause:
	ld	a,#3
	rst	0x08
;scheduling.c:149: IntsOff();
;	genInline
		di 
;scheduling.c:150: ControlRequests++;
;	genPlus
;	genPlusIncr
	ld	iy,#_ControlRequests
	inc	0(iy)
;scheduling.c:151: if(ControlRequests==1) ExchangeRegs();
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	a,0(iy)
	cp	a,#0x01
	jp	z,00107$
00106$:
	jp	00103$
00107$:
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_ExchangeRegs
;	genLabel
00103$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
_Pause_end::
;scheduling.c:154: void Resume() {
;	genLabel
;	genFunction
;	---------------------------------
; Function Resume
; ---------------------------------
_Resume_start::
_Resume:
	ld	a,#3
	rst	0x08
;scheduling.c:155: if(ControlRequests>0) {
;	genCmpGt
	ld	a,#0x00
	ld	iy,#_ControlRequests
	sub	a,0(iy)
	jp	p,00104$
;scheduling.c:156: ControlRequests--;
;	genMinus
	dec	0(iy)
;scheduling.c:157: if(ControlRequests==0) {
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	a,0(iy)
	or	a,a
	jp	z,00111$
00110$:
	jp	00106$
00111$:
;scheduling.c:158: UserMode();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_UserMode
;	genGoto
	jp	00106$
;	genLabel
00104$:
;scheduling.c:161: Halt("RESUME WITHOUT PAUSE");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_6
	push	hl
;	genCall
	call	_Halt
	pop	af
;	genLabel
00106$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
_Resume_end::
Fscheduling$_str_6$0$0 == .
__str_6:
	.ascii "RESUME WITHOUT PAUSE"
	.db 0x00
;scheduling.c:165: void BroadcastEvent(int EventClass, short EventId) {
;	genLabel
;	genFunction
;	---------------------------------
; Function BroadcastEvent
; ---------------------------------
_BroadcastEvent_start::
_BroadcastEvent:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-2
	add	hl,sp
	ld	sp,hl
;scheduling.c:167: Pause();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_Pause
;scheduling.c:168: Task=SystemTasks;
;	genAssign
;	AOP_STK for _BroadcastEvent_Task_1_1
	ld	hl,(_SystemTasks)
	ld	-2(ix),l
	ld	-1(ix),h
;scheduling.c:169: while(Task!=NULL) {
;	genLabel
00103$:
;	genCmpEq
;	AOP_STK for _BroadcastEvent_Task_1_1
; genCmpEq: left 2, right 2, result 0
	ld	a,-2(ix)
	or	a,-1(ix)
	jp	z,00105$
00111$:
;scheduling.c:170: if(Task->Value.RegisteredEvents&EventClass) {
;	genPlus
;	AOP_STK for _BroadcastEvent_Task_1_1
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-2(ix)
	add	a,#0x06
	ld	e,a
	ld	a,-1(ix)
	adc	a,#0x00
	ld	d,a
;	genPointerGet
	ld	l,e
	ld	h,d
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
;	genAnd
;	AOP_STK for 
	ld	a,c
	and	a,4(ix)
	ld	c,a
	ld	a,b
	and	a,5(ix)
	ld	b,a
;	genIfx
	ld	a,c
	or	a,b
	jp	z,00102$
;scheduling.c:171: Task->Value.RegisteredEvents=EVENT_RUNTASK;
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,e
	ld	h,d
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;scheduling.c:172: Task->Value.EventId=EventId;
;	genPlus
;	AOP_STK for _BroadcastEvent_Task_1_1
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-2(ix)
	add	a,#0x08
	ld	l,a
	ld	a,-1(ix)
	adc	a,#0x00
	ld	h,a
;	genAssign (pointer)
;	AOP_STK for 
;	isBitvar = 0
	ld	a,6(ix)
	ld	(hl),a
;	genLabel
00102$:
;scheduling.c:174: Task=Task->Next;
;	genPlus
;	AOP_STK for _BroadcastEvent_Task_1_1
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,-2(ix)
	add	a,#0x09
	ld	l,a
	ld	a,-1(ix)
	adc	a,#0x00
	ld	h,a
;	genPointerGet
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
;	genAssign
;	AOP_STK for _BroadcastEvent_Task_1_1
	ld	-2(ix),l
	ld	-1(ix),h
;	genGoto
	jp	00103$
;	genLabel
00105$:
;scheduling.c:176: Resume();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_Resume
;	genLabel
00106$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_BroadcastEvent_end::
;scheduling.c:181: short AwaitEvent(int EventClass) {
;	genLabel
;	genFunction
;	---------------------------------
; Function AwaitEvent
; ---------------------------------
_AwaitEvent_start::
_AwaitEvent:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
;scheduling.c:182: Pause();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_Pause
;scheduling.c:183: CurrentTask->Value.RegisteredEvents|=EventClass;
;	genAssign
	ld	hl,(_CurrentTask)
;	genPlus
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,l
	add	a,#0x06
	ld	c,a
	ld	a,h
	adc	a,#0x00
	ld	b,a
;	genAssign
	ld	hl,(_CurrentTask)
;	genPlus
;	genPlusIncr
	ld	de,#0x0006
	add	hl,de
;	genPointerGet
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
;	genOr
;	AOP_STK for 
	ld	a,e
	or	a,4(ix)
	ld	e,a
	ld	a,d
	or	a,5(ix)
	ld	d,a
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,c
	ld	h,b
	ld	(hl),e
	inc	hl
	ld	(hl),d
;scheduling.c:184: Resume();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_Resume
;scheduling.c:185: Switch();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_Switch
;scheduling.c:186: return CurrentTask->Value.EventId;
;	genAssign
	ld	hl,(_CurrentTask)
;	genPlus
;	genPlusIncr
	ld	bc,#0x0008
	add	hl,bc
;	genPointerGet
	ld	c,(hl)
;	genRet
; Dump of IC_LEFT: type AOP_REG size 1
;	 reg = c
	ld	l,c
;	genLabel
00101$:
;	genEndFunction
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_AwaitEvent_end::
;scheduling.c:189: void Switch() {
;	genLabel
;	genFunction
;	---------------------------------
; Function Switch
; ---------------------------------
_Switch_start::
_Switch:
	ld	a,#3
	rst	0x08
;scheduling.c:195: IntsOff();
;	genInline
		di 
;scheduling.c:196: ExchangeRegs();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_ExchangeRegs
;scheduling.c:197: ControlRequests++;
;	genPlus
;	genPlusIncr
	ld	iy,#_ControlRequests
	inc	0(iy)
;scheduling.c:198: GetStackPointerASM(_OldSP);
;	genInline
		ld (_OldSP),sp 
;scheduling.c:199: SaveIndexes();
;	genInline
		ld hl,£0xEFFF ld sp,hl push ix push iy 
;scheduling.c:200: Scheduler(OldSP);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,(_OldSP)
	push	hl
;	genCall
	call	_Scheduler
	pop	af
;	genLabel
00101$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
_Switch_end::
;scheduling.c:203: void NewContext(int* SP) {
;	genLabel
;	genFunction
;	---------------------------------
; Function NewContext
; ---------------------------------
_NewContext_start::
_NewContext:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
;scheduling.c:205: SP; FunctionArgToReg(H, L);
;	genInline
		ld ix,£0 add ix,sp ld L,4(ix) ld H,5(ix) 
;scheduling.c:208: SetStackPointerASM(_OldSP);
;	genInline
		ld sp,(_OldSP) 
;scheduling.c:209: ExchangeRegs();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_ExchangeRegs
;scheduling.c:210: ReloadIndexes();
;	genInline
		ld ix,(0xEFFD) ld iy,(0xEFFB) 
;scheduling.c:212: SaveContext();
;	genInline
		push af push bc push de push hl push ix push iy 
;scheduling.c:215: ExchangeRegs();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_ExchangeRegs
;scheduling.c:216: GetStackPointerASM(_TempSP);
;	genInline
		ld (_TempSP),sp 
;scheduling.c:217: SetStackPointerREG(HL);
;	genInline
		ld sp,HL 
;scheduling.c:218: *CurrentSP=TempSP;
;	genAssign
	ld	bc,(_CurrentSP)
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,c
	ld	h,b
	ld	iy,#_TempSP
	ld	a,0(iy)
	ld	(hl),a
	inc	hl
	ld	a,1(iy)
	ld	(hl),a
;scheduling.c:220: ExchangeRegs();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_ExchangeRegs
;scheduling.c:222: LoadContext();
;	genInline
		pop iy pop ix pop hl pop de pop bc pop af 
;scheduling.c:224: if(ControlRequests==0) Halt("ISR IN USER MODE");
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	iy,#_ControlRequests
	ld	a,0(iy)
	or	a,a
	jp	z,00107$
00106$:
	jp	00102$
00107$:
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_7
	push	hl
;	genCall
	call	_Halt
	pop	af
;	genLabel
00102$:
;scheduling.c:225: ControlRequests--;
;	genMinus
	ld	iy,#_ControlRequests
	dec	0(iy)
;scheduling.c:226: IntsOn();
;	genInline
		im 1 ei 
;scheduling.c:227: ImmediateReturn();
;	genInline
		ret 
;	genLabel
00103$:
;	genEndFunction
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_NewContext_end::
Fscheduling$_str_7$0$0 == .
__str_7:
	.ascii "ISR IN USER MODE"
	.db 0x00
;scheduling.c:230: void ScheduleTask(task* Task) {
;	genLabel
;	genFunction
;	---------------------------------
; Function ScheduleTask
; ---------------------------------
_ScheduleTask_start::
_ScheduleTask:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
;scheduling.c:231: _SimPrintString("Context switch\n");
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#__str_8
	push	hl
;	genCall
	call	__Z80SimPrintString
	pop	af
;scheduling.c:232: NewContext(Task->SP);
;	genAssign
;	AOP_STK for 
	ld	l,4(ix)
	ld	h,5(ix)
;	genPlus
;	genPlusIncr
	ld	bc,#0x0004
	add	hl,bc
;	genPointerGet
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	push	hl
;	genCall
	call	_NewContext
	pop	af
;	genLabel
00101$:
;	genEndFunction
	pop	ix
	ld	a,#4
	rst	0x08
	ret
_ScheduleTask_end::
Fscheduling$_str_8$0$0 == .
__str_8:
	.ascii "Context switch"
	.db 0x0A
	.db 0x00
;scheduling.c:235: bool IsMultitasking() {
;	genLabel
;	genFunction
;	---------------------------------
; Function IsMultitasking
; ---------------------------------
_IsMultitasking_start::
_IsMultitasking:
	ld	a,#3
	rst	0x08
;scheduling.c:236: if(ControlRequests==0) return TRUE; else return FALSE;
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	iy,#_ControlRequests
	ld	a,0(iy)
	or	a,a
	jp	z,00108$
00107$:
	jp	00102$
00108$:
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x01
	jp	00104$
;	genLabel
00102$:
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 1
	ld	l,#0x00
;	genLabel
00104$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
_IsMultitasking_end::
	.area _CODE
