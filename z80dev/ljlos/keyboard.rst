                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.5 Fri Apr 27 12:30:19 2012
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module keyboard
                              7 	.optsdcc -mz80
                              8 	
                              9 ;--------------------------------------------------------
                             10 ; Public variables in this module
                             11 ;--------------------------------------------------------
                             12 	.globl _KeyboardInited
                             13 	.globl _KeyboardPollCount
                             14 	.globl _KeyboardBufferCount
                             15 	.globl _KeyboardBuffer
                             16 	.globl _KeyTable
                             17 	.globl _SystemLock
                             18 	.globl _KeyboardInit
                             19 	.globl _PollKeyboard
                             20 	.globl _GetKeypress
                             21 ;--------------------------------------------------------
                             22 ;  ram data
                             23 ;--------------------------------------------------------
                             24 	.area _DATA
                    0000     25 G$SystemLock$0$0==.
   0000                      26 _SystemLock::
   0000                      27 	.ds 1
                    0001     28 G$KeyTable$0$0==.
   0001                      29 _KeyTable::
   0001                      30 	.ds 8
                    0009     31 G$KeyboardBuffer$0$0==.
   0009                      32 _KeyboardBuffer::
   0009                      33 	.ds 32
                    0029     34 G$KeyboardBufferCount$0$0==.
   0029                      35 _KeyboardBufferCount::
   0029                      36 	.ds 1
                    002A     37 G$KeyboardPollCount$0$0==.
   002A                      38 _KeyboardPollCount::
   002A                      39 	.ds 1
                    002B     40 G$KeyboardInited$0$0==.
   002B                      41 _KeyboardInited::
   002B                      42 	.ds 1
                             43 ;--------------------------------------------------------
                             44 ; overlayable items in  ram 
                             45 ;--------------------------------------------------------
                             46 	.area _OVERLAY
                             47 ;--------------------------------------------------------
                             48 ; external initialized ram data
                             49 ;--------------------------------------------------------
                             50 ;--------------------------------------------------------
                             51 ; global & static initialisations
                             52 ;--------------------------------------------------------
                             53 	.area _GSINIT
                             54 	.area _GSFINAL
                             55 	.area _GSINIT
                             56 ;--------------------------------------------------------
                             57 ; Home
                             58 ;--------------------------------------------------------
                             59 	.area _HOME
                             60 	.area _CODE
                             61 ;--------------------------------------------------------
                             62 ; code
                             63 ;--------------------------------------------------------
                             64 	.area _CODE
                             65 ;keyboard.c:19: bool KeyboardInited; void KeyboardInit() {
                             66 ;	genLabel
                             67 ;	genFunction
                             68 ;	---------------------------------
                             69 ; Function KeyboardInit
                             70 ; ---------------------------------
   0000                      71 _KeyboardInit_start::
   0000                      72 _KeyboardInit:
   2597 3E 03                73 	ld	a,#3
   2599 CF                   74 	rst	0x08
                             75 ;keyboard.c:20: if(!KeyboardInited) {
                             76 ;	genIfx
   259A AF                   77 	xor	a,a
   259B FD 21 5E 83          78 	ld	iy,#_KeyboardInited
   259F FD B6 00             79 	or	a,0(iy)
   25A2 C2 C5 25             80 	jp	nz,00103$
                             81 ;keyboard.c:21: RegisterInterrupt(PollKeyboard);
                             82 ;	genIpush
                             83 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   25A5 21 DF 25             84 	ld	hl,#_PollKeyboard
   25A8 E5                   85 	push	hl
                             86 ;	genCall
   25A9 CD 24 18             87 	call	_RegisterInterrupt
   25AC F1                   88 	pop	af
                             89 ;keyboard.c:22: KeyboardBufferCount=0;
                             90 ;	genAssign
   25AD FD 21 5C 83          91 	ld	iy,#_KeyboardBufferCount
   25B1 FD 36 00 00          92 	ld	0(iy),#0x00
                             93 ;keyboard.c:23: KeyboardPollCount=0;
                             94 ;	genAssign
   25B5 FD 21 5D 83          95 	ld	iy,#_KeyboardPollCount
   25B9 FD 36 00 00          96 	ld	0(iy),#0x00
                             97 ;keyboard.c:24: _SimPrintString("Keyboard initialized\n");
                             98 ;	genIpush
                             99 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   25BD 21 C9 25            100 	ld	hl,#__str_0
   25C0 E5                  101 	push	hl
                            102 ;	genCall
   25C1 CD CA 2A            103 	call	__Z80SimPrintString
   25C4 F1                  104 	pop	af
                            105 ;	genLabel
   002E                     106 00103$:
                            107 ;	genEndFunction
   25C5 3E 04               108 	ld	a,#4
   25C7 CF                  109 	rst	0x08
   25C8 C9                  110 	ret
   0032                     111 _KeyboardInit_end::
                    0032    112 Fkeyboard$_str_0$0$0 == .
   0032                     113 __str_0:
   25C9 4B 65 79 62 6F 61   114 	.ascii "Keyboard initialized"
        72 64 20 69 6E 69
        74 69 61 6C 69 7A
        65 64
   25DD 0A                  115 	.db 0x0A
   25DE 00                  116 	.db 0x00
                            117 ;keyboard.c:28: void PollKeyboard() {
                            118 ;	genLabel
                            119 ;	genFunction
                            120 ;	---------------------------------
                            121 ; Function PollKeyboard
                            122 ; ---------------------------------
   0048                     123 _PollKeyboard_start::
   0048                     124 _PollKeyboard:
   25DF 3E 03               125 	ld	a,#3
   25E1 CF                  126 	rst	0x08
                            127 ;keyboard.c:46: _endasm;
                            128 ;	genInline
                            129 ;
   25E2 F5                  130 		       push af
   25E3 C5                  131 		       push bc
   25E4 E5                  132 		       push hl
   25E5 01 FE FE            133 		       ld bc,#0xfefe
   25E8 21 34 83            134 		       ld hl,#_KeyTable
   0054                     135         KeyboardLoop:
   25EB ED 78               136 		       in a,(c)
   25ED 2F                  137 		       cpl
   25EE 77                  138 		       ld (hl),a
   25EF 23                  139 		       inc hl
   25F0 CB 00               140 		       rlc b
   25F2 DA EB 25            141 		       jp c,KeyboardLoop
   25F5 F1                  142 		       pop af
   25F6 C1                  143 		       pop bc
   25F7 E1                  144 		       pop hl
                            145 		       
                            146 ;keyboard.c:47: if(KeyboardPollCount>0) {
                            147 ;	genCmpGt
   25F8 3E 00               148 	ld	a,#0x00
   25FA FD 21 5D 83         149 	ld	iy,#_KeyboardPollCount
   25FE FD 96 00            150 	sub	a,0(iy)
   2601 F2 0A 26            151 	jp	p,00221$
                            152 ;keyboard.c:48: KeyboardPollCount--;
                            153 ;	genMinus
   2604 FD 35 00            154 	dec	0(iy)
                            155 ;	genGoto
   2607 C3 0F 28            156 	jp	00223$
                            157 ;	genLabel
   0073                     158 00221$:
                            159 ;keyboard.c:50: Char='\0';
                            160 ;	genAssign
   260A 0E 00               161 	ld	c,#0x00
                            162 ;keyboard.c:51: if(KeyTable[0]&0x02) Char='z';
                            163 ;	genPointerGet
   260C 21 34 83            164 	ld	hl,#_KeyTable
   260F 46                  165 	ld	b,(hl)
                            166 ;	genAnd
   2610 78                  167 	ld	a,b
   2611 E6 02               168 	and	a,#0x02
   2613 CA 1B 26            169 	jp	z,00110$
   007F                     170 00270$:
                            171 ;	genAssign
   2616 0E 7A               172 	ld	c,#0x7A
                            173 ;	genGoto
   2618 C3 39 26            174 	jp	00111$
                            175 ;	genLabel
   0084                     176 00110$:
                            177 ;keyboard.c:52: else if(KeyTable[0]&0x04) Char='x';
                            178 ;	genAnd
   261B 78                  179 	ld	a,b
   261C E6 04               180 	and	a,#0x04
   261E CA 26 26            181 	jp	z,00107$
   008A                     182 00271$:
                            183 ;	genAssign
   2621 0E 78               184 	ld	c,#0x78
                            185 ;	genGoto
   2623 C3 39 26            186 	jp	00111$
                            187 ;	genLabel
   008F                     188 00107$:
                            189 ;keyboard.c:53: else if(KeyTable[0]&0x08) Char='c';
                            190 ;	genAnd
   2626 78                  191 	ld	a,b
   2627 E6 08               192 	and	a,#0x08
   2629 CA 31 26            193 	jp	z,00104$
   0095                     194 00272$:
                            195 ;	genAssign
   262C 0E 63               196 	ld	c,#0x63
                            197 ;	genGoto
   262E C3 39 26            198 	jp	00111$
                            199 ;	genLabel
   009A                     200 00104$:
                            201 ;keyboard.c:54: else if(KeyTable[0]&0x10) Char='v';
                            202 ;	genAnd
   2631 78                  203 	ld	a,b
   2632 E6 10               204 	and	a,#0x10
   2634 CA 39 26            205 	jp	z,00111$
   00A0                     206 00273$:
                            207 ;	genAssign
   2637 0E 76               208 	ld	c,#0x76
                            209 ;	genLabel
   00A2                     210 00111$:
                            211 ;keyboard.c:55: if(KeyTable[1]&0x01) Char='a';
                            212 ;	genPlus
                            213 ;	genPlusIncr
   2639 21 35 83            214 	ld	hl,#_KeyTable + 1
                            215 ;	genPointerGet
   263C 5E                  216 	ld	e,(hl)
                            217 ;	genAnd
   263D 7B                  218 	ld	a,e
   263E E6 01               219 	and	a,#0x01
   2640 CA 48 26            220 	jp	z,00124$
   00AC                     221 00274$:
                            222 ;	genAssign
   2643 0E 61               223 	ld	c,#0x61
                            224 ;	genGoto
   2645 C3 71 26            225 	jp	00125$
                            226 ;	genLabel
   00B1                     227 00124$:
                            228 ;keyboard.c:56: else if(KeyTable[1]&0x02) Char='s';
                            229 ;	genAnd
   2648 7B                  230 	ld	a,e
   2649 E6 02               231 	and	a,#0x02
   264B CA 53 26            232 	jp	z,00121$
   00B7                     233 00275$:
                            234 ;	genAssign
   264E 0E 73               235 	ld	c,#0x73
                            236 ;	genGoto
   2650 C3 71 26            237 	jp	00125$
                            238 ;	genLabel
   00BC                     239 00121$:
                            240 ;keyboard.c:57: else if(KeyTable[1]&0x04) Char='d';
                            241 ;	genAnd
   2653 7B                  242 	ld	a,e
   2654 E6 04               243 	and	a,#0x04
   2656 CA 5E 26            244 	jp	z,00118$
   00C2                     245 00276$:
                            246 ;	genAssign
   2659 0E 64               247 	ld	c,#0x64
                            248 ;	genGoto
   265B C3 71 26            249 	jp	00125$
                            250 ;	genLabel
   00C7                     251 00118$:
                            252 ;keyboard.c:58: else if(KeyTable[1]&0x08) Char='f';
                            253 ;	genAnd
   265E 7B                  254 	ld	a,e
   265F E6 08               255 	and	a,#0x08
   2661 CA 69 26            256 	jp	z,00115$
   00CD                     257 00277$:
                            258 ;	genAssign
   2664 0E 66               259 	ld	c,#0x66
                            260 ;	genGoto
   2666 C3 71 26            261 	jp	00125$
                            262 ;	genLabel
   00D2                     263 00115$:
                            264 ;keyboard.c:59: else if(KeyTable[1]&0x10) Char='g';
                            265 ;	genAnd
   2669 7B                  266 	ld	a,e
   266A E6 10               267 	and	a,#0x10
   266C CA 71 26            268 	jp	z,00125$
   00D8                     269 00278$:
                            270 ;	genAssign
   266F 0E 67               271 	ld	c,#0x67
                            272 ;	genLabel
   00DA                     273 00125$:
                            274 ;keyboard.c:60: if(KeyTable[2]&0x01) Char='q';
                            275 ;	genPlus
                            276 ;	genPlusIncr
   2671 21 36 83            277 	ld	hl,#_KeyTable + 2
                            278 ;	genPointerGet
   2674 5E                  279 	ld	e,(hl)
                            280 ;	genAnd
   2675 7B                  281 	ld	a,e
   2676 E6 01               282 	and	a,#0x01
   2678 CA 80 26            283 	jp	z,00138$
   00E4                     284 00279$:
                            285 ;	genAssign
   267B 0E 71               286 	ld	c,#0x71
                            287 ;	genGoto
   267D C3 A9 26            288 	jp	00139$
                            289 ;	genLabel
   00E9                     290 00138$:
                            291 ;keyboard.c:61: else if(KeyTable[2]&0x02) Char='w';
                            292 ;	genAnd
   2680 7B                  293 	ld	a,e
   2681 E6 02               294 	and	a,#0x02
   2683 CA 8B 26            295 	jp	z,00135$
   00EF                     296 00280$:
                            297 ;	genAssign
   2686 0E 77               298 	ld	c,#0x77
                            299 ;	genGoto
   2688 C3 A9 26            300 	jp	00139$
                            301 ;	genLabel
   00F4                     302 00135$:
                            303 ;keyboard.c:62: else if(KeyTable[2]&0x04) Char='e';
                            304 ;	genAnd
   268B 7B                  305 	ld	a,e
   268C E6 04               306 	and	a,#0x04
   268E CA 96 26            307 	jp	z,00132$
   00FA                     308 00281$:
                            309 ;	genAssign
   2691 0E 65               310 	ld	c,#0x65
                            311 ;	genGoto
   2693 C3 A9 26            312 	jp	00139$
                            313 ;	genLabel
   00FF                     314 00132$:
                            315 ;keyboard.c:63: else if(KeyTable[2]&0x08) Char='r';
                            316 ;	genAnd
   2696 7B                  317 	ld	a,e
   2697 E6 08               318 	and	a,#0x08
   2699 CA A1 26            319 	jp	z,00129$
   0105                     320 00282$:
                            321 ;	genAssign
   269C 0E 72               322 	ld	c,#0x72
                            323 ;	genGoto
   269E C3 A9 26            324 	jp	00139$
                            325 ;	genLabel
   010A                     326 00129$:
                            327 ;keyboard.c:64: else if(KeyTable[2]&0x10) Char='t';
                            328 ;	genAnd
   26A1 7B                  329 	ld	a,e
   26A2 E6 10               330 	and	a,#0x10
   26A4 CA A9 26            331 	jp	z,00139$
   0110                     332 00283$:
                            333 ;	genAssign
   26A7 0E 74               334 	ld	c,#0x74
                            335 ;	genLabel
   0112                     336 00139$:
                            337 ;keyboard.c:65: if(KeyTable[3]&0x01) Char='1';
                            338 ;	genPlus
                            339 ;	genPlusIncr
   26A9 21 37 83            340 	ld	hl,#_KeyTable + 3
                            341 ;	genPointerGet
   26AC 5E                  342 	ld	e,(hl)
                            343 ;	genAnd
   26AD 7B                  344 	ld	a,e
   26AE E6 01               345 	and	a,#0x01
   26B0 CA B8 26            346 	jp	z,00152$
   011C                     347 00284$:
                            348 ;	genAssign
   26B3 0E 31               349 	ld	c,#0x31
                            350 ;	genGoto
   26B5 C3 E1 26            351 	jp	00153$
                            352 ;	genLabel
   0121                     353 00152$:
                            354 ;keyboard.c:66: else if(KeyTable[3]&0x02) Char='2';
                            355 ;	genAnd
   26B8 7B                  356 	ld	a,e
   26B9 E6 02               357 	and	a,#0x02
   26BB CA C3 26            358 	jp	z,00149$
   0127                     359 00285$:
                            360 ;	genAssign
   26BE 0E 32               361 	ld	c,#0x32
                            362 ;	genGoto
   26C0 C3 E1 26            363 	jp	00153$
                            364 ;	genLabel
   012C                     365 00149$:
                            366 ;keyboard.c:67: else if(KeyTable[3]&0x04) Char='3';
                            367 ;	genAnd
   26C3 7B                  368 	ld	a,e
   26C4 E6 04               369 	and	a,#0x04
   26C6 CA CE 26            370 	jp	z,00146$
   0132                     371 00286$:
                            372 ;	genAssign
   26C9 0E 33               373 	ld	c,#0x33
                            374 ;	genGoto
   26CB C3 E1 26            375 	jp	00153$
                            376 ;	genLabel
   0137                     377 00146$:
                            378 ;keyboard.c:68: else if(KeyTable[3]&0x08) Char='4';
                            379 ;	genAnd
   26CE 7B                  380 	ld	a,e
   26CF E6 08               381 	and	a,#0x08
   26D1 CA D9 26            382 	jp	z,00143$
   013D                     383 00287$:
                            384 ;	genAssign
   26D4 0E 34               385 	ld	c,#0x34
                            386 ;	genGoto
   26D6 C3 E1 26            387 	jp	00153$
                            388 ;	genLabel
   0142                     389 00143$:
                            390 ;keyboard.c:69: else if(KeyTable[3]&0x10) Char='5';
                            391 ;	genAnd
   26D9 7B                  392 	ld	a,e
   26DA E6 10               393 	and	a,#0x10
   26DC CA E1 26            394 	jp	z,00153$
   0148                     395 00288$:
                            396 ;	genAssign
   26DF 0E 35               397 	ld	c,#0x35
                            398 ;	genLabel
   014A                     399 00153$:
                            400 ;keyboard.c:70: if(KeyTable[4]&0x01) Char='0';
                            401 ;	genPlus
                            402 ;	genPlusIncr
   26E1 21 38 83            403 	ld	hl,#_KeyTable + 4
                            404 ;	genPointerGet
   26E4 5E                  405 	ld	e,(hl)
                            406 ;	genAnd
   26E5 7B                  407 	ld	a,e
   26E6 E6 01               408 	and	a,#0x01
   26E8 CA F0 26            409 	jp	z,00166$
   0154                     410 00289$:
                            411 ;	genAssign
   26EB 0E 30               412 	ld	c,#0x30
                            413 ;	genGoto
   26ED C3 19 27            414 	jp	00167$
                            415 ;	genLabel
   0159                     416 00166$:
                            417 ;keyboard.c:71: else if(KeyTable[4]&0x02) Char='9';
                            418 ;	genAnd
   26F0 7B                  419 	ld	a,e
   26F1 E6 02               420 	and	a,#0x02
   26F3 CA FB 26            421 	jp	z,00163$
   015F                     422 00290$:
                            423 ;	genAssign
   26F6 0E 39               424 	ld	c,#0x39
                            425 ;	genGoto
   26F8 C3 19 27            426 	jp	00167$
                            427 ;	genLabel
   0164                     428 00163$:
                            429 ;keyboard.c:72: else if(KeyTable[4]&0x04) Char='8';
                            430 ;	genAnd
   26FB 7B                  431 	ld	a,e
   26FC E6 04               432 	and	a,#0x04
   26FE CA 06 27            433 	jp	z,00160$
   016A                     434 00291$:
                            435 ;	genAssign
   2701 0E 38               436 	ld	c,#0x38
                            437 ;	genGoto
   2703 C3 19 27            438 	jp	00167$
                            439 ;	genLabel
   016F                     440 00160$:
                            441 ;keyboard.c:73: else if(KeyTable[4]&0x08) Char='7';
                            442 ;	genAnd
   2706 7B                  443 	ld	a,e
   2707 E6 08               444 	and	a,#0x08
   2709 CA 11 27            445 	jp	z,00157$
   0175                     446 00292$:
                            447 ;	genAssign
   270C 0E 37               448 	ld	c,#0x37
                            449 ;	genGoto
   270E C3 19 27            450 	jp	00167$
                            451 ;	genLabel
   017A                     452 00157$:
                            453 ;keyboard.c:74: else if(KeyTable[4]&0x10) Char='6';
                            454 ;	genAnd
   2711 7B                  455 	ld	a,e
   2712 E6 10               456 	and	a,#0x10
   2714 CA 19 27            457 	jp	z,00167$
   0180                     458 00293$:
                            459 ;	genAssign
   2717 0E 36               460 	ld	c,#0x36
                            461 ;	genLabel
   0182                     462 00167$:
                            463 ;keyboard.c:75: if(KeyTable[5]&0x01) Char='p';
                            464 ;	genPlus
                            465 ;	genPlusIncr
   2719 21 39 83            466 	ld	hl,#_KeyTable + 5
                            467 ;	genPointerGet
   271C 5E                  468 	ld	e,(hl)
                            469 ;	genAnd
   271D 7B                  470 	ld	a,e
   271E E6 01               471 	and	a,#0x01
   2720 CA 28 27            472 	jp	z,00180$
   018C                     473 00294$:
                            474 ;	genAssign
   2723 0E 70               475 	ld	c,#0x70
                            476 ;	genGoto
   2725 C3 51 27            477 	jp	00181$
                            478 ;	genLabel
   0191                     479 00180$:
                            480 ;keyboard.c:76: else if(KeyTable[5]&0x02) Char='o';
                            481 ;	genAnd
   2728 7B                  482 	ld	a,e
   2729 E6 02               483 	and	a,#0x02
   272B CA 33 27            484 	jp	z,00177$
   0197                     485 00295$:
                            486 ;	genAssign
   272E 0E 6F               487 	ld	c,#0x6F
                            488 ;	genGoto
   2730 C3 51 27            489 	jp	00181$
                            490 ;	genLabel
   019C                     491 00177$:
                            492 ;keyboard.c:77: else if(KeyTable[5]&0x04) Char='i';
                            493 ;	genAnd
   2733 7B                  494 	ld	a,e
   2734 E6 04               495 	and	a,#0x04
   2736 CA 3E 27            496 	jp	z,00174$
   01A2                     497 00296$:
                            498 ;	genAssign
   2739 0E 69               499 	ld	c,#0x69
                            500 ;	genGoto
   273B C3 51 27            501 	jp	00181$
                            502 ;	genLabel
   01A7                     503 00174$:
                            504 ;keyboard.c:78: else if(KeyTable[5]&0x08) Char='u';
                            505 ;	genAnd
   273E 7B                  506 	ld	a,e
   273F E6 08               507 	and	a,#0x08
   2741 CA 49 27            508 	jp	z,00171$
   01AD                     509 00297$:
                            510 ;	genAssign
   2744 0E 75               511 	ld	c,#0x75
                            512 ;	genGoto
   2746 C3 51 27            513 	jp	00181$
                            514 ;	genLabel
   01B2                     515 00171$:
                            516 ;keyboard.c:79: else if(KeyTable[5]&0x10) Char='y';
                            517 ;	genAnd
   2749 7B                  518 	ld	a,e
   274A E6 10               519 	and	a,#0x10
   274C CA 51 27            520 	jp	z,00181$
   01B8                     521 00298$:
                            522 ;	genAssign
   274F 0E 79               523 	ld	c,#0x79
                            524 ;	genLabel
   01BA                     525 00181$:
                            526 ;keyboard.c:80: if(KeyTable[6]&0x01) Char='\n';
                            527 ;	genPlus
                            528 ;	genPlusIncr
   2751 21 3A 83            529 	ld	hl,#_KeyTable + 6
                            530 ;	genPointerGet
   2754 5E                  531 	ld	e,(hl)
                            532 ;	genAnd
   2755 7B                  533 	ld	a,e
   2756 E6 01               534 	and	a,#0x01
   2758 CA 60 27            535 	jp	z,00194$
   01C4                     536 00299$:
                            537 ;	genAssign
   275B 0E 0A               538 	ld	c,#0x0A
                            539 ;	genGoto
   275D C3 89 27            540 	jp	00195$
                            541 ;	genLabel
   01C9                     542 00194$:
                            543 ;keyboard.c:81: else if(KeyTable[6]&0x02) Char='l';
                            544 ;	genAnd
   2760 7B                  545 	ld	a,e
   2761 E6 02               546 	and	a,#0x02
   2763 CA 6B 27            547 	jp	z,00191$
   01CF                     548 00300$:
                            549 ;	genAssign
   2766 0E 6C               550 	ld	c,#0x6C
                            551 ;	genGoto
   2768 C3 89 27            552 	jp	00195$
                            553 ;	genLabel
   01D4                     554 00191$:
                            555 ;keyboard.c:82: else if(KeyTable[6]&0x04) Char='k';
                            556 ;	genAnd
   276B 7B                  557 	ld	a,e
   276C E6 04               558 	and	a,#0x04
   276E CA 76 27            559 	jp	z,00188$
   01DA                     560 00301$:
                            561 ;	genAssign
   2771 0E 6B               562 	ld	c,#0x6B
                            563 ;	genGoto
   2773 C3 89 27            564 	jp	00195$
                            565 ;	genLabel
   01DF                     566 00188$:
                            567 ;keyboard.c:83: else if(KeyTable[6]&0x08) Char='j';
                            568 ;	genAnd
   2776 7B                  569 	ld	a,e
   2777 E6 08               570 	and	a,#0x08
   2779 CA 81 27            571 	jp	z,00185$
   01E5                     572 00302$:
                            573 ;	genAssign
   277C 0E 6A               574 	ld	c,#0x6A
                            575 ;	genGoto
   277E C3 89 27            576 	jp	00195$
                            577 ;	genLabel
   01EA                     578 00185$:
                            579 ;keyboard.c:84: else if(KeyTable[6]&0x10) Char='h';
                            580 ;	genAnd
   2781 7B                  581 	ld	a,e
   2782 E6 10               582 	and	a,#0x10
   2784 CA 89 27            583 	jp	z,00195$
   01F0                     584 00303$:
                            585 ;	genAssign
   2787 0E 68               586 	ld	c,#0x68
                            587 ;	genLabel
   01F2                     588 00195$:
                            589 ;keyboard.c:85: if(KeyTable[7]&0x01) Char=' ';
                            590 ;	genPlus
                            591 ;	genPlusIncr
   2789 21 3B 83            592 	ld	hl,#_KeyTable + 7
                            593 ;	genPointerGet
   278C 5E                  594 	ld	e,(hl)
                            595 ;	genAnd
   278D 7B                  596 	ld	a,e
   278E E6 01               597 	and	a,#0x01
   2790 CA 98 27            598 	jp	z,00208$
   01FC                     599 00304$:
                            600 ;	genAssign
   2793 0E 20               601 	ld	c,#0x20
                            602 ;	genGoto
   2795 C3 C1 27            603 	jp	00209$
                            604 ;	genLabel
   0201                     605 00208$:
                            606 ;keyboard.c:86: else if(KeyTable[7]&0x02) Char=' ';
                            607 ;	genAnd
   2798 7B                  608 	ld	a,e
   2799 E6 02               609 	and	a,#0x02
   279B CA A3 27            610 	jp	z,00205$
   0207                     611 00305$:
                            612 ;	genAssign
   279E 0E 20               613 	ld	c,#0x20
                            614 ;	genGoto
   27A0 C3 C1 27            615 	jp	00209$
                            616 ;	genLabel
   020C                     617 00205$:
                            618 ;keyboard.c:87: else if(KeyTable[7]&0x04) Char='m';
                            619 ;	genAnd
   27A3 7B                  620 	ld	a,e
   27A4 E6 04               621 	and	a,#0x04
   27A6 CA AE 27            622 	jp	z,00202$
   0212                     623 00306$:
                            624 ;	genAssign
   27A9 0E 6D               625 	ld	c,#0x6D
                            626 ;	genGoto
   27AB C3 C1 27            627 	jp	00209$
                            628 ;	genLabel
   0217                     629 00202$:
                            630 ;keyboard.c:88: else if(KeyTable[7]&0x08) Char='n';
                            631 ;	genAnd
   27AE 7B                  632 	ld	a,e
   27AF E6 08               633 	and	a,#0x08
   27B1 CA B9 27            634 	jp	z,00199$
   021D                     635 00307$:
                            636 ;	genAssign
   27B4 0E 6E               637 	ld	c,#0x6E
                            638 ;	genGoto
   27B6 C3 C1 27            639 	jp	00209$
                            640 ;	genLabel
   0222                     641 00199$:
                            642 ;keyboard.c:89: else if(KeyTable[7]&0x10) Char='b';
                            643 ;	genAnd
   27B9 7B                  644 	ld	a,e
   27BA E6 10               645 	and	a,#0x10
   27BC CA C1 27            646 	jp	z,00209$
   0228                     647 00308$:
                            648 ;	genAssign
   27BF 0E 62               649 	ld	c,#0x62
                            650 ;	genLabel
   022A                     651 00209$:
                            652 ;keyboard.c:90: if(Char>='a' && Char<='z') if(KeyTable[0]&0x01) Char=Char+('A'-'a');
                            653 ;	genAssign
   27C1 69                  654 	ld	l,c
                            655 ;	genCmpLt
   27C2 7D                  656 	ld	a,l
   27C3 D6 61               657 	sub	a,#0x61
   27C5 DA D9 27            658 	jp	c,00213$
                            659 ;	genAssign
   27C8 69                  660 	ld	l,c
                            661 ;	genCmpGt
   27C9 3E 7A               662 	ld	a,#0x7A
   27CB 95                  663 	sub	a,l
   27CC DA D9 27            664 	jp	c,00213$
                            665 ;	genAnd
   27CF 78                  666 	ld	a,b
   27D0 E6 01               667 	and	a,#0x01
   27D2 CA D9 27            668 	jp	z,00213$
   023E                     669 00309$:
                            670 ;	genPlus
                            671 ;	genPlusIncr
                            672 ;	Can't optimise plus by inc, falling back to the normal way
   27D5 79                  673 	ld	a,c
   27D6 C6 E0               674 	add	a,#0xE0
   27D8 4F                  675 	ld	c,a
                            676 ;	genLabel
   0242                     677 00213$:
                            678 ;keyboard.c:91: if(Char!='\0') {
                            679 ;	genCmpEq
                            680 ; genCmpEq: left 1, right 1, result 0
   27D9 79                  681 	ld	a,c
   27DA B7                  682 	or	a,a
   27DB CA 0F 28            683 	jp	z,00223$
   0247                     684 00310$:
                            685 ;keyboard.c:92: if(KeyboardBufferCount>=MAX_KEYBOARDBUFFER) Beep(); else {
                            686 ;	genCmpLt
   27DE FD 21 5C 83         687 	ld	iy,#_KeyboardBufferCount
   27E2 FD 7E 00            688 	ld	a,0(iy)
   27E5 D6 20               689 	sub	a,#0x20
   27E7 FA F2 27            690 	jp	m,00216$
                            691 ;	genCall
                            692 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   27EA C5                  693 	push	bc
   27EB CD 39 25            694 	call	_Beep
   27EE C1                  695 	pop	bc
                            696 ;	genGoto
   27EF C3 0F 28            697 	jp	00223$
                            698 ;	genLabel
   025B                     699 00216$:
                            700 ;keyboard.c:93: KeyboardBuffer[KeyboardBufferCount]=Char;
                            701 ;	genPlus
                            702 ;	Can't optimise plus by inc, falling back to the normal way
                            703 ;	Shift into pair idx 0
   27F2 21 5C 83            704 	ld	hl,#_KeyboardBufferCount
   27F5 3E 3C               705 	ld	a,#<_KeyboardBuffer
   27F7 86                  706 	add	a,(hl)
   27F8 5F                  707 	ld	e,a
   27F9 3E 83               708 	ld	a,#>_KeyboardBuffer
   27FB CE 00               709 	adc	a,#0x00
   27FD 57                  710 	ld	d,a
                            711 ;	genAssign (pointer)
                            712 ;	isBitvar = 0
   27FE 79                  713 	ld	a,c
   27FF 12                  714 	ld	(de),a
                            715 ;keyboard.c:94: KeyboardBufferCount++;
                            716 ;	genPlus
                            717 ;	genPlusIncr
   2800 FD 21 5C 83         718 	ld	iy,#_KeyboardBufferCount
   2804 FD 34 00            719 	inc	0(iy)
                            720 ;keyboard.c:95: KeyboardPollCount=6;
                            721 ;	genAssign
   2807 FD 21 5D 83         722 	ld	iy,#_KeyboardPollCount
   280B FD 36 00 06         723 	ld	0(iy),#0x06
                            724 ;	genLabel
   0278                     725 00223$:
                            726 ;	genEndFunction
   280F 3E 04               727 	ld	a,#4
   2811 CF                  728 	rst	0x08
   2812 C9                  729 	ret
   027C                     730 _PollKeyboard_end::
                            731 ;keyboard.c:101: char GetKeypress() {
                            732 ;	genLabel
                            733 ;	genFunction
                            734 ;	---------------------------------
                            735 ; Function GetKeypress
                            736 ; ---------------------------------
   027C                     737 _GetKeypress_start::
   027C                     738 _GetKeypress:
   2813 3E 03               739 	ld	a,#3
   2815 CF                  740 	rst	0x08
                            741 ;keyboard.c:104: Pause();
                            742 ;	genCall
                            743 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   2816 CD 2A 1C            744 	call	_Pause
                            745 ;keyboard.c:105: if(KeyboardBufferCount) {
                            746 ;	genIfx
   2819 AF                  747 	xor	a,a
   281A FD 21 5C 83         748 	ld	iy,#_KeyboardBufferCount
   281E FD B6 00            749 	or	a,0(iy)
   2821 CA 5C 28            750 	jp	z,00102$
                            751 ;keyboard.c:106: Keypress=KeyboardBuffer[0];
                            752 ;	genPointerGet
   2824 21 3C 83            753 	ld	hl,#_KeyboardBuffer
   2827 6E                  754 	ld	l,(hl)
                            755 ;	genAssign
   2828 4D                  756 	ld	c,l
                            757 ;keyboard.c:107: for(i=1; i<KeyboardBufferCount; i++) KeyboardBuffer[i-1]=KeyboardBuffer[i];
                            758 ;	genAssign
   2829 06 01               759 	ld	b,#0x01
                            760 ;	genLabel
   0294                     761 00104$:
                            762 ;	genCmpLt
   282B 78                  763 	ld	a,b
   282C FD 21 5C 83         764 	ld	iy,#_KeyboardBufferCount
   2830 FD 96 00            765 	sub	a,0(iy)
   2833 F2 52 28            766 	jp	p,00107$
                            767 ;	genMinus
   2836 78                  768 	ld	a,b
   2837 C6 FF               769 	add	a,#0xFF
   2839 6F                  770 	ld	l,a
                            771 ;	genPlus
                            772 ;	Can't optimise plus by inc, falling back to the normal way
   283A 3E 3C               773 	ld	a,#<_KeyboardBuffer
   283C 85                  774 	add	a,l
   283D 5F                  775 	ld	e,a
   283E 3E 83               776 	ld	a,#>_KeyboardBuffer
   2840 CE 00               777 	adc	a,#0x00
   2842 57                  778 	ld	d,a
                            779 ;	genPlus
                            780 ;	Can't optimise plus by inc, falling back to the normal way
   2843 3E 3C               781 	ld	a,#<_KeyboardBuffer
   2845 80                  782 	add	a,b
   2846 6F                  783 	ld	l,a
   2847 3E 83               784 	ld	a,#>_KeyboardBuffer
   2849 CE 00               785 	adc	a,#0x00
   284B 67                  786 	ld	h,a
                            787 ;	genPointerGet
   284C 7E                  788 	ld	a,(hl)
                            789 ;	genAssign (pointer)
                            790 ;	isBitvar = 0
   284D 12                  791 	ld	(de),a
                            792 ;	genPlus
                            793 ;	genPlusIncr
                            794 ; Removed redundent load
   284E 04                  795 	inc	b
                            796 ;	genGoto
   284F C3 2B 28            797 	jp	00104$
                            798 ;	genLabel
   02BB                     799 00107$:
                            800 ;keyboard.c:108: KeyboardBufferCount--;
                            801 ;	genMinus
   2852 FD 21 5C 83         802 	ld	iy,#_KeyboardBufferCount
   2856 FD 35 00            803 	dec	0(iy)
                            804 ;	genGoto
   2859 C3 5E 28            805 	jp	00103$
                            806 ;	genLabel
   02C5                     807 00102$:
                            808 ;keyboard.c:110: Keypress='\0';
                            809 ;	genAssign
   285C 0E 00               810 	ld	c,#0x00
                            811 ;	genLabel
   02C7                     812 00103$:
                            813 ;keyboard.c:112: Resume();
                            814 ;	genCall
                            815 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   285E C5                  816 	push	bc
   285F CD 47 1C            817 	call	_Resume
   2862 C1                  818 	pop	bc
                            819 ;keyboard.c:113: return Keypress;
                            820 ;	genRet
                            821 ; Dump of IC_LEFT: type AOP_REG size 1
                            822 ;	 reg = c
   2863 69                  823 	ld	l,c
                            824 ;	genLabel
   02CD                     825 00108$:
                            826 ;	genEndFunction
   2864 3E 04               827 	ld	a,#4
   2866 CF                  828 	rst	0x08
   2867 C9                  829 	ret
   02D1                     830 _GetKeypress_end::
                            831 	.area _CODE
