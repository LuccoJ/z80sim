                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.5 Fri Apr 27 12:30:18 2012
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module scheduling
                              7 	.optsdcc -mz80
                              8 	
                              9 ;--------------------------------------------------------
                             10 ; Public variables in this module
                             11 ;--------------------------------------------------------
                             12 	.globl _NewContext
                             13 	.globl _DoNothingScheduler
                             14 	.globl __InterruptService
                             15 	.globl _RegisterInterrupt
                             16 	.globl _SchedulingInited
                             17 	.globl _UserSP
                             18 	.globl _InterruptVectorCount
                             19 	.globl _InterruptVector
                             20 	.globl _ControlRequests
                             21 	.globl _ActiveScheduler
                             22 	.globl _TempSP
                             23 	.globl _OldSP
                             24 	.globl _CurrentSP
                             25 	.globl _SystemTasks
                             26 	.globl _CurrentTask
                             27 	.globl _SystemLock
                             28 	.globl _SchedulingInit
                             29 	.globl _SetScheduler
                             30 	.globl _Scheduler
                             31 	.globl _NullScheduler
                             32 	.globl _DefaultScheduler
                             33 	.globl _CreateTask
                             34 	.globl _SupervisorMode
                             35 	.globl _UserMode
                             36 	.globl _Pause
                             37 	.globl _Resume
                             38 	.globl _BroadcastEvent
                             39 	.globl _AwaitEvent
                             40 	.globl _Switch
                             41 	.globl _ScheduleTask
                             42 	.globl _IsMultitasking
                             43 ;--------------------------------------------------------
                             44 ;  ram data
                             45 ;--------------------------------------------------------
                             46 	.area _DATA
                    0000     47 G$SystemLock$0$0==.
   0000                      48 _SystemLock::
   0000                      49 	.ds 1
                    0001     50 G$CurrentTask$0$0==.
   0001                      51 _CurrentTask::
   0001                      52 	.ds 2
                    0003     53 G$SystemTasks$0$0==.
   0003                      54 _SystemTasks::
   0003                      55 	.ds 2
                    0005     56 G$CurrentSP$0$0==.
   0005                      57 _CurrentSP::
   0005                      58 	.ds 2
                    0007     59 G$OldSP$0$0==.
   0007                      60 _OldSP::
   0007                      61 	.ds 2
                    0009     62 G$TempSP$0$0==.
   0009                      63 _TempSP::
   0009                      64 	.ds 2
                    000B     65 G$ActiveScheduler$0$0==.
   000B                      66 _ActiveScheduler::
   000B                      67 	.ds 2
                    000D     68 G$ControlRequests$0$0==.
   000D                      69 _ControlRequests::
   000D                      70 	.ds 1
                    000E     71 G$InterruptVector$0$0==.
   000E                      72 _InterruptVector::
   000E                      73 	.ds 512
                    020E     74 G$InterruptVectorCount$0$0==.
   020E                      75 _InterruptVectorCount::
   020E                      76 	.ds 1
                    020F     77 G$UserSP$0$0==.
   020F                      78 _UserSP::
   020F                      79 	.ds 2
                    0211     80 G$SchedulingInited$0$0==.
   0211                      81 _SchedulingInited::
   0211                      82 	.ds 1
                             83 ;--------------------------------------------------------
                             84 ; overlayable items in  ram 
                             85 ;--------------------------------------------------------
                             86 	.area _OVERLAY
                             87 ;--------------------------------------------------------
                             88 ; external initialized ram data
                             89 ;--------------------------------------------------------
                             90 ;--------------------------------------------------------
                             91 ; global & static initialisations
                             92 ;--------------------------------------------------------
                             93 	.area _GSINIT
                             94 	.area _GSFINAL
                             95 	.area _GSINIT
                             96 ;--------------------------------------------------------
                             97 ; Home
                             98 ;--------------------------------------------------------
                             99 	.area _HOME
                            100 	.area _CODE
                            101 ;--------------------------------------------------------
                            102 ; code
                            103 ;--------------------------------------------------------
                            104 	.area _CODE
                            105 ;scheduling.c:34: void RegisterInterrupt(void (*InterruptFunction)()) {
                            106 ;	genLabel
                            107 ;	genFunction
                            108 ;	---------------------------------
                            109 ; Function RegisterInterrupt
                            110 ; ---------------------------------
   0000                     111 _RegisterInterrupt_start::
   0000                     112 _RegisterInterrupt:
   1824 3E 03               113 	ld	a,#3
   1826 CF                  114 	rst	0x08
   1827 DD E5               115 	push	ix
   1829 DD 21 00 00         116 	ld	ix,#0
   182D DD 39               117 	add	ix,sp
                            118 ;scheduling.c:35: InterruptVector[InterruptVectorCount++]=InterruptFunction;
                            119 ;	genAssign
   182F FD 21 21 83         120 	ld	iy,#_InterruptVectorCount
   1833 FD 4E 00            121 	ld	c,0(iy)
                            122 ;	genPlus
                            123 ;	genPlusIncr
   1836 FD 34 00            124 	inc	0(iy)
                            125 ;	genCast
   1839 69                  126 	ld	l,c
   183A 79                  127 	ld	a,c
   183B 17                  128 	rla	
   183C 9F                  129 	sbc	a,a
   183D 67                  130 	ld	h,a
                            131 ;	genLeftShift
                            132 ; Removed redundent load
                            133 ; Removed redundent load
   183E 29                  134 	add	hl,hl
                            135 ;	genPlus
                            136 ;	Can't optimise plus by inc, falling back to the normal way
   183F 3E 21               137 	ld	a,#<_InterruptVector
   1841 85                  138 	add	a,l
   1842 6F                  139 	ld	l,a
   1843 3E 81               140 	ld	a,#>_InterruptVector
   1845 8C                  141 	adc	a,h
   1846 67                  142 	ld	h,a
                            143 ;	genAssign (pointer)
                            144 ;	AOP_STK for 
                            145 ;	isBitvar = 0
   1847 DD 7E 04            146 	ld	a,4(ix)
   184A 77                  147 	ld	(hl),a
   184B 23                  148 	inc	hl
   184C DD 7E 05            149 	ld	a,5(ix)
   184F 77                  150 	ld	(hl),a
                            151 ;	genLabel
   002C                     152 00101$:
                            153 ;	genEndFunction
   1850 DD E1               154 	pop	ix
   1852 3E 04               155 	ld	a,#4
   1854 CF                  156 	rst	0x08
   1855 C9                  157 	ret
   0032                     158 _RegisterInterrupt_end::
                            159 ;scheduling.c:39: void _InterruptService() {
                            160 ;	genLabel
                            161 ;	genFunction
                            162 ;	---------------------------------
                            163 ; Function _InterruptService
                            164 ; ---------------------------------
   0032                     165 __InterruptService_start::
   0032                     166 __InterruptService:
   1856 3E 03               167 	ld	a,#3
   1858 CF                  168 	rst	0x08
                            169 ;scheduling.c:41: ExchangeRegs();
                            170 ;	genCall
                            171 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1859 CD F4 03            172 	call	_ExchangeRegs
                            173 ;scheduling.c:42: GetStackPointerASM(_UserSP);
                            174 ;	genInline
   185C ED 73 22 83         175 		ld (_UserSP),sp 
                            176 ;scheduling.c:43: SaveIndexes();
                            177 ;	genInline
   1860 21 FF EF F9 DD E5   178 		ld hl,£0xEFFF ld sp,hl push ix push iy 
        FD E5
                            179 ;scheduling.c:44: if(ControlRequests<0) Halt("NEGATIVE CONTROLREQUESTS");
                            180 ;	genCmpLt
   1868 FD 21 20 81         181 	ld	iy,#_ControlRequests
   186C FD 7E 00            182 	ld	a,0(iy)
   186F CB 7F               183 	bit	7,a
   1871 CA 7C 18            184 	jp	z,00102$
                            185 ;	genIpush
                            186 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1874 21 D7 18            187 	ld	hl,#__str_0
   1877 E5                  188 	push	hl
                            189 ;	genCall
   1878 CD 32 23            190 	call	_Halt
   187B F1                  191 	pop	af
                            192 ;	genLabel
   0058                     193 00102$:
                            194 ;scheduling.c:45: if(!IsMultitasking()) Halt("INTERRUPT IN KERNEL MODE");
                            195 ;	genCall
                            196 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   187C CD 3F 1E            197 	call	_IsMultitasking
                            198 ;	genIfx
   187F AF                  199 	xor	a,a
   1880 B5                  200 	or	a,l
   1881 C2 8C 18            201 	jp	nz,00104$
                            202 ;	genIpush
                            203 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1884 21 F0 18            204 	ld	hl,#__str_1
   1887 E5                  205 	push	hl
                            206 ;	genCall
   1888 CD 32 23            207 	call	_Halt
   188B F1                  208 	pop	af
                            209 ;	genLabel
   0068                     210 00104$:
                            211 ;scheduling.c:46: ControlRequests++;
                            212 ;	genPlus
                            213 ;	genPlusIncr
   188C FD 21 20 81         214 	ld	iy,#_ControlRequests
   1890 FD 34 00            215 	inc	0(iy)
                            216 ;scheduling.c:47: Tick();
                            217 ;	genCall
                            218 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1893 CD B6 24            219 	call	_Tick
                            220 ;scheduling.c:48: for(i=0; i<InterruptVectorCount; i++) {
                            221 ;	genAssign
   1896 0E 00               222 	ld	c,#0x00
                            223 ;	genLabel
   0074                     224 00105$:
                            225 ;	genCmpLt
   1898 79                  226 	ld	a,c
   1899 FD 21 21 83         227 	ld	iy,#_InterruptVectorCount
   189D FD 96 00            228 	sub	a,0(iy)
   18A0 F2 C3 18            229 	jp	p,00108$
                            230 ;scheduling.c:49: (InterruptVector[i])();
                            231 ;	genCast
   18A3 69                  232 	ld	l,c
   18A4 79                  233 	ld	a,c
   18A5 17                  234 	rla	
   18A6 9F                  235 	sbc	a,a
   18A7 67                  236 	ld	h,a
                            237 ;	genLeftShift
                            238 ; Removed redundent load
                            239 ; Removed redundent load
   18A8 29                  240 	add	hl,hl
                            241 ;	genPlus
                            242 ;	Can't optimise plus by inc, falling back to the normal way
   18A9 3E 21               243 	ld	a,#<_InterruptVector
   18AB 85                  244 	add	a,l
   18AC 6F                  245 	ld	l,a
   18AD 3E 81               246 	ld	a,#>_InterruptVector
   18AF 8C                  247 	adc	a,h
   18B0 67                  248 	ld	h,a
                            249 ;	genPointerGet
   18B1 5E                  250 	ld	e,(hl)
   18B2 23                  251 	inc	hl
   18B3 56                  252 	ld	d,(hl)
                            253 ;	genPcall
                            254 ; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
   18B4 C5                  255 	push	bc
   18B5 D5                  256 	push	de
   18B6 21 BD 18            257 	ld	hl,#00115$
   18B9 E5                  258 	push	hl
   18BA 6B                  259 	ld	l,e
   18BB 62                  260 	ld	h,d
   18BC E9                  261 	jp	(hl)
   0099                     262 00115$:
   18BD D1                  263 	pop	de
   18BE C1                  264 	pop	bc
                            265 ;scheduling.c:48: for(i=0; i<InterruptVectorCount; i++) {
                            266 ;	genPlus
                            267 ;	genPlusIncr
                            268 ; Removed redundent load
   18BF 0C                  269 	inc	c
                            270 ;	genGoto
   18C0 C3 98 18            271 	jp	00105$
                            272 ;	genLabel
   009F                     273 00108$:
                            274 ;scheduling.c:51: Scheduler(UserSP);
                            275 ;	genIpush
                            276 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   18C3 2A 22 83            277 	ld	hl,(_UserSP)
   18C6 E5                  278 	push	hl
                            279 ;	genCall
   18C7 CD 96 19            280 	call	_Scheduler
   18CA F1                  281 	pop	af
                            282 ;scheduling.c:52: Halt("OUT OF REACH");
                            283 ;	genIpush
                            284 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   18CB 21 09 19            285 	ld	hl,#__str_2
   18CE E5                  286 	push	hl
                            287 ;	genCall
   18CF CD 32 23            288 	call	_Halt
   18D2 F1                  289 	pop	af
                            290 ;	genLabel
   00AF                     291 00109$:
                            292 ;	genEndFunction
   18D3 3E 04               293 	ld	a,#4
   18D5 CF                  294 	rst	0x08
   18D6 C9                  295 	ret
   00B3                     296 __InterruptService_end::
                    00B3    297 Fscheduling$_str_0$0$0 == .
   00B3                     298 __str_0:
   18D7 4E 45 47 41 54 49   299 	.ascii "NEGATIVE CONTROLREQUESTS"
        56 45 20 43 4F 4E
        54 52 4F 4C 52 45
        51 55 45 53 54 53
   18EF 00                  300 	.db 0x00
                    00CC    301 Fscheduling$_str_1$0$0 == .
   00CC                     302 __str_1:
   18F0 49 4E 54 45 52 52   303 	.ascii "INTERRUPT IN KERNEL MODE"
        55 50 54 20 49 4E
        20 4B 45 52 4E 45
        4C 20 4D 4F 44 45
   1908 00                  304 	.db 0x00
                    00E5    305 Fscheduling$_str_2$0$0 == .
   00E5                     306 __str_2:
   1909 4F 55 54 20 4F 46   307 	.ascii "OUT OF REACH"
        20 52 45 41 43 48
   1915 00                  308 	.db 0x00
                            309 ;scheduling.c:55: bool SchedulingInited; void SchedulingInit() {
                            310 ;	genLabel
                            311 ;	genFunction
                            312 ;	---------------------------------
                            313 ; Function SchedulingInit
                            314 ; ---------------------------------
   00F2                     315 _SchedulingInit_start::
   00F2                     316 _SchedulingInit:
   1916 3E 03               317 	ld	a,#3
   1918 CF                  318 	rst	0x08
                            319 ;scheduling.c:56: if(!SchedulingInited) {
                            320 ;	genIfx
   1919 AF                  321 	xor	a,a
   191A FD 21 24 83         322 	ld	iy,#_SchedulingInited
   191E FD B6 00            323 	or	a,0(iy)
   1921 C2 71 19            324 	jp	nz,00103$
                            325 ;scheduling.c:57: MemoryInit();
                            326 ;	genCall
                            327 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1924 CD E2 15            328 	call	_MemoryInit
                            329 ;scheduling.c:58: TimeInit();
                            330 ;	genCall
                            331 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1927 CD 7B 24            332 	call	_TimeInit
                            333 ;scheduling.c:59: ControlRequests=1;
                            334 ;	genAssign
   192A FD 21 20 81         335 	ld	iy,#_ControlRequests
   192E FD 36 00 01         336 	ld	0(iy),#0x01
                            337 ;scheduling.c:60: CurrentTask=SystemTasks=NULL;
                            338 ;	genAssign
   1932 FD 21 16 81         339 	ld	iy,#_SystemTasks
   1936 FD 36 00 00         340 	ld	0(iy),#0x00
   193A FD 36 01 00         341 	ld	1(iy),#0x00
                            342 ;	genAssign
   193E FD 21 14 81         343 	ld	iy,#_CurrentTask
   1942 FD 36 00 00         344 	ld	0(iy),#0x00
   1946 FD 36 01 00         345 	ld	1(iy),#0x00
                            346 ;scheduling.c:61: ActiveScheduler=NullScheduler;
                            347 ;	genAssign
   194A FD 21 1E 81         348 	ld	iy,#_ActiveScheduler
   194E FD 36 00 E5         349 	ld	0(iy),#<_NullScheduler
   1952 FD 36 01 19         350 	ld	1(iy),#>_NullScheduler
                            351 ;scheduling.c:62: InterruptVectorCount=0;
                            352 ;	genAssign
   1956 FD 21 21 83         353 	ld	iy,#_InterruptVectorCount
   195A FD 36 00 00         354 	ld	0(iy),#0x00
                            355 ;scheduling.c:63: SystemLock=LockCreate();
                            356 ;	genCall
                            357 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   195E CD 36 17            358 	call	_LockCreate
   1961 4D                  359 	ld	c,l
                            360 ;	genAssign
   1962 FD 21 13 81         361 	ld	iy,#_SystemLock
   1966 FD 71 00            362 	ld	0(iy),c
                            363 ;scheduling.c:65: SchedulingInited=TRUE;
                            364 ;	genAssign
   1969 FD 21 24 83         365 	ld	iy,#_SchedulingInited
   196D FD 36 00 01         366 	ld	0(iy),#0x01
                            367 ;	genLabel
   014D                     368 00103$:
                            369 ;	genEndFunction
   1971 3E 04               370 	ld	a,#4
   1973 CF                  371 	rst	0x08
   1974 C9                  372 	ret
   0151                     373 _SchedulingInit_end::
                            374 ;scheduling.c:69: void SetScheduler(void (*SchedulerFunction)()) {
                            375 ;	genLabel
                            376 ;	genFunction
                            377 ;	---------------------------------
                            378 ; Function SetScheduler
                            379 ; ---------------------------------
   0151                     380 _SetScheduler_start::
   0151                     381 _SetScheduler:
   1975 3E 03               382 	ld	a,#3
   1977 CF                  383 	rst	0x08
   1978 DD E5               384 	push	ix
   197A DD 21 00 00         385 	ld	ix,#0
   197E DD 39               386 	add	ix,sp
                            387 ;scheduling.c:70: ActiveScheduler=SchedulerFunction;
                            388 ;	genAssign
                            389 ;	AOP_STK for 
   1980 DD 7E 04            390 	ld	a,4(ix)
   1983 FD 21 1E 81         391 	ld	iy,#_ActiveScheduler
   1987 FD 77 00            392 	ld	0(iy),a
   198A DD 7E 05            393 	ld	a,5(ix)
   198D FD 77 01            394 	ld	1(iy),a
                            395 ;	genLabel
   016C                     396 00101$:
                            397 ;	genEndFunction
   1990 DD E1               398 	pop	ix
   1992 3E 04               399 	ld	a,#4
   1994 CF                  400 	rst	0x08
   1995 C9                  401 	ret
   0172                     402 _SetScheduler_end::
                            403 ;scheduling.c:73: void Scheduler(void* SP) {
                            404 ;	genLabel
                            405 ;	genFunction
                            406 ;	---------------------------------
                            407 ; Function Scheduler
                            408 ; ---------------------------------
   0172                     409 _Scheduler_start::
   0172                     410 _Scheduler:
   1996 3E 03               411 	ld	a,#3
   1998 CF                  412 	rst	0x08
   1999 DD E5               413 	push	ix
   199B DD 21 00 00         414 	ld	ix,#0
   199F DD 39               415 	add	ix,sp
                            416 ;scheduling.c:74: OldSP=SP;
                            417 ;	genAssign
                            418 ;	AOP_STK for 
   19A1 DD 7E 04            419 	ld	a,4(ix)
   19A4 FD 21 1A 81         420 	ld	iy,#_OldSP
   19A8 FD 77 00            421 	ld	0(iy),a
   19AB DD 7E 05            422 	ld	a,5(ix)
   19AE FD 77 01            423 	ld	1(iy),a
                            424 ;scheduling.c:75: if(ControlRequests>10) Halt("TOO MANY REQUESTS");
                            425 ;	genCmpGt
   19B1 3E 0A               426 	ld	a,#0x0A
   19B3 FD 21 20 81         427 	ld	iy,#_ControlRequests
   19B7 FD 96 00            428 	sub	a,0(iy)
   19BA F2 C5 19            429 	jp	p,00102$
                            430 ;	genIpush
                            431 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   19BD 21 D3 19            432 	ld	hl,#__str_3
   19C0 E5                  433 	push	hl
                            434 ;	genCall
   19C1 CD 32 23            435 	call	_Halt
   19C4 F1                  436 	pop	af
                            437 ;	genLabel
   01A1                     438 00102$:
                            439 ;scheduling.c:76: ActiveScheduler();
                            440 ;	genPcall
                            441 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   19C5 21 CD 19            442 	ld	hl,#00106$
   19C8 E5                  443 	push	hl
   19C9 2A 1E 81            444 	ld	hl,(_ActiveScheduler)
   19CC E9                  445 	jp	(hl)
   01A9                     446 00106$:
                            447 ;	genLabel
   01A9                     448 00103$:
                            449 ;	genEndFunction
   19CD DD E1               450 	pop	ix
   19CF 3E 04               451 	ld	a,#4
   19D1 CF                  452 	rst	0x08
   19D2 C9                  453 	ret
   01AF                     454 _Scheduler_end::
                    01AF    455 Fscheduling$_str_3$0$0 == .
   01AF                     456 __str_3:
   19D3 54 4F 4F 20 4D 41   457 	.ascii "TOO MANY REQUESTS"
        4E 59 20 52 45 51
        55 45 53 54 53
   19E4 00                  458 	.db 0x00
                            459 ;scheduling.c:79: void NullScheduler() {
                            460 ;	genLabel
                            461 ;	genFunction
                            462 ;	---------------------------------
                            463 ; Function NullScheduler
                            464 ; ---------------------------------
   01C1                     465 _NullScheduler_start::
   01C1                     466 _NullScheduler:
   19E5 3E 03               467 	ld	a,#3
   19E7 CF                  468 	rst	0x08
                            469 ;scheduling.c:80: ControlRequests--;
                            470 ;	genMinus
   19E8 FD 21 20 81         471 	ld	iy,#_ControlRequests
   19EC FD 35 00            472 	dec	0(iy)
                            473 ;scheduling.c:81: SetStackPointerASM(_OldSP);
                            474 ;	genInline
   19EF ED 7B 1A 81         475 		ld sp,(_OldSP) 
                            476 ;scheduling.c:82: ExchangeRegs();
                            477 ;	genCall
                            478 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   19F3 CD F4 03            479 	call	_ExchangeRegs
                            480 ;scheduling.c:83: ReloadIndexes();
                            481 ;	genInline
   19F6 DD 2A FD EF FD 2A   482 		ld ix,(0xEFFD) ld iy,(0xEFFB) 
        FB EF
                            483 ;scheduling.c:84: IntsOn();
                            484 ;	genInline
   19FE ED 56 FB            485 		im 1 ei 
                            486 ;	genLabel
   01DD                     487 00101$:
                            488 ;	genEndFunction
   1A01 3E 04               489 	ld	a,#4
   1A03 CF                  490 	rst	0x08
   1A04 C9                  491 	ret
   01E1                     492 _NullScheduler_end::
                            493 ;scheduling.c:87: void DoNothingScheduler() {
                            494 ;	genLabel
                            495 ;	genFunction
                            496 ;	---------------------------------
                            497 ; Function DoNothingScheduler
                            498 ; ---------------------------------
   01E1                     499 _DoNothingScheduler_start::
   01E1                     500 _DoNothingScheduler:
   1A05 3E 03               501 	ld	a,#3
   1A07 CF                  502 	rst	0x08
                            503 ;scheduling.c:88: }
                            504 ;	genLabel
   01E4                     505 00101$:
                            506 ;	genEndFunction
   1A08 3E 04               507 	ld	a,#4
   1A0A CF                  508 	rst	0x08
   1A0B C9                  509 	ret
   01E8                     510 _DoNothingScheduler_end::
                            511 ;scheduling.c:90: void DefaultScheduler() {
                            512 ;	genLabel
                            513 ;	genFunction
                            514 ;	---------------------------------
                            515 ; Function DefaultScheduler
                            516 ; ---------------------------------
   01E8                     517 _DefaultScheduler_start::
   01E8                     518 _DefaultScheduler:
   1A0C 3E 03               519 	ld	a,#3
   1A0E CF                  520 	rst	0x08
                            521 ;scheduling.c:91: if(LockQuery(SystemLock)) {
                            522 ;	genIpush
                            523 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1A0F 3A 13 81            524 	ld	a,(_SystemLock)
   1A12 F5                  525 	push	af
   1A13 33                  526 	inc	sp
                            527 ;	genCall
   1A14 CD FD 17            528 	call	_LockQuery
   1A17 33                  529 	inc	sp
                            530 ;	genIfx
   1A18 AF                  531 	xor	a,a
   1A19 B5                  532 	or	a,l
   1A1A CA 2B 1A            533 	jp	z,00102$
                            534 ;scheduling.c:92: Halt("SYSTEM LOCKED SCH");
                            535 ;	genIpush
                            536 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1A1D 21 CD 1A            537 	ld	hl,#__str_4
   1A20 E5                  538 	push	hl
                            539 ;	genCall
   1A21 CD 32 23            540 	call	_Halt
   1A24 F1                  541 	pop	af
                            542 ;scheduling.c:93: NullScheduler();
                            543 ;	genCall
                            544 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1A25 CD E5 19            545 	call	_NullScheduler
                            546 ;scheduling.c:94: return;
                            547 ;	genRet
   1A28 C3 C9 1A            548 	jp	00114$
                            549 ;	genLabel
   0207                     550 00102$:
                            551 ;scheduling.c:96: if(SystemTasks==NULL) Break("SCHEDULING NO TASK");
                            552 ;	genCmpEq
                            553 ; genCmpEq: left 2, right 2, result 0
   1A2B FD 21 16 81         554 	ld	iy,#_SystemTasks
   1A2F FD 7E 00            555 	ld	a,0(iy)
   1A32 FD B6 01            556 	or	a,1(iy)
   1A35 CA 3B 1A            557 	jp	z,00123$
   0214                     558 00122$:
   1A38 C3 43 1A            559 	jp	00104$
   0217                     560 00123$:
                            561 ;	genIpush
                            562 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1A3B 21 DF 1A            563 	ld	hl,#__str_5
   1A3E E5                  564 	push	hl
                            565 ;	genCall
   1A3F CD 53 23            566 	call	_Break
   1A42 F1                  567 	pop	af
                            568 ;	genLabel
   021F                     569 00104$:
                            570 ;scheduling.c:97: if(CurrentTask==NULL) {
                            571 ;	genCmpEq
                            572 ; genCmpEq: left 2, right 2, result 0
   1A43 FD 21 14 81         573 	ld	iy,#_CurrentTask
   1A47 FD 7E 00            574 	ld	a,0(iy)
   1A4A FD B6 01            575 	or	a,1(iy)
   1A4D CA 53 1A            576 	jp	z,00125$
   022C                     577 00124$:
   1A50 C3 63 1A            578 	jp	00106$
   022F                     579 00125$:
                            580 ;scheduling.c:98: CurrentTask=SystemTasks;
                            581 ;	genAssign
   1A53 2A 16 81            582 	ld	hl,(_SystemTasks)
   1A56 FD 21 14 81         583 	ld	iy,#_CurrentTask
   1A5A FD 75 00            584 	ld	0(iy),l
   1A5D FD 74 01            585 	ld	1(iy),h
                            586 ;	genGoto
   1A60 C3 73 1A            587 	jp	00111$
                            588 ;	genLabel
   023F                     589 00106$:
                            590 ;scheduling.c:100: CurrentSP=&(CurrentTask->Value.SP);
                            591 ;	genAssign
   1A63 ED 4B 14 81         592 	ld	bc,(_CurrentTask)
                            593 ;	genPlus
                            594 ;	genPlusIncr
                            595 ;	Can't optimise plus by inc, falling back to the normal way
                            596 ;	Shift into pair idx 0
   1A67 21 18 81            597 	ld	hl,#_CurrentSP
   1A6A 79                  598 	ld	a,c
   1A6B C6 04               599 	add	a,#0x04
   1A6D 77                  600 	ld	(hl),a
   1A6E 78                  601 	ld	a,b
   1A6F CE 00               602 	adc	a,#0x00
   1A71 23                  603 	inc	hl
   1A72 77                  604 	ld	(hl),a
                            605 ;scheduling.c:104: do {
                            606 ;	genLabel
   024F                     607 00111$:
                            608 ;scheduling.c:105: if(CurrentTask->Next==NULL) {
                            609 ;	genAssign
   1A73 2A 14 81            610 	ld	hl,(_CurrentTask)
                            611 ;	genPlus
                            612 ;	genPlusIncr
   1A76 01 09 00            613 	ld	bc,#0x0009
   1A79 09                  614 	add	hl,bc
                            615 ;	genPointerGet
   1A7A 7E                  616 	ld	a,(hl)
   1A7B 23                  617 	inc	hl
   1A7C 66                  618 	ld	h,(hl)
                            619 ;	genCmpEq
                            620 ; genCmpEq: left 2, right 2, result 0
   1A7D 6F                  621 	ld	l,a
   1A7E B4                  622 	or	a,h
   1A7F CA 85 1A            623 	jp	z,00127$
   025E                     624 00126$:
   1A82 C3 95 1A            625 	jp	00109$
   0261                     626 00127$:
                            627 ;scheduling.c:106: CurrentTask=SystemTasks;
                            628 ;	genAssign
   1A85 2A 16 81            629 	ld	hl,(_SystemTasks)
   1A88 FD 21 14 81         630 	ld	iy,#_CurrentTask
   1A8C FD 75 00            631 	ld	0(iy),l
   1A8F FD 74 01            632 	ld	1(iy),h
                            633 ;	genGoto
   1A92 C3 AF 1A            634 	jp	00112$
                            635 ;	genLabel
   0271                     636 00109$:
                            637 ;scheduling.c:108: CurrentTask=CurrentTask->Next;
                            638 ;	genAssign
   1A95 2A 14 81            639 	ld	hl,(_CurrentTask)
                            640 ;	genPlus
                            641 ;	genPlusIncr
                            642 ;	Can't optimise plus by inc, falling back to the normal way
   1A98 7D                  643 	ld	a,l
   1A99 C6 09               644 	add	a,#0x09
   1A9B 4F                  645 	ld	c,a
   1A9C 7C                  646 	ld	a,h
   1A9D CE 00               647 	adc	a,#0x00
   1A9F 47                  648 	ld	b,a
                            649 ;	genPointerGet
   1AA0 69                  650 	ld	l,c
   1AA1 60                  651 	ld	h,b
   1AA2 7E                  652 	ld	a,(hl)
   1AA3 FD 21 14 81         653 	ld	iy,#_CurrentTask
   1AA7 FD 77 00            654 	ld	0(iy),a
   1AAA 23                  655 	inc	hl
   1AAB 7E                  656 	ld	a,(hl)
   1AAC FD 77 01            657 	ld	1(iy),a
                            658 ;	genLabel
   028B                     659 00112$:
                            660 ;scheduling.c:110: } while(CurrentTask->Value.RegisteredEvents!=EVENT_RUNTASK);
                            661 ;	genAssign
   1AAF 2A 14 81            662 	ld	hl,(_CurrentTask)
                            663 ;	genPlus
                            664 ;	genPlusIncr
   1AB2 01 06 00            665 	ld	bc,#0x0006
   1AB5 09                  666 	add	hl,bc
                            667 ;	genPointerGet
   1AB6 7E                  668 	ld	a,(hl)
   1AB7 23                  669 	inc	hl
   1AB8 66                  670 	ld	h,(hl)
                            671 ;	genCmpEq
                            672 ; genCmpEq: left 2, right 2, result 0
   1AB9 6F                  673 	ld	l,a
   1ABA B4                  674 	or	a,h
   1ABB CA C1 1A            675 	jp	z,00129$
   029A                     676 00128$:
   1ABE C3 73 1A            677 	jp	00111$
   029D                     678 00129$:
                            679 ;scheduling.c:111: ScheduleTask(&(CurrentTask->Value));
                            680 ;	genAssign
   1AC1 2A 14 81            681 	ld	hl,(_CurrentTask)
                            682 ;	genIpush
                            683 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1AC4 E5                  684 	push	hl
                            685 ;	genCall
   1AC5 CD 03 1E            686 	call	_ScheduleTask
   1AC8 F1                  687 	pop	af
                            688 ;	genLabel
   02A5                     689 00114$:
                            690 ;	genEndFunction
   1AC9 3E 04               691 	ld	a,#4
   1ACB CF                  692 	rst	0x08
   1ACC C9                  693 	ret
   02A9                     694 _DefaultScheduler_end::
                    02A9    695 Fscheduling$_str_4$0$0 == .
   02A9                     696 __str_4:
   1ACD 53 59 53 54 45 4D   697 	.ascii "SYSTEM LOCKED SCH"
        20 4C 4F 43 4B 45
        44 20 53 43 48
   1ADE 00                  698 	.db 0x00
                    02BB    699 Fscheduling$_str_5$0$0 == .
   02BB                     700 __str_5:
   1ADF 53 43 48 45 44 55   701 	.ascii "SCHEDULING NO TASK"
        4C 49 4E 47 20 4E
        4F 20 54 41 53 4B
   1AF1 00                  702 	.db 0x00
                            703 ;scheduling.c:114: task* CreateTask(void* EntryPoint, unsigned int AssignedStack) {
                            704 ;	genLabel
                            705 ;	genFunction
                            706 ;	---------------------------------
                            707 ; Function CreateTask
                            708 ; ---------------------------------
   02CE                     709 _CreateTask_start::
   02CE                     710 _CreateTask:
   1AF2 3E 03               711 	ld	a,#3
   1AF4 CF                  712 	rst	0x08
   1AF5 DD E5               713 	push	ix
   1AF7 DD 21 00 00         714 	ld	ix,#0
   1AFB DD 39               715 	add	ix,sp
   1AFD 21 FE FF            716 	ld	hl,#-2
   1B00 39                  717 	add	hl,sp
   1B01 F9                  718 	ld	sp,hl
                            719 ;scheduling.c:118: NewTask=MemoryAllocate(sizeof(taskElement), memHEAP);
                            720 ;	genIpush
                            721 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1B02 3E 01               722 	ld	a,#0x01
   1B04 F5                  723 	push	af
   1B05 33                  724 	inc	sp
                            725 ;	genIpush
   1B06 21 0B 00            726 	ld	hl,#0x000B
   1B09 E5                  727 	push	hl
                            728 ;	genCall
   1B0A CD 7A 16            729 	call	_MemoryAllocate
   1B0D F1                  730 	pop	af
   1B0E 33                  731 	inc	sp
                            732 ;	genAssign
                            733 ;	genAssign
                            734 ;	AOP_STK for _CreateTask_NewTask_1_1
   1B0F DD 75 FE            735 	ld	-2(ix),l
   1B12 DD 74 FF            736 	ld	-1(ix),h
                            737 ;scheduling.c:119: NewTask->Next=SystemTasks;
                            738 ;	genPlus
                            739 ;	AOP_STK for _CreateTask_NewTask_1_1
                            740 ;	genPlusIncr
                            741 ;	Can't optimise plus by inc, falling back to the normal way
   1B15 DD 7E FE            742 	ld	a,-2(ix)
   1B18 C6 09               743 	add	a,#0x09
   1B1A 5F                  744 	ld	e,a
   1B1B DD 7E FF            745 	ld	a,-1(ix)
   1B1E CE 00               746 	adc	a,#0x00
   1B20 57                  747 	ld	d,a
                            748 ;	genAssign (pointer)
                            749 ;	isBitvar = 0
   1B21 6B                  750 	ld	l,e
   1B22 62                  751 	ld	h,d
   1B23 FD 21 16 81         752 	ld	iy,#_SystemTasks
   1B27 FD 7E 00            753 	ld	a,0(iy)
   1B2A 77                  754 	ld	(hl),a
   1B2B 23                  755 	inc	hl
   1B2C FD 7E 01            756 	ld	a,1(iy)
   1B2F 77                  757 	ld	(hl),a
                            758 ;scheduling.c:120: SystemTasks=NewTask;
                            759 ;	genAssign
                            760 ;	AOP_STK for _CreateTask_NewTask_1_1
   1B30 DD 7E FE            761 	ld	a,-2(ix)
   1B33 FD 77 00            762 	ld	0(iy),a
   1B36 DD 7E FF            763 	ld	a,-1(ix)
   1B39 FD 77 01            764 	ld	1(iy),a
                            765 ;scheduling.c:123: TaskInfo->StackFrameTop=MemoryAllocate(AssignedStack, memSTACK);
                            766 ;	genIpush
                            767 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1B3C 3E 00               768 	ld	a,#0x00
   1B3E F5                  769 	push	af
   1B3F 33                  770 	inc	sp
                            771 ;	genIpush
                            772 ;	AOP_STK for 
   1B40 DD 6E 06            773 	ld	l,6(ix)
   1B43 DD 66 07            774 	ld	h,7(ix)
   1B46 E5                  775 	push	hl
                            776 ;	genCall
   1B47 CD 7A 16            777 	call	_MemoryAllocate
   1B4A 54                  778 	ld	d,h
   1B4B 5D                  779 	ld	e,l
   1B4C F1                  780 	pop	af
   1B4D 33                  781 	inc	sp
                            782 ;	genAssign (pointer)
                            783 ;	AOP_STK for _CreateTask_NewTask_1_1
                            784 ;	isBitvar = 0
   1B4E DD 6E FE            785 	ld	l,-2(ix)
   1B51 DD 66 FF            786 	ld	h,-1(ix)
   1B54 73                  787 	ld	(hl),e
   1B55 23                  788 	inc	hl
   1B56 72                  789 	ld	(hl),d
                            790 ;scheduling.c:124: TaskInfo->StackFrameBottom=(void*)((unsigned int)TaskInfo->StackFrameTop-AssignedStack);
                            791 ;	genPlus
                            792 ;	AOP_STK for _CreateTask_NewTask_1_1
                            793 ;	genPlusIncr
   1B57 DD 6E FE            794 	ld	l,-2(ix)
   1B5A DD 66 FF            795 	ld	h,-1(ix)
   1B5D 23                  796 	inc	hl
   1B5E 23                  797 	inc	hl
                            798 ;	genCast
   1B5F 4B                  799 	ld	c,e
   1B60 42                  800 	ld	b,d
                            801 ;	genMinus
                            802 ;	AOP_STK for 
   1B61 79                  803 	ld	a,c
   1B62 DD 96 06            804 	sub	a,6(ix)
   1B65 4F                  805 	ld	c,a
   1B66 78                  806 	ld	a,b
   1B67 DD 9E 07            807 	sbc	a,7(ix)
   1B6A 47                  808 	ld	b,a
                            809 ;	genCast
                            810 ;	genAssign (pointer)
                            811 ;	isBitvar = 0
   1B6B 71                  812 	ld	(hl),c
   1B6C 23                  813 	inc	hl
   1B6D 70                  814 	ld	(hl),b
                            815 ;scheduling.c:125: TaskInfo->SP=TaskInfo->StackFrameTop;
                            816 ;	genPlus
                            817 ;	AOP_STK for _CreateTask_NewTask_1_1
                            818 ;	genPlusIncr
                            819 ;	Can't optimise plus by inc, falling back to the normal way
   1B6E DD 7E FE            820 	ld	a,-2(ix)
   1B71 C6 04               821 	add	a,#0x04
   1B73 4F                  822 	ld	c,a
   1B74 DD 7E FF            823 	ld	a,-1(ix)
   1B77 CE 00               824 	adc	a,#0x00
   1B79 47                  825 	ld	b,a
                            826 ;	genAssign (pointer)
                            827 ;	isBitvar = 0
   1B7A 69                  828 	ld	l,c
   1B7B 60                  829 	ld	h,b
   1B7C 73                  830 	ld	(hl),e
   1B7D 23                  831 	inc	hl
   1B7E 72                  832 	ld	(hl),d
                            833 ;scheduling.c:126: TaskInfo->SP--; *(void**)(TaskInfo->SP)=EntryPoint;
                            834 ;	genMinus
   1B7F 1B                  835 	dec	de
   1B80 1B                  836 	dec	de
                            837 ;	genAssign (pointer)
                            838 ;	isBitvar = 0
   1B81 69                  839 	ld	l,c
   1B82 60                  840 	ld	h,b
   1B83 73                  841 	ld	(hl),e
   1B84 23                  842 	inc	hl
   1B85 72                  843 	ld	(hl),d
                            844 ;	genAssign (pointer)
                            845 ;	AOP_STK for 
                            846 ;	isBitvar = 0
   1B86 6B                  847 	ld	l,e
   1B87 62                  848 	ld	h,d
   1B88 DD 7E 04            849 	ld	a,4(ix)
   1B8B 77                  850 	ld	(hl),a
   1B8C 23                  851 	inc	hl
   1B8D DD 7E 05            852 	ld	a,5(ix)
   1B90 77                  853 	ld	(hl),a
                            854 ;scheduling.c:127: TaskInfo->SP--; *TaskInfo->SP=0; // AF
                            855 ;	genMinus
   1B91 1B                  856 	dec	de
   1B92 1B                  857 	dec	de
                            858 ;	genAssign (pointer)
                            859 ;	isBitvar = 0
   1B93 69                  860 	ld	l,c
   1B94 60                  861 	ld	h,b
   1B95 73                  862 	ld	(hl),e
   1B96 23                  863 	inc	hl
   1B97 72                  864 	ld	(hl),d
                            865 ;	genAssign (pointer)
                            866 ;	isBitvar = 0
   1B98 6B                  867 	ld	l,e
   1B99 62                  868 	ld	h,d
   1B9A 36 00               869 	ld	(hl),#0x00
   1B9C 23                  870 	inc	hl
   1B9D 36 00               871 	ld	(hl),#0x00
                            872 ;scheduling.c:128: TaskInfo->SP--; *TaskInfo->SP=0; // BC
                            873 ;	genMinus
   1B9F 1B                  874 	dec	de
   1BA0 1B                  875 	dec	de
                            876 ;	genAssign (pointer)
                            877 ;	isBitvar = 0
   1BA1 69                  878 	ld	l,c
   1BA2 60                  879 	ld	h,b
   1BA3 73                  880 	ld	(hl),e
   1BA4 23                  881 	inc	hl
   1BA5 72                  882 	ld	(hl),d
                            883 ;	genAssign (pointer)
                            884 ;	isBitvar = 0
   1BA6 6B                  885 	ld	l,e
   1BA7 62                  886 	ld	h,d
   1BA8 36 00               887 	ld	(hl),#0x00
   1BAA 23                  888 	inc	hl
   1BAB 36 00               889 	ld	(hl),#0x00
                            890 ;scheduling.c:129: TaskInfo->SP--; *TaskInfo->SP=0; // DE
                            891 ;	genMinus
   1BAD 1B                  892 	dec	de
   1BAE 1B                  893 	dec	de
                            894 ;	genAssign (pointer)
                            895 ;	isBitvar = 0
   1BAF 69                  896 	ld	l,c
   1BB0 60                  897 	ld	h,b
   1BB1 73                  898 	ld	(hl),e
   1BB2 23                  899 	inc	hl
   1BB3 72                  900 	ld	(hl),d
                            901 ;	genAssign (pointer)
                            902 ;	isBitvar = 0
   1BB4 6B                  903 	ld	l,e
   1BB5 62                  904 	ld	h,d
   1BB6 36 00               905 	ld	(hl),#0x00
   1BB8 23                  906 	inc	hl
   1BB9 36 00               907 	ld	(hl),#0x00
                            908 ;scheduling.c:130: TaskInfo->SP--; *TaskInfo->SP=0; // HL
                            909 ;	genMinus
   1BBB 1B                  910 	dec	de
   1BBC 1B                  911 	dec	de
                            912 ;	genAssign (pointer)
                            913 ;	isBitvar = 0
   1BBD 69                  914 	ld	l,c
   1BBE 60                  915 	ld	h,b
   1BBF 73                  916 	ld	(hl),e
   1BC0 23                  917 	inc	hl
   1BC1 72                  918 	ld	(hl),d
                            919 ;	genAssign (pointer)
                            920 ;	isBitvar = 0
   1BC2 6B                  921 	ld	l,e
   1BC3 62                  922 	ld	h,d
   1BC4 36 00               923 	ld	(hl),#0x00
   1BC6 23                  924 	inc	hl
   1BC7 36 00               925 	ld	(hl),#0x00
                            926 ;scheduling.c:131: TaskInfo->SP--; *TaskInfo->SP=0; // IX
                            927 ;	genMinus
   1BC9 1B                  928 	dec	de
   1BCA 1B                  929 	dec	de
                            930 ;	genAssign (pointer)
                            931 ;	isBitvar = 0
   1BCB 69                  932 	ld	l,c
   1BCC 60                  933 	ld	h,b
   1BCD 73                  934 	ld	(hl),e
   1BCE 23                  935 	inc	hl
   1BCF 72                  936 	ld	(hl),d
                            937 ;	genAssign (pointer)
                            938 ;	isBitvar = 0
   1BD0 6B                  939 	ld	l,e
   1BD1 62                  940 	ld	h,d
   1BD2 36 00               941 	ld	(hl),#0x00
   1BD4 23                  942 	inc	hl
   1BD5 36 00               943 	ld	(hl),#0x00
                            944 ;scheduling.c:132: TaskInfo->SP--; *TaskInfo->SP=0; // IY
                            945 ;	genMinus
   1BD7 1B                  946 	dec	de
   1BD8 1B                  947 	dec	de
                            948 ;	genAssign (pointer)
                            949 ;	isBitvar = 0
   1BD9 69                  950 	ld	l,c
   1BDA 60                  951 	ld	h,b
   1BDB 73                  952 	ld	(hl),e
   1BDC 23                  953 	inc	hl
   1BDD 72                  954 	ld	(hl),d
                            955 ;	genAssign (pointer)
                            956 ;	isBitvar = 0
   1BDE 6B                  957 	ld	l,e
   1BDF 62                  958 	ld	h,d
   1BE0 36 00               959 	ld	(hl),#0x00
   1BE2 23                  960 	inc	hl
   1BE3 36 00               961 	ld	(hl),#0x00
                            962 ;scheduling.c:133: TaskInfo->RegisteredEvents=EVENT_RUNTASK;
                            963 ;	genPlus
                            964 ;	AOP_STK for _CreateTask_NewTask_1_1
                            965 ;	genPlusIncr
                            966 ;	Can't optimise plus by inc, falling back to the normal way
   1BE5 DD 7E FE            967 	ld	a,-2(ix)
   1BE8 C6 06               968 	add	a,#0x06
   1BEA 6F                  969 	ld	l,a
   1BEB DD 7E FF            970 	ld	a,-1(ix)
   1BEE CE 00               971 	adc	a,#0x00
   1BF0 67                  972 	ld	h,a
                            973 ;	genAssign (pointer)
                            974 ;	isBitvar = 0
   1BF1 36 00               975 	ld	(hl),#0x00
   1BF3 23                  976 	inc	hl
   1BF4 36 00               977 	ld	(hl),#0x00
                            978 ;scheduling.c:134: TaskInfo->EventId=0;
                            979 ;	genPlus
                            980 ;	AOP_STK for _CreateTask_NewTask_1_1
                            981 ;	genPlusIncr
                            982 ;	Can't optimise plus by inc, falling back to the normal way
   1BF6 DD 7E FE            983 	ld	a,-2(ix)
   1BF9 C6 08               984 	add	a,#0x08
   1BFB 6F                  985 	ld	l,a
   1BFC DD 7E FF            986 	ld	a,-1(ix)
   1BFF CE 00               987 	adc	a,#0x00
   1C01 67                  988 	ld	h,a
                            989 ;	genAssign (pointer)
                            990 ;	isBitvar = 0
   1C02 36 00               991 	ld	(hl),#0x00
                            992 ;scheduling.c:135: return TaskInfo;
                            993 ;	genRet
                            994 ;	AOP_STK for _CreateTask_NewTask_1_1
                            995 ; Dump of IC_LEFT: type AOP_STK size 2
                            996 ;	 aop_stk -2
   1C04 DD 6E FE            997 	ld	l,-2(ix)
   1C07 DD 66 FF            998 	ld	h,-1(ix)
                            999 ;	genLabel
   03E6                    1000 00101$:
                           1001 ;	genEndFunction
   1C0A DD F9              1002 	ld	sp,ix
   1C0C DD E1              1003 	pop	ix
   1C0E 3E 04              1004 	ld	a,#4
   1C10 CF                 1005 	rst	0x08
   1C11 C9                 1006 	ret
   03EE                    1007 _CreateTask_end::
                           1008 ;scheduling.c:138: void SupervisorMode() {
                           1009 ;	genLabel
                           1010 ;	genFunction
                           1011 ;	---------------------------------
                           1012 ; Function SupervisorMode
                           1013 ; ---------------------------------
   03EE                    1014 _SupervisorMode_start::
   03EE                    1015 _SupervisorMode:
   1C12 3E 03              1016 	ld	a,#3
   1C14 CF                 1017 	rst	0x08
                           1018 ;scheduling.c:139: IntsOff();
                           1019 ;	genInline
   1C15 F3                 1020 		di 
                           1021 ;scheduling.c:140: ExchangeRegs();
                           1022 ;	genCall
                           1023 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1C16 CD F4 03           1024 	call	_ExchangeRegs
                           1025 ;	genLabel
   03F5                    1026 00101$:
                           1027 ;	genEndFunction
   1C19 3E 04              1028 	ld	a,#4
   1C1B CF                 1029 	rst	0x08
   1C1C C9                 1030 	ret
   03F9                    1031 _SupervisorMode_end::
                           1032 ;scheduling.c:143: void UserMode() {
                           1033 ;	genLabel
                           1034 ;	genFunction
                           1035 ;	---------------------------------
                           1036 ; Function UserMode
                           1037 ; ---------------------------------
   03F9                    1038 _UserMode_start::
   03F9                    1039 _UserMode:
   1C1D 3E 03              1040 	ld	a,#3
   1C1F CF                 1041 	rst	0x08
                           1042 ;scheduling.c:144: ExchangeRegs();
                           1043 ;	genCall
                           1044 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1C20 CD F4 03           1045 	call	_ExchangeRegs
                           1046 ;scheduling.c:145: IntsOn();
                           1047 ;	genInline
   1C23 ED 56 FB           1048 		im 1 ei 
                           1049 ;	genLabel
   0402                    1050 00101$:
                           1051 ;	genEndFunction
   1C26 3E 04              1052 	ld	a,#4
   1C28 CF                 1053 	rst	0x08
   1C29 C9                 1054 	ret
   0406                    1055 _UserMode_end::
                           1056 ;scheduling.c:148: void Pause() {
                           1057 ;	genLabel
                           1058 ;	genFunction
                           1059 ;	---------------------------------
                           1060 ; Function Pause
                           1061 ; ---------------------------------
   0406                    1062 _Pause_start::
   0406                    1063 _Pause:
   1C2A 3E 03              1064 	ld	a,#3
   1C2C CF                 1065 	rst	0x08
                           1066 ;scheduling.c:149: IntsOff();
                           1067 ;	genInline
   1C2D F3                 1068 		di 
                           1069 ;scheduling.c:150: ControlRequests++;
                           1070 ;	genPlus
                           1071 ;	genPlusIncr
   1C2E FD 21 20 81        1072 	ld	iy,#_ControlRequests
   1C32 FD 34 00           1073 	inc	0(iy)
                           1074 ;scheduling.c:151: if(ControlRequests==1) ExchangeRegs();
                           1075 ;	genCmpEq
                           1076 ; genCmpEq: left 1, right 1, result 0
   1C35 FD 7E 00           1077 	ld	a,0(iy)
   1C38 FE 01              1078 	cp	a,#0x01
   1C3A CA 40 1C           1079 	jp	z,00107$
   0419                    1080 00106$:
   1C3D C3 43 1C           1081 	jp	00103$
   041C                    1082 00107$:
                           1083 ;	genCall
                           1084 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1C40 CD F4 03           1085 	call	_ExchangeRegs
                           1086 ;	genLabel
   041F                    1087 00103$:
                           1088 ;	genEndFunction
   1C43 3E 04              1089 	ld	a,#4
   1C45 CF                 1090 	rst	0x08
   1C46 C9                 1091 	ret
   0423                    1092 _Pause_end::
                           1093 ;scheduling.c:154: void Resume() {
                           1094 ;	genLabel
                           1095 ;	genFunction
                           1096 ;	---------------------------------
                           1097 ; Function Resume
                           1098 ; ---------------------------------
   0423                    1099 _Resume_start::
   0423                    1100 _Resume:
   1C47 3E 03              1101 	ld	a,#3
   1C49 CF                 1102 	rst	0x08
                           1103 ;scheduling.c:155: if(ControlRequests>0) {
                           1104 ;	genCmpGt
   1C4A 3E 00              1105 	ld	a,#0x00
   1C4C FD 21 20 81        1106 	ld	iy,#_ControlRequests
   1C50 FD 96 00           1107 	sub	a,0(iy)
   1C53 F2 69 1C           1108 	jp	p,00104$
                           1109 ;scheduling.c:156: ControlRequests--;
                           1110 ;	genMinus
   1C56 FD 35 00           1111 	dec	0(iy)
                           1112 ;scheduling.c:157: if(ControlRequests==0) {
                           1113 ;	genCmpEq
                           1114 ; genCmpEq: left 1, right 1, result 0
   1C59 FD 7E 00           1115 	ld	a,0(iy)
   1C5C B7                 1116 	or	a,a
   1C5D CA 63 1C           1117 	jp	z,00111$
   043C                    1118 00110$:
   1C60 C3 71 1C           1119 	jp	00106$
   043F                    1120 00111$:
                           1121 ;scheduling.c:158: UserMode();
                           1122 ;	genCall
                           1123 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1C63 CD 1D 1C           1124 	call	_UserMode
                           1125 ;	genGoto
   1C66 C3 71 1C           1126 	jp	00106$
                           1127 ;	genLabel
   0445                    1128 00104$:
                           1129 ;scheduling.c:161: Halt("RESUME WITHOUT PAUSE");
                           1130 ;	genIpush
                           1131 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1C69 21 75 1C           1132 	ld	hl,#__str_6
   1C6C E5                 1133 	push	hl
                           1134 ;	genCall
   1C6D CD 32 23           1135 	call	_Halt
   1C70 F1                 1136 	pop	af
                           1137 ;	genLabel
   044D                    1138 00106$:
                           1139 ;	genEndFunction
   1C71 3E 04              1140 	ld	a,#4
   1C73 CF                 1141 	rst	0x08
   1C74 C9                 1142 	ret
   0451                    1143 _Resume_end::
                    0451   1144 Fscheduling$_str_6$0$0 == .
   0451                    1145 __str_6:
   1C75 52 45 53 55 4D 45  1146 	.ascii "RESUME WITHOUT PAUSE"
        20 57 49 54 48 4F
        55 54 20 50 41 55
        53 45
   1C89 00                 1147 	.db 0x00
                           1148 ;scheduling.c:165: void BroadcastEvent(int EventClass, short EventId) {
                           1149 ;	genLabel
                           1150 ;	genFunction
                           1151 ;	---------------------------------
                           1152 ; Function BroadcastEvent
                           1153 ; ---------------------------------
   0466                    1154 _BroadcastEvent_start::
   0466                    1155 _BroadcastEvent:
   1C8A 3E 03              1156 	ld	a,#3
   1C8C CF                 1157 	rst	0x08
   1C8D DD E5              1158 	push	ix
   1C8F DD 21 00 00        1159 	ld	ix,#0
   1C93 DD 39              1160 	add	ix,sp
   1C95 21 FE FF           1161 	ld	hl,#-2
   1C98 39                 1162 	add	hl,sp
   1C99 F9                 1163 	ld	sp,hl
                           1164 ;scheduling.c:167: Pause();
                           1165 ;	genCall
                           1166 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1C9A CD 2A 1C           1167 	call	_Pause
                           1168 ;scheduling.c:168: Task=SystemTasks;
                           1169 ;	genAssign
                           1170 ;	AOP_STK for _BroadcastEvent_Task_1_1
   1C9D 2A 16 81           1171 	ld	hl,(_SystemTasks)
   1CA0 DD 75 FE           1172 	ld	-2(ix),l
   1CA3 DD 74 FF           1173 	ld	-1(ix),h
                           1174 ;scheduling.c:169: while(Task!=NULL) {
                           1175 ;	genLabel
   0482                    1176 00103$:
                           1177 ;	genCmpEq
                           1178 ;	AOP_STK for _BroadcastEvent_Task_1_1
                           1179 ; genCmpEq: left 2, right 2, result 0
   1CA6 DD 7E FE           1180 	ld	a,-2(ix)
   1CA9 DD B6 FF           1181 	or	a,-1(ix)
   1CAC CA FF 1C           1182 	jp	z,00105$
   048B                    1183 00111$:
                           1184 ;scheduling.c:170: if(Task->Value.RegisteredEvents&EventClass) {
                           1185 ;	genPlus
                           1186 ;	AOP_STK for _BroadcastEvent_Task_1_1
                           1187 ;	genPlusIncr
                           1188 ;	Can't optimise plus by inc, falling back to the normal way
   1CAF DD 7E FE           1189 	ld	a,-2(ix)
   1CB2 C6 06              1190 	add	a,#0x06
   1CB4 5F                 1191 	ld	e,a
   1CB5 DD 7E FF           1192 	ld	a,-1(ix)
   1CB8 CE 00              1193 	adc	a,#0x00
   1CBA 57                 1194 	ld	d,a
                           1195 ;	genPointerGet
   1CBB 6B                 1196 	ld	l,e
   1CBC 62                 1197 	ld	h,d
   1CBD 4E                 1198 	ld	c,(hl)
   1CBE 23                 1199 	inc	hl
   1CBF 46                 1200 	ld	b,(hl)
                           1201 ;	genAnd
                           1202 ;	AOP_STK for 
   1CC0 79                 1203 	ld	a,c
   1CC1 DD A6 04           1204 	and	a,4(ix)
   1CC4 4F                 1205 	ld	c,a
   1CC5 78                 1206 	ld	a,b
   1CC6 DD A6 05           1207 	and	a,5(ix)
   1CC9 47                 1208 	ld	b,a
                           1209 ;	genIfx
   1CCA 79                 1210 	ld	a,c
   1CCB B0                 1211 	or	a,b
   1CCC CA E6 1C           1212 	jp	z,00102$
                           1213 ;scheduling.c:171: Task->Value.RegisteredEvents=EVENT_RUNTASK;
                           1214 ;	genAssign (pointer)
                           1215 ;	isBitvar = 0
   1CCF 6B                 1216 	ld	l,e
   1CD0 62                 1217 	ld	h,d
   1CD1 36 00              1218 	ld	(hl),#0x00
   1CD3 23                 1219 	inc	hl
   1CD4 36 00              1220 	ld	(hl),#0x00
                           1221 ;scheduling.c:172: Task->Value.EventId=EventId;
                           1222 ;	genPlus
                           1223 ;	AOP_STK for _BroadcastEvent_Task_1_1
                           1224 ;	genPlusIncr
                           1225 ;	Can't optimise plus by inc, falling back to the normal way
   1CD6 DD 7E FE           1226 	ld	a,-2(ix)
   1CD9 C6 08              1227 	add	a,#0x08
   1CDB 6F                 1228 	ld	l,a
   1CDC DD 7E FF           1229 	ld	a,-1(ix)
   1CDF CE 00              1230 	adc	a,#0x00
   1CE1 67                 1231 	ld	h,a
                           1232 ;	genAssign (pointer)
                           1233 ;	AOP_STK for 
                           1234 ;	isBitvar = 0
   1CE2 DD 7E 06           1235 	ld	a,6(ix)
   1CE5 77                 1236 	ld	(hl),a
                           1237 ;	genLabel
   04C2                    1238 00102$:
                           1239 ;scheduling.c:174: Task=Task->Next;
                           1240 ;	genPlus
                           1241 ;	AOP_STK for _BroadcastEvent_Task_1_1
                           1242 ;	genPlusIncr
                           1243 ;	Can't optimise plus by inc, falling back to the normal way
   1CE6 DD 7E FE           1244 	ld	a,-2(ix)
   1CE9 C6 09              1245 	add	a,#0x09
   1CEB 6F                 1246 	ld	l,a
   1CEC DD 7E FF           1247 	ld	a,-1(ix)
   1CEF CE 00              1248 	adc	a,#0x00
   1CF1 67                 1249 	ld	h,a
                           1250 ;	genPointerGet
   1CF2 7E                 1251 	ld	a,(hl)
   1CF3 23                 1252 	inc	hl
   1CF4 66                 1253 	ld	h,(hl)
   1CF5 6F                 1254 	ld	l,a
                           1255 ;	genAssign
                           1256 ;	AOP_STK for _BroadcastEvent_Task_1_1
   1CF6 DD 75 FE           1257 	ld	-2(ix),l
   1CF9 DD 74 FF           1258 	ld	-1(ix),h
                           1259 ;	genGoto
   1CFC C3 A6 1C           1260 	jp	00103$
                           1261 ;	genLabel
   04DB                    1262 00105$:
                           1263 ;scheduling.c:176: Resume();
                           1264 ;	genCall
                           1265 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1CFF CD 47 1C           1266 	call	_Resume
                           1267 ;	genLabel
   04DE                    1268 00106$:
                           1269 ;	genEndFunction
   1D02 DD F9              1270 	ld	sp,ix
   1D04 DD E1              1271 	pop	ix
   1D06 3E 04              1272 	ld	a,#4
   1D08 CF                 1273 	rst	0x08
   1D09 C9                 1274 	ret
   04E6                    1275 _BroadcastEvent_end::
                           1276 ;scheduling.c:181: short AwaitEvent(int EventClass) {
                           1277 ;	genLabel
                           1278 ;	genFunction
                           1279 ;	---------------------------------
                           1280 ; Function AwaitEvent
                           1281 ; ---------------------------------
   04E6                    1282 _AwaitEvent_start::
   04E6                    1283 _AwaitEvent:
   1D0A 3E 03              1284 	ld	a,#3
   1D0C CF                 1285 	rst	0x08
   1D0D DD E5              1286 	push	ix
   1D0F DD 21 00 00        1287 	ld	ix,#0
   1D13 DD 39              1288 	add	ix,sp
                           1289 ;scheduling.c:182: Pause();
                           1290 ;	genCall
                           1291 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1D15 CD 2A 1C           1292 	call	_Pause
                           1293 ;scheduling.c:183: CurrentTask->Value.RegisteredEvents|=EventClass;
                           1294 ;	genAssign
   1D18 2A 14 81           1295 	ld	hl,(_CurrentTask)
                           1296 ;	genPlus
                           1297 ;	genPlusIncr
                           1298 ;	Can't optimise plus by inc, falling back to the normal way
   1D1B 7D                 1299 	ld	a,l
   1D1C C6 06              1300 	add	a,#0x06
   1D1E 4F                 1301 	ld	c,a
   1D1F 7C                 1302 	ld	a,h
   1D20 CE 00              1303 	adc	a,#0x00
   1D22 47                 1304 	ld	b,a
                           1305 ;	genAssign
   1D23 2A 14 81           1306 	ld	hl,(_CurrentTask)
                           1307 ;	genPlus
                           1308 ;	genPlusIncr
   1D26 11 06 00           1309 	ld	de,#0x0006
   1D29 19                 1310 	add	hl,de
                           1311 ;	genPointerGet
   1D2A 5E                 1312 	ld	e,(hl)
   1D2B 23                 1313 	inc	hl
   1D2C 56                 1314 	ld	d,(hl)
                           1315 ;	genOr
                           1316 ;	AOP_STK for 
   1D2D 7B                 1317 	ld	a,e
   1D2E DD B6 04           1318 	or	a,4(ix)
   1D31 5F                 1319 	ld	e,a
   1D32 7A                 1320 	ld	a,d
   1D33 DD B6 05           1321 	or	a,5(ix)
   1D36 57                 1322 	ld	d,a
                           1323 ;	genAssign (pointer)
                           1324 ;	isBitvar = 0
   1D37 69                 1325 	ld	l,c
   1D38 60                 1326 	ld	h,b
   1D39 73                 1327 	ld	(hl),e
   1D3A 23                 1328 	inc	hl
   1D3B 72                 1329 	ld	(hl),d
                           1330 ;scheduling.c:184: Resume();
                           1331 ;	genCall
                           1332 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1D3C CD 47 1C           1333 	call	_Resume
                           1334 ;scheduling.c:185: Switch();
                           1335 ;	genCall
                           1336 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1D3F CD 51 1D           1337 	call	_Switch
                           1338 ;scheduling.c:186: return CurrentTask->Value.EventId;
                           1339 ;	genAssign
   1D42 2A 14 81           1340 	ld	hl,(_CurrentTask)
                           1341 ;	genPlus
                           1342 ;	genPlusIncr
   1D45 01 08 00           1343 	ld	bc,#0x0008
   1D48 09                 1344 	add	hl,bc
                           1345 ;	genPointerGet
   1D49 4E                 1346 	ld	c,(hl)
                           1347 ;	genRet
                           1348 ; Dump of IC_LEFT: type AOP_REG size 1
                           1349 ;	 reg = c
   1D4A 69                 1350 	ld	l,c
                           1351 ;	genLabel
   0527                    1352 00101$:
                           1353 ;	genEndFunction
   1D4B DD E1              1354 	pop	ix
   1D4D 3E 04              1355 	ld	a,#4
   1D4F CF                 1356 	rst	0x08
   1D50 C9                 1357 	ret
   052D                    1358 _AwaitEvent_end::
                           1359 ;scheduling.c:189: void Switch() {
                           1360 ;	genLabel
                           1361 ;	genFunction
                           1362 ;	---------------------------------
                           1363 ; Function Switch
                           1364 ; ---------------------------------
   052D                    1365 _Switch_start::
   052D                    1366 _Switch:
   1D51 3E 03              1367 	ld	a,#3
   1D53 CF                 1368 	rst	0x08
                           1369 ;scheduling.c:195: IntsOff();
                           1370 ;	genInline
   1D54 F3                 1371 		di 
                           1372 ;scheduling.c:196: ExchangeRegs();
                           1373 ;	genCall
                           1374 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1D55 CD F4 03           1375 	call	_ExchangeRegs
                           1376 ;scheduling.c:197: ControlRequests++;
                           1377 ;	genPlus
                           1378 ;	genPlusIncr
   1D58 FD 21 20 81        1379 	ld	iy,#_ControlRequests
   1D5C FD 34 00           1380 	inc	0(iy)
                           1381 ;scheduling.c:198: GetStackPointerASM(_OldSP);
                           1382 ;	genInline
   1D5F ED 73 1A 81        1383 		ld (_OldSP),sp 
                           1384 ;scheduling.c:199: SaveIndexes();
                           1385 ;	genInline
   1D63 21 FF EF F9 DD E5  1386 		ld hl,£0xEFFF ld sp,hl push ix push iy 
        FD E5
                           1387 ;scheduling.c:200: Scheduler(OldSP);
                           1388 ;	genIpush
                           1389 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1D6B 2A 1A 81           1390 	ld	hl,(_OldSP)
   1D6E E5                 1391 	push	hl
                           1392 ;	genCall
   1D6F CD 96 19           1393 	call	_Scheduler
   1D72 F1                 1394 	pop	af
                           1395 ;	genLabel
   054F                    1396 00101$:
                           1397 ;	genEndFunction
   1D73 3E 04              1398 	ld	a,#4
   1D75 CF                 1399 	rst	0x08
   1D76 C9                 1400 	ret
   0553                    1401 _Switch_end::
                           1402 ;scheduling.c:203: void NewContext(int* SP) {
                           1403 ;	genLabel
                           1404 ;	genFunction
                           1405 ;	---------------------------------
                           1406 ; Function NewContext
                           1407 ; ---------------------------------
   0553                    1408 _NewContext_start::
   0553                    1409 _NewContext:
   1D77 3E 03              1410 	ld	a,#3
   1D79 CF                 1411 	rst	0x08
   1D7A DD E5              1412 	push	ix
   1D7C DD 21 00 00        1413 	ld	ix,#0
   1D80 DD 39              1414 	add	ix,sp
                           1415 ;scheduling.c:205: SP; FunctionArgToReg(H, L);
                           1416 ;	genInline
   1D82 DD 21 00 00 DD 39  1417 		ld ix,£0 add ix,sp ld L,4(ix) ld H,5(ix) 
        DD 6E 04 DD 66 05
                           1418 ;scheduling.c:208: SetStackPointerASM(_OldSP);
                           1419 ;	genInline
   1D8E ED 7B 1A 81        1420 		ld sp,(_OldSP) 
                           1421 ;scheduling.c:209: ExchangeRegs();
                           1422 ;	genCall
                           1423 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1D92 CD F4 03           1424 	call	_ExchangeRegs
                           1425 ;scheduling.c:210: ReloadIndexes();
                           1426 ;	genInline
   1D95 DD 2A FD EF FD 2A  1427 		ld ix,(0xEFFD) ld iy,(0xEFFB) 
        FB EF
                           1428 ;scheduling.c:212: SaveContext();
                           1429 ;	genInline
   1D9D F5 C5 D5 E5 DD E5  1430 		push af push bc push de push hl push ix push iy 
        FD E5
                           1431 ;scheduling.c:215: ExchangeRegs();
                           1432 ;	genCall
                           1433 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1DA5 CD F4 03           1434 	call	_ExchangeRegs
                           1435 ;scheduling.c:216: GetStackPointerASM(_TempSP);
                           1436 ;	genInline
   1DA8 ED 73 1C 81        1437 		ld (_TempSP),sp 
                           1438 ;scheduling.c:217: SetStackPointerREG(HL);
                           1439 ;	genInline
   1DAC F9                 1440 		ld sp,HL 
                           1441 ;scheduling.c:218: *CurrentSP=TempSP;
                           1442 ;	genAssign
   1DAD ED 4B 18 81        1443 	ld	bc,(_CurrentSP)
                           1444 ;	genAssign (pointer)
                           1445 ;	isBitvar = 0
   1DB1 69                 1446 	ld	l,c
   1DB2 60                 1447 	ld	h,b
   1DB3 FD 21 1C 81        1448 	ld	iy,#_TempSP
   1DB7 FD 7E 00           1449 	ld	a,0(iy)
   1DBA 77                 1450 	ld	(hl),a
   1DBB 23                 1451 	inc	hl
   1DBC FD 7E 01           1452 	ld	a,1(iy)
   1DBF 77                 1453 	ld	(hl),a
                           1454 ;scheduling.c:220: ExchangeRegs();
                           1455 ;	genCall
                           1456 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1DC0 CD F4 03           1457 	call	_ExchangeRegs
                           1458 ;scheduling.c:222: LoadContext();
                           1459 ;	genInline
   1DC3 FD E1 DD E1 E1 D1  1460 		pop iy pop ix pop hl pop de pop bc pop af 
        C1 F1
                           1461 ;scheduling.c:224: if(ControlRequests==0) Halt("ISR IN USER MODE");
                           1462 ;	genCmpEq
                           1463 ; genCmpEq: left 1, right 1, result 0
   1DCB FD 21 20 81        1464 	ld	iy,#_ControlRequests
   1DCF FD 7E 00           1465 	ld	a,0(iy)
   1DD2 B7                 1466 	or	a,a
   1DD3 CA D9 1D           1467 	jp	z,00107$
   05B2                    1468 00106$:
   1DD6 C3 E1 1D           1469 	jp	00102$
   05B5                    1470 00107$:
                           1471 ;	genIpush
                           1472 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1DD9 21 F2 1D           1473 	ld	hl,#__str_7
   1DDC E5                 1474 	push	hl
                           1475 ;	genCall
   1DDD CD 32 23           1476 	call	_Halt
   1DE0 F1                 1477 	pop	af
                           1478 ;	genLabel
   05BD                    1479 00102$:
                           1480 ;scheduling.c:225: ControlRequests--;
                           1481 ;	genMinus
   1DE1 FD 21 20 81        1482 	ld	iy,#_ControlRequests
   1DE5 FD 35 00           1483 	dec	0(iy)
                           1484 ;scheduling.c:226: IntsOn();
                           1485 ;	genInline
   1DE8 ED 56 FB           1486 		im 1 ei 
                           1487 ;scheduling.c:227: ImmediateReturn();
                           1488 ;	genInline
   1DEB C9                 1489 		ret 
                           1490 ;	genLabel
   05C8                    1491 00103$:
                           1492 ;	genEndFunction
   1DEC DD E1              1493 	pop	ix
   1DEE 3E 04              1494 	ld	a,#4
   1DF0 CF                 1495 	rst	0x08
   1DF1 C9                 1496 	ret
   05CE                    1497 _NewContext_end::
                    05CE   1498 Fscheduling$_str_7$0$0 == .
   05CE                    1499 __str_7:
   1DF2 49 53 52 20 49 4E  1500 	.ascii "ISR IN USER MODE"
        20 55 53 45 52 20
        4D 4F 44 45
   1E02 00                 1501 	.db 0x00
                           1502 ;scheduling.c:230: void ScheduleTask(task* Task) {
                           1503 ;	genLabel
                           1504 ;	genFunction
                           1505 ;	---------------------------------
                           1506 ; Function ScheduleTask
                           1507 ; ---------------------------------
   05DF                    1508 _ScheduleTask_start::
   05DF                    1509 _ScheduleTask:
   1E03 3E 03              1510 	ld	a,#3
   1E05 CF                 1511 	rst	0x08
   1E06 DD E5              1512 	push	ix
   1E08 DD 21 00 00        1513 	ld	ix,#0
   1E0C DD 39              1514 	add	ix,sp
                           1515 ;scheduling.c:231: _SimPrintString("Context switch\n");
                           1516 ;	genIpush
                           1517 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1E0E 21 2F 1E           1518 	ld	hl,#__str_8
   1E11 E5                 1519 	push	hl
                           1520 ;	genCall
   1E12 CD CA 2A           1521 	call	__Z80SimPrintString
   1E15 F1                 1522 	pop	af
                           1523 ;scheduling.c:232: NewContext(Task->SP);
                           1524 ;	genAssign
                           1525 ;	AOP_STK for 
   1E16 DD 6E 04           1526 	ld	l,4(ix)
   1E19 DD 66 05           1527 	ld	h,5(ix)
                           1528 ;	genPlus
                           1529 ;	genPlusIncr
   1E1C 01 04 00           1530 	ld	bc,#0x0004
   1E1F 09                 1531 	add	hl,bc
                           1532 ;	genPointerGet
   1E20 7E                 1533 	ld	a,(hl)
   1E21 23                 1534 	inc	hl
   1E22 66                 1535 	ld	h,(hl)
   1E23 6F                 1536 	ld	l,a
                           1537 ;	genIpush
                           1538 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1E24 E5                 1539 	push	hl
                           1540 ;	genCall
   1E25 CD 77 1D           1541 	call	_NewContext
   1E28 F1                 1542 	pop	af
                           1543 ;	genLabel
   0605                    1544 00101$:
                           1545 ;	genEndFunction
   1E29 DD E1              1546 	pop	ix
   1E2B 3E 04              1547 	ld	a,#4
   1E2D CF                 1548 	rst	0x08
   1E2E C9                 1549 	ret
   060B                    1550 _ScheduleTask_end::
                    060B   1551 Fscheduling$_str_8$0$0 == .
   060B                    1552 __str_8:
   1E2F 43 6F 6E 74 65 78  1553 	.ascii "Context switch"
        74 20 73 77 69 74
        63 68
   1E3D 0A                 1554 	.db 0x0A
   1E3E 00                 1555 	.db 0x00
                           1556 ;scheduling.c:235: bool IsMultitasking() {
                           1557 ;	genLabel
                           1558 ;	genFunction
                           1559 ;	---------------------------------
                           1560 ; Function IsMultitasking
                           1561 ; ---------------------------------
   061B                    1562 _IsMultitasking_start::
   061B                    1563 _IsMultitasking:
   1E3F 3E 03              1564 	ld	a,#3
   1E41 CF                 1565 	rst	0x08
                           1566 ;scheduling.c:236: if(ControlRequests==0) return TRUE; else return FALSE;
                           1567 ;	genCmpEq
                           1568 ; genCmpEq: left 1, right 1, result 0
   1E42 FD 21 20 81        1569 	ld	iy,#_ControlRequests
   1E46 FD 7E 00           1570 	ld	a,0(iy)
   1E49 B7                 1571 	or	a,a
   1E4A CA 50 1E           1572 	jp	z,00108$
   0629                    1573 00107$:
   1E4D C3 55 1E           1574 	jp	00102$
   062C                    1575 00108$:
                           1576 ;	genRet
                           1577 ; Dump of IC_LEFT: type AOP_LIT size 1
   1E50 2E 01              1578 	ld	l,#0x01
   1E52 C3 57 1E           1579 	jp	00104$
                           1580 ;	genLabel
   0631                    1581 00102$:
                           1582 ;	genRet
                           1583 ; Dump of IC_LEFT: type AOP_LIT size 1
   1E55 2E 00              1584 	ld	l,#0x00
                           1585 ;	genLabel
   0633                    1586 00104$:
                           1587 ;	genEndFunction
   1E57 3E 04              1588 	ld	a,#4
   1E59 CF                 1589 	rst	0x08
   1E5A C9                 1590 	ret
   0637                    1591 _IsMultitasking_end::
                           1592 	.area _CODE
