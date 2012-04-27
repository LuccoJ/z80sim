                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.5 Fri Apr 27 12:30:18 2012
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module main
                              7 	.optsdcc -mz80
                              8 	
                              9 ;--------------------------------------------------------
                             10 ; Public variables in this module
                             11 ;--------------------------------------------------------
                             12 	.globl _main
                             13 	.globl _SystemTask
                             14 	.globl _Task2
                             15 	.globl _Task1
                             16 	.globl _SystemInit
                             17 	.globl _PrintNumber
                             18 	.globl _PrintReg
                             19 	.globl _MainEntry
                             20 	.globl _SystemLock
                             21 	.globl _TestMemory
                             22 ;--------------------------------------------------------
                             23 ;  ram data
                             24 ;--------------------------------------------------------
                             25 	.area _DATA
                    0000     26 G$SystemLock$0$0==.
   0000                      27 _SystemLock::
   0000                      28 	.ds 1
                    0001     29 G$MainEntry$0$0==.
   0001                      30 _MainEntry::
   0001                      31 	.ds 2
                    0003     32 G$PrintReg$0$0==.
   0003                      33 _PrintReg::
   0003                      34 	.ds 1
                             35 ;--------------------------------------------------------
                             36 ; overlayable items in  ram 
                             37 ;--------------------------------------------------------
                             38 	.area _OVERLAY
                             39 ;--------------------------------------------------------
                             40 ; external initialized ram data
                             41 ;--------------------------------------------------------
                             42 ;--------------------------------------------------------
                             43 ; global & static initialisations
                             44 ;--------------------------------------------------------
                             45 	.area _GSINIT
                             46 	.area _GSFINAL
                             47 	.area _GSINIT
                             48 ;--------------------------------------------------------
                             49 ; Home
                             50 ;--------------------------------------------------------
                             51 	.area _HOME
                             52 	.area _CODE
                             53 ;--------------------------------------------------------
                             54 ; code
                             55 ;--------------------------------------------------------
                             56 	.area _CODE
                             57 ;main.c:25: void PrintNumber(unsigned int n) {
                             58 ;	genLabel
                             59 ;	genFunction
                             60 ;	---------------------------------
                             61 ; Function PrintNumber
                             62 ; ---------------------------------
   0000                      63 _PrintNumber_start::
   0000                      64 _PrintNumber:
   003D 3E 03                65 	ld	a,#3
   003F CF                   66 	rst	0x08
   0040 DD E5                67 	push	ix
   0042 DD 21 00 00          68 	ld	ix,#0
   0046 DD 39                69 	add	ix,sp
   0048 21 F0 FF             70 	ld	hl,#-16
   004B 39                   71 	add	hl,sp
   004C F9                   72 	ld	sp,hl
                             73 ;main.c:27: WordToString(n, Temp);
                             74 ;	genAddrOf
   004D 21 00 00             75 	ld	hl,#0x0000
   0050 39                   76 	add	hl,sp
   0051 4D                   77 	ld	c,l
   0052 44                   78 	ld	b,h
                             79 ;	genIpush
                             80 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   0053 C5                   81 	push	bc
   0054 C5                   82 	push	bc
                             83 ;	genIpush
                             84 ;	AOP_STK for 
   0055 DD 6E 04             85 	ld	l,4(ix)
   0058 DD 66 05             86 	ld	h,5(ix)
   005B E5                   87 	push	hl
                             88 ;	genCall
   005C CD 0E 06             89 	call	_WordToString
   005F F1                   90 	pop	af
   0060 F1                   91 	pop	af
   0061 C1                   92 	pop	bc
                             93 ;main.c:28: ConsoleWrite(Temp);
                             94 ;	genIpush
                             95 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0062 C5                   96 	push	bc
                             97 ;	genCall
   0063 CD 84 14             98 	call	_ConsoleWrite
   0066 F1                   99 	pop	af
                            100 ;	genLabel
   002A                     101 00101$:
                            102 ;	genEndFunction
   0067 DD F9               103 	ld	sp,ix
   0069 DD E1               104 	pop	ix
   006B 3E 04               105 	ld	a,#4
   006D CF                  106 	rst	0x08
   006E C9                  107 	ret
   0032                     108 _PrintNumber_end::
                            109 ;main.c:31: void SystemInit() {
                            110 ;	genLabel
                            111 ;	genFunction
                            112 ;	---------------------------------
                            113 ; Function SystemInit
                            114 ; ---------------------------------
   0032                     115 _SystemInit_start::
   0032                     116 _SystemInit:
   006F 3E 03               117 	ld	a,#3
   0071 CF                  118 	rst	0x08
                            119 ;main.c:32: }
                            120 ;	genLabel
   0035                     121 00101$:
                            122 ;	genEndFunction
   0072 3E 04               123 	ld	a,#4
   0074 CF                  124 	rst	0x08
   0075 C9                  125 	ret
   0039                     126 _SystemInit_end::
                            127 ;main.c:34: void Task1() {
                            128 ;	genLabel
                            129 ;	genFunction
                            130 ;	---------------------------------
                            131 ; Function Task1
                            132 ; ---------------------------------
   0039                     133 _Task1_start::
   0039                     134 _Task1:
   0076 3E 03               135 	ld	a,#3
   0078 CF                  136 	rst	0x08
                            137 ;main.c:35: while(1) {
                            138 ;	genLabel
   003C                     139 00104$:
                            140 ;main.c:36: if(!IsMultitasking()) {
                            141 ;	genCall
                            142 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0079 CD 3F 1E            143 	call	_IsMultitasking
                            144 ;	genIfx
   007C AF                  145 	xor	a,a
   007D B5                  146 	or	a,l
   007E C2 89 00            147 	jp	nz,00102$
                            148 ;main.c:37: Halt("INTS DISABLED PRC1");
                            149 ;	genIpush
                            150 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0081 21 A0 00            151 	ld	hl,#__str_0
   0084 E5                  152 	push	hl
                            153 ;	genCall
   0085 CD 32 23            154 	call	_Halt
   0088 F1                  155 	pop	af
                            156 ;	genLabel
   004C                     157 00102$:
                            158 ;main.c:39: ConsoleWrite("1");
                            159 ;	genIpush
                            160 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0089 21 B3 00            161 	ld	hl,#__str_1
   008C E5                  162 	push	hl
                            163 ;	genCall
   008D CD 84 14            164 	call	_ConsoleWrite
   0090 F1                  165 	pop	af
                            166 ;main.c:40: _SimPrintString("1");
                            167 ;	genIpush
                            168 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0091 21 B3 00            169 	ld	hl,#__str_1
   0094 E5                  170 	push	hl
                            171 ;	genCall
   0095 CD CA 2A            172 	call	__Z80SimPrintString
   0098 F1                  173 	pop	af
                            174 ;	genGoto
   0099 C3 79 00            175 	jp	00104$
                            176 ;	genLabel
   005F                     177 00106$:
                            178 ;	genEndFunction
   009C 3E 04               179 	ld	a,#4
   009E CF                  180 	rst	0x08
   009F C9                  181 	ret
   0063                     182 _Task1_end::
                    0063    183 Fmain$_str_0$0$0 == .
   0063                     184 __str_0:
   00A0 49 4E 54 53 20 44   185 	.ascii "INTS DISABLED PRC1"
        49 53 41 42 4C 45
        44 20 50 52 43 31
   00B2 00                  186 	.db 0x00
                    0076    187 Fmain$_str_1$0$0 == .
   0076                     188 __str_1:
   00B3 31                  189 	.ascii "1"
   00B4 00                  190 	.db 0x00
                            191 ;main.c:44: void Task2() {
                            192 ;	genLabel
                            193 ;	genFunction
                            194 ;	---------------------------------
                            195 ; Function Task2
                            196 ; ---------------------------------
   0078                     197 _Task2_start::
   0078                     198 _Task2:
   00B5 3E 03               199 	ld	a,#3
   00B7 CF                  200 	rst	0x08
                            201 ;main.c:45: while(1) {
                            202 ;	genLabel
   007B                     203 00104$:
                            204 ;main.c:46: if(!IsMultitasking()) {
                            205 ;	genCall
                            206 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   00B8 CD 3F 1E            207 	call	_IsMultitasking
                            208 ;	genIfx
   00BB AF                  209 	xor	a,a
   00BC B5                  210 	or	a,l
   00BD C2 C8 00            211 	jp	nz,00102$
                            212 ;main.c:47: Halt("INTS DISABLED PRC2");
                            213 ;	genIpush
                            214 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   00C0 21 DF 00            215 	ld	hl,#__str_2
   00C3 E5                  216 	push	hl
                            217 ;	genCall
   00C4 CD 32 23            218 	call	_Halt
   00C7 F1                  219 	pop	af
                            220 ;	genLabel
   008B                     221 00102$:
                            222 ;main.c:49: ConsoleWrite("2");
                            223 ;	genIpush
                            224 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   00C8 21 F2 00            225 	ld	hl,#__str_3
   00CB E5                  226 	push	hl
                            227 ;	genCall
   00CC CD 84 14            228 	call	_ConsoleWrite
   00CF F1                  229 	pop	af
                            230 ;main.c:50: _SimPrintString("2");
                            231 ;	genIpush
                            232 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   00D0 21 F2 00            233 	ld	hl,#__str_3
   00D3 E5                  234 	push	hl
                            235 ;	genCall
   00D4 CD CA 2A            236 	call	__Z80SimPrintString
   00D7 F1                  237 	pop	af
                            238 ;	genGoto
   00D8 C3 B8 00            239 	jp	00104$
                            240 ;	genLabel
   009E                     241 00106$:
                            242 ;	genEndFunction
   00DB 3E 04               243 	ld	a,#4
   00DD CF                  244 	rst	0x08
   00DE C9                  245 	ret
   00A2                     246 _Task2_end::
                    00A2    247 Fmain$_str_2$0$0 == .
   00A2                     248 __str_2:
   00DF 49 4E 54 53 20 44   249 	.ascii "INTS DISABLED PRC2"
        49 53 41 42 4C 45
        44 20 50 52 43 32
   00F1 00                  250 	.db 0x00
                    00B5    251 Fmain$_str_3$0$0 == .
   00B5                     252 __str_3:
   00F2 32                  253 	.ascii "2"
   00F3 00                  254 	.db 0x00
                            255 ;main.c:54: void SystemTask() {
                            256 ;	genLabel
                            257 ;	genFunction
                            258 ;	---------------------------------
                            259 ; Function SystemTask
                            260 ; ---------------------------------
   00B7                     261 _SystemTask_start::
   00B7                     262 _SystemTask:
   00F4 3E 03               263 	ld	a,#3
   00F6 CF                  264 	rst	0x08
                            265 ;main.c:55: if(!IsMultitasking()) Halt("PAUSE WITHOUT RESUME");
                            266 ;	genCall
                            267 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   00F7 CD 3F 1E            268 	call	_IsMultitasking
                            269 ;	genIfx
   00FA AF                  270 	xor	a,a
   00FB B5                  271 	or	a,l
   00FC C2 07 01            272 	jp	nz,00102$
                            273 ;	genIpush
                            274 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   00FF 21 0E 01            275 	ld	hl,#__str_4
   0102 E5                  276 	push	hl
                            277 ;	genCall
   0103 CD 32 23            278 	call	_Halt
   0106 F1                  279 	pop	af
                            280 ;	genLabel
   00CA                     281 00102$:
                            282 ;main.c:56: SystemMonitor();
                            283 ;	genCall
                            284 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0107 CD 9D 23            285 	call	_SystemMonitor
                            286 ;	genLabel
   00CD                     287 00103$:
                            288 ;	genEndFunction
   010A 3E 04               289 	ld	a,#4
   010C CF                  290 	rst	0x08
   010D C9                  291 	ret
   00D1                     292 _SystemTask_end::
                    00D1    293 Fmain$_str_4$0$0 == .
   00D1                     294 __str_4:
   010E 50 41 55 53 45 20   295 	.ascii "PAUSE WITHOUT RESUME"
        57 49 54 48 4F 55
        54 20 52 45 53 55
        4D 45
   0122 00                  296 	.db 0x00
                            297 ;main.c:59: void main() {
                            298 ;	genLabel
                            299 ;	genFunction
                            300 ;	---------------------------------
                            301 ; Function main
                            302 ; ---------------------------------
   00E6                     303 _main_start::
   00E6                     304 _main:
   0123 3E 03               305 	ld	a,#3
   0125 CF                  306 	rst	0x08
                            307 ;main.c:76: _endasm;
                            308 ;	genInline
                            309 ;
   0126 F3                  310 		       di
   0127 31 FF FF            311 		       ld sp,#0xffff
   012A 3E 00               312 		       ld a,#0x0
   012C 01 00 00            313 		       ld bc,#0x0
   012F 11 00 00            314 		       ld de,#0x0
   0132 21 00 00            315 		       ld hl,#0x0
   0135 DD 21 00 00         316 		       ld ix,#0x0
   0139 FD 21 00 00         317 		       ld iy,#0x0
                            318 		       
                            319 ;main.c:78: _SimWriteProtect((void*)0x0000, (void*)0x3fff);
                            320 ;	genIpush
                            321 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   013D 21 FF 3F            322 	ld	hl,#0x3FFF
   0140 E5                  323 	push	hl
                            324 ;	genIpush
   0141 21 00 00            325 	ld	hl,#0x0000
   0144 E5                  326 	push	hl
                            327 ;	genCall
   0145 CD 1C 2B            328 	call	__Z80SimWriteProtect
   0148 F1                  329 	pop	af
   0149 F1                  330 	pop	af
                            331 ;main.c:80: _SimPrintString("\n-------------------\n");
                            332 ;	genIpush
                            333 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   014A 21 EC 01            334 	ld	hl,#__str_5
   014D E5                  335 	push	hl
                            336 ;	genCall
   014E CD CA 2A            337 	call	__Z80SimPrintString
   0151 F1                  338 	pop	af
                            339 ;main.c:81: _SimPrintString("System reset\n");
                            340 ;	genIpush
                            341 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0152 21 02 02            342 	ld	hl,#__str_6
   0155 E5                  343 	push	hl
                            344 ;	genCall
   0156 CD CA 2A            345 	call	__Z80SimPrintString
   0159 F1                  346 	pop	af
                            347 ;main.c:82: _SimPrintString("-------------------\n");
                            348 ;	genIpush
                            349 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   015A 21 10 02            350 	ld	hl,#__str_7
   015D E5                  351 	push	hl
                            352 ;	genCall
   015E CD CA 2A            353 	call	__Z80SimPrintString
   0161 F1                  354 	pop	af
                            355 ;main.c:84: IntsOff();
                            356 ;	genInline
   0162 F3                  357 		di 
                            358 ;main.c:86: _SimPrintString("Interrupts disabled. Booting...\n");
                            359 ;	genIpush
                            360 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0163 21 25 02            361 	ld	hl,#__str_8
   0166 E5                  362 	push	hl
                            363 ;	genCall
   0167 CD CA 2A            364 	call	__Z80SimPrintString
   016A F1                  365 	pop	af
                            366 ;main.c:88: TestMemory();
                            367 ;	genCall
                            368 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   016B CD A5 02            369 	call	_TestMemory
                            370 ;main.c:89: HardwareInit();
                            371 ;	genCall
                            372 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   016E CD E5 03            373 	call	_HardwareInit
                            374 ;main.c:90: LocksInit();
                            375 ;	genCall
                            376 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0171 CD F6 16            377 	call	_LocksInit
                            378 ;main.c:91: SchedulingInit();
                            379 ;	genCall
                            380 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0174 CD 16 19            381 	call	_SchedulingInit
                            382 ;main.c:92: SupervisorMode();
                            383 ;	genCall
                            384 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0177 CD 12 1C            385 	call	_SupervisorMode
                            386 ;main.c:93: TimeInit();
                            387 ;	genCall
                            388 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   017A CD 7B 24            389 	call	_TimeInit
                            390 ;main.c:94: SystemInit();
                            391 ;	genCall
                            392 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   017D CD 6F 00            393 	call	_SystemInit
                            394 ;main.c:95: MemoryInit();
                            395 ;	genCall
                            396 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0180 CD E2 15            397 	call	_MemoryInit
                            398 ;main.c:98: ConsoleInit();
                            399 ;	genCall
                            400 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0183 CD 5F 11            401 	call	_ConsoleInit
                            402 ;main.c:99: ConsoleWrite("LJL OS 0.1 FOR ZX SPECTRUM 48\n");
                            403 ;	genIpush
                            404 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0186 21 46 02            405 	ld	hl,#__str_9
   0189 E5                  406 	push	hl
                            407 ;	genCall
   018A CD 84 14            408 	call	_ConsoleWrite
   018D F1                  409 	pop	af
                            410 ;main.c:100: ConsoleWrite("\nCONSOLE OUTPUT\n\n");
                            411 ;	genIpush
                            412 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   018E 21 65 02            413 	ld	hl,#__str_10
   0191 E5                  414 	push	hl
                            415 ;	genCall
   0192 CD 84 14            416 	call	_ConsoleWrite
   0195 F1                  417 	pop	af
                            418 ;main.c:110: MainEntry=Task1;
                            419 ;	genAssign
   0196 FD 21 01 80         420 	ld	iy,#_MainEntry
   019A FD 36 00 76         421 	ld	0(iy),#<_Task1
   019E FD 36 01 00         422 	ld	1(iy),#>_Task1
                            423 ;main.c:111: TI1=CreateTask(MainEntry, 100);
                            424 ;	genAssign
   01A2 ED 4B 01 80         425 	ld	bc,(_MainEntry)
                            426 ;	genIpush
                            427 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   01A6 21 64 00            428 	ld	hl,#0x0064
   01A9 E5                  429 	push	hl
                            430 ;	genIpush
   01AA C5                  431 	push	bc
                            432 ;	genCall
   01AB CD F2 1A            433 	call	_CreateTask
   01AE F1                  434 	pop	af
   01AF F1                  435 	pop	af
                            436 ;main.c:112: MainEntry=Task2;
                            437 ;	genAssign
   01B0 FD 21 01 80         438 	ld	iy,#_MainEntry
   01B4 FD 36 00 B5         439 	ld	0(iy),#<_Task2
   01B8 FD 36 01 00         440 	ld	1(iy),#>_Task2
                            441 ;main.c:113: TI2=CreateTask(MainEntry, 100);
                            442 ;	genAssign
   01BC ED 4B 01 80         443 	ld	bc,(_MainEntry)
                            444 ;	genIpush
                            445 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   01C0 21 64 00            446 	ld	hl,#0x0064
   01C3 E5                  447 	push	hl
                            448 ;	genIpush
   01C4 C5                  449 	push	bc
                            450 ;	genCall
   01C5 CD F2 1A            451 	call	_CreateTask
   01C8 F1                  452 	pop	af
   01C9 F1                  453 	pop	af
                            454 ;main.c:114: ConsoleWrite("TASKS CREATED\n");
                            455 ;	genIpush
                            456 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   01CA 21 77 02            457 	ld	hl,#__str_11
   01CD E5                  458 	push	hl
                            459 ;	genCall
   01CE CD 84 14            460 	call	_ConsoleWrite
   01D1 F1                  461 	pop	af
                            462 ;main.c:115: SetScheduler(DefaultScheduler);
                            463 ;	genIpush
                            464 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   01D2 21 0C 1A            465 	ld	hl,#_DefaultScheduler
   01D5 E5                  466 	push	hl
                            467 ;	genCall
   01D6 CD 75 19            468 	call	_SetScheduler
   01D9 F1                  469 	pop	af
                            470 ;main.c:116: ConsoleWrite("SCHEDULER SET\n");
                            471 ;	genIpush
                            472 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   01DA 21 86 02            473 	ld	hl,#__str_12
   01DD E5                  474 	push	hl
                            475 ;	genCall
   01DE CD 84 14            476 	call	_ConsoleWrite
   01E1 F1                  477 	pop	af
                            478 ;main.c:117: Resume();
                            479 ;	genCall
                            480 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   01E2 CD 47 1C            481 	call	_Resume
                            482 ;	genLabel
   01A8                     483 00102$:
                            484 ;	genGoto
   01E5 C3 E5 01            485 	jp	00102$
                            486 ;main.c:121: Halt("SYSTEM SHUTDOWN");
                            487 ;	genLabel
   01AB                     488 00104$:
                            489 ;	genEndFunction
   01E8 3E 04               490 	ld	a,#4
   01EA CF                  491 	rst	0x08
   01EB C9                  492 	ret
   01AF                     493 _main_end::
                    01AF    494 Fmain$_str_5$0$0 == .
   01AF                     495 __str_5:
   01EC 0A                  496 	.db 0x0A
   01ED 2D 2D 2D 2D 2D 2D   497 	.ascii "-------------------"
        2D 2D 2D 2D 2D 2D
        2D 2D 2D 2D 2D 2D
        2D
   0200 0A                  498 	.db 0x0A
   0201 00                  499 	.db 0x00
                    01C5    500 Fmain$_str_6$0$0 == .
   01C5                     501 __str_6:
   0202 53 79 73 74 65 6D   502 	.ascii "System reset"
        20 72 65 73 65 74
   020E 0A                  503 	.db 0x0A
   020F 00                  504 	.db 0x00
                    01D3    505 Fmain$_str_7$0$0 == .
   01D3                     506 __str_7:
   0210 2D 2D 2D 2D 2D 2D   507 	.ascii "-------------------"
        2D 2D 2D 2D 2D 2D
        2D 2D 2D 2D 2D 2D
        2D
   0223 0A                  508 	.db 0x0A
   0224 00                  509 	.db 0x00
                    01E8    510 Fmain$_str_8$0$0 == .
   01E8                     511 __str_8:
   0225 49 6E 74 65 72 72   512 	.ascii "Interrupts disabled. Booting..."
        75 70 74 73 20 64
        69 73 61 62 6C 65
        64 2E 20 42 6F 6F
        74 69 6E 67 2E 2E
        2E
   0244 0A                  513 	.db 0x0A
   0245 00                  514 	.db 0x00
                    0209    515 Fmain$_str_9$0$0 == .
   0209                     516 __str_9:
   0246 4C 4A 4C 20 4F 53   517 	.ascii "LJL OS 0.1 FOR ZX SPECTRUM 48"
        20 30 2E 31 20 46
        4F 52 20 5A 58 20
        53 50 45 43 54 52
        55 4D 20 34 38
   0263 0A                  518 	.db 0x0A
   0264 00                  519 	.db 0x00
                    0228    520 Fmain$_str_10$0$0 == .
   0228                     521 __str_10:
   0265 0A                  522 	.db 0x0A
   0266 43 4F 4E 53 4F 4C   523 	.ascii "CONSOLE OUTPUT"
        45 20 4F 55 54 50
        55 54
   0274 0A                  524 	.db 0x0A
   0275 0A                  525 	.db 0x0A
   0276 00                  526 	.db 0x00
                    023A    527 Fmain$_str_11$0$0 == .
   023A                     528 __str_11:
   0277 54 41 53 4B 53 20   529 	.ascii "TASKS CREATED"
        43 52 45 41 54 45
        44
   0284 0A                  530 	.db 0x0A
   0285 00                  531 	.db 0x00
                    0249    532 Fmain$_str_12$0$0 == .
   0249                     533 __str_12:
   0286 53 43 48 45 44 55   534 	.ascii "SCHEDULER SET"
        4C 45 52 20 53 45
        54
   0293 0A                  535 	.db 0x0A
   0294 00                  536 	.db 0x00
                    0258    537 Fmain$_str_13$0$0 == .
   0258                     538 __str_13:
   0295 53 59 53 54 45 4D   539 	.ascii "SYSTEM SHUTDOWN"
        20 53 48 55 54 44
        4F 57 4E
   02A4 00                  540 	.db 0x00
                            541 ;main.c:124: void TestMemory()
                            542 ;	genLabel
                            543 ;	genFunction
                            544 ;	---------------------------------
                            545 ; Function TestMemory
                            546 ; ---------------------------------
   0268                     547 _TestMemory_start::
   0268                     548 _TestMemory:
   02A5 3E 03               549 	ld	a,#3
   02A7 CF                  550 	rst	0x08
                            551 ;main.c:127: PutString("TESTING MEMORY A", 1, 1);
                            552 ;	genIpush
                            553 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   02A8 21 01 01            554 	ld	hl,#0x0101
   02AB E5                  555 	push	hl
                            556 ;	genIpush
   02AC 21 8C 03            557 	ld	hl,#__str_14
   02AF E5                  558 	push	hl
                            559 ;	genCall
   02B0 CD F1 10            560 	call	_PutString
   02B3 F1                  561 	pop	af
   02B4 F1                  562 	pop	af
                            563 ;main.c:128: _SimUnprotect(0x4000, 0x5fff);
                            564 ;	genIpush
                            565 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   02B5 21 FF 5F            566 	ld	hl,#0x5FFF
   02B8 E5                  567 	push	hl
                            568 ;	genIpush
   02B9 21 00 40            569 	ld	hl,#0x4000
   02BC E5                  570 	push	hl
                            571 ;	genCall
   02BD CD 7C 2B            572 	call	__Z80SimUnprotect
   02C0 F1                  573 	pop	af
   02C1 F1                  574 	pop	af
                            575 ;main.c:129: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
                            576 ;	genAssign
   02C2 01 00 40            577 	ld	bc,#0x4000
                            578 ;	genLabel
   0288                     579 00105$:
                            580 ;	genCmpLt
   02C5 79                  581 	ld	a,c
   02C6 D6 EA               582 	sub	a,#0xEA
   02C8 78                  583 	ld	a,b
   02C9 DE EE               584 	sbc	a,#0xEE
   02CB D2 D5 02            585 	jp	nc,00131$
                            586 ;main.c:130: *i=0xAA;
                            587 ;	genAssign (pointer)
                            588 ;	isBitvar = 0
   02CE 3E AA               589 	ld	a,#0xAA
   02D0 02                  590 	ld	(bc),a
                            591 ;main.c:129: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
                            592 ;	genPlus
                            593 ;	genPlusIncr
   02D1 03                  594 	inc	bc
                            595 ;	genGoto
   02D2 C3 C5 02            596 	jp	00105$
                            597 ;main.c:132: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
                            598 ;	genLabel
   0298                     599 00131$:
                            600 ;	genAssign
   02D5 01 00 40            601 	ld	bc,#0x4000
                            602 ;	genLabel
   029B                     603 00109$:
                            604 ;	genCmpLt
   02D8 79                  605 	ld	a,c
   02D9 D6 EA               606 	sub	a,#0xEA
   02DB 78                  607 	ld	a,b
   02DC DE EE               608 	sbc	a,#0xEE
   02DE D2 05 03            609 	jp	nc,00112$
                            610 ;main.c:133: if(*i!=0xAA) {
                            611 ;	genPointerGet
   02E1 0A                  612 	ld	a,(bc)
                            613 ;	genCmpEq
                            614 ; genCmpEq: left 1, right 1, result 0
   02E2 6F                  615 	ld	l,a
   02E3 FE AA               616 	cp	a,#0xAA
   02E5 CA 01 03            617 	jp	z,00111$
   02AB                     618 00139$:
                            619 ;main.c:134: PutString("BAD MEMORY", 1, 1);
                            620 ;	genIpush
                            621 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   02E8 C5                  622 	push	bc
   02E9 21 01 01            623 	ld	hl,#0x0101
   02EC E5                  624 	push	hl
                            625 ;	genIpush
   02ED 21 9D 03            626 	ld	hl,#__str_15
   02F0 E5                  627 	push	hl
                            628 ;	genCall
   02F1 CD F1 10            629 	call	_PutString
   02F4 F1                  630 	pop	af
   02F5 F1                  631 	pop	af
   02F6 C1                  632 	pop	bc
                            633 ;main.c:135: Halt("BAD MEMORY");
                            634 ;	genIpush
                            635 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   02F7 C5                  636 	push	bc
   02F8 21 9D 03            637 	ld	hl,#__str_15
   02FB E5                  638 	push	hl
                            639 ;	genCall
   02FC CD 32 23            640 	call	_Halt
   02FF F1                  641 	pop	af
   0300 C1                  642 	pop	bc
                            643 ;	genLabel
   02C4                     644 00111$:
                            645 ;main.c:132: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
                            646 ;	genPlus
                            647 ;	genPlusIncr
   0301 03                  648 	inc	bc
                            649 ;	genGoto
   0302 C3 D8 02            650 	jp	00109$
                            651 ;	genLabel
   02C8                     652 00112$:
                            653 ;main.c:138: PutString("TESTING MEMORY B", 2, 1);
                            654 ;	genIpush
                            655 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0305 21 02 01            656 	ld	hl,#0x0102
   0308 E5                  657 	push	hl
                            658 ;	genIpush
   0309 21 A8 03            659 	ld	hl,#__str_16
   030C E5                  660 	push	hl
                            661 ;	genCall
   030D CD F1 10            662 	call	_PutString
   0310 F1                  663 	pop	af
   0311 F1                  664 	pop	af
                            665 ;main.c:139: _SimUnprotect(0x4000, 0x5fff);
                            666 ;	genIpush
                            667 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0312 21 FF 5F            668 	ld	hl,#0x5FFF
   0315 E5                  669 	push	hl
                            670 ;	genIpush
   0316 21 00 40            671 	ld	hl,#0x4000
   0319 E5                  672 	push	hl
                            673 ;	genCall
   031A CD 7C 2B            674 	call	__Z80SimUnprotect
   031D F1                  675 	pop	af
   031E F1                  676 	pop	af
                            677 ;main.c:140: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
                            678 ;	genAssign
   031F 01 00 40            679 	ld	bc,#0x4000
                            680 ;	genLabel
   02E5                     681 00113$:
                            682 ;	genCmpLt
   0322 79                  683 	ld	a,c
   0323 D6 EA               684 	sub	a,#0xEA
   0325 78                  685 	ld	a,b
   0326 DE EE               686 	sbc	a,#0xEE
   0328 D2 32 03            687 	jp	nc,00136$
                            688 ;main.c:141: *i=(~0xAA);
                            689 ;	genAssign (pointer)
                            690 ;	isBitvar = 0
   032B 3E 55               691 	ld	a,#0x55
   032D 02                  692 	ld	(bc),a
                            693 ;main.c:140: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
                            694 ;	genPlus
                            695 ;	genPlusIncr
   032E 03                  696 	inc	bc
                            697 ;	genGoto
   032F C3 22 03            698 	jp	00113$
                            699 ;main.c:143: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
                            700 ;	genLabel
   02F5                     701 00136$:
                            702 ;	genAssign
   0332 01 00 40            703 	ld	bc,#0x4000
                            704 ;	genLabel
   02F8                     705 00117$:
                            706 ;	genCmpLt
   0335 79                  707 	ld	a,c
   0336 D6 EA               708 	sub	a,#0xEA
   0338 78                  709 	ld	a,b
   0339 DE EE               710 	sbc	a,#0xEE
   033B D2 53 03            711 	jp	nc,00120$
                            712 ;main.c:144: if(*i!=(~0xAA)) Halt("BAD MEMORY");
                            713 ;	genPointerGet
   033E 0A                  714 	ld	a,(bc)
                            715 ;	genCmpEq
                            716 ; genCmpEq: left 1, right 1, result 0
   033F 6F                  717 	ld	l,a
   0340 FE 55               718 	cp	a,#0x55
   0342 CA 4F 03            719 	jp	z,00119$
   0308                     720 00140$:
                            721 ;	genIpush
                            722 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   0345 C5                  723 	push	bc
   0346 21 9D 03            724 	ld	hl,#__str_15
   0349 E5                  725 	push	hl
                            726 ;	genCall
   034A CD 32 23            727 	call	_Halt
   034D F1                  728 	pop	af
   034E C1                  729 	pop	bc
                            730 ;	genLabel
   0312                     731 00119$:
                            732 ;main.c:143: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
                            733 ;	genPlus
                            734 ;	genPlusIncr
   034F 03                  735 	inc	bc
                            736 ;	genGoto
   0350 C3 35 03            737 	jp	00117$
                            738 ;	genLabel
   0316                     739 00120$:
                            740 ;main.c:146: PutString("MEMORY TEST COMPLETE", 3, 1);
                            741 ;	genIpush
                            742 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0353 21 03 01            743 	ld	hl,#0x0103
   0356 E5                  744 	push	hl
                            745 ;	genIpush
   0357 21 B9 03            746 	ld	hl,#__str_17
   035A E5                  747 	push	hl
                            748 ;	genCall
   035B CD F1 10            749 	call	_PutString
   035E F1                  750 	pop	af
   035F F1                  751 	pop	af
                            752 ;main.c:147: _SimUnprotect(0x4000, 0x5fff);
                            753 ;	genIpush
                            754 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0360 21 FF 5F            755 	ld	hl,#0x5FFF
   0363 E5                  756 	push	hl
                            757 ;	genIpush
   0364 21 00 40            758 	ld	hl,#0x4000
   0367 E5                  759 	push	hl
                            760 ;	genCall
   0368 CD 7C 2B            761 	call	__Z80SimUnprotect
   036B F1                  762 	pop	af
   036C F1                  763 	pop	af
                            764 ;main.c:148: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
                            765 ;	genAssign
   036D 01 00 40            766 	ld	bc,#0x4000
                            767 ;	genLabel
   0333                     768 00121$:
                            769 ;	genCmpLt
   0370 79                  770 	ld	a,c
   0371 D6 EA               771 	sub	a,#0xEA
   0373 78                  772 	ld	a,b
   0374 DE EE               773 	sbc	a,#0xEE
   0376 D2 80 03            774 	jp	nc,00124$
                            775 ;main.c:149: *i=0;
                            776 ;	genAssign (pointer)
                            777 ;	isBitvar = 0
   0379 3E 00               778 	ld	a,#0x00
   037B 02                  779 	ld	(bc),a
                            780 ;main.c:148: for(i=(char*)0x4000; i<(char*)0xEEEA; i++) {
                            781 ;	genPlus
                            782 ;	genPlusIncr
   037C 03                  783 	inc	bc
                            784 ;	genGoto
   037D C3 70 03            785 	jp	00121$
                            786 ;	genLabel
   0343                     787 00124$:
                            788 ;main.c:151: _SimPrintString("Memory test completed\n");
                            789 ;	genIpush
                            790 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0380 21 CE 03            791 	ld	hl,#__str_18
   0383 E5                  792 	push	hl
                            793 ;	genCall
   0384 CD CA 2A            794 	call	__Z80SimPrintString
   0387 F1                  795 	pop	af
                            796 ;	genLabel
   034B                     797 00125$:
                            798 ;	genEndFunction
   0388 3E 04               799 	ld	a,#4
   038A CF                  800 	rst	0x08
   038B C9                  801 	ret
   034F                     802 _TestMemory_end::
                    034F    803 Fmain$_str_14$0$0 == .
   034F                     804 __str_14:
   038C 54 45 53 54 49 4E   805 	.ascii "TESTING MEMORY A"
        47 20 4D 45 4D 4F
        52 59 20 41
   039C 00                  806 	.db 0x00
                    0360    807 Fmain$_str_15$0$0 == .
   0360                     808 __str_15:
   039D 42 41 44 20 4D 45   809 	.ascii "BAD MEMORY"
        4D 4F 52 59
   03A7 00                  810 	.db 0x00
                    036B    811 Fmain$_str_16$0$0 == .
   036B                     812 __str_16:
   03A8 54 45 53 54 49 4E   813 	.ascii "TESTING MEMORY B"
        47 20 4D 45 4D 4F
        52 59 20 42
   03B8 00                  814 	.db 0x00
                    037C    815 Fmain$_str_17$0$0 == .
   037C                     816 __str_17:
   03B9 4D 45 4D 4F 52 59   817 	.ascii "MEMORY TEST COMPLETE"
        20 54 45 53 54 20
        43 4F 4D 50 4C 45
        54 45
   03CD 00                  818 	.db 0x00
                    0391    819 Fmain$_str_18$0$0 == .
   0391                     820 __str_18:
   03CE 4D 65 6D 6F 72 79   821 	.ascii "Memory test completed"
        20 74 65 73 74 20
        63 6F 6D 70 6C 65
        74 65 64
   03E3 0A                  822 	.db 0x0A
   03E4 00                  823 	.db 0x00
                            824 	.area _CODE
