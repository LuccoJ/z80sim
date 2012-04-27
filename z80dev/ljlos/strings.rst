                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.5 Fri Apr 27 12:30:18 2012
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module strings
                              7 	.optsdcc -mz80
                              8 	
                              9 ;--------------------------------------------------------
                             10 ; Public variables in this module
                             11 ;--------------------------------------------------------
                             12 	.globl _Power
                             13 	.globl _Divide
                             14 	.globl _Mod
                             15 	.globl _StringLength
                             16 	.globl _StringWrite
                             17 	.globl _SameString
                             18 	.globl _WordToHex
                             19 	.globl _WordToString
                             20 	.globl _IntToString
                             21 ;--------------------------------------------------------
                             22 ;  ram data
                             23 ;--------------------------------------------------------
                             24 	.area _DATA
                             25 ;--------------------------------------------------------
                             26 ; overlayable items in  ram 
                             27 ;--------------------------------------------------------
                             28 	.area _OVERLAY
                             29 ;--------------------------------------------------------
                             30 ; external initialized ram data
                             31 ;--------------------------------------------------------
                             32 ;--------------------------------------------------------
                             33 ; global & static initialisations
                             34 ;--------------------------------------------------------
                             35 	.area _GSINIT
                             36 	.area _GSFINAL
                             37 	.area _GSINIT
                             38 ;--------------------------------------------------------
                             39 ; Home
                             40 ;--------------------------------------------------------
                             41 	.area _HOME
                             42 	.area _CODE
                             43 ;--------------------------------------------------------
                             44 ; code
                             45 ;--------------------------------------------------------
                             46 	.area _CODE
                             47 ;strings.c:5: int StringLength(char* String) {
                             48 ;	genLabel
                             49 ;	genFunction
                             50 ;	---------------------------------
                             51 ; Function StringLength
                             52 ; ---------------------------------
   0000                      53 _StringLength_start::
   0000                      54 _StringLength:
   0406 3E 03                55 	ld	a,#3
   0408 CF                   56 	rst	0x08
   0409 DD E5                57 	push	ix
   040B DD 21 00 00          58 	ld	ix,#0
   040F DD 39                59 	add	ix,sp
                             60 ;strings.c:8: while(String[i]!='\0') i++;
                             61 ;	genAssign
   0411 01 00 00             62 	ld	bc,#0x0000
                             63 ;	genLabel
   000E                      64 00101$:
                             65 ;	genPlus
                             66 ;	AOP_STK for 
                             67 ;	Can't optimise plus by inc, falling back to the normal way
   0414 DD 6E 04             68 	ld	l,4(ix)
   0417 DD 66 05             69 	ld	h,5(ix)
   041A 09                   70 	add	hl,bc
                             71 ;	genPointerGet
   041B 6E                   72 	ld	l,(hl)
                             73 ;	genCmpEq
                             74 ; genCmpEq: left 1, right 1, result 0
   041C 7D                   75 	ld	a,l
   041D B7                   76 	or	a,a
   041E CA 25 04             77 	jp	z,00103$
   001B                      78 00108$:
                             79 ;	genPlus
                             80 ;	genPlusIncr
   0421 03                   81 	inc	bc
                             82 ;	genGoto
   0422 C3 14 04             83 	jp	00101$
                             84 ;	genLabel
   001F                      85 00103$:
                             86 ;strings.c:9: return i;
                             87 ;	genRet
                             88 ; Dump of IC_LEFT: type AOP_REG size 2
                             89 ;	 reg = bc
   0425 69                   90 	ld	l,c
   0426 60                   91 	ld	h,b
                             92 ;	genLabel
   0021                      93 00104$:
                             94 ;	genEndFunction
   0427 DD E1                95 	pop	ix
   0429 3E 04                96 	ld	a,#4
   042B CF                   97 	rst	0x08
   042C C9                   98 	ret
   0027                      99 _StringLength_end::
                            100 ;strings.c:12: void StringWrite(char* Destination, const char* Source) {
                            101 ;	genLabel
                            102 ;	genFunction
                            103 ;	---------------------------------
                            104 ; Function StringWrite
                            105 ; ---------------------------------
   0027                     106 _StringWrite_start::
   0027                     107 _StringWrite:
   042D 3E 03               108 	ld	a,#3
   042F CF                  109 	rst	0x08
   0430 DD E5               110 	push	ix
   0432 DD 21 00 00         111 	ld	ix,#0
   0436 DD 39               112 	add	ix,sp
                            113 ;strings.c:13: MemoryCopy((void*)Destination, (void*)Source, StringLength(Source));
                            114 ;	genIpush
                            115 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
                            116 ;	AOP_STK for 
   0438 DD 6E 06            117 	ld	l,6(ix)
   043B DD 66 07            118 	ld	h,7(ix)
   043E E5                  119 	push	hl
                            120 ;	genCall
   043F CD 06 04            121 	call	_StringLength
   0442 F1                  122 	pop	af
                            123 ;	genAssign
                            124 ;	AOP_STK for 
   0443 DD 4E 06            125 	ld	c,6(ix)
   0446 DD 46 07            126 	ld	b,7(ix)
                            127 ;	genAssign
                            128 ;	AOP_STK for 
   0449 DD 5E 04            129 	ld	e,4(ix)
   044C DD 56 05            130 	ld	d,5(ix)
                            131 ;	genIpush
                            132 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   044F E5                  133 	push	hl
                            134 ;	genIpush
   0450 C5                  135 	push	bc
                            136 ;	genIpush
   0451 D5                  137 	push	de
                            138 ;	genCall
   0452 CD 31 16            139 	call	_MemoryCopy
   0455 F1                  140 	pop	af
   0456 F1                  141 	pop	af
   0457 F1                  142 	pop	af
                            143 ;	genLabel
   0052                     144 00101$:
                            145 ;	genEndFunction
   0458 DD E1               146 	pop	ix
   045A 3E 04               147 	ld	a,#4
   045C CF                  148 	rst	0x08
   045D C9                  149 	ret
   0058                     150 _StringWrite_end::
                            151 ;strings.c:16: bool SameString(char* String1, char* String2) {
                            152 ;	genLabel
                            153 ;	genFunction
                            154 ;	---------------------------------
                            155 ; Function SameString
                            156 ; ---------------------------------
   0058                     157 _SameString_start::
   0058                     158 _SameString:
   045E 3E 03               159 	ld	a,#3
   0460 CF                  160 	rst	0x08
   0461 DD E5               161 	push	ix
   0463 DD 21 00 00         162 	ld	ix,#0
   0467 DD 39               163 	add	ix,sp
                            164 ;strings.c:19: while(String1[i]!='\0') {
                            165 ;	genAssign
   0469 01 00 00            166 	ld	bc,#0x0000
                            167 ;	genLabel
   0066                     168 00103$:
                            169 ;	genPlus
                            170 ;	AOP_STK for 
                            171 ;	Can't optimise plus by inc, falling back to the normal way
   046C DD 6E 04            172 	ld	l,4(ix)
   046F DD 66 05            173 	ld	h,5(ix)
   0472 09                  174 	add	hl,bc
                            175 ;	genPointerGet
   0473 5E                  176 	ld	e,(hl)
                            177 ;	genCmpEq
                            178 ; genCmpEq: left 1, right 1, result 0
   0474 7B                  179 	ld	a,e
   0475 B7                  180 	or	a,a
   0476 CA 8F 04            181 	jp	z,00105$
   0073                     182 00111$:
                            183 ;strings.c:20: if(String1[i]!=String2[i]) return FALSE;
                            184 ;	genPlus
                            185 ;	AOP_STK for 
                            186 ;	Can't optimise plus by inc, falling back to the normal way
   0479 DD 6E 06            187 	ld	l,6(ix)
   047C DD 66 07            188 	ld	h,7(ix)
   047F 09                  189 	add	hl,bc
                            190 ;	genPointerGet
   0480 6E                  191 	ld	l,(hl)
                            192 ;	genCmpEq
                            193 ; genCmpEq: left 1, right 1, result 0
   0481 7D                  194 	ld	a,l
   0482 BB                  195 	cp	e
   0483 CA 8B 04            196 	jp	z,00102$
   0080                     197 00112$:
                            198 ;	genRet
                            199 ; Dump of IC_LEFT: type AOP_LIT size 1
   0486 2E 00               200 	ld	l,#0x00
   0488 C3 91 04            201 	jp	00106$
                            202 ;	genLabel
   0085                     203 00102$:
                            204 ;strings.c:21: i++;
                            205 ;	genPlus
                            206 ;	genPlusIncr
   048B 03                  207 	inc	bc
                            208 ;	genGoto
   048C C3 6C 04            209 	jp	00103$
                            210 ;	genLabel
   0089                     211 00105$:
                            212 ;strings.c:23: return TRUE;
                            213 ;	genRet
                            214 ; Dump of IC_LEFT: type AOP_LIT size 1
   048F 2E 01               215 	ld	l,#0x01
                            216 ;	genLabel
   008B                     217 00106$:
                            218 ;	genEndFunction
   0491 DD E1               219 	pop	ix
   0493 3E 04               220 	ld	a,#4
   0495 CF                  221 	rst	0x08
   0496 C9                  222 	ret
   0091                     223 _SameString_end::
                            224 ;strings.c:26: unsigned int Mod(unsigned int Dividend, unsigned int Divisor) {
                            225 ;	genLabel
                            226 ;	genFunction
                            227 ;	---------------------------------
                            228 ; Function Mod
                            229 ; ---------------------------------
   0091                     230 _Mod_start::
   0091                     231 _Mod:
   0497 3E 03               232 	ld	a,#3
   0499 CF                  233 	rst	0x08
   049A DD E5               234 	push	ix
   049C DD 21 00 00         235 	ld	ix,#0
   04A0 DD 39               236 	add	ix,sp
                            237 ;strings.c:28: Temp=Dividend;
                            238 ;	genAssign
                            239 ;	AOP_STK for 
   04A2 DD 4E 04            240 	ld	c,4(ix)
   04A5 DD 46 05            241 	ld	b,5(ix)
                            242 ;strings.c:29: while(Temp>=Divisor) {
                            243 ;	genLabel
   00A2                     244 00101$:
                            245 ;	genCmpLt
                            246 ;	AOP_STK for 
   04A8 79                  247 	ld	a,c
   04A9 DD 96 06            248 	sub	a,6(ix)
   04AC 78                  249 	ld	a,b
   04AD DD 9E 07            250 	sbc	a,7(ix)
   04B0 DA C0 04            251 	jp	c,00103$
                            252 ;strings.c:30: Temp-=Divisor;
                            253 ;	genMinus
                            254 ;	AOP_STK for 
   04B3 79                  255 	ld	a,c
   04B4 DD 96 06            256 	sub	a,6(ix)
   04B7 4F                  257 	ld	c,a
   04B8 78                  258 	ld	a,b
   04B9 DD 9E 07            259 	sbc	a,7(ix)
   04BC 47                  260 	ld	b,a
                            261 ;	genGoto
   04BD C3 A8 04            262 	jp	00101$
                            263 ;	genLabel
   00BA                     264 00103$:
                            265 ;strings.c:32: return Temp;
                            266 ;	genRet
                            267 ; Dump of IC_LEFT: type AOP_REG size 2
                            268 ;	 reg = bc
   04C0 69                  269 	ld	l,c
   04C1 60                  270 	ld	h,b
                            271 ;	genLabel
   00BC                     272 00104$:
                            273 ;	genEndFunction
   04C2 DD E1               274 	pop	ix
   04C4 3E 04               275 	ld	a,#4
   04C6 CF                  276 	rst	0x08
   04C7 C9                  277 	ret
   00C2                     278 _Mod_end::
                            279 ;strings.c:35: unsigned int Divide(unsigned int Dividend, int Divisor) {
                            280 ;	genLabel
                            281 ;	genFunction
                            282 ;	---------------------------------
                            283 ; Function Divide
                            284 ; ---------------------------------
   00C2                     285 _Divide_start::
   00C2                     286 _Divide:
   04C8 3E 03               287 	ld	a,#3
   04CA CF                  288 	rst	0x08
   04CB DD E5               289 	push	ix
   04CD DD 21 00 00         290 	ld	ix,#0
   04D1 DD 39               291 	add	ix,sp
   04D3 21 FE FF            292 	ld	hl,#-2
   04D6 39                  293 	add	hl,sp
   04D7 F9                  294 	ld	sp,hl
                            295 ;strings.c:39: Temp=Dividend;
                            296 ;	genAssign
                            297 ;	AOP_STK for 
   04D8 DD 4E 04            298 	ld	c,4(ix)
   04DB DD 46 05            299 	ld	b,5(ix)
                            300 ;strings.c:40: while(Temp>=Divisor) {
                            301 ;	genAssign
                            302 ;	AOP_STK for 
   04DE DD 6E 06            303 	ld	l,6(ix)
   04E1 DD 66 07            304 	ld	h,7(ix)
                            305 ;	genAssign
                            306 ;	AOP_STK for _Divide_i_1_1
   04E4 DD 36 FE 00         307 	ld	-2(ix),#0x00
   04E8 DD 36 FF 00         308 	ld	-1(ix),#0x00
                            309 ;	genLabel
   00E6                     310 00101$:
                            311 ;	genCmpLt
   04EC 79                  312 	ld	a,c
   04ED 95                  313 	sub	a,l
   04EE 78                  314 	ld	a,b
   04EF 9C                  315 	sbc	a,h
   04F0 DA 07 05            316 	jp	c,00103$
                            317 ;strings.c:41: Temp-=Divisor;
                            318 ;	genAssign
   04F3 5D                  319 	ld	e,l
   04F4 54                  320 	ld	d,h
                            321 ;	genMinus
   04F5 79                  322 	ld	a,c
   04F6 93                  323 	sub	a,e
   04F7 4F                  324 	ld	c,a
   04F8 78                  325 	ld	a,b
   04F9 9A                  326 	sbc	a,d
   04FA 47                  327 	ld	b,a
                            328 ;strings.c:42: i++;
                            329 ;	genPlus
                            330 ;	AOP_STK for _Divide_i_1_1
                            331 ;	genPlusIncr
   04FB DD 34 FE            332 	inc	-2(ix)
   04FE C2 04 05            333 	jp	nz,00108$
   0501 DD 34 FF            334 	inc	-1(ix)
   00FE                     335 00108$:
                            336 ;	genGoto
   0504 C3 EC 04            337 	jp	00101$
                            338 ;	genLabel
   0101                     339 00103$:
                            340 ;strings.c:44: return i;
                            341 ;	genRet
                            342 ;	AOP_STK for _Divide_i_1_1
                            343 ; Dump of IC_LEFT: type AOP_STK size 2
                            344 ;	 aop_stk -2
   0507 DD 6E FE            345 	ld	l,-2(ix)
   050A DD 66 FF            346 	ld	h,-1(ix)
                            347 ;	genLabel
   0107                     348 00104$:
                            349 ;	genEndFunction
   050D DD F9               350 	ld	sp,ix
   050F DD E1               351 	pop	ix
   0511 3E 04               352 	ld	a,#4
   0513 CF                  353 	rst	0x08
   0514 C9                  354 	ret
   010F                     355 _Divide_end::
                            356 ;strings.c:48: int Power(int Base, int Exponent) {
                            357 ;	genLabel
                            358 ;	genFunction
                            359 ;	---------------------------------
                            360 ; Function Power
                            361 ; ---------------------------------
   010F                     362 _Power_start::
   010F                     363 _Power:
   0515 3E 03               364 	ld	a,#3
   0517 CF                  365 	rst	0x08
   0518 DD E5               366 	push	ix
   051A DD 21 00 00         367 	ld	ix,#0
   051E DD 39               368 	add	ix,sp
   0520 21 FE FF            369 	ld	hl,#-2
   0523 39                  370 	add	hl,sp
   0524 F9                  371 	ld	sp,hl
                            372 ;strings.c:51: Temp=1;
                            373 ;	genAssign
                            374 ;	AOP_STK for _Power_Temp_1_1
   0525 DD 36 FE 01         375 	ld	-2(ix),#0x01
   0529 DD 36 FF 00         376 	ld	-1(ix),#0x00
                            377 ;strings.c:52: for(i=0; i<Exponent; i++) {
                            378 ;	genAssign
   052D 11 00 00            379 	ld	de,#0x0000
                            380 ;	genLabel
   012A                     381 00101$:
                            382 ;	genCmpLt
                            383 ;	AOP_STK for 
   0530 7B                  384 	ld	a,e
   0531 DD 96 06            385 	sub	a,6(ix)
   0534 7A                  386 	ld	a,d
   0535 DD 9E 07            387 	sbc	a,7(ix)
   0538 F2 5C 05            388 	jp	p,00104$
                            389 ;strings.c:53: Temp=Temp*Base;
                            390 ;	genIpush
                            391 ; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 0 deSending: 0
   053B D5                  392 	push	de
                            393 ;	AOP_STK for 
   053C DD 6E 04            394 	ld	l,4(ix)
   053F DD 66 05            395 	ld	h,5(ix)
   0542 E5                  396 	push	hl
                            397 ;	genIpush
                            398 ;	AOP_STK for _Power_Temp_1_1
   0543 DD 6E FE            399 	ld	l,-2(ix)
   0546 DD 66 FF            400 	ld	h,-1(ix)
   0549 E5                  401 	push	hl
                            402 ;	genCall
   054A CD AB 2B            403 	call	__mulint_rrf_s
   054D 44                  404 	ld	b,h
   054E 4D                  405 	ld	c,l
   054F F1                  406 	pop	af
   0550 F1                  407 	pop	af
   0551 D1                  408 	pop	de
                            409 ;	genAssign
                            410 ;	AOP_STK for _Power_Temp_1_1
   0552 DD 71 FE            411 	ld	-2(ix),c
   0555 DD 70 FF            412 	ld	-1(ix),b
                            413 ;strings.c:52: for(i=0; i<Exponent; i++) {
                            414 ;	genPlus
                            415 ;	genPlusIncr
   0558 13                  416 	inc	de
                            417 ;	genGoto
   0559 C3 30 05            418 	jp	00101$
                            419 ;	genLabel
   0156                     420 00104$:
                            421 ;strings.c:55: return Temp;
                            422 ;	genRet
                            423 ;	AOP_STK for _Power_Temp_1_1
                            424 ; Dump of IC_LEFT: type AOP_STK size 2
                            425 ;	 aop_stk -2
   055C DD 6E FE            426 	ld	l,-2(ix)
   055F DD 66 FF            427 	ld	h,-1(ix)
                            428 ;	genLabel
   015C                     429 00105$:
                            430 ;	genEndFunction
   0562 DD F9               431 	ld	sp,ix
   0564 DD E1               432 	pop	ix
   0566 3E 04               433 	ld	a,#4
   0568 CF                  434 	rst	0x08
   0569 C9                  435 	ret
   0164                     436 _Power_end::
                            437 ;strings.c:58: void WordToHex(unsigned int Number, char* String) {
                            438 ;	genLabel
                            439 ;	genFunction
                            440 ;	---------------------------------
                            441 ; Function WordToHex
                            442 ; ---------------------------------
   0164                     443 _WordToHex_start::
   0164                     444 _WordToHex:
   056A 3E 03               445 	ld	a,#3
   056C CF                  446 	rst	0x08
   056D DD E5               447 	push	ix
   056F DD 21 00 00         448 	ld	ix,#0
   0573 DD 39               449 	add	ix,sp
   0575 21 FC FF            450 	ld	hl,#-4
   0578 39                  451 	add	hl,sp
   0579 F9                  452 	ld	sp,hl
                            453 ;strings.c:61: Temp=Number;
                            454 ;	genAssign
                            455 ;	AOP_STK for 
                            456 ;	AOP_STK for _WordToHex_Temp_1_1
   057A DD 7E 04            457 	ld	a,4(ix)
   057D DD 77 FE            458 	ld	-2(ix),a
   0580 DD 7E 05            459 	ld	a,5(ix)
   0583 DD 77 FF            460 	ld	-1(ix),a
                            461 ;strings.c:62: for(i=3; i>=0; i--) {
                            462 ;	genAssign
   0586 11 03 00            463 	ld	de,#0x0003
                            464 ;	genLabel
   0183                     465 00104$:
                            466 ;	genCmpLt
   0589 7A                  467 	ld	a,d
   058A CB 7F               468 	bit	7,a
   058C C2 F8 05            469 	jp	nz,00107$
                            470 ;strings.c:63: Module=Temp&15;
                            471 ;	genAnd
                            472 ;	AOP_STK for _WordToHex_Temp_1_1
                            473 ;	AOP_STK for _WordToHex_Module_1_1
   058F DD 7E FE            474 	ld	a,-2(ix)
   0592 E6 0F               475 	and	a,#0x0F
   0594 DD 77 FC            476 	ld	-4(ix),a
   0597 DD 36 FD 00         477 	ld	-3(ix),#0x00
                            478 ;strings.c:64: if(Module<10) String[i]=Module+'0'; else String[i]=Module+'A'-10;
                            479 ;	genCmpLt
                            480 ;	AOP_STK for _WordToHex_Module_1_1
   059B DD 7E FC            481 	ld	a,-4(ix)
   059E D6 0A               482 	sub	a,#0x0A
   05A0 DD 7E FD            483 	ld	a,-3(ix)
   05A3 DE 00               484 	sbc	a,#0x00
   05A5 D2 C0 05            485 	jp	nc,00102$
                            486 ;	genPlus
                            487 ;	AOP_STK for 
                            488 ;	Can't optimise plus by inc, falling back to the normal way
   05A8 DD 6E 06            489 	ld	l,6(ix)
   05AB DD 66 07            490 	ld	h,7(ix)
   05AE 19                  491 	add	hl,de
                            492 ;	genPlus
                            493 ;	AOP_STK for _WordToHex_Module_1_1
                            494 ;	genPlusIncr
                            495 ;	Can't optimise plus by inc, falling back to the normal way
   05AF DD 7E FC            496 	ld	a,-4(ix)
   05B2 C6 30               497 	add	a,#0x30
   05B4 4F                  498 	ld	c,a
   05B5 DD 7E FD            499 	ld	a,-3(ix)
   05B8 CE 00               500 	adc	a,#0x00
   05BA 47                  501 	ld	b,a
                            502 ;	genCast
   05BB 79                  503 	ld	a,c
                            504 ;	genAssign (pointer)
                            505 ;	isBitvar = 0
   05BC 77                  506 	ld	(hl),a
                            507 ;	genGoto
   05BD C3 D5 05            508 	jp	00103$
                            509 ;	genLabel
   01BA                     510 00102$:
                            511 ;	genPlus
                            512 ;	AOP_STK for 
                            513 ;	Can't optimise plus by inc, falling back to the normal way
   05C0 DD 6E 06            514 	ld	l,6(ix)
   05C3 DD 66 07            515 	ld	h,7(ix)
   05C6 19                  516 	add	hl,de
                            517 ;	genMinus
                            518 ;	AOP_STK for _WordToHex_Module_1_1
   05C7 DD 7E FC            519 	ld	a,-4(ix)
   05CA C6 37               520 	add	a,#0x37
   05CC 4F                  521 	ld	c,a
   05CD DD 7E FD            522 	ld	a,-3(ix)
   05D0 CE 00               523 	adc	a,#0x00
   05D2 47                  524 	ld	b,a
                            525 ;	genCast
   05D3 79                  526 	ld	a,c
                            527 ;	genAssign (pointer)
                            528 ;	isBitvar = 0
   05D4 77                  529 	ld	(hl),a
                            530 ;	genLabel
   01CF                     531 00103$:
                            532 ;strings.c:65: Temp=(Temp>>4)&0xfff;
                            533 ;	genRightShift
                            534 ;	AOP_STK for _WordToHex_Temp_1_1
   05D5 DD 4E FE            535 	ld	c,-2(ix)
   05D8 DD 46 FF            536 	ld	b,-1(ix)
   05DB CB 38               537 	srl	b
   05DD CB 19               538 	rr	c
   05DF CB 38               539 	srl	b
   05E1 CB 19               540 	rr	c
   05E3 CB 38               541 	srl	b
   05E5 CB 19               542 	rr	c
   05E7 CB 38               543 	srl	b
   05E9 CB 19               544 	rr	c
                            545 ;	genAnd
                            546 ;	AOP_STK for _WordToHex_Temp_1_1
   05EB DD 71 FE            547 	ld	-2(ix),c
   05EE 78                  548 	ld	a,b
   05EF E6 0F               549 	and	a,#0x0F
   05F1 DD 77 FF            550 	ld	-1(ix),a
                            551 ;strings.c:62: for(i=3; i>=0; i--) {
                            552 ;	genMinus
   05F4 1B                  553 	dec	de
                            554 ;	genGoto
   05F5 C3 89 05            555 	jp	00104$
                            556 ;	genLabel
   01F2                     557 00107$:
                            558 ;strings.c:67: String[4]='\0';
                            559 ;	genPlus
                            560 ;	AOP_STK for 
                            561 ;	genPlusIncr
                            562 ;	Can't optimise plus by inc, falling back to the normal way
   05F8 DD 7E 06            563 	ld	a,6(ix)
   05FB C6 04               564 	add	a,#0x04
   05FD 6F                  565 	ld	l,a
   05FE DD 7E 07            566 	ld	a,7(ix)
   0601 CE 00               567 	adc	a,#0x00
   0603 67                  568 	ld	h,a
                            569 ;	genAssign (pointer)
                            570 ;	isBitvar = 0
   0604 36 00               571 	ld	(hl),#0x00
                            572 ;	genLabel
   0200                     573 00108$:
                            574 ;	genEndFunction
   0606 DD F9               575 	ld	sp,ix
   0608 DD E1               576 	pop	ix
   060A 3E 04               577 	ld	a,#4
   060C CF                  578 	rst	0x08
   060D C9                  579 	ret
   0208                     580 _WordToHex_end::
                            581 ;strings.c:71: void WordToString(unsigned int Number, char* String) {
                            582 ;	genLabel
                            583 ;	genFunction
                            584 ;	---------------------------------
                            585 ; Function WordToString
                            586 ; ---------------------------------
   0208                     587 _WordToString_start::
   0208                     588 _WordToString:
   060E 3E 03               589 	ld	a,#3
   0610 CF                  590 	rst	0x08
   0611 DD E5               591 	push	ix
   0613 DD 21 00 00         592 	ld	ix,#0
   0617 DD 39               593 	add	ix,sp
   0619 21 FE FF            594 	ld	hl,#-2
   061C 39                  595 	add	hl,sp
   061D F9                  596 	ld	sp,hl
                            597 ;strings.c:74: Temp=Number;
                            598 ;	genAssign
                            599 ;	AOP_STK for 
   061E DD 4E 04            600 	ld	c,4(ix)
   0621 DD 46 05            601 	ld	b,5(ix)
                            602 ;strings.c:75: for(i=0; i<7; i++) String[i]=' ';
                            603 ;	genAssign
   0624 11 00 00            604 	ld	de,#0x0000
                            605 ;	genLabel
   0221                     606 00104$:
                            607 ;	genCmpLt
   0627 7B                  608 	ld	a,e
   0628 D6 07               609 	sub	a,#0x07
   062A 7A                  610 	ld	a,d
   062B DE 00               611 	sbc	a,#0x00
   062D F2 3D 06            612 	jp	p,00113$
                            613 ;	genPlus
                            614 ;	AOP_STK for 
                            615 ;	Can't optimise plus by inc, falling back to the normal way
   0630 DD 6E 06            616 	ld	l,6(ix)
   0633 DD 66 07            617 	ld	h,7(ix)
   0636 19                  618 	add	hl,de
                            619 ;	genAssign (pointer)
                            620 ;	isBitvar = 0
   0637 36 20               621 	ld	(hl),#0x20
                            622 ;	genPlus
                            623 ;	genPlusIncr
   0639 13                  624 	inc	de
                            625 ;	genGoto
   063A C3 27 06            626 	jp	00104$
                            627 ;strings.c:77: while(Temp!=0) {
                            628 ;	genLabel
   0237                     629 00113$:
                            630 ;	genAssign
                            631 ;	AOP_STK for _WordToString_i_1_1
   063D DD 36 FE 00         632 	ld	-2(ix),#0x00
   0641 DD 36 FF 00         633 	ld	-1(ix),#0x00
                            634 ;	genLabel
   023F                     635 00101$:
                            636 ;	genCmpEq
                            637 ; genCmpEq: left 2, right 2, result 0
   0645 79                  638 	ld	a,c
   0646 B0                  639 	or	a,b
   0647 CA 92 06            640 	jp	z,00103$
   0244                     641 00114$:
                            642 ;strings.c:78: String[5-i]=Mod(Temp, 10)+'0';
                            643 ;	genMinus
                            644 ;	AOP_STK for _WordToString_i_1_1
   064A 3E 05               645 	ld	a,#0x05
   064C DD 96 FE            646 	sub	a,-2(ix)
   064F 6F                  647 	ld	l,a
   0650 3E 00               648 	ld	a,#0x00
   0652 DD 9E FF            649 	sbc	a,-1(ix)
   0655 67                  650 	ld	h,a
                            651 ;	genPlus
                            652 ;	AOP_STK for 
                            653 ;	Can't optimise plus by inc, falling back to the normal way
   0656 DD 7E 06            654 	ld	a,6(ix)
   0659 85                  655 	add	a,l
   065A 5F                  656 	ld	e,a
   065B DD 7E 07            657 	ld	a,7(ix)
   065E 8C                  658 	adc	a,h
   065F 57                  659 	ld	d,a
                            660 ;	genIpush
                            661 ; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
   0660 C5                  662 	push	bc
   0661 D5                  663 	push	de
   0662 21 0A 00            664 	ld	hl,#0x000A
   0665 E5                  665 	push	hl
                            666 ;	genIpush
   0666 C5                  667 	push	bc
                            668 ;	genCall
   0667 CD 97 04            669 	call	_Mod
   066A F1                  670 	pop	af
   066B F1                  671 	pop	af
   066C D1                  672 	pop	de
   066D C1                  673 	pop	bc
                            674 ;	genPlus
                            675 ;	genPlusIncr
                            676 ;	Can't optimise plus by inc, falling back to the normal way
   066E 7D                  677 	ld	a,l
   066F C6 30               678 	add	a,#0x30
   0671 6F                  679 	ld	l,a
   0672 7C                  680 	ld	a,h
   0673 CE 00               681 	adc	a,#0x00
   0675 67                  682 	ld	h,a
                            683 ;	genCast
   0676 7D                  684 	ld	a,l
                            685 ;	genAssign (pointer)
                            686 ;	isBitvar = 0
   0677 12                  687 	ld	(de),a
                            688 ;strings.c:79: Temp=Divide(Temp, 10);
                            689 ;	genIpush
                            690 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   0678 C5                  691 	push	bc
   0679 21 0A 00            692 	ld	hl,#0x000A
   067C E5                  693 	push	hl
                            694 ;	genIpush
   067D C5                  695 	push	bc
                            696 ;	genCall
   067E CD C8 04            697 	call	_Divide
   0681 F1                  698 	pop	af
   0682 F1                  699 	pop	af
   0683 C1                  700 	pop	bc
                            701 ;	genAssign
   0684 4D                  702 	ld	c,l
   0685 44                  703 	ld	b,h
                            704 ;strings.c:80: i++;
                            705 ;	genPlus
                            706 ;	AOP_STK for _WordToString_i_1_1
                            707 ;	genPlusIncr
   0686 DD 34 FE            708 	inc	-2(ix)
   0689 C2 8F 06            709 	jp	nz,00115$
   068C DD 34 FF            710 	inc	-1(ix)
   0289                     711 00115$:
                            712 ;	genGoto
   068F C3 45 06            713 	jp	00101$
                            714 ;	genLabel
   028C                     715 00103$:
                            716 ;strings.c:82: String[6]='\0';
                            717 ;	genPlus
                            718 ;	AOP_STK for 
                            719 ;	genPlusIncr
                            720 ;	Can't optimise plus by inc, falling back to the normal way
   0692 DD 7E 06            721 	ld	a,6(ix)
   0695 C6 06               722 	add	a,#0x06
   0697 6F                  723 	ld	l,a
   0698 DD 7E 07            724 	ld	a,7(ix)
   069B CE 00               725 	adc	a,#0x00
   069D 67                  726 	ld	h,a
                            727 ;	genAssign (pointer)
                            728 ;	isBitvar = 0
   069E 36 00               729 	ld	(hl),#0x00
                            730 ;	genLabel
   029A                     731 00108$:
                            732 ;	genEndFunction
   06A0 DD F9               733 	ld	sp,ix
   06A2 DD E1               734 	pop	ix
   06A4 3E 04               735 	ld	a,#4
   06A6 CF                  736 	rst	0x08
   06A7 C9                  737 	ret
   02A2                     738 _WordToString_end::
                            739 ;strings.c:86: void IntToString(int Number, char* String) {
                            740 ;	genLabel
                            741 ;	genFunction
                            742 ;	---------------------------------
                            743 ; Function IntToString
                            744 ; ---------------------------------
   02A2                     745 _IntToString_start::
   02A2                     746 _IntToString:
   06A8 3E 03               747 	ld	a,#3
   06AA CF                  748 	rst	0x08
   06AB DD E5               749 	push	ix
   06AD DD 21 00 00         750 	ld	ix,#0
   06B1 DD 39               751 	add	ix,sp
   06B3 21 FE FF            752 	ld	hl,#-2
   06B6 39                  753 	add	hl,sp
   06B7 F9                  754 	ld	sp,hl
                            755 ;strings.c:89: Temp=Number;
                            756 ;	genAssign
                            757 ;	AOP_STK for 
   06B8 DD 4E 04            758 	ld	c,4(ix)
   06BB DD 46 05            759 	ld	b,5(ix)
                            760 ;strings.c:90: for(i=0; i<7; i++) String[i]=' ';
                            761 ;	genAssign
   06BE 11 00 00            762 	ld	de,#0x0000
                            763 ;	genLabel
   02BB                     764 00106$:
                            765 ;	genCmpLt
   06C1 7B                  766 	ld	a,e
   06C2 D6 07               767 	sub	a,#0x07
   06C4 7A                  768 	ld	a,d
   06C5 DE 00               769 	sbc	a,#0x00
   06C7 F2 D7 06            770 	jp	p,00109$
                            771 ;	genPlus
                            772 ;	AOP_STK for 
                            773 ;	Can't optimise plus by inc, falling back to the normal way
   06CA DD 6E 06            774 	ld	l,6(ix)
   06CD DD 66 07            775 	ld	h,7(ix)
   06D0 19                  776 	add	hl,de
                            777 ;	genAssign (pointer)
                            778 ;	isBitvar = 0
   06D1 36 20               779 	ld	(hl),#0x20
                            780 ;	genPlus
                            781 ;	genPlusIncr
   06D3 13                  782 	inc	de
                            783 ;	genGoto
   06D4 C3 C1 06            784 	jp	00106$
                            785 ;	genLabel
   02D1                     786 00109$:
                            787 ;strings.c:91: i=0;
                            788 ;	genAssign
   06D7 11 00 00            789 	ld	de,#0x0000
                            790 ;strings.c:92: if(Temp<0) {
                            791 ;	genCmpLt
   06DA 78                  792 	ld	a,b
   06DB CB 7F               793 	bit	7,a
   06DD CA F2 06            794 	jp	z,00116$
                            795 ;strings.c:93: Temp=-Temp;
                            796 ;	genUminus
   06E0 AF                  797 	xor     a,a
   06E1 99                  798 	sbc	a,c
   06E2 4F                  799 	ld	c,a
   06E3 3E 00               800 	ld	a,#0x00
   06E5 98                  801 	sbc	a,b
   06E6 47                  802 	ld	b,a
                            803 ;strings.c:94: String[i]='-';
                            804 ;	genAssign
                            805 ;	AOP_STK for 
   06E7 DD 6E 06            806 	ld	l,6(ix)
   06EA DD 66 07            807 	ld	h,7(ix)
                            808 ;	genAssign (pointer)
                            809 ;	isBitvar = 0
   06ED 36 2D               810 	ld	(hl),#0x2D
                            811 ;strings.c:95: i++;
                            812 ;	genAssign
   06EF 11 01 00            813 	ld	de,#0x0001
                            814 ;strings.c:97: while(Temp!=0) {
                            815 ;	genLabel
   02EC                     816 00116$:
                            817 ;	genAssign
                            818 ;	AOP_STK for _IntToString_i_1_1
   06F2 DD 73 FE            819 	ld	-2(ix),e
   06F5 DD 72 FF            820 	ld	-1(ix),d
                            821 ;	genLabel
   02F2                     822 00103$:
                            823 ;	genCmpEq
                            824 ; genCmpEq: left 2, right 2, result 0
   06F8 79                  825 	ld	a,c
   06F9 B0                  826 	or	a,b
   06FA CA 45 07            827 	jp	z,00105$
   02F7                     828 00117$:
                            829 ;strings.c:98: String[5-i]=Mod(Temp, 10)+'0';
                            830 ;	genMinus
                            831 ;	AOP_STK for _IntToString_i_1_1
   06FD 3E 05               832 	ld	a,#0x05
   06FF DD 96 FE            833 	sub	a,-2(ix)
   0702 6F                  834 	ld	l,a
   0703 3E 00               835 	ld	a,#0x00
   0705 DD 9E FF            836 	sbc	a,-1(ix)
   0708 67                  837 	ld	h,a
                            838 ;	genPlus
                            839 ;	AOP_STK for 
                            840 ;	Can't optimise plus by inc, falling back to the normal way
   0709 DD 7E 06            841 	ld	a,6(ix)
   070C 85                  842 	add	a,l
   070D 5F                  843 	ld	e,a
   070E DD 7E 07            844 	ld	a,7(ix)
   0711 8C                  845 	adc	a,h
   0712 57                  846 	ld	d,a
                            847 ;	genIpush
                            848 ; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
   0713 C5                  849 	push	bc
   0714 D5                  850 	push	de
   0715 21 0A 00            851 	ld	hl,#0x000A
   0718 E5                  852 	push	hl
                            853 ;	genIpush
   0719 C5                  854 	push	bc
                            855 ;	genCall
   071A CD 97 04            856 	call	_Mod
   071D F1                  857 	pop	af
   071E F1                  858 	pop	af
   071F D1                  859 	pop	de
   0720 C1                  860 	pop	bc
                            861 ;	genPlus
                            862 ;	genPlusIncr
                            863 ;	Can't optimise plus by inc, falling back to the normal way
   0721 7D                  864 	ld	a,l
   0722 C6 30               865 	add	a,#0x30
   0724 6F                  866 	ld	l,a
   0725 7C                  867 	ld	a,h
   0726 CE 00               868 	adc	a,#0x00
   0728 67                  869 	ld	h,a
                            870 ;	genCast
   0729 7D                  871 	ld	a,l
                            872 ;	genAssign (pointer)
                            873 ;	isBitvar = 0
   072A 12                  874 	ld	(de),a
                            875 ;strings.c:99: Temp=Divide(Temp, 10);
                            876 ;	genIpush
                            877 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   072B C5                  878 	push	bc
   072C 21 0A 00            879 	ld	hl,#0x000A
   072F E5                  880 	push	hl
                            881 ;	genIpush
   0730 C5                  882 	push	bc
                            883 ;	genCall
   0731 CD C8 04            884 	call	_Divide
   0734 F1                  885 	pop	af
   0735 F1                  886 	pop	af
   0736 C1                  887 	pop	bc
                            888 ;	genAssign
                            889 ;	genAssign
   0737 4D                  890 	ld	c,l
   0738 44                  891 	ld	b,h
                            892 ;strings.c:100: i++;
                            893 ;	genPlus
                            894 ;	AOP_STK for _IntToString_i_1_1
                            895 ;	genPlusIncr
   0739 DD 34 FE            896 	inc	-2(ix)
   073C C2 42 07            897 	jp	nz,00118$
   073F DD 34 FF            898 	inc	-1(ix)
   033C                     899 00118$:
                            900 ;	genGoto
   0742 C3 F8 06            901 	jp	00103$
                            902 ;	genLabel
   033F                     903 00105$:
                            904 ;strings.c:102: String[6]='\0';
                            905 ;	genPlus
                            906 ;	AOP_STK for 
                            907 ;	genPlusIncr
                            908 ;	Can't optimise plus by inc, falling back to the normal way
   0745 DD 7E 06            909 	ld	a,6(ix)
   0748 C6 06               910 	add	a,#0x06
   074A 6F                  911 	ld	l,a
   074B DD 7E 07            912 	ld	a,7(ix)
   074E CE 00               913 	adc	a,#0x00
   0750 67                  914 	ld	h,a
                            915 ;	genAssign (pointer)
                            916 ;	isBitvar = 0
   0751 36 00               917 	ld	(hl),#0x00
                            918 ;	genLabel
   034D                     919 00110$:
                            920 ;	genEndFunction
   0753 DD F9               921 	ld	sp,ix
   0755 DD E1               922 	pop	ix
   0757 3E 04               923 	ld	a,#4
   0759 CF                  924 	rst	0x08
   075A C9                  925 	ret
   0355                     926 _IntToString_end::
                            927 	.area _CODE
