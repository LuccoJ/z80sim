                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.5 Fri Apr 27 12:30:18 2012
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module console
                              7 	.optsdcc -mz80
                              8 	
                              9 ;--------------------------------------------------------
                             10 ; Public variables in this module
                             11 ;--------------------------------------------------------
                             12 	.globl _ScrollUp
                             13 	.globl _CursorUndraw
                             14 	.globl _CursorDraw
                             15 	.globl _ConsoleInited
                             16 	.globl _ConsoleLock
                             17 	.globl _CursorColumn
                             18 	.globl _CursorRow
                             19 	.globl _Column
                             20 	.globl _Row
                             21 	.globl _SystemLock
                             22 	.globl _ConsoleInit
                             23 	.globl _ConsoleWrite
                             24 	.globl _ConsoleReadLine
                             25 ;--------------------------------------------------------
                             26 ;  ram data
                             27 ;--------------------------------------------------------
                             28 	.area _DATA
                    0000     29 G$SystemLock$0$0==.
   0000                      30 _SystemLock::
   0000                      31 	.ds 1
                    0001     32 G$Row$0$0==.
   0001                      33 _Row::
   0001                      34 	.ds 1
                    0002     35 G$Column$0$0==.
   0002                      36 _Column::
   0002                      37 	.ds 1
                    0003     38 G$CursorRow$0$0==.
   0003                      39 _CursorRow::
   0003                      40 	.ds 1
                    0004     41 G$CursorColumn$0$0==.
   0004                      42 _CursorColumn::
   0004                      43 	.ds 1
                    0005     44 G$ConsoleLock$0$0==.
   0005                      45 _ConsoleLock::
   0005                      46 	.ds 1
                    0006     47 G$ConsoleInited$0$0==.
   0006                      48 _ConsoleInited::
   0006                      49 	.ds 1
                             50 ;--------------------------------------------------------
                             51 ; overlayable items in  ram 
                             52 ;--------------------------------------------------------
                             53 	.area _OVERLAY
                             54 ;--------------------------------------------------------
                             55 ; external initialized ram data
                             56 ;--------------------------------------------------------
                             57 ;--------------------------------------------------------
                             58 ; global & static initialisations
                             59 ;--------------------------------------------------------
                             60 	.area _GSINIT
                             61 	.area _GSFINAL
                             62 	.area _GSINIT
                             63 ;--------------------------------------------------------
                             64 ; Home
                             65 ;--------------------------------------------------------
                             66 	.area _HOME
                             67 	.area _CODE
                             68 ;--------------------------------------------------------
                             69 ; code
                             70 ;--------------------------------------------------------
                             71 	.area _CODE
                             72 ;console.c:18: bool ConsoleInited; void ConsoleInit() {
                             73 ;	genLabel
                             74 ;	genFunction
                             75 ;	---------------------------------
                             76 ; Function ConsoleInit
                             77 ; ---------------------------------
   0000                      78 _ConsoleInit_start::
   0000                      79 _ConsoleInit:
   115F 3E 03                80 	ld	a,#3
   1161 CF                   81 	rst	0x08
                             82 ;console.c:19: if(!ConsoleInited) {
                             83 ;	genIfx
   1162 AF                   84 	xor	a,a
   1163 FD 21 0C 80          85 	ld	iy,#_ConsoleInited
   1167 FD B6 00             86 	or	a,0(iy)
   116A C2 D1 11             87 	jp	nz,00103$
                             88 ;console.c:20: LocksInit();
                             89 ;	genCall
                             90 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   116D CD F6 16             91 	call	_LocksInit
                             92 ;console.c:21: ScreenClear(0, 7);
                             93 ;	genIpush
                             94 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1170 21 00 07             95 	ld	hl,#0x0700
   1173 E5                   96 	push	hl
                             97 ;	genCall
   1174 CD 5B 07             98 	call	_ScreenClear
   1177 F1                   99 	pop	af
                            100 ;console.c:22: Row=0; Column=0;
                            101 ;	genAssign
   1178 FD 21 07 80         102 	ld	iy,#_Row
   117C FD 36 00 00         103 	ld	0(iy),#0x00
                            104 ;	genAssign
   1180 FD 21 08 80         105 	ld	iy,#_Column
   1184 FD 36 00 00         106 	ld	0(iy),#0x00
                            107 ;console.c:23: CursorRow=0; CursorColumn=0;
                            108 ;	genAssign
   1188 FD 21 09 80         109 	ld	iy,#_CursorRow
   118C FD 36 00 00         110 	ld	0(iy),#0x00
                            111 ;	genAssign
   1190 FD 21 0A 80         112 	ld	iy,#_CursorColumn
   1194 FD 36 00 00         113 	ld	0(iy),#0x00
                            114 ;console.c:24: ConsoleLock=LockCreate();
                            115 ;	genCall
                            116 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1198 CD 36 17            117 	call	_LockCreate
   119B 4D                  118 	ld	c,l
                            119 ;	genAssign
   119C FD 21 0B 80         120 	ld	iy,#_ConsoleLock
   11A0 FD 71 00            121 	ld	0(iy),c
                            122 ;console.c:25: ConsoleWrite("(C) 2003 LORENZO J. LUCCHINI\n\n\n");
                            123 ;	genIpush
                            124 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   11A3 21 D5 11            125 	ld	hl,#__str_0
   11A6 E5                  126 	push	hl
                            127 ;	genCall
   11A7 CD 84 14            128 	call	_ConsoleWrite
   11AA F1                  129 	pop	af
                            130 ;console.c:26: ConsoleInited=TRUE;
                            131 ;	genAssign
   11AB FD 21 0C 80         132 	ld	iy,#_ConsoleInited
   11AF FD 36 00 01         133 	ld	0(iy),#0x01
                            134 ;console.c:27: _SimPrintString("Console initialized, lock number ");
                            135 ;	genIpush
                            136 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   11B3 21 F5 11            137 	ld	hl,#__str_1
   11B6 E5                  138 	push	hl
                            139 ;	genCall
   11B7 CD CA 2A            140 	call	__Z80SimPrintString
   11BA F1                  141 	pop	af
                            142 ;console.c:28: _SimPrintWord((unsigned int)ConsoleLock);
                            143 ;	genCast
   11BB FD 21 0B 80         144 	ld	iy,#_ConsoleLock
   11BF FD 4E 00            145 	ld	c,0(iy)
   11C2 06 00               146 	ld	b,#0x00
                            147 ;	genIpush
                            148 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   11C4 C5                  149 	push	bc
                            150 ;	genCall
   11C5 CD F2 2A            151 	call	__Z80SimPrintWord
   11C8 F1                  152 	pop	af
                            153 ;console.c:29: _SimPrintString("\n");
                            154 ;	genIpush
                            155 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   11C9 21 17 12            156 	ld	hl,#__str_2
   11CC E5                  157 	push	hl
                            158 ;	genCall
   11CD CD CA 2A            159 	call	__Z80SimPrintString
   11D0 F1                  160 	pop	af
                            161 ;	genLabel
   0072                     162 00103$:
                            163 ;	genEndFunction
   11D1 3E 04               164 	ld	a,#4
   11D3 CF                  165 	rst	0x08
   11D4 C9                  166 	ret
   0076                     167 _ConsoleInit_end::
                    0076    168 Fconsole$_str_0$0$0 == .
   0076                     169 __str_0:
   11D5 28 43 29 20 32 30   170 	.ascii "(C) 2003 LORENZO J. LUCCHINI"
        30 33 20 4C 4F 52
        45 4E 5A 4F 20 4A
        2E 20 4C 55 43 43
        48 49 4E 49
   11F1 0A                  171 	.db 0x0A
   11F2 0A                  172 	.db 0x0A
   11F3 0A                  173 	.db 0x0A
   11F4 00                  174 	.db 0x00
                    0096    175 Fconsole$_str_1$0$0 == .
   0096                     176 __str_1:
   11F5 43 6F 6E 73 6F 6C   177 	.ascii "Console initialized, lock number "
        65 20 69 6E 69 74
        69 61 6C 69 7A 65
        64 2C 20 6C 6F 63
        6B 20 6E 75 6D 62
        65 72 20
   1216 00                  178 	.db 0x00
                    00B8    179 Fconsole$_str_2$0$0 == .
   00B8                     180 __str_2:
   1217 0A                  181 	.db 0x0A
   1218 00                  182 	.db 0x00
                            183 ;console.c:33: void CursorDraw(short Row, short Column) {
                            184 ;	genLabel
                            185 ;	genFunction
                            186 ;	---------------------------------
                            187 ; Function CursorDraw
                            188 ; ---------------------------------
   00BA                     189 _CursorDraw_start::
   00BA                     190 _CursorDraw:
   1219 3E 03               191 	ld	a,#3
   121B CF                  192 	rst	0x08
   121C DD E5               193 	push	ix
   121E DD 21 00 00         194 	ld	ix,#0
   1222 DD 39               195 	add	ix,sp
                            196 ;console.c:35: PutCharacter(' ', Row, Column);
                            197 ;	genIpush
                            198 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
                            199 ;	AOP_STK for 
   1224 DD 7E 05            200 	ld	a,5(ix)
   1227 F5                  201 	push	af
   1228 33                  202 	inc	sp
                            203 ;	genIpush
                            204 ;	AOP_STK for 
   1229 DD 7E 04            205 	ld	a,4(ix)
   122C F5                  206 	push	af
   122D 33                  207 	inc	sp
                            208 ;	genIpush
   122E 3E 20               209 	ld	a,#0x20
   1230 F5                  210 	push	af
   1231 33                  211 	inc	sp
                            212 ;	genCall
   1232 CD 1B 10            213 	call	_PutCharacter
   1235 F1                  214 	pop	af
   1236 33                  215 	inc	sp
                            216 ;console.c:36: SetAttrib((1<<7)|(1<<3)|(7<<0), Row, Column);
                            217 ;	genIpush
                            218 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
                            219 ;	AOP_STK for 
   1237 DD 7E 05            220 	ld	a,5(ix)
   123A F5                  221 	push	af
   123B 33                  222 	inc	sp
                            223 ;	genIpush
                            224 ;	AOP_STK for 
   123C DD 7E 04            225 	ld	a,4(ix)
   123F F5                  226 	push	af
   1240 33                  227 	inc	sp
                            228 ;	genIpush
   1241 3E 8F               229 	ld	a,#0x8F
   1243 F5                  230 	push	af
   1244 33                  231 	inc	sp
                            232 ;	genCall
   1245 CD D6 0F            233 	call	_SetAttrib
   1248 F1                  234 	pop	af
   1249 33                  235 	inc	sp
                            236 ;	genLabel
   00EB                     237 00101$:
                            238 ;	genEndFunction
   124A DD E1               239 	pop	ix
   124C 3E 04               240 	ld	a,#4
   124E CF                  241 	rst	0x08
   124F C9                  242 	ret
   00F1                     243 _CursorDraw_end::
                            244 ;console.c:39: void CursorUndraw() {
                            245 ;	genLabel
                            246 ;	genFunction
                            247 ;	---------------------------------
                            248 ; Function CursorUndraw
                            249 ; ---------------------------------
   00F1                     250 _CursorUndraw_start::
   00F1                     251 _CursorUndraw:
   1250 3E 03               252 	ld	a,#3
   1252 CF                  253 	rst	0x08
                            254 ;console.c:40: SetAttrib(0, CursorRow, CursorColumn);
                            255 ;	genIpush
                            256 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1253 3A 0A 80            257 	ld	a,(_CursorColumn)
   1256 F5                  258 	push	af
   1257 33                  259 	inc	sp
                            260 ;	genIpush
   1258 3A 09 80            261 	ld	a,(_CursorRow)
   125B F5                  262 	push	af
   125C 33                  263 	inc	sp
                            264 ;	genIpush
   125D 3E 00               265 	ld	a,#0x00
   125F F5                  266 	push	af
   1260 33                  267 	inc	sp
                            268 ;	genCall
   1261 CD D6 0F            269 	call	_SetAttrib
   1264 F1                  270 	pop	af
   1265 33                  271 	inc	sp
                            272 ;	genLabel
   0107                     273 00101$:
                            274 ;	genEndFunction
   1266 3E 04               275 	ld	a,#4
   1268 CF                  276 	rst	0x08
   1269 C9                  277 	ret
   010B                     278 _CursorUndraw_end::
                            279 ;console.c:229: void ScrollUp() {
                            280 ;	genLabel
                            281 ;	genFunction
                            282 ;	---------------------------------
                            283 ; Function ScrollUp
                            284 ; ---------------------------------
   010B                     285 _ScrollUp_start::
   010B                     286 _ScrollUp:
   126A 3E 03               287 	ld	a,#3
   126C CF                  288 	rst	0x08
   126D DD E5               289 	push	ix
   126F DD 21 00 00         290 	ld	ix,#0
   1273 DD 39               291 	add	ix,sp
   1275 21 E6 FF            292 	ld	hl,#-26
   1278 39                  293 	add	hl,sp
   1279 F9                  294 	ld	sp,hl
                            295 ;console.c:233: for(l=0; l<6114; l+=2048) {
                            296 ;	genAssign
                            297 ;	AOP_STK for _ScrollUp_l_1_1
   127A DD 36 FA 00         298 	ld	-6(ix),#0x00
   127E DD 36 FB 00         299 	ld	-5(ix),#0x00
                            300 ;	genLabel
   0123                     301 00121$:
                            302 ;	genCmpLt
                            303 ;	AOP_STK for _ScrollUp_l_1_1
   1282 DD 7E FA            304 	ld	a,-6(ix)
   1285 D6 E2               305 	sub	a,#0xE2
   1287 DD 7E FB            306 	ld	a,-5(ix)
   128A DE 17               307 	sbc	a,#0x17
   128C D2 7C 14            308 	jp	nc,00125$
                            309 ;console.c:234: for(k=0; k<224; k+=32) {
                            310 ;	genAssign
                            311 ;	AOP_STK for _ScrollUp_k_1_1
   128F DD 36 FC 00         312 	ld	-4(ix),#0x00
   1293 DD 36 FD 00         313 	ld	-3(ix),#0x00
                            314 ;	genLabel
   0138                     315 00109$:
                            316 ;	genCmpLt
                            317 ;	AOP_STK for _ScrollUp_k_1_1
   1297 DD 7E FC            318 	ld	a,-4(ix)
   129A D6 E0               319 	sub	a,#0xE0
   129C DD 7E FD            320 	ld	a,-3(ix)
   129F DE 00               321 	sbc	a,#0x00
   12A1 3E 00               322 	ld	a,#0x00
   12A3 17                  323 	rla
                            324 ;	genIfx
   12A4 B7                  325 	or	a,a
   12A5 CA 88 13            326 	jp	z,00137$
                            327 ;console.c:235: for(j=0; j<2048; j+=256) {
                            328 ;	genAssign
                            329 ;	AOP_STK for _ScrollUp_j_1_1
   12A8 DD 36 FE 00         330 	ld	-2(ix),#0x00
   12AC DD 36 FF 00         331 	ld	-1(ix),#0x00
                            332 ;	genLabel
   0151                     333 00105$:
                            334 ;	genCmpLt
                            335 ;	AOP_STK for _ScrollUp_j_1_1
   12B0 DD 7E FE            336 	ld	a,-2(ix)
   12B3 D6 00               337 	sub	a,#0x00
   12B5 DD 7E FF            338 	ld	a,-1(ix)
   12B8 DE 08               339 	sbc	a,#0x08
   12BA 3E 00               340 	ld	a,#0x00
   12BC 17                  341 	rla
                            342 ;	genIfx
   12BD B7                  343 	or	a,a
   12BE CA 75 13            344 	jp	z,00111$
                            345 ;console.c:236: Sum=j+k+l;
                            346 ;	genPlus
                            347 ;	AOP_STK for _ScrollUp_j_1_1
                            348 ;	AOP_STK for _ScrollUp_k_1_1
                            349 ;	AOP_STK for _ScrollUp__1_0
                            350 ;	Can't optimise plus by inc, falling back to the normal way
   12C1 DD 7E FE            351 	ld	a,-2(ix)
   12C4 DD 86 FC            352 	add	a,-4(ix)
   12C7 DD 77 F5            353 	ld	-11(ix),a
   12CA DD 7E FF            354 	ld	a,-1(ix)
   12CD DD 8E FD            355 	adc	a,-3(ix)
   12D0 DD 77 F6            356 	ld	-10(ix),a
                            357 ;	genPlus
                            358 ;	AOP_STK for _ScrollUp__1_0
                            359 ;	AOP_STK for _ScrollUp_l_1_1
                            360 ;	AOP_STK for _ScrollUp__1_0
                            361 ;	Can't optimise plus by inc, falling back to the normal way
   12D3 DD 7E F5            362 	ld	a,-11(ix)
   12D6 DD 86 FA            363 	add	a,-6(ix)
   12D9 DD 77 F3            364 	ld	-13(ix),a
   12DC DD 7E F6            365 	ld	a,-10(ix)
   12DF DD 8E FB            366 	adc	a,-5(ix)
   12E2 DD 77 F4            367 	ld	-12(ix),a
                            368 ;	genAssign
                            369 ;	AOP_STK for _ScrollUp__1_0
                            370 ;	AOP_STK for _ScrollUp_Sum_1_1
   12E5 DD 7E F3            371 	ld	a,-13(ix)
   12E8 DD 77 F7            372 	ld	-9(ix),a
   12EB DD 7E F4            373 	ld	a,-12(ix)
   12EE DD 77 F8            374 	ld	-8(ix),a
                            375 ;console.c:237: for(i=0; i<32; i++) {
                            376 ;	genAssign
                            377 ;	AOP_STK for _ScrollUp_i_1_1
   12F1 DD 36 F9 00         378 	ld	-7(ix),#0x00
                            379 ;	genLabel
   0196                     380 00101$:
                            381 ;	genCmpLt
                            382 ;	AOP_STK for _ScrollUp_i_1_1
   12F5 DD 7E F9            383 	ld	a,-7(ix)
   12F8 D6 20               384 	sub	a,#0x20
   12FA 3E 00               385 	ld	a,#0x00
   12FC 17                  386 	rla
                            387 ;	genIfx
   12FD B7                  388 	or	a,a
   12FE CA 62 13            389 	jp	z,00107$
                            390 ;console.c:238: ScreenMemory[i+Sum]=ScreenMemory[32+i+Sum];
                            391 ;	genCast
                            392 ;	AOP_STK for _ScrollUp_i_1_1
                            393 ;	AOP_STK for _ScrollUp__1_0
   1301 DD 7E F9            394 	ld	a,-7(ix)
   1304 DD 77 F1            395 	ld	-15(ix),a
   1307 DD 36 F2 00         396 	ld	-14(ix),#0x00
                            397 ;	genPlus
                            398 ;	AOP_STK for _ScrollUp__1_0
                            399 ;	AOP_STK for _ScrollUp_Sum_1_1
                            400 ;	AOP_STK for _ScrollUp__1_0
                            401 ;	Can't optimise plus by inc, falling back to the normal way
   130B DD 7E F1            402 	ld	a,-15(ix)
   130E DD 86 F7            403 	add	a,-9(ix)
   1311 DD 77 ED            404 	ld	-19(ix),a
   1314 DD 7E F2            405 	ld	a,-14(ix)
   1317 DD 8E F8            406 	adc	a,-8(ix)
   131A DD 77 EE            407 	ld	-18(ix),a
                            408 ;	genPlus
                            409 ;	AOP_STK for _ScrollUp__1_0
                            410 ;	AOP_STK for _ScrollUp__1_0
                            411 ;	genPlusIncr
                            412 ;	Can't optimise plus by inc, falling back to the normal way
   131D DD 7E ED            413 	ld	a,-19(ix)
   1320 C6 00               414 	add	a,#0x00
   1322 DD 77 EF            415 	ld	-17(ix),a
   1325 DD 7E EE            416 	ld	a,-18(ix)
   1328 CE 40               417 	adc	a,#0x40
   132A DD 77 F0            418 	ld	-16(ix),a
                            419 ;	genPlus
                            420 ;	AOP_STK for _ScrollUp_i_1_1
                            421 ;	AOP_STK for _ScrollUp__1_0
                            422 ;	genPlusIncr
                            423 ;	Can't optimise plus by inc, falling back to the normal way
   132D DD 7E F9            424 	ld	a,-7(ix)
   1330 C6 20               425 	add	a,#0x20
                            426 ;	genCast
                            427 ;	AOP_STK for _ScrollUp__1_0
                            428 ;	AOP_STK for _ScrollUp__1_0
   1332 DD 77 EC            429 	ld	-20(ix),a
   1335 DD 77 EA            430 	ld	-22(ix),a
   1338 DD 36 EB 00         431 	ld	-21(ix),#0x00
                            432 ;	genPlus
                            433 ;	AOP_STK for _ScrollUp__1_0
                            434 ;	AOP_STK for _ScrollUp_Sum_1_1
                            435 ;	Can't optimise plus by inc, falling back to the normal way
   133C DD 7E EA            436 	ld	a,-22(ix)
   133F DD 86 F7            437 	add	a,-9(ix)
   1342 57                  438 	ld	d,a
   1343 DD 7E EB            439 	ld	a,-21(ix)
   1346 DD 8E F8            440 	adc	a,-8(ix)
   1349 47                  441 	ld	b,a
                            442 ;	genPlus
                            443 ;	genPlusIncr
                            444 ;	Can't optimise plus by inc, falling back to the normal way
   134A 7A                  445 	ld	a,d
   134B C6 00               446 	add	a,#0x00
   134D 4F                  447 	ld	c,a
   134E 78                  448 	ld	a,b
   134F CE 40               449 	adc	a,#0x40
   1351 5F                  450 	ld	e,a
                            451 ;	genPointerGet
   1352 69                  452 	ld	l,c
   1353 63                  453 	ld	h,e
   1354 7E                  454 	ld	a,(hl)
                            455 ;	genAssign (pointer)
                            456 ;	AOP_STK for _ScrollUp__1_0
                            457 ;	isBitvar = 0
   1355 DD 6E EF            458 	ld	l,-17(ix)
   1358 DD 66 F0            459 	ld	h,-16(ix)
   135B 77                  460 	ld	(hl),a
                            461 ;console.c:237: for(i=0; i<32; i++) {
                            462 ;	genPlus
                            463 ;	AOP_STK for _ScrollUp_i_1_1
                            464 ;	genPlusIncr
   135C DD 34 F9            465 	inc	-7(ix)
                            466 ;	genGoto
   135F C3 F5 12            467 	jp	00101$
                            468 ;	genLabel
   0203                     469 00107$:
                            470 ;console.c:235: for(j=0; j<2048; j+=256) {
                            471 ;	genPlus
                            472 ;	AOP_STK for _ScrollUp_j_1_1
                            473 ;	genPlusIncr
                            474 ;	Can't optimise plus by inc, falling back to the normal way
   1362 DD 7E FE            475 	ld	a,-2(ix)
   1365 C6 00               476 	add	a,#0x00
   1367 DD 77 FE            477 	ld	-2(ix),a
   136A DD 7E FF            478 	ld	a,-1(ix)
   136D CE 01               479 	adc	a,#0x01
   136F DD 77 FF            480 	ld	-1(ix),a
                            481 ;	genGoto
   1372 C3 B0 12            482 	jp	00105$
                            483 ;	genLabel
   0216                     484 00111$:
                            485 ;console.c:234: for(k=0; k<224; k+=32) {
                            486 ;	genPlus
                            487 ;	AOP_STK for _ScrollUp_k_1_1
                            488 ;	genPlusIncr
                            489 ;	Can't optimise plus by inc, falling back to the normal way
   1375 DD 7E FC            490 	ld	a,-4(ix)
   1378 C6 20               491 	add	a,#0x20
   137A DD 77 FC            492 	ld	-4(ix),a
   137D DD 7E FD            493 	ld	a,-3(ix)
   1380 CE 00               494 	adc	a,#0x00
   1382 DD 77 FD            495 	ld	-3(ix),a
                            496 ;	genGoto
   1385 C3 97 12            497 	jp	00109$
                            498 ;console.c:242: for(j=0; j<2048; j+=256) {
                            499 ;	genLabel
   0229                     500 00137$:
                            501 ;	genAssign
                            502 ;	AOP_STK for _ScrollUp_j_1_1
   1388 DD 36 FE 00         503 	ld	-2(ix),#0x00
   138C DD 36 FF 00         504 	ld	-1(ix),#0x00
                            505 ;	genLabel
   0231                     506 00117$:
                            507 ;	genCmpLt
                            508 ;	AOP_STK for _ScrollUp_j_1_1
   1390 DD 7E FE            509 	ld	a,-2(ix)
   1393 D6 00               510 	sub	a,#0x00
   1395 DD 7E FF            511 	ld	a,-1(ix)
   1398 DE 08               512 	sbc	a,#0x08
   139A 3E 00               513 	ld	a,#0x00
   139C 17                  514 	rla
                            515 ;	genIfx
   139D B7                  516 	or	a,a
   139E CA 69 14            517 	jp	z,00123$
                            518 ;console.c:243: for(i=0; i<32; i++) {
                            519 ;	genAssign
                            520 ;	AOP_STK for _ScrollUp_i_1_1
   13A1 DD 36 F9 00         521 	ld	-7(ix),#0x00
                            522 ;	genLabel
   0246                     523 00113$:
                            524 ;	genCmpLt
                            525 ;	AOP_STK for _ScrollUp_i_1_1
   13A5 DD 7E F9            526 	ld	a,-7(ix)
   13A8 D6 20               527 	sub	a,#0x20
   13AA 3E 00               528 	ld	a,#0x00
   13AC 17                  529 	rla
                            530 ;	genIfx
   13AD B7                  531 	or	a,a
   13AE CA 56 14            532 	jp	z,00119$
                            533 ;console.c:244: ScreenMemory[i+j+224+l]=ScreenMemory[32+i+j+0+l+2048];
                            534 ;	genCast
                            535 ;	AOP_STK for _ScrollUp_i_1_1
                            536 ;	AOP_STK for _ScrollUp__1_0
   13B1 DD 7E F9            537 	ld	a,-7(ix)
   13B4 DD 77 EA            538 	ld	-22(ix),a
   13B7 DD 36 EB 00         539 	ld	-21(ix),#0x00
                            540 ;	genPlus
                            541 ;	AOP_STK for _ScrollUp__1_0
                            542 ;	AOP_STK for _ScrollUp_j_1_1
                            543 ;	AOP_STK for _ScrollUp__1_0
                            544 ;	Can't optimise plus by inc, falling back to the normal way
   13BB DD 7E EA            545 	ld	a,-22(ix)
   13BE DD 86 FE            546 	add	a,-2(ix)
   13C1 DD 77 ED            547 	ld	-19(ix),a
   13C4 DD 7E EB            548 	ld	a,-21(ix)
   13C7 DD 8E FF            549 	adc	a,-1(ix)
   13CA DD 77 EE            550 	ld	-18(ix),a
                            551 ;	genPlus
                            552 ;	AOP_STK for _ScrollUp__1_0
                            553 ;	AOP_STK for _ScrollUp__1_0
                            554 ;	genPlusIncr
                            555 ;	Can't optimise plus by inc, falling back to the normal way
   13CD DD 7E ED            556 	ld	a,-19(ix)
   13D0 C6 E0               557 	add	a,#0xE0
   13D2 DD 77 EF            558 	ld	-17(ix),a
   13D5 DD 7E EE            559 	ld	a,-18(ix)
   13D8 CE 00               560 	adc	a,#0x00
   13DA DD 77 F0            561 	ld	-16(ix),a
                            562 ;	genPlus
                            563 ;	AOP_STK for _ScrollUp__1_0
                            564 ;	AOP_STK for _ScrollUp_l_1_1
                            565 ;	AOP_STK for _ScrollUp__1_0
                            566 ;	Can't optimise plus by inc, falling back to the normal way
   13DD DD 7E EF            567 	ld	a,-17(ix)
   13E0 DD 86 FA            568 	add	a,-6(ix)
   13E3 DD 77 F3            569 	ld	-13(ix),a
   13E6 DD 7E F0            570 	ld	a,-16(ix)
   13E9 DD 8E FB            571 	adc	a,-5(ix)
   13EC DD 77 F4            572 	ld	-12(ix),a
                            573 ;	genPlus
                            574 ;	AOP_STK for _ScrollUp__1_0
                            575 ;	AOP_STK for _ScrollUp__1_0
                            576 ;	genPlusIncr
                            577 ;	Can't optimise plus by inc, falling back to the normal way
   13EF DD 7E F3            578 	ld	a,-13(ix)
   13F2 C6 00               579 	add	a,#0x00
   13F4 DD 77 F1            580 	ld	-15(ix),a
   13F7 DD 7E F4            581 	ld	a,-12(ix)
   13FA CE 40               582 	adc	a,#0x40
   13FC DD 77 F2            583 	ld	-14(ix),a
                            584 ;	genPlus
                            585 ;	AOP_STK for _ScrollUp_i_1_1
                            586 ;	AOP_STK for _ScrollUp__1_0
                            587 ;	genPlusIncr
                            588 ;	Can't optimise plus by inc, falling back to the normal way
   13FF DD 7E F9            589 	ld	a,-7(ix)
   1402 C6 20               590 	add	a,#0x20
                            591 ;	genCast
                            592 ;	AOP_STK for _ScrollUp__1_0
                            593 ;	AOP_STK for _ScrollUp__1_0
   1404 DD 77 EC            594 	ld	-20(ix),a
   1407 DD 77 F5            595 	ld	-11(ix),a
   140A DD 36 F6 00         596 	ld	-10(ix),#0x00
                            597 ;	genPlus
                            598 ;	AOP_STK for _ScrollUp__1_0
                            599 ;	AOP_STK for _ScrollUp_j_1_1
                            600 ;	AOP_STK for _ScrollUp__1_0
                            601 ;	Can't optimise plus by inc, falling back to the normal way
   140E DD 7E F5            602 	ld	a,-11(ix)
   1411 DD 86 FE            603 	add	a,-2(ix)
   1414 DD 77 E8            604 	ld	-24(ix),a
   1417 DD 7E F6            605 	ld	a,-10(ix)
   141A DD 8E FF            606 	adc	a,-1(ix)
   141D DD 77 E9            607 	ld	-23(ix),a
                            608 ;	genPlus
                            609 ;	AOP_STK for _ScrollUp__1_0
                            610 ;	AOP_STK for _ScrollUp_l_1_1
                            611 ;	AOP_STK for _ScrollUp__1_0
                            612 ;	Can't optimise plus by inc, falling back to the normal way
   1420 DD 7E E8            613 	ld	a,-24(ix)
   1423 DD 86 FA            614 	add	a,-6(ix)
   1426 DD 77 E6            615 	ld	-26(ix),a
   1429 DD 7E E9            616 	ld	a,-23(ix)
   142C DD 8E FB            617 	adc	a,-5(ix)
   142F DD 77 E7            618 	ld	-25(ix),a
                            619 ;	genPlus
                            620 ;	AOP_STK for _ScrollUp__1_0
                            621 ;	genPlusIncr
                            622 ;	Can't optimise plus by inc, falling back to the normal way
   1432 DD 7E E6            623 	ld	a,-26(ix)
   1435 C6 00               624 	add	a,#0x00
   1437 4F                  625 	ld	c,a
   1438 DD 7E E7            626 	ld	a,-25(ix)
   143B CE 08               627 	adc	a,#0x08
   143D 5F                  628 	ld	e,a
                            629 ;	genPlus
                            630 ;	genPlusIncr
                            631 ;	Can't optimise plus by inc, falling back to the normal way
   143E 79                  632 	ld	a,c
   143F C6 00               633 	add	a,#0x00
   1441 47                  634 	ld	b,a
   1442 7B                  635 	ld	a,e
   1443 CE 40               636 	adc	a,#0x40
   1445 57                  637 	ld	d,a
                            638 ;	genPointerGet
   1446 68                  639 	ld	l,b
   1447 62                  640 	ld	h,d
   1448 7E                  641 	ld	a,(hl)
                            642 ;	genAssign (pointer)
                            643 ;	AOP_STK for _ScrollUp__1_0
                            644 ;	isBitvar = 0
   1449 DD 6E F1            645 	ld	l,-15(ix)
   144C DD 66 F2            646 	ld	h,-14(ix)
   144F 77                  647 	ld	(hl),a
                            648 ;console.c:243: for(i=0; i<32; i++) {
                            649 ;	genPlus
                            650 ;	AOP_STK for _ScrollUp_i_1_1
                            651 ;	genPlusIncr
   1450 DD 34 F9            652 	inc	-7(ix)
                            653 ;	genGoto
   1453 C3 A5 13            654 	jp	00113$
                            655 ;	genLabel
   02F7                     656 00119$:
                            657 ;console.c:242: for(j=0; j<2048; j+=256) {
                            658 ;	genPlus
                            659 ;	AOP_STK for _ScrollUp_j_1_1
                            660 ;	genPlusIncr
                            661 ;	Can't optimise plus by inc, falling back to the normal way
   1456 DD 7E FE            662 	ld	a,-2(ix)
   1459 C6 00               663 	add	a,#0x00
   145B DD 77 FE            664 	ld	-2(ix),a
   145E DD 7E FF            665 	ld	a,-1(ix)
   1461 CE 01               666 	adc	a,#0x01
   1463 DD 77 FF            667 	ld	-1(ix),a
                            668 ;	genGoto
   1466 C3 90 13            669 	jp	00117$
                            670 ;	genLabel
   030A                     671 00123$:
                            672 ;console.c:233: for(l=0; l<6114; l+=2048) {
                            673 ;	genPlus
                            674 ;	AOP_STK for _ScrollUp_l_1_1
                            675 ;	genPlusIncr
                            676 ;	Can't optimise plus by inc, falling back to the normal way
   1469 DD 7E FA            677 	ld	a,-6(ix)
   146C C6 00               678 	add	a,#0x00
   146E DD 77 FA            679 	ld	-6(ix),a
   1471 DD 7E FB            680 	ld	a,-5(ix)
   1474 CE 08               681 	adc	a,#0x08
   1476 DD 77 FB            682 	ld	-5(ix),a
                            683 ;	genGoto
   1479 C3 82 12            684 	jp	00121$
                            685 ;	genLabel
   031D                     686 00125$:
                            687 ;	genEndFunction
   147C DD F9               688 	ld	sp,ix
   147E DD E1               689 	pop	ix
   1480 3E 04               690 	ld	a,#4
   1482 CF                  691 	rst	0x08
   1483 C9                  692 	ret
   0325                     693 _ScrollUp_end::
                            694 ;console.c:250: void ConsoleWrite(char* String) {
                            695 ;	genLabel
                            696 ;	genFunction
                            697 ;	---------------------------------
                            698 ; Function ConsoleWrite
                            699 ; ---------------------------------
   0325                     700 _ConsoleWrite_start::
   0325                     701 _ConsoleWrite:
   1484 3E 03               702 	ld	a,#3
   1486 CF                  703 	rst	0x08
   1487 DD E5               704 	push	ix
   1489 DD 21 00 00         705 	ld	ix,#0
   148D DD 39               706 	add	ix,sp
   148F 21 FE FF            707 	ld	hl,#-2
   1492 39                  708 	add	hl,sp
   1493 F9                  709 	ld	sp,hl
                            710 ;console.c:253: LockObtain(ConsoleLock);
                            711 ;	genIpush
                            712 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1494 3A 0B 80            713 	ld	a,(_ConsoleLock)
   1497 F5                  714 	push	af
   1498 33                  715 	inc	sp
                            716 ;	genCall
   1499 CD 5B 17            717 	call	_LockObtain
   149C 33                  718 	inc	sp
                            719 ;console.c:255: Length=StringLength(String);
                            720 ;	genIpush
                            721 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
                            722 ;	AOP_STK for 
   149D DD 6E 04            723 	ld	l,4(ix)
   14A0 DD 66 05            724 	ld	h,5(ix)
   14A3 E5                  725 	push	hl
                            726 ;	genCall
   14A4 CD 06 04            727 	call	_StringLength
   14A7 F1                  728 	pop	af
                            729 ;	genAssign
                            730 ;	AOP_STK for _ConsoleWrite_Length_1_1
   14A8 DD 75 FE            731 	ld	-2(ix),l
   14AB DD 74 FF            732 	ld	-1(ix),h
                            733 ;console.c:256: for(i=0; i<Length; i++) {
                            734 ;	genAssign
   14AE 11 00 00            735 	ld	de,#0x0000
                            736 ;	genLabel
   0352                     737 00109$:
                            738 ;	genCmpLt
                            739 ;	AOP_STK for _ConsoleWrite_Length_1_1
   14B1 7B                  740 	ld	a,e
   14B2 DD 96 FE            741 	sub	a,-2(ix)
   14B5 7A                  742 	ld	a,d
   14B6 DD 9E FF            743 	sbc	a,-1(ix)
   14B9 F2 34 15            744 	jp	p,00112$
                            745 ;console.c:257: if(Row>23) {
                            746 ;	genCmpGt
   14BC 3E 17               747 	ld	a,#0x17
   14BE FD 21 07 80         748 	ld	iy,#_Row
   14C2 FD 96 00            749 	sub	a,0(iy)
   14C5 F2 D1 14            750 	jp	p,00102$
                            751 ;console.c:258: Row=23;
                            752 ;	genAssign
   14C8 FD 36 00 17         753 	ld	0(iy),#0x17
                            754 ;console.c:259: ScrollUp();
                            755 ;	genCall
                            756 ; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
   14CC D5                  757 	push	de
   14CD CD 6A 12            758 	call	_ScrollUp
   14D0 D1                  759 	pop	de
                            760 ;	genLabel
   0372                     761 00102$:
                            762 ;console.c:261: if(String[i]=='\n') {
                            763 ;	genPlus
                            764 ;	AOP_STK for 
                            765 ;	Can't optimise plus by inc, falling back to the normal way
   14D1 DD 6E 04            766 	ld	l,4(ix)
   14D4 DD 66 05            767 	ld	h,5(ix)
   14D7 19                  768 	add	hl,de
                            769 ;	genPointerGet
   14D8 4E                  770 	ld	c,(hl)
                            771 ;	genCmpEq
                            772 ; genCmpEq: left 1, right 1, result 0
   14D9 79                  773 	ld	a,c
   14DA FE 0A               774 	cp	a,#0x0A
   14DC CA E2 14            775 	jp	z,00121$
   0380                     776 00120$:
   14DF C3 F4 14            777 	jp	00107$
   0383                     778 00121$:
                            779 ;console.c:262: Row++;
                            780 ;	genPlus
                            781 ;	genPlusIncr
   14E2 FD 21 07 80         782 	ld	iy,#_Row
   14E6 FD 34 00            783 	inc	0(iy)
                            784 ;console.c:263: Column=0;
                            785 ;	genAssign
   14E9 FD 21 08 80         786 	ld	iy,#_Column
   14ED FD 36 00 00         787 	ld	0(iy),#0x00
                            788 ;	genGoto
   14F1 C3 30 15            789 	jp	00111$
                            790 ;	genLabel
   0395                     791 00107$:
                            792 ;console.c:265: PutCharacter(String[i], Row, Column);
                            793 ;	genIpush
                            794 ; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
   14F4 D5                  795 	push	de
   14F5 3A 08 80            796 	ld	a,(_Column)
   14F8 F5                  797 	push	af
   14F9 33                  798 	inc	sp
                            799 ;	genIpush
   14FA 3A 07 80            800 	ld	a,(_Row)
   14FD F5                  801 	push	af
   14FE 33                  802 	inc	sp
                            803 ;	genIpush
   14FF 79                  804 	ld	a,c
   1500 F5                  805 	push	af
   1501 33                  806 	inc	sp
                            807 ;	genCall
   1502 CD 1B 10            808 	call	_PutCharacter
   1505 F1                  809 	pop	af
   1506 33                  810 	inc	sp
   1507 D1                  811 	pop	de
                            812 ;console.c:266: if(Column==31) {
                            813 ;	genCmpEq
                            814 ; genCmpEq: left 1, right 1, result 0
   1508 FD 21 08 80         815 	ld	iy,#_Column
   150C FD 7E 00            816 	ld	a,0(iy)
   150F FE 1F               817 	cp	a,#0x1F
   1511 CA 17 15            818 	jp	z,00123$
   03B5                     819 00122$:
   1514 C3 29 15            820 	jp	00104$
   03B8                     821 00123$:
                            822 ;console.c:267: Row++;
                            823 ;	genPlus
                            824 ;	genPlusIncr
   1517 FD 21 07 80         825 	ld	iy,#_Row
   151B FD 34 00            826 	inc	0(iy)
                            827 ;console.c:268: Column=0;
                            828 ;	genAssign
   151E FD 21 08 80         829 	ld	iy,#_Column
   1522 FD 36 00 00         830 	ld	0(iy),#0x00
                            831 ;	genGoto
   1526 C3 30 15            832 	jp	00111$
                            833 ;	genLabel
   03CA                     834 00104$:
                            835 ;console.c:269: } else Column++;
                            836 ;	genPlus
                            837 ;	genPlusIncr
   1529 FD 21 08 80         838 	ld	iy,#_Column
   152D FD 34 00            839 	inc	0(iy)
                            840 ;	genLabel
   03D1                     841 00111$:
                            842 ;console.c:256: for(i=0; i<Length; i++) {
                            843 ;	genPlus
                            844 ;	genPlusIncr
   1530 13                  845 	inc	de
                            846 ;	genGoto
   1531 C3 B1 14            847 	jp	00109$
                            848 ;	genLabel
   03D5                     849 00112$:
                            850 ;console.c:273: LockRelease(ConsoleLock);
                            851 ;	genIpush
                            852 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1534 3A 0B 80            853 	ld	a,(_ConsoleLock)
   1537 F5                  854 	push	af
   1538 33                  855 	inc	sp
                            856 ;	genCall
   1539 CD CE 17            857 	call	_LockRelease
   153C 33                  858 	inc	sp
                            859 ;console.c:274: _SimPrintString(String);
                            860 ;	genIpush
                            861 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
                            862 ;	AOP_STK for 
   153D DD 6E 04            863 	ld	l,4(ix)
   1540 DD 66 05            864 	ld	h,5(ix)
   1543 E5                  865 	push	hl
                            866 ;	genCall
   1544 CD CA 2A            867 	call	__Z80SimPrintString
   1547 F1                  868 	pop	af
                            869 ;	genLabel
   03E9                     870 00113$:
                            871 ;	genEndFunction
   1548 DD F9               872 	ld	sp,ix
   154A DD E1               873 	pop	ix
   154C 3E 04               874 	ld	a,#4
   154E CF                  875 	rst	0x08
   154F C9                  876 	ret
   03F1                     877 _ConsoleWrite_end::
                            878 ;console.c:277: unsigned short ConsoleReadLine(char* String) {
                            879 ;	genLabel
                            880 ;	genFunction
                            881 ;	---------------------------------
                            882 ; Function ConsoleReadLine
                            883 ; ---------------------------------
   03F1                     884 _ConsoleReadLine_start::
   03F1                     885 _ConsoleReadLine:
   1550 3E 03               886 	ld	a,#3
   1552 CF                  887 	rst	0x08
   1553 DD E5               888 	push	ix
   1555 DD 21 00 00         889 	ld	ix,#0
   1559 DD 39               890 	add	ix,sp
   155B 21 FC FF            891 	ld	hl,#-4
   155E 39                  892 	add	hl,sp
   155F F9                  893 	ld	sp,hl
                            894 ;console.c:280: Character[1]='\0';
                            895 ;	genAddrOf
                            896 ;	AOP_STK for _ConsoleReadLine__1_0
   1560 21 02 00            897 	ld	hl,#0x0002
   1563 39                  898 	add	hl,sp
                            899 ;	genPlus
                            900 ;	AOP_STK for _ConsoleReadLine__1_0
                            901 ;	genPlusIncr
   1564 DD 75 FC            902 	ld	-4(ix),l
   1567 DD 74 FD            903 	ld	-3(ix),h
   156A 23                  904 	inc	hl
                            905 ;	genAssign (pointer)
                            906 ;	isBitvar = 0
   156B 36 00               907 	ld	(hl),#0x00
                            908 ;console.c:282: ConsoleWrite("#");
                            909 ;	genIpush
                            910 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   156D 21 E0 15            911 	ld	hl,#__str_3
   1570 E5                  912 	push	hl
                            913 ;	genCall
   1571 CD 84 14            914 	call	_ConsoleWrite
   1574 F1                  915 	pop	af
                            916 ;console.c:283: do {
                            917 ;	genAssign
   1575 1E 00               918 	ld	e,#0x00
                            919 ;	genLabel
   0418                     920 00104$:
                            921 ;console.c:284: Character[0]=GetKeypress();
                            922 ;	genCall
                            923 ; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
   1577 D5                  924 	push	de
   1578 CD 13 28            925 	call	_GetKeypress
   157B 7D                  926 	ld	a,l
   157C D1                  927 	pop	de
   157D 57                  928 	ld	d,a
                            929 ;	genAssign (pointer)
                            930 ;	AOP_STK for _ConsoleReadLine__1_0
                            931 ;	isBitvar = 0
   157E DD 6E FC            932 	ld	l,-4(ix)
   1581 DD 66 FD            933 	ld	h,-3(ix)
   1584 72                  934 	ld	(hl),d
                            935 ;console.c:285: if(Character[0]!='\0') {
                            936 ;	genCmpEq
                            937 ; genCmpEq: left 1, right 1, result 0
   1585 7A                  938 	ld	a,d
   1586 B7                  939 	or	a,a
   1587 CA AD 15            940 	jp	z,00105$
   042B                     941 00112$:
                            942 ;console.c:286: ConsoleWrite(Character);
                            943 ;	genIpush
                            944 ; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
   158A D5                  945 	push	de
                            946 ;	AOP_STK for _ConsoleReadLine__1_0
   158B DD 6E FC            947 	ld	l,-4(ix)
   158E DD 66 FD            948 	ld	h,-3(ix)
   1591 E5                  949 	push	hl
                            950 ;	genCall
   1592 CD 84 14            951 	call	_ConsoleWrite
   1595 F1                  952 	pop	af
   1596 D1                  953 	pop	de
                            954 ;console.c:287: String[i]=Character[0];
                            955 ;	genPlus
                            956 ;	AOP_STK for 
                            957 ;	Can't optimise plus by inc, falling back to the normal way
   1597 DD 7E 04            958 	ld	a,4(ix)
   159A 83                  959 	add	a,e
   159B 57                  960 	ld	d,a
   159C DD 7E 05            961 	ld	a,5(ix)
   159F CE 00               962 	adc	a,#0x00
   15A1 4F                  963 	ld	c,a
                            964 ;	genPointerGet
                            965 ;	AOP_STK for _ConsoleReadLine__1_0
   15A2 DD 6E FC            966 	ld	l,-4(ix)
   15A5 DD 66 FD            967 	ld	h,-3(ix)
   15A8 7E                  968 	ld	a,(hl)
                            969 ;	genAssign (pointer)
                            970 ;	isBitvar = 0
   15A9 6A                  971 	ld	l,d
   15AA 61                  972 	ld	h,c
   15AB 77                  973 	ld	(hl),a
                            974 ;console.c:288: i++;
                            975 ;	genPlus
                            976 ;	genPlusIncr
                            977 ; Removed redundent load
   15AC 1C                  978 	inc	e
                            979 ;	genLabel
   044E                     980 00105$:
                            981 ;console.c:290: } while(Character[0]!='\n' && i<256);
                            982 ;	genPointerGet
                            983 ;	AOP_STK for _ConsoleReadLine__1_0
   15AD DD 6E FC            984 	ld	l,-4(ix)
   15B0 DD 66 FD            985 	ld	h,-3(ix)
   15B3 6E                  986 	ld	l,(hl)
                            987 ;	genCmpEq
                            988 ; genCmpEq: left 1, right 1, result 0
   15B4 7D                  989 	ld	a,l
   15B5 FE 0A               990 	cp	a,#0x0A
   15B7 CA C6 15            991 	jp	z,00106$
   045B                     992 00113$:
                            993 ;	genCast
   15BA 6B                  994 	ld	l,e
   15BB 26 00               995 	ld	h,#0x00
                            996 ;	genCmpLt
   15BD 7D                  997 	ld	a,l
   15BE D6 00               998 	sub	a,#0x00
   15C0 7C                  999 	ld	a,h
   15C1 DE 01              1000 	sbc	a,#0x01
   15C3 DA 77 15           1001 	jp	c,00104$
                           1002 ;	genLabel
   0467                    1003 00106$:
                           1004 ;console.c:291: String[i-1]='\0';
                           1005 ;	genMinus
   15C6 7B                 1006 	ld	a,e
   15C7 C6 FF              1007 	add	a,#0xFF
   15C9 6F                 1008 	ld	l,a
                           1009 ;	genPlus
                           1010 ;	AOP_STK for 
                           1011 ;	Can't optimise plus by inc, falling back to the normal way
   15CA DD 7E 04           1012 	ld	a,4(ix)
   15CD 85                 1013 	add	a,l
   15CE 6F                 1014 	ld	l,a
   15CF DD 7E 05           1015 	ld	a,5(ix)
   15D2 CE 00              1016 	adc	a,#0x00
   15D4 67                 1017 	ld	h,a
                           1018 ;	genAssign (pointer)
                           1019 ;	isBitvar = 0
   15D5 36 00              1020 	ld	(hl),#0x00
                           1021 ;console.c:292: return i;
                           1022 ;	genRet
                           1023 ; Dump of IC_LEFT: type AOP_REG size 1
                           1024 ;	 reg = e
   15D7 6B                 1025 	ld	l,e
                           1026 ;	genLabel
   0479                    1027 00107$:
                           1028 ;	genEndFunction
   15D8 DD F9              1029 	ld	sp,ix
   15DA DD E1              1030 	pop	ix
   15DC 3E 04              1031 	ld	a,#4
   15DE CF                 1032 	rst	0x08
   15DF C9                 1033 	ret
   0481                    1034 _ConsoleReadLine_end::
                    0481   1035 Fconsole$_str_3$0$0 == .
   0481                    1036 __str_3:
   15E0 23                 1037 	.ascii "#"
   15E1 00                 1038 	.db 0x00
                           1039 	.area _CODE
