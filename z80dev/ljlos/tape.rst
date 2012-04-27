                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.5 Fri Apr 27 12:30:19 2012
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module tape
                              7 	.optsdcc -mz80
                              8 	
                              9 ;--------------------------------------------------------
                             10 ; Public variables in this module
                             11 ;--------------------------------------------------------
                             12 	.globl _SaveBlock
                             13 	.globl _TapeSave
                             14 	.globl _TapeLoad
                             15 	.globl _TapeSaveManchester
                             16 	.globl _TapeSaveC
                             17 	.globl _PortOutput
                             18 	.globl _TapeInit
                             19 	.globl _TapeInited
                             20 	.globl _TapeHalfWaveLength
                             21 	.globl _TapeMeanWaveLength
                             22 ;--------------------------------------------------------
                             23 ;  ram data
                             24 ;--------------------------------------------------------
                             25 	.area _DATA
                    0000     26 G$TapeMeanWaveLength$0$0==.
   0000                      27 _TapeMeanWaveLength::
   0000                      28 	.ds 1
                    0001     29 G$TapeHalfWaveLength$0$0==.
   0001                      30 _TapeHalfWaveLength::
   0001                      31 	.ds 1
                    0002     32 G$TapeInited$0$0==.
   0002                      33 _TapeInited::
   0002                      34 	.ds 1
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
                             57 ;tape.c:7: bool TapeInited; void TapeInit() {
                             58 ;	genLabel
                             59 ;	genFunction
                             60 ;	---------------------------------
                             61 ; Function TapeInit
                             62 ; ---------------------------------
   0000                      63 _TapeInit_start::
   0000                      64 _TapeInit:
   2868 3E 03                65 	ld	a,#3
   286A CF                   66 	rst	0x08
                             67 ;tape.c:8: if(!TapeInited) {
                             68 ;	genIfx
   286B AF                   69 	xor	a,a
   286C FD 21 61 83          70 	ld	iy,#_TapeInited
   2870 FD B6 00             71 	or	a,0(iy)
   2873 C2 8E 28             72 	jp	nz,00103$
                             73 ;tape.c:9: TapeHalfWaveLength=60;
                             74 ;	genAssign
   2876 FD 21 60 83          75 	ld	iy,#_TapeHalfWaveLength
   287A FD 36 00 3C          76 	ld	0(iy),#0x3C
                             77 ;tape.c:10: TapeMeanWaveLength=(TapeHalfWaveLength*3)/2;
                             78 ;	genAssign
   287E FD 21 5F 83          79 	ld	iy,#_TapeMeanWaveLength
   2882 FD 36 00 5A          80 	ld	0(iy),#0x5A
                             81 ;tape.c:11: TapeInited=TRUE;
                             82 ;	genAssign
   2886 FD 21 61 83          83 	ld	iy,#_TapeInited
   288A FD 36 00 01          84 	ld	0(iy),#0x01
                             85 ;	genLabel
   0026                      86 00103$:
                             87 ;	genEndFunction
   288E 3E 04                88 	ld	a,#4
   2890 CF                   89 	rst	0x08
   2891 C9                   90 	ret
   002A                      91 _TapeInit_end::
                             92 ;tape.c:15: void PortOutput(char PortNumber, char Value) {
                             93 ;	genLabel
                             94 ;	genFunction
                             95 ;	---------------------------------
                             96 ; Function PortOutput
                             97 ; ---------------------------------
   002A                      98 _PortOutput_start::
   002A                      99 _PortOutput:
   2892 3E 03               100 	ld	a,#3
   2894 CF                  101 	rst	0x08
   2895 DD E5               102 	push	ix
   2897 DD 21 00 00         103 	ld	ix,#0
   289B DD 39               104 	add	ix,sp
                            105 ;tape.c:20: _endasm;
                            106 ;	genInline
                            107 	
   289D DD 4E 04            108 		       ld c,4(ix)
   28A0 DD 56 05            109 		       ld d,5(ix)
   28A3 ED 51               110 		       out (c),d
                            111 		       
                            112 ;	genLabel
   003D                     113 00101$:
                            114 ;	genEndFunction
   28A5 DD E1               115 	pop	ix
   28A7 3E 04               116 	ld	a,#4
   28A9 CF                  117 	rst	0x08
   28AA C9                  118 	ret
   0043                     119 _PortOutput_end::
                            120 ;tape.c:23: void TapeSaveC(void *Start, void* End) {
                            121 ;	genLabel
                            122 ;	genFunction
                            123 ;	---------------------------------
                            124 ; Function TapeSaveC
                            125 ; ---------------------------------
   0043                     126 _TapeSaveC_start::
   0043                     127 _TapeSaveC:
   28AB 3E 03               128 	ld	a,#3
   28AD CF                  129 	rst	0x08
   28AE DD E5               130 	push	ix
   28B0 DD 21 00 00         131 	ld	ix,#0
   28B4 DD 39               132 	add	ix,sp
   28B6 21 FC FF            133 	ld	hl,#-4
   28B9 39                  134 	add	hl,sp
   28BA F9                  135 	ld	sp,hl
                            136 ;tape.c:28: for(i=Start; i<End; i++) {
                            137 ;	genAssign
                            138 ;	AOP_STK for 
                            139 ;	AOP_STK for _TapeSaveC_i_1_1
   28BB DD 7E 04            140 	ld	a,4(ix)
   28BE DD 77 FE            141 	ld	-2(ix),a
   28C1 DD 7E 05            142 	ld	a,5(ix)
   28C4 DD 77 FF            143 	ld	-1(ix),a
                            144 ;	genCmpLt
                            145 ;	AOP_STK for _TapeSaveC_i_1_1
                            146 ;	AOP_STK for 
   28C7 DD 7E FE            147 	ld	a,-2(ix)
   28CA DD 96 06            148 	sub	a,6(ix)
   28CD DD 7E FF            149 	ld	a,-1(ix)
   28D0 DD 9E 07            150 	sbc	a,7(ix)
   28D3 07                  151 	rlca
   28D4 E6 01               152 	and     a,#0x01
   28D6 5F                  153 	ld	e,a
                            154 ;	genLabel
   006F                     155 00108$:
                            156 ;	genIfx
   28D7 AF                  157 	xor	a,a
   28D8 B3                  158 	or	a,e
   28D9 CA 24 29            159 	jp	z,00112$
                            160 ;tape.c:29: Byte=*((char*)i);
                            161 ;	genPointerGet
                            162 ;	AOP_STK for _TapeSaveC_i_1_1
   28DC DD 6E FE            163 	ld	l,-2(ix)
   28DF DD 66 FF            164 	ld	h,-1(ix)
   28E2 6E                  165 	ld	l,(hl)
                            166 ;	genAssign
   28E3 55                  167 	ld	d,l
                            168 ;tape.c:30: for(j=0; j<8; j++) {
                            169 ;	genAssign
                            170 ;	AOP_STK for _TapeSaveC_j_1_1
   28E4 DD 36 FD 08         171 	ld	-3(ix),#0x08
                            172 ;	genLabel
   0080                     173 00107$:
                            174 ;tape.c:31: Byte=Byte>>1;
                            175 ;	genRightShift
   28E8 42                  176 	ld	b,d
   28E9 CB 28               177 	sra	b
                            178 ;	genAssign
   28EB 50                  179 	ld	d,b
                            180 ;tape.c:32: Condition=Byte&1;
                            181 ;	genAnd
                            182 ;	AOP_STK for _TapeSaveC__1_0
   28EC 7A                  183 	ld	a,d
   28ED E6 01               184 	and	a,#0x01
   28EF DD 77 FC            185 	ld	-4(ix),a
                            186 ;	genAssign
                            187 ;	AOP_STK for _TapeSaveC__1_0
   28F2 DD 4E FC            188 	ld	c,-4(ix)
                            189 ;tape.c:33: if(Condition) PortOutput(0xfe, 0x02);
                            190 ;	genIfx
   28F5 AF                  191 	xor	a,a
   28F6 B1                  192 	or	a,c
   28F7 CA 06 29            193 	jp	z,00102$
                            194 ;	genIpush
                            195 ; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
   28FA C5                  196 	push	bc
   28FB D5                  197 	push	de
   28FC 21 FE 02            198 	ld	hl,#0x02FE
   28FF E5                  199 	push	hl
                            200 ;	genCall
   2900 CD 92 28            201 	call	_PortOutput
   2903 F1                  202 	pop	af
   2904 D1                  203 	pop	de
   2905 C1                  204 	pop	bc
                            205 ;	genLabel
   009E                     206 00102$:
                            207 ;tape.c:34: if(!Condition) PortOutput(0xfe, 0x0d);
                            208 ;	genIfx
   2906 AF                  209 	xor	a,a
   2907 B1                  210 	or	a,c
   2908 C2 17 29            211 	jp	nz,00104$
                            212 ;	genIpush
                            213 ; _saveRegsForCall: sendSetSize: 0 deInUse: 1 bcInUse: 1 deSending: 0
   290B C5                  214 	push	bc
   290C D5                  215 	push	de
   290D 21 FE 0D            216 	ld	hl,#0x0DFE
   2910 E5                  217 	push	hl
                            218 ;	genCall
   2911 CD 92 28            219 	call	_PortOutput
   2914 F1                  220 	pop	af
   2915 D1                  221 	pop	de
   2916 C1                  222 	pop	bc
                            223 ;	genLabel
   00AF                     224 00104$:
                            225 ;	genMinus
                            226 ;	AOP_STK for _TapeSaveC_j_1_1
   2917 DD 35 FD            227 	dec	-3(ix)
                            228 ;tape.c:30: for(j=0; j<8; j++) {
                            229 ;	genIfx
                            230 ;	AOP_STK for _TapeSaveC_j_1_1
   291A AF                  231 	xor	a,a
   291B DD B6 FD            232 	or	a,-3(ix)
   291E C2 E8 28            233 	jp	nz,00107$
                            234 ;tape.c:28: for(i=Start; i<End; i++) {
                            235 ;	genGoto
   2921 C3 D7 28            236 	jp	00108$
                            237 ;	genLabel
   00BC                     238 00112$:
                            239 ;	genEndFunction
   2924 DD F9               240 	ld	sp,ix
   2926 DD E1               241 	pop	ix
   2928 3E 04               242 	ld	a,#4
   292A CF                  243 	rst	0x08
   292B C9                  244 	ret
   00C4                     245 _TapeSaveC_end::
                            246 ;tape.c:39: void TapeSaveManchester(void *StartPosition, void* StopPosition) {
                            247 ;	genLabel
                            248 ;	genFunction
                            249 ;	---------------------------------
                            250 ; Function TapeSaveManchester
                            251 ; ---------------------------------
   00C4                     252 _TapeSaveManchester_start::
   00C4                     253 _TapeSaveManchester:
   292C 3E 03               254 	ld	a,#3
   292E CF                  255 	rst	0x08
   292F DD E5               256 	push	ix
   2931 DD 21 00 00         257 	ld	ix,#0
   2935 DD 39               258 	add	ix,sp
                            259 ;tape.c:80: _endasm;
                            260 ;	genInline
                            261 	
                            262 	
   00CF                     263         ManchesterLoadByte:
   2937 46                  264 		       ld b,(hl)
   2938 0E 07               265 		       ld c,#7
   293A 23                  266 		       inc hl
   293B 7C                  267 		       ld a,h
   293C DD BE 07            268 		       cp a,7(ix)
   293F C2 49 29            269 		       jp nz,ManchesterDoBit
   2942 7D                  270 		       ld a,l
   2943 DD BE 06            271 		       cp a,6(ix)
   2946 CA 68 29            272 		       jp z,ManchesterEnd
                            273 	
   00E1                     274         ManchesterDoBit:
   2949 CB 20               275 		       sla b ; 8
   294B D2 53 29            276 		       jp nc,Manchester0 ; 10
                            277 	
   00E6                     278         Manchester1:
   294E 3E 02               279 		       ld a,£0x02 ; 7
   2950 C3 58 29            280 		       jp ManchesterWriteBit ; 10
                            281 	
   00EB                     282         Manchester0:
   2953 3E 0D               283 		       ld a,£0x0d
   2955 C3 58 29            284 		       jp ManchesterWriteBit
                            285 	
   00F0                     286         ManchesterWriteBit:
   2958 D3 FE               287 		       out (0xfe),a
   295A EE 11               288 		       xor a,£0x11 ; cambiare
                            289 	
   295C D3 FE               290 		       out (0xfe),a
                            291 	
   00F6                     292         ManchesterEndLoop:
   295E 0D                  293 		       dec c ; 4
   295F CA 37 29            294 		       jp z,ManchesterLoadByte ; 10
                            295 		       ; just wait
   2962 C3 65 29            296 		       jp ManchesterNext ; 10
   00FD                     297         ManchesterNext:
   2965 C3 49 29            298 		       jp ManchesterDoBit ; 10
                            299 	
   0100                     300         ManchesterEnd:
                            301 		       
                            302 ;	genLabel
   0100                     303 00101$:
                            304 ;	genEndFunction
   2968 DD E1               305 	pop	ix
   296A 3E 04               306 	ld	a,#4
   296C CF                  307 	rst	0x08
   296D C9                  308 	ret
   0106                     309 _TapeSaveManchester_end::
                            310 ;tape.c:83: void TapeLoad(void* StartPosition, void* StopPosition) {
                            311 ;	genLabel
                            312 ;	genFunction
                            313 ;	---------------------------------
                            314 ; Function TapeLoad
                            315 ; ---------------------------------
   0106                     316 _TapeLoad_start::
   0106                     317 _TapeLoad:
   296E 3E 03               318 	ld	a,#3
   2970 CF                  319 	rst	0x08
   2971 DD E5               320 	push	ix
   2973 DD 21 00 00         321 	ld	ix,#0
   2977 DD 39               322 	add	ix,sp
                            323 ;tape.c:145: _endasm;
                            324 ;	genInline
                            325 	
   2979 DD 6E 04            326 		       ld l,4(ix)
   297C DD 66 05            327 		       ld h,5(ix)
   297F DD 5E 06            328 		       ld e,6(ix)
   2982 DD 56 07            329 		       ld d,7(ix)
                            330 	
   2985 06 07               331 		       ld b,£7
                            332 	
   011F                     333         WaitBit:
   2987 0E 00               334 		       ld c,£0
                            335 	
   0121                     336         WaitTrigger1:
   2989 0C                  337 		       inc c
   298A DB FE               338 		       in a,(0xfe)
   298C CB 77               339 		       bit 6,a
   298E C2 89 29            340 		       jp nz, WaitTrigger1
                            341 	
   2991 3E 0A               342 		       ld a,£10
   2993 B9                  343 		       cp a,c
   2994 F2 89 29            344 		       jp p,WaitTrigger1
                            345 	
   012F                     346         Border1:
   2997 3E 01               347 		       ld a,£0x01
   2999 D3 FE               348 		       out (0xfe),a
                            349 	
   0133                     350         WaitTrigger2:
   299B 0C                  351 		       inc c
   299C DB FE               352 		       in a,(0xfe)
   299E CB 77               353 		       bit 6,a
   29A0 CA 9B 29            354 		       jp z, WaitTrigger2
                            355 	
   29A3 3E 14               356 		       ld a,£20
   29A5 B9                  357 		       cp a,c
   29A6 F2 9B 29            358 		       jp p,WaitTrigger2
                            359 	
   0141                     360         Border2:
   29A9 3E 05               361 		       ld a,£0x05
   29AB D3 FE               362 		       out (0xfe),a
                            363 	
   29AD 05                  364 		       dec b
   29AE C2 B4 29            365 		       jp nz,DoBit
                            366 	
   29B1 06 07               367 		       ld b,£7
   29B3 23                  368 		       inc hl
                            369 	
   014C                     370         DoBit:
   29B4 CB 26               371 		       sla (hl)
                            372 	
   29B6 3A 5F 83            373 		       ld a,(_TapeMeanWaveLength)
   29B9 B9                  374 		       cp a,c
   29BA D2 BE 29            375 		       jp nc,EndBit
                            376 	
   29BD 34                  377 		       inc (hl)
                            378 	
   0156                     379         EndBit:
   29BE 7C                  380 		       ld a,h
   29BF BA                  381 		       cp a,d
   29C0 C2 87 29            382 		       jp nz,WaitBit
   29C3 7D                  383 		       ld a,l
   29C4 BB                  384 		       cp a,e
   29C5 C2 87 29            385 		       jp nz,WaitBit
                            386 		       
                            387 ;	genLabel
   0160                     388 00101$:
                            389 ;	genEndFunction
   29C8 DD E1               390 	pop	ix
   29CA 3E 04               391 	ld	a,#4
   29CC CF                  392 	rst	0x08
   29CD C9                  393 	ret
   0166                     394 _TapeLoad_end::
                            395 ;tape.c:148: void TapeSave(void* StartPosition, void* EndPosition) {
                            396 ;	genLabel
                            397 ;	genFunction
                            398 ;	---------------------------------
                            399 ; Function TapeSave
                            400 ; ---------------------------------
   0166                     401 _TapeSave_start::
   0166                     402 _TapeSave:
   29CE 3E 03               403 	ld	a,#3
   29D0 CF                  404 	rst	0x08
   29D1 DD E5               405 	push	ix
   29D3 DD 21 00 00         406 	ld	ix,#0
   29D7 DD 39               407 	add	ix,sp
                            408 ;tape.c:200: _endasm;
                            409 ;	genInline
                            410 	
   29D9 DD 6E 04            411 		       ld l,4(ix)
   29DC DD 66 05            412 		       ld h,5(ix)
   29DF DD 5E 06            413 		       ld e,6(ix)
   29E2 DD 56 07            414 		       ld d,7(ix)
                            415 	
   29E5 06 07               416 		       ld b,£7
                            417 	
   017F                     418         SaveStart:
   29E7 3A 60 83            419 		       ld a,(_TapeHalfWaveLength)
   29EA 57                  420 		       ld d,a
                            421 	
   29EB 05                  422 		       dec b
   29EC C2 F2 29            423 		       jp nz,SaveDoBit
                            424 	
   29EF 06 07               425 		       ld b,£7
   29F1 23                  426 		       inc hl
                            427 	
   018A                     428         SaveDoBit:
   29F2 CB 26               429 		       sla (hl)
   29F4 D2 F9 29            430 		       jp nc, SaveWriteBit
                            431 	
   29F7 CB 22               432 		       sla d
                            433 	
   0191                     434         SaveWriteBit:
   29F9 4A                  435 		       ld c,d
                            436 	
   0192                     437         SaveWriteTrigger1:
   29FA 00 00 00 C6 00      438 		       nop nop nop add a,#0
   29FF 0D                  439 		       dec c
   2A00 C2 FA 29            440 		       jp nz, SaveWriteTrigger1
                            441 	
   2A03 3E 0D               442 		       ld a,£0x0d
   2A05 D3 FE               443 		       out (0xfe),a
                            444 	
   2A07 4A                  445 		       ld c,d
                            446 	
   01A0                     447         SaveWriteTrigger2:
   2A08 00 00 00 C6 00      448 		       nop nop nop add a,#0
   2A0D 0D                  449 		       dec c
   2A0E C2 08 2A            450 		       jp nz, SaveWriteTrigger2
                            451 	
   2A11 3E 02               452 		       ld a,£0x02
   2A13 D3 FE               453 		       out (0xfe),a
                            454 	
   2A15 7C                  455 		       ld a,h
   2A16 DD BE 07            456 		       cp a,7(ix)
   2A19 C2 E7 29            457 		       jp nz,SaveStart
   2A1C 7D                  458 		       ld a,l
   2A1D DD BE 06            459 		       cp a,6(ix)
   2A20 C2 E7 29            460 		       jp nz,SaveStart
                            461 		       
                            462 ;	genLabel
   01BB                     463 00101$:
                            464 ;	genEndFunction
   2A23 DD E1               465 	pop	ix
   2A25 3E 04               466 	ld	a,#4
   2A27 CF                  467 	rst	0x08
   2A28 C9                  468 	ret
   01C1                     469 _TapeSave_end::
                            470 ;tape.c:204: void SaveBlock(void* BlockStart) {
                            471 ;	genLabel
                            472 ;	genFunction
                            473 ;	---------------------------------
                            474 ; Function SaveBlock
                            475 ; ---------------------------------
   01C1                     476 _SaveBlock_start::
   01C1                     477 _SaveBlock:
   2A29 3E 03               478 	ld	a,#3
   2A2B CF                  479 	rst	0x08
   2A2C DD E5               480 	push	ix
   2A2E DD 21 00 00         481 	ld	ix,#0
   2A32 DD 39               482 	add	ix,sp
                            483 ;tape.c:299: _endasm;
                            484 ;	genInline
                            485 ;
   2A34 DD 6E 04            486 		       ld l,4(ix)
   2A37 DD 66 05            487 		       ld h,5(ix)
   2A3A DD 46 06            488 		       ld b,6(ix)
                            489 	
   2A3D 11 10 00            490 		       ld de,#0x0010
                            491 	
   01D8                     492         Sync:
   2A40 06 FF               493 		       ld b,#0xff ; 7
   2A42 3E 0D               494 		       ld a,#0x0d ; 7
   2A44 D3 FE               495 		       out (0xfe),a ; 11
   01DE                     496         W1:
   2A46 10 FE               497 	djnz	W1
   2A48 01 AD DE            498 		       ld bc,#0xDEAD ; 10
   2A4B 06 FF               499 		       ld b,#0xff ; 7
   2A4D 3E 02               500 		       ld a,#0x02 ; 7
   2A4F 3E 02               501 		       ld a,#0x02 ; 7
   2A51 3E 02               502 		       ld a,#0x02 ; 7
   2A53 D3 FE               503 		       out (0xfe),a ; 11
   01ED                     504         W2:
   2A55 10 FE               505 	djnz	W2
   2A57 1B                  506 		       dec de ; 6
   2A58 7B                  507 		       ld a,e ; 4
   2A59 B2                  508 		       or d ; 4
   2A5A C2 40 2A            509 		       jp nz,Sync ; 10
                            510 	
   2A5D 5D                  511 		       ld e,l
                            512 	
   01F6                     513         FetchByte:
   2A5E 0E 07               514 		       ld c,#7 ; 7
   2A60 56                  515 		       ld d,(hl) ; 7
   2A61 23                  516 		       inc hl ; 4
   2A62 7B                  517 		       ld a,e ; 4
   2A63 BD                  518 		       cp a,l ; 4
   2A64 CA A8 2A            519 		       jp z,BlockSaved ; 10
                            520 	
   01FF                     521         ProcessBit:
   2A67 CB 12               522 		       rl d ; 8
   2A69 DA 71 2A            523 		       jp c, Bit0 ; 10
                            524 	
   0204                     525         Bit1:
   2A6C 06 10               526 		       ld b,#16
   2A6E C3 76 2A            527 		       jp BitWrite
                            528 	
   0209                     529         Bit0:
   2A71 06 08               530 		       ld b,#8
   2A73 C3 76 2A            531 		       jp BitWrite
                            532 	
   020E                     533         BitWrite:
   2A76 3E 02               534 		       ld a,£0x02 ; 7
   2A78 D3 FE               535 		       out (0xfe),a ; 11
   2A7A 78                  536 		       ld a,b
   0213                     537         W3:
   2A7B 10 FE               538 	djnz	W3
   2A7D 47                  539 		       ld b,a
                            540 	
   2A7E 00                  541 		       nop
   2A7F 00                  542 		       nop
   2A80 00                  543 		       nop
   2A81 00                  544 		       nop
   2A82 00                  545 		       nop
   2A83 00                  546 		       nop
   2A84 00                  547 		       nop
   2A85 00                  548 		       nop
   2A86 00                  549 		       nop
   2A87 00                  550 		       nop
   2A88 00                  551 		       nop
   2A89 00                  552 		       nop
   2A8A 00                  553 		       nop
   2A8B 00                  554 		       nop
   2A8C 00                  555 		       nop
   2A8D 00                  556 		       nop
   2A8E 00                  557 		       nop
   2A8F 00                  558 		       nop
   2A90 00                  559 		       nop
   2A91 00                  560 		       nop
                            561 	
   2A92 3E 0D               562 		       ld a,£0x0d ; 7
   2A94 D3 FE               563 		       out (0xfe),a ; 11
   022E                     564         W4:
   2A96 10 FE               565 	djnz	W4
                            566 	
   2A98 0D                  567 		       dec c ; 4
   2A99 CA 5E 2A            568 		       jp z,FetchByte ; 10
                            569 	
   2A9C 00                  570 		       nop
   2A9D 00                  571 		       nop
   2A9E 00                  572 		       nop
   2A9F 00                  573 		       nop
   2AA0 00                  574 		       nop
   2AA1 00                  575 		       nop
   2AA2 00                  576 		       nop
   2AA3 00                  577 		       nop
   2AA4 00                  578 		       nop ; 36
                            579 	
   2AA5 C3 67 2A            580 		       jp ProcessBit ; 10
                            581 	
   0240                     582         BlockSaved:
                            583 		       
                            584 ;	genLabel
   0240                     585 00101$:
                            586 ;	genEndFunction
   2AA8 DD E1               587 	pop	ix
   2AAA 3E 04               588 	ld	a,#4
   2AAC CF                  589 	rst	0x08
   2AAD C9                  590 	ret
   0246                     591 _SaveBlock_end::
                            592 	.area _CODE
