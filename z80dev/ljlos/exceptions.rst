                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.5 Fri Apr 27 12:30:18 2012
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module exceptions
                              7 	.optsdcc -mz80
                              8 	
                              9 ;--------------------------------------------------------
                             10 ; Public variables in this module
                             11 ;--------------------------------------------------------
                             12 	.globl _Alert
                             13 	.globl _GetRegister
                             14 	.globl _RegValue
                             15 	.globl _SavedIY
                             16 	.globl _SavedIX
                             17 	.globl _SavedPC
                             18 	.globl _SystemLock
                             19 	.globl _Halt
                             20 	.globl _Break
                             21 	.globl _SystemMonitor
                             22 ;--------------------------------------------------------
                             23 ;  ram data
                             24 ;--------------------------------------------------------
                             25 	.area _DATA
                    0000     26 G$SystemLock$0$0==.
   0000                      27 _SystemLock::
   0000                      28 	.ds 1
                    0001     29 G$SavedPC$0$0==.
   0001                      30 _SavedPC::
   0001                      31 	.ds 2
                    0003     32 G$SavedIX$0$0==.
   0003                      33 _SavedIX::
   0003                      34 	.ds 2
                    0005     35 G$SavedIY$0$0==.
   0005                      36 _SavedIY::
   0005                      37 	.ds 2
                    0007     38 G$RegValue$0$0==.
   0007                      39 _RegValue::
   0007                      40 	.ds 2
                             41 ;--------------------------------------------------------
                             42 ; overlayable items in  ram 
                             43 ;--------------------------------------------------------
                             44 	.area _OVERLAY
                             45 ;--------------------------------------------------------
                             46 ; external initialized ram data
                             47 ;--------------------------------------------------------
                             48 ;--------------------------------------------------------
                             49 ; global & static initialisations
                             50 ;--------------------------------------------------------
                             51 	.area _GSINIT
                             52 	.area _GSFINAL
                             53 	.area _GSINIT
                             54 ;--------------------------------------------------------
                             55 ; Home
                             56 ;--------------------------------------------------------
                             57 	.area _HOME
                             58 	.area _CODE
                             59 ;--------------------------------------------------------
                             60 ; code
                             61 ;--------------------------------------------------------
                             62 	.area _CODE
                             63 ;exceptions.c:18: unsigned int GetRegister(enum {PC, SP, A, BC, DE, HL, IX, IY} Reg) {
                             64 ;	genLabel
                             65 ;	genFunction
                             66 ;	---------------------------------
                             67 ; Function GetRegister
                             68 ; ---------------------------------
   0000                      69 _GetRegister_start::
   0000                      70 _GetRegister:
   1E5B 3E 03                71 	ld	a,#3
   1E5D CF                   72 	rst	0x08
   1E5E DD E5                73 	push	ix
   1E60 DD 21 00 00          74 	ld	ix,#0
   1E64 DD 39                75 	add	ix,sp
                             76 ;exceptions.c:19: switch(Reg) {
                             77 ;	genCmpLt
                             78 ;	AOP_STK for 
   1E66 DD 7E 04             79 	ld	a,4(ix)
   1E69 D6 01                80 	sub	a,#0x01
   1E6B FA DA 1E             81 	jp	m,00108$
                             82 ;	genCmpGt
                             83 ;	AOP_STK for 
   1E6E 3E 07                84 	ld	a,#0x07
   1E70 DD 96 04             85 	sub	a,4(ix)
   1E73 FA DA 1E             86 	jp	m,00108$
                             87 ;	genMinus
                             88 ;	AOP_STK for 
   1E76 DD 7E 04             89 	ld	a,4(ix)
   1E79 C6 FF                90 	add	a,#0xFF
   1E7B 4F                   91 	ld	c,a
                             92 ;	genJumpTab
   1E7C D5                   93 	push	de
   1E7D 59                   94 	ld	e,c
   1E7E 16 00                95 	ld	d,#0x00
   1E80 21 88 1E             96 	ld	hl,#00114$
   1E83 19                   97 	add	hl,de
   1E84 19                   98 	add	hl,de
   1E85 19                   99 	add	hl,de
   1E86 D1                  100 	pop	de
   1E87 E9                  101 	jp	(hl)
   002D                     102 00114$:
   1E88 C3 9D 1E            103 	jp	00101$
   1E8B C3 A6 1E            104 	jp	00102$
   1E8E C3 AE 1E            105 	jp	00103$
   1E91 C3 B7 1E            106 	jp	00104$
   1E94 C3 C0 1E            107 	jp	00105$
   1E97 C3 C8 1E            108 	jp	00106$
   1E9A C3 D1 1E            109 	jp	00107$
                            110 ;exceptions.c:25: _endasm;
                            111 ;	genLabel
   0042                     112 00101$:
                            113 ;	genInline
                            114 ;
   1E9D D9                  115 		               exx
   1E9E ED 73 2C 83         116 		               ld (_RegValue),sp
   1EA2 D9                  117 		               exx
                            118 		               
                            119 ;exceptions.c:26: break;
                            120 ;	genGoto
   1EA3 C3 E6 1E            121 	jp	00109$
                            122 ;exceptions.c:32: _endasm;
                            123 ;	genLabel
   004B                     124 00102$:
                            125 ;	genInline
                            126 ;
   1EA6 08                  127 		               ex af,af
   1EA7 32 2C 83            128 		               ld (_RegValue),a
   1EAA 08                  129 		               ex af,af
                            130 		               
                            131 ;exceptions.c:33: break;
                            132 ;	genGoto
   1EAB C3 E6 1E            133 	jp	00109$
                            134 ;exceptions.c:39: _endasm;
                            135 ;	genLabel
   0053                     136 00103$:
                            137 ;	genInline
                            138 ;
   1EAE D9                  139 		               exx
   1EAF ED 53 2C 83         140 		               ld (_RegValue),de
   1EB3 D9                  141 		               exx
                            142 		               
                            143 ;exceptions.c:40: break;
                            144 ;	genGoto
   1EB4 C3 E6 1E            145 	jp	00109$
                            146 ;exceptions.c:46: _endasm;
                            147 ;	genLabel
   005C                     148 00104$:
                            149 ;	genInline
                            150 ;
   1EB7 D9                  151 		               exx
   1EB8 ED 53 2C 83         152 		               ld (_RegValue),de
   1EBC D9                  153 		               exx
                            154 		               
                            155 ;exceptions.c:47: break;
                            156 ;	genGoto
   1EBD C3 E6 1E            157 	jp	00109$
                            158 ;exceptions.c:53: _endasm;
                            159 ;	genLabel
   0065                     160 00105$:
                            161 ;	genInline
                            162 ;
   1EC0 D9                  163 		               exx
   1EC1 22 2C 83            164 		               ld (_RegValue),hl
   1EC4 D9                  165 		               exx
                            166 		               
                            167 ;exceptions.c:54: break;
                            168 ;	genGoto
   1EC5 C3 E6 1E            169 	jp	00109$
                            170 ;exceptions.c:60: _endasm;
                            171 ;	genLabel
   006D                     172 00106$:
                            173 ;	genInline
                            174 ;
   1EC8 D9                  175 		               exx
   1EC9 DD 22 2C 83         176 		               ld (_RegValue),ix
   1ECD D9                  177 		               exx
                            178 		               
                            179 ;exceptions.c:61: break;
                            180 ;	genGoto
   1ECE C3 E6 1E            181 	jp	00109$
                            182 ;exceptions.c:67: _endasm;
                            183 ;	genLabel
   0076                     184 00107$:
                            185 ;	genInline
                            186 ;
   1ED1 D9                  187 		               exx
   1ED2 FD 22 2C 83         188 		               ld (_RegValue),iy
   1ED6 D9                  189 		               exx
                            190 		               
                            191 ;exceptions.c:68: break;
                            192 ;	genGoto
   1ED7 C3 E6 1E            193 	jp	00109$
                            194 ;exceptions.c:70: RegValue=0;
                            195 ;	genLabel
   007F                     196 00108$:
                            197 ;	genAssign
   1EDA FD 21 2C 83         198 	ld	iy,#_RegValue
   1EDE FD 36 00 00         199 	ld	0(iy),#0x00
   1EE2 FD 36 01 00         200 	ld	1(iy),#0x00
                            201 ;exceptions.c:71: }
                            202 ;	genLabel
   008B                     203 00109$:
                            204 ;exceptions.c:76: _endasm;
                            205 ;	genInline
                            206 ;
   1EE6 2A 2C 83            207 		       ld hl,(_RegValue)
   1EE9 DD E1               208 		       pop ix
   1EEB C9                  209 		       ret
                            210 		       
                            211 ;exceptions.c:77: return RegValue;
                            212 ;	genRet
                            213 ; Dump of IC_LEFT: type AOP_IY size 2
   1EEC 2A 2C 83            214 	ld	hl,(_RegValue)
                            215 ;	genLabel
   0094                     216 00110$:
                            217 ;	genEndFunction
   1EEF DD E1               218 	pop	ix
   1EF1 3E 04               219 	ld	a,#4
   1EF3 CF                  220 	rst	0x08
   1EF4 C9                  221 	ret
   009A                     222 _GetRegister_end::
                            223 ;exceptions.c:81: void Alert(enum {alertHalt, alertBreak} Type, char* Message) {
                            224 ;	genLabel
                            225 ;	genFunction
                            226 ;	---------------------------------
                            227 ; Function Alert
                            228 ; ---------------------------------
   009A                     229 _Alert_start::
   009A                     230 _Alert:
   1EF5 3E 03               231 	ld	a,#3
   1EF7 CF                  232 	rst	0x08
   1EF8 DD E5               233 	push	ix
   1EFA DD 21 00 00         234 	ld	ix,#0
   1EFE DD 39               235 	add	ix,sp
   1F00 21 F0 FF            236 	ld	hl,#-16
   1F03 39                  237 	add	hl,sp
   1F04 F9                  238 	ld	sp,hl
                            239 ;exceptions.c:83: Pause();
                            240 ;	genCall
                            241 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1F05 CD 2A 1C            242 	call	_Pause
                            243 ;exceptions.c:85: _SimPrintString("-------------------\n");
                            244 ;	genIpush
                            245 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1F08 21 A3 22            246 	ld	hl,#__str_0
   1F0B E5                  247 	push	hl
                            248 ;	genCall
   1F0C CD CA 2A            249 	call	__Z80SimPrintString
   1F0F F1                  250 	pop	af
                            251 ;exceptions.c:86: if(Type==alertBreak) {
                            252 ;	genCmpEq
                            253 ;	AOP_STK for 
                            254 ; genCmpEq: left 1, right 1, result 1
                            255 ;4
   1F10 DD 7E 04            256 	ld	a,4(ix)
   1F13 FE 01               257 	cp	a,#0x01
   1F15 C2 1D 1F            258 	jp	nz,00117$
   1F18 3E 01               259 	ld	a,#0x01
   1F1A C3 1E 1F            260 	jp	00118$
   00C2                     261 00117$:
   1F1D AF                  262 	xor	a,a
   00C3                     263 00118$:
                            264 ;6
   1F1E 4F                  265 	ld	c,a
                            266 ;	genIfx
   1F1F AF                  267 	xor	a,a
   1F20 B1                  268 	or	a,c
   1F21 CA 61 1F            269 	jp	z,00102$
                            270 ;exceptions.c:87: _SimPrintString("BREAK: ");
                            271 ;	genIpush
                            272 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1F24 C5                  273 	push	bc
   1F25 21 B8 22            274 	ld	hl,#__str_1
   1F28 E5                  275 	push	hl
                            276 ;	genCall
   1F29 CD CA 2A            277 	call	__Z80SimPrintString
   1F2C F1                  278 	pop	af
   1F2D C1                  279 	pop	bc
                            280 ;exceptions.c:88: _SimPrintString(Message);
                            281 ;	genIpush
                            282 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1F2E C5                  283 	push	bc
                            284 ;	AOP_STK for 
   1F2F DD 6E 05            285 	ld	l,5(ix)
   1F32 DD 66 06            286 	ld	h,6(ix)
   1F35 E5                  287 	push	hl
                            288 ;	genCall
   1F36 CD CA 2A            289 	call	__Z80SimPrintString
   1F39 F1                  290 	pop	af
   1F3A C1                  291 	pop	bc
                            292 ;exceptions.c:89: _SimPrintString("\n");
                            293 ;	genIpush
                            294 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1F3B C5                  295 	push	bc
   1F3C 21 C0 22            296 	ld	hl,#__str_2
   1F3F E5                  297 	push	hl
                            298 ;	genCall
   1F40 CD CA 2A            299 	call	__Z80SimPrintString
   1F43 F1                  300 	pop	af
   1F44 C1                  301 	pop	bc
                            302 ;exceptions.c:90: _SimPrintString("-------------------\n");
                            303 ;	genIpush
                            304 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1F45 C5                  305 	push	bc
   1F46 21 A3 22            306 	ld	hl,#__str_0
   1F49 E5                  307 	push	hl
                            308 ;	genCall
   1F4A CD CA 2A            309 	call	__Z80SimPrintString
   1F4D F1                  310 	pop	af
   1F4E C1                  311 	pop	bc
                            312 ;exceptions.c:91: _SimDumpRegs();
                            313 ;	genCall
                            314 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1F4F C5                  315 	push	bc
   1F50 CD 00 00            316 	call	__SimDumpRegs
   1F53 C1                  317 	pop	bc
                            318 ;exceptions.c:92: _SimPrintString("-------------------\n");
                            319 ;	genIpush
                            320 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1F54 C5                  321 	push	bc
   1F55 21 A3 22            322 	ld	hl,#__str_0
   1F58 E5                  323 	push	hl
                            324 ;	genCall
   1F59 CD CA 2A            325 	call	__Z80SimPrintString
   1F5C F1                  326 	pop	af
   1F5D C1                  327 	pop	bc
                            328 ;	genGoto
   1F5E C3 A0 1F            329 	jp	00103$
                            330 ;	genLabel
   0106                     331 00102$:
                            332 ;exceptions.c:94: _SimPrintString("HALT: ");
                            333 ;	genIpush
                            334 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1F61 C5                  335 	push	bc
   1F62 21 C2 22            336 	ld	hl,#__str_3
   1F65 E5                  337 	push	hl
                            338 ;	genCall
   1F66 CD CA 2A            339 	call	__Z80SimPrintString
   1F69 F1                  340 	pop	af
   1F6A C1                  341 	pop	bc
                            342 ;exceptions.c:95: _SimPrintString(Message);
                            343 ;	genIpush
                            344 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1F6B C5                  345 	push	bc
                            346 ;	AOP_STK for 
   1F6C DD 6E 05            347 	ld	l,5(ix)
   1F6F DD 66 06            348 	ld	h,6(ix)
   1F72 E5                  349 	push	hl
                            350 ;	genCall
   1F73 CD CA 2A            351 	call	__Z80SimPrintString
   1F76 F1                  352 	pop	af
   1F77 C1                  353 	pop	bc
                            354 ;exceptions.c:96: _SimPrintString("\n");
                            355 ;	genIpush
                            356 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1F78 C5                  357 	push	bc
   1F79 21 C0 22            358 	ld	hl,#__str_2
   1F7C E5                  359 	push	hl
                            360 ;	genCall
   1F7D CD CA 2A            361 	call	__Z80SimPrintString
   1F80 F1                  362 	pop	af
   1F81 C1                  363 	pop	bc
                            364 ;exceptions.c:97: _SimPrintString("-------------------\n");
                            365 ;	genIpush
                            366 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1F82 C5                  367 	push	bc
   1F83 21 A3 22            368 	ld	hl,#__str_0
   1F86 E5                  369 	push	hl
                            370 ;	genCall
   1F87 CD CA 2A            371 	call	__Z80SimPrintString
   1F8A F1                  372 	pop	af
   1F8B C1                  373 	pop	bc
                            374 ;exceptions.c:98: _SimDumpRegs();
                            375 ;	genCall
                            376 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1F8C C5                  377 	push	bc
   1F8D CD 00 00            378 	call	__SimDumpRegs
   1F90 C1                  379 	pop	bc
                            380 ;exceptions.c:99: _SimPrintString("-------------------\n");
                            381 ;	genIpush
                            382 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1F91 C5                  383 	push	bc
   1F92 21 A3 22            384 	ld	hl,#__str_0
   1F95 E5                  385 	push	hl
                            386 ;	genCall
   1F96 CD CA 2A            387 	call	__Z80SimPrintString
   1F99 F1                  388 	pop	af
   1F9A C1                  389 	pop	bc
                            390 ;exceptions.c:100: _SimTerminate();
                            391 ;	genCall
                            392 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1F9B C5                  393 	push	bc
   1F9C CD AE 2A            394 	call	__Z80SimTerminate
   1F9F C1                  395 	pop	bc
                            396 ;	genLabel
   0145                     397 00103$:
                            398 ;exceptions.c:104: PutString("\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4", 18, 0);
                            399 ;	genIpush
                            400 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1FA0 C5                  401 	push	bc
   1FA1 21 12 00            402 	ld	hl,#0x0012
   1FA4 E5                  403 	push	hl
                            404 ;	genIpush
   1FA5 21 C9 22            405 	ld	hl,#__str_4
   1FA8 E5                  406 	push	hl
                            407 ;	genCall
   1FA9 CD F1 10            408 	call	_PutString
   1FAC F1                  409 	pop	af
   1FAD F1                  410 	pop	af
   1FAE C1                  411 	pop	bc
                            412 ;exceptions.c:105: PutString("                                ", 19, 0);
                            413 ;	genIpush
                            414 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1FAF C5                  415 	push	bc
   1FB0 21 13 00            416 	ld	hl,#0x0013
   1FB3 E5                  417 	push	hl
                            418 ;	genIpush
   1FB4 21 EA 22            419 	ld	hl,#__str_5
   1FB7 E5                  420 	push	hl
                            421 ;	genCall
   1FB8 CD F1 10            422 	call	_PutString
   1FBB F1                  423 	pop	af
   1FBC F1                  424 	pop	af
   1FBD C1                  425 	pop	bc
                            426 ;exceptions.c:106: PutString("\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4", 20, 0);
                            427 ;	genIpush
                            428 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1FBE C5                  429 	push	bc
   1FBF 21 14 00            430 	ld	hl,#0x0014
   1FC2 E5                  431 	push	hl
                            432 ;	genIpush
   1FC3 21 C9 22            433 	ld	hl,#__str_4
   1FC6 E5                  434 	push	hl
                            435 ;	genCall
   1FC7 CD F1 10            436 	call	_PutString
   1FCA F1                  437 	pop	af
   1FCB F1                  438 	pop	af
   1FCC C1                  439 	pop	bc
                            440 ;exceptions.c:107: PutString("                                ", 21, 0);
                            441 ;	genIpush
                            442 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1FCD C5                  443 	push	bc
   1FCE 21 15 00            444 	ld	hl,#0x0015
   1FD1 E5                  445 	push	hl
                            446 ;	genIpush
   1FD2 21 EA 22            447 	ld	hl,#__str_5
   1FD5 E5                  448 	push	hl
                            449 ;	genCall
   1FD6 CD F1 10            450 	call	_PutString
   1FD9 F1                  451 	pop	af
   1FDA F1                  452 	pop	af
   1FDB C1                  453 	pop	bc
                            454 ;exceptions.c:108: PutString("                                ", 22, 0);
                            455 ;	genIpush
                            456 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1FDC C5                  457 	push	bc
   1FDD 21 16 00            458 	ld	hl,#0x0016
   1FE0 E5                  459 	push	hl
                            460 ;	genIpush
   1FE1 21 EA 22            461 	ld	hl,#__str_5
   1FE4 E5                  462 	push	hl
                            463 ;	genCall
   1FE5 CD F1 10            464 	call	_PutString
   1FE8 F1                  465 	pop	af
   1FE9 F1                  466 	pop	af
   1FEA C1                  467 	pop	bc
                            468 ;exceptions.c:109: PutString("                                ", 23, 0);
                            469 ;	genIpush
                            470 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1FEB C5                  471 	push	bc
   1FEC 21 17 00            472 	ld	hl,#0x0017
   1FEF E5                  473 	push	hl
                            474 ;	genIpush
   1FF0 21 EA 22            475 	ld	hl,#__str_5
   1FF3 E5                  476 	push	hl
                            477 ;	genCall
   1FF4 CD F1 10            478 	call	_PutString
   1FF7 F1                  479 	pop	af
   1FF8 F1                  480 	pop	af
   1FF9 C1                  481 	pop	bc
                            482 ;exceptions.c:110: SetAttrib(SCRATTR_FLASH|SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 1);
                            483 ;	genIpush
                            484 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1FFA C5                  485 	push	bc
   1FFB 21 13 01            486 	ld	hl,#0x0113
   1FFE E5                  487 	push	hl
                            488 ;	genIpush
   1FFF 3E B9               489 	ld	a,#0xB9
   2001 F5                  490 	push	af
   2002 33                  491 	inc	sp
                            492 ;	genCall
   2003 CD D6 0F            493 	call	_SetAttrib
   2006 F1                  494 	pop	af
   2007 33                  495 	inc	sp
   2008 C1                  496 	pop	bc
                            497 ;exceptions.c:111: SetAttrib(SCRATTR_FLASH|SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 2);
                            498 ;	genIpush
                            499 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   2009 C5                  500 	push	bc
   200A 21 13 02            501 	ld	hl,#0x0213
   200D E5                  502 	push	hl
                            503 ;	genIpush
   200E 3E B9               504 	ld	a,#0xB9
   2010 F5                  505 	push	af
   2011 33                  506 	inc	sp
                            507 ;	genCall
   2012 CD D6 0F            508 	call	_SetAttrib
   2015 F1                  509 	pop	af
   2016 33                  510 	inc	sp
   2017 C1                  511 	pop	bc
                            512 ;exceptions.c:112: SetAttrib(SCRATTR_FLASH|SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 3);
                            513 ;	genIpush
                            514 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   2018 C5                  515 	push	bc
   2019 21 13 03            516 	ld	hl,#0x0313
   201C E5                  517 	push	hl
                            518 ;	genIpush
   201D 3E B9               519 	ld	a,#0xB9
   201F F5                  520 	push	af
   2020 33                  521 	inc	sp
                            522 ;	genCall
   2021 CD D6 0F            523 	call	_SetAttrib
   2024 F1                  524 	pop	af
   2025 33                  525 	inc	sp
   2026 C1                  526 	pop	bc
                            527 ;exceptions.c:113: SetAttrib(SCRATTR_FLASH|SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 4);
                            528 ;	genIpush
                            529 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   2027 C5                  530 	push	bc
   2028 21 13 04            531 	ld	hl,#0x0413
   202B E5                  532 	push	hl
                            533 ;	genIpush
   202C 3E B9               534 	ld	a,#0xB9
   202E F5                  535 	push	af
   202F 33                  536 	inc	sp
                            537 ;	genCall
   2030 CD D6 0F            538 	call	_SetAttrib
   2033 F1                  539 	pop	af
   2034 33                  540 	inc	sp
   2035 C1                  541 	pop	bc
                            542 ;exceptions.c:114: if(Type==alertBreak) {
                            543 ;	genIfx
   2036 AF                  544 	xor	a,a
   2037 B1                  545 	or	a,c
   2038 CA 68 20            546 	jp	z,00105$
                            547 ;exceptions.c:115: SetAttrib(SCRATTR_FLASH|SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 5);
                            548 ;	genIpush
                            549 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   203B 21 13 05            550 	ld	hl,#0x0513
   203E E5                  551 	push	hl
                            552 ;	genIpush
   203F 3E B9               553 	ld	a,#0xB9
   2041 F5                  554 	push	af
   2042 33                  555 	inc	sp
                            556 ;	genCall
   2043 CD D6 0F            557 	call	_SetAttrib
   2046 F1                  558 	pop	af
   2047 33                  559 	inc	sp
                            560 ;exceptions.c:116: PutString(" BREAK ", 19, 0);
                            561 ;	genIpush
                            562 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   2048 21 13 00            563 	ld	hl,#0x0013
   204B E5                  564 	push	hl
                            565 ;	genIpush
   204C 21 0B 23            566 	ld	hl,#__str_6
   204F E5                  567 	push	hl
                            568 ;	genCall
   2050 CD F1 10            569 	call	_PutString
   2053 F1                  570 	pop	af
   2054 F1                  571 	pop	af
                            572 ;exceptions.c:117: PutString(Message, 19, 7);
                            573 ;	genIpush
                            574 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   2055 21 13 07            575 	ld	hl,#0x0713
   2058 E5                  576 	push	hl
                            577 ;	genIpush
                            578 ;	AOP_STK for 
   2059 DD 6E 05            579 	ld	l,5(ix)
   205C DD 66 06            580 	ld	h,6(ix)
   205F E5                  581 	push	hl
                            582 ;	genCall
   2060 CD F1 10            583 	call	_PutString
   2063 F1                  584 	pop	af
   2064 F1                  585 	pop	af
                            586 ;	genGoto
   2065 C3 85 20            587 	jp	00106$
                            588 ;	genLabel
   020D                     589 00105$:
                            590 ;exceptions.c:119: PutString(" HALT ", 19, 0);
                            591 ;	genIpush
                            592 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   2068 21 13 00            593 	ld	hl,#0x0013
   206B E5                  594 	push	hl
                            595 ;	genIpush
   206C 21 13 23            596 	ld	hl,#__str_7
   206F E5                  597 	push	hl
                            598 ;	genCall
   2070 CD F1 10            599 	call	_PutString
   2073 F1                  600 	pop	af
   2074 F1                  601 	pop	af
                            602 ;exceptions.c:120: PutString(Message, 19, 6);
                            603 ;	genIpush
                            604 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   2075 21 13 06            605 	ld	hl,#0x0613
   2078 E5                  606 	push	hl
                            607 ;	genIpush
                            608 ;	AOP_STK for 
   2079 DD 6E 05            609 	ld	l,5(ix)
   207C DD 66 06            610 	ld	h,6(ix)
   207F E5                  611 	push	hl
                            612 ;	genCall
   2080 CD F1 10            613 	call	_PutString
   2083 F1                  614 	pop	af
   2084 F1                  615 	pop	af
                            616 ;	genLabel
   022A                     617 00106$:
                            618 ;exceptions.c:123: PutString(" A", 21, 2);	WordToHex(GetRegister(A), Value); PutString(Value, 21, 5);
                            619 ;	genIpush
                            620 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   2085 21 15 02            621 	ld	hl,#0x0215
   2088 E5                  622 	push	hl
                            623 ;	genIpush
   2089 21 1A 23            624 	ld	hl,#__str_8
   208C E5                  625 	push	hl
                            626 ;	genCall
   208D CD F1 10            627 	call	_PutString
   2090 F1                  628 	pop	af
   2091 F1                  629 	pop	af
                            630 ;	genAddrOf
   2092 21 00 00            631 	ld	hl,#0x0000
   2095 39                  632 	add	hl,sp
   2096 4D                  633 	ld	c,l
   2097 44                  634 	ld	b,h
                            635 ;	genIpush
                            636 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   2098 C5                  637 	push	bc
   2099 3E 02               638 	ld	a,#0x02
   209B F5                  639 	push	af
   209C 33                  640 	inc	sp
                            641 ;	genCall
   209D CD 5B 1E            642 	call	_GetRegister
   20A0 54                  643 	ld	d,h
   20A1 5D                  644 	ld	e,l
   20A2 33                  645 	inc	sp
   20A3 C1                  646 	pop	bc
                            647 ;	genIpush
                            648 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   20A4 C5                  649 	push	bc
   20A5 C5                  650 	push	bc
                            651 ;	genIpush
   20A6 D5                  652 	push	de
                            653 ;	genCall
   20A7 CD 6A 05            654 	call	_WordToHex
   20AA F1                  655 	pop	af
   20AB F1                  656 	pop	af
   20AC C1                  657 	pop	bc
                            658 ;	genIpush
                            659 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   20AD C5                  660 	push	bc
   20AE 21 15 05            661 	ld	hl,#0x0515
   20B1 E5                  662 	push	hl
                            663 ;	genIpush
   20B2 C5                  664 	push	bc
                            665 ;	genCall
   20B3 CD F1 10            666 	call	_PutString
   20B6 F1                  667 	pop	af
   20B7 F1                  668 	pop	af
   20B8 C1                  669 	pop	bc
                            670 ;exceptions.c:124: PutString("BC", 21, 12); WordToHex(GetRegister(BC), Value); PutString(Value, 21, 15);
                            671 ;	genIpush
                            672 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   20B9 C5                  673 	push	bc
   20BA 21 15 0C            674 	ld	hl,#0x0C15
   20BD E5                  675 	push	hl
                            676 ;	genIpush
   20BE 21 1D 23            677 	ld	hl,#__str_9
   20C1 E5                  678 	push	hl
                            679 ;	genCall
   20C2 CD F1 10            680 	call	_PutString
   20C5 F1                  681 	pop	af
   20C6 F1                  682 	pop	af
   20C7 C1                  683 	pop	bc
                            684 ;	genIpush
                            685 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   20C8 C5                  686 	push	bc
   20C9 3E 03               687 	ld	a,#0x03
   20CB F5                  688 	push	af
   20CC 33                  689 	inc	sp
                            690 ;	genCall
   20CD CD 5B 1E            691 	call	_GetRegister
   20D0 54                  692 	ld	d,h
   20D1 5D                  693 	ld	e,l
   20D2 33                  694 	inc	sp
   20D3 C1                  695 	pop	bc
                            696 ;	genIpush
                            697 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   20D4 C5                  698 	push	bc
   20D5 C5                  699 	push	bc
                            700 ;	genIpush
   20D6 D5                  701 	push	de
                            702 ;	genCall
   20D7 CD 6A 05            703 	call	_WordToHex
   20DA F1                  704 	pop	af
   20DB F1                  705 	pop	af
   20DC C1                  706 	pop	bc
                            707 ;	genIpush
                            708 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   20DD C5                  709 	push	bc
   20DE 21 15 0F            710 	ld	hl,#0x0F15
   20E1 E5                  711 	push	hl
                            712 ;	genIpush
   20E2 C5                  713 	push	bc
                            714 ;	genCall
   20E3 CD F1 10            715 	call	_PutString
   20E6 F1                  716 	pop	af
   20E7 F1                  717 	pop	af
   20E8 C1                  718 	pop	bc
                            719 ;exceptions.c:125: PutString("DE", 21, 22); WordToHex(GetRegister(DE), Value); PutString(Value, 21, 25);
                            720 ;	genIpush
                            721 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   20E9 C5                  722 	push	bc
   20EA 21 15 16            723 	ld	hl,#0x1615
   20ED E5                  724 	push	hl
                            725 ;	genIpush
   20EE 21 20 23            726 	ld	hl,#__str_10
   20F1 E5                  727 	push	hl
                            728 ;	genCall
   20F2 CD F1 10            729 	call	_PutString
   20F5 F1                  730 	pop	af
   20F6 F1                  731 	pop	af
   20F7 C1                  732 	pop	bc
                            733 ;	genIpush
                            734 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   20F8 C5                  735 	push	bc
   20F9 3E 04               736 	ld	a,#0x04
   20FB F5                  737 	push	af
   20FC 33                  738 	inc	sp
                            739 ;	genCall
   20FD CD 5B 1E            740 	call	_GetRegister
   2100 54                  741 	ld	d,h
   2101 5D                  742 	ld	e,l
   2102 33                  743 	inc	sp
   2103 C1                  744 	pop	bc
                            745 ;	genIpush
                            746 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   2104 C5                  747 	push	bc
   2105 C5                  748 	push	bc
                            749 ;	genIpush
   2106 D5                  750 	push	de
                            751 ;	genCall
   2107 CD 6A 05            752 	call	_WordToHex
   210A F1                  753 	pop	af
   210B F1                  754 	pop	af
   210C C1                  755 	pop	bc
                            756 ;	genIpush
                            757 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   210D C5                  758 	push	bc
   210E 21 15 19            759 	ld	hl,#0x1915
   2111 E5                  760 	push	hl
                            761 ;	genIpush
   2112 C5                  762 	push	bc
                            763 ;	genCall
   2113 CD F1 10            764 	call	_PutString
   2116 F1                  765 	pop	af
   2117 F1                  766 	pop	af
   2118 C1                  767 	pop	bc
                            768 ;exceptions.c:127: PutString("HL", 22, 2); WordToHex(GetRegister(HL), Value); PutString(Value, 22, 5);
                            769 ;	genIpush
                            770 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   2119 C5                  771 	push	bc
   211A 21 16 02            772 	ld	hl,#0x0216
   211D E5                  773 	push	hl
                            774 ;	genIpush
   211E 21 23 23            775 	ld	hl,#__str_11
   2121 E5                  776 	push	hl
                            777 ;	genCall
   2122 CD F1 10            778 	call	_PutString
   2125 F1                  779 	pop	af
   2126 F1                  780 	pop	af
   2127 C1                  781 	pop	bc
                            782 ;	genIpush
                            783 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   2128 C5                  784 	push	bc
   2129 3E 05               785 	ld	a,#0x05
   212B F5                  786 	push	af
   212C 33                  787 	inc	sp
                            788 ;	genCall
   212D CD 5B 1E            789 	call	_GetRegister
   2130 54                  790 	ld	d,h
   2131 5D                  791 	ld	e,l
   2132 33                  792 	inc	sp
   2133 C1                  793 	pop	bc
                            794 ;	genIpush
                            795 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   2134 C5                  796 	push	bc
   2135 C5                  797 	push	bc
                            798 ;	genIpush
   2136 D5                  799 	push	de
                            800 ;	genCall
   2137 CD 6A 05            801 	call	_WordToHex
   213A F1                  802 	pop	af
   213B F1                  803 	pop	af
   213C C1                  804 	pop	bc
                            805 ;	genIpush
                            806 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   213D C5                  807 	push	bc
   213E 21 16 05            808 	ld	hl,#0x0516
   2141 E5                  809 	push	hl
                            810 ;	genIpush
   2142 C5                  811 	push	bc
                            812 ;	genCall
   2143 CD F1 10            813 	call	_PutString
   2146 F1                  814 	pop	af
   2147 F1                  815 	pop	af
   2148 C1                  816 	pop	bc
                            817 ;exceptions.c:128: PutString("IX", 22, 12); WordToHex(SavedIX, Value); PutString(Value, 22, 15);
                            818 ;	genIpush
                            819 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   2149 C5                  820 	push	bc
   214A 21 16 0C            821 	ld	hl,#0x0C16
   214D E5                  822 	push	hl
                            823 ;	genIpush
   214E 21 26 23            824 	ld	hl,#__str_12
   2151 E5                  825 	push	hl
                            826 ;	genCall
   2152 CD F1 10            827 	call	_PutString
   2155 F1                  828 	pop	af
   2156 F1                  829 	pop	af
   2157 C1                  830 	pop	bc
                            831 ;	genIpush
                            832 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   2158 C5                  833 	push	bc
   2159 C5                  834 	push	bc
                            835 ;	genIpush
   215A 2A 28 83            836 	ld	hl,(_SavedIX)
   215D E5                  837 	push	hl
                            838 ;	genCall
   215E CD 6A 05            839 	call	_WordToHex
   2161 F1                  840 	pop	af
   2162 F1                  841 	pop	af
   2163 C1                  842 	pop	bc
                            843 ;	genIpush
                            844 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   2164 C5                  845 	push	bc
   2165 21 16 0F            846 	ld	hl,#0x0F16
   2168 E5                  847 	push	hl
                            848 ;	genIpush
   2169 C5                  849 	push	bc
                            850 ;	genCall
   216A CD F1 10            851 	call	_PutString
   216D F1                  852 	pop	af
   216E F1                  853 	pop	af
   216F C1                  854 	pop	bc
                            855 ;exceptions.c:129: PutString("IY", 22, 22); WordToHex(SavedIY, Value); PutString(Value, 22, 25);
                            856 ;	genIpush
                            857 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   2170 C5                  858 	push	bc
   2171 21 16 16            859 	ld	hl,#0x1616
   2174 E5                  860 	push	hl
                            861 ;	genIpush
   2175 21 29 23            862 	ld	hl,#__str_13
   2178 E5                  863 	push	hl
                            864 ;	genCall
   2179 CD F1 10            865 	call	_PutString
   217C F1                  866 	pop	af
   217D F1                  867 	pop	af
   217E C1                  868 	pop	bc
                            869 ;	genIpush
                            870 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   217F C5                  871 	push	bc
   2180 C5                  872 	push	bc
                            873 ;	genIpush
   2181 2A 2A 83            874 	ld	hl,(_SavedIY)
   2184 E5                  875 	push	hl
                            876 ;	genCall
   2185 CD 6A 05            877 	call	_WordToHex
   2188 F1                  878 	pop	af
   2189 F1                  879 	pop	af
   218A C1                  880 	pop	bc
                            881 ;	genIpush
                            882 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   218B C5                  883 	push	bc
   218C 21 16 19            884 	ld	hl,#0x1916
   218F E5                  885 	push	hl
                            886 ;	genIpush
   2190 C5                  887 	push	bc
                            888 ;	genCall
   2191 CD F1 10            889 	call	_PutString
   2194 F1                  890 	pop	af
   2195 F1                  891 	pop	af
   2196 C1                  892 	pop	bc
                            893 ;exceptions.c:131: PutString("SP", 23, 2); WordToHex(GetRegister(SP), Value); PutString(Value, 23, 5);
                            894 ;	genIpush
                            895 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   2197 C5                  896 	push	bc
   2198 21 17 02            897 	ld	hl,#0x0217
   219B E5                  898 	push	hl
                            899 ;	genIpush
   219C 21 2C 23            900 	ld	hl,#__str_14
   219F E5                  901 	push	hl
                            902 ;	genCall
   21A0 CD F1 10            903 	call	_PutString
   21A3 F1                  904 	pop	af
   21A4 F1                  905 	pop	af
   21A5 C1                  906 	pop	bc
                            907 ;	genIpush
                            908 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   21A6 C5                  909 	push	bc
   21A7 3E 01               910 	ld	a,#0x01
   21A9 F5                  911 	push	af
   21AA 33                  912 	inc	sp
                            913 ;	genCall
   21AB CD 5B 1E            914 	call	_GetRegister
   21AE 54                  915 	ld	d,h
   21AF 5D                  916 	ld	e,l
   21B0 33                  917 	inc	sp
   21B1 C1                  918 	pop	bc
                            919 ;	genIpush
                            920 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   21B2 C5                  921 	push	bc
   21B3 C5                  922 	push	bc
                            923 ;	genIpush
   21B4 D5                  924 	push	de
                            925 ;	genCall
   21B5 CD 6A 05            926 	call	_WordToHex
   21B8 F1                  927 	pop	af
   21B9 F1                  928 	pop	af
   21BA C1                  929 	pop	bc
                            930 ;	genIpush
                            931 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   21BB C5                  932 	push	bc
   21BC 21 17 05            933 	ld	hl,#0x0517
   21BF E5                  934 	push	hl
                            935 ;	genIpush
   21C0 C5                  936 	push	bc
                            937 ;	genCall
   21C1 CD F1 10            938 	call	_PutString
   21C4 F1                  939 	pop	af
   21C5 F1                  940 	pop	af
   21C6 C1                  941 	pop	bc
                            942 ;exceptions.c:132: PutString("PC", 23, 12); WordToHex(SavedPC, Value); PutString(Value, 23, 15);
                            943 ;	genIpush
                            944 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   21C7 C5                  945 	push	bc
   21C8 21 17 0C            946 	ld	hl,#0x0C17
   21CB E5                  947 	push	hl
                            948 ;	genIpush
   21CC 21 2F 23            949 	ld	hl,#__str_15
   21CF E5                  950 	push	hl
                            951 ;	genCall
   21D0 CD F1 10            952 	call	_PutString
   21D3 F1                  953 	pop	af
   21D4 F1                  954 	pop	af
   21D5 C1                  955 	pop	bc
                            956 ;	genIpush
                            957 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   21D6 C5                  958 	push	bc
   21D7 C5                  959 	push	bc
                            960 ;	genIpush
   21D8 2A 26 83            961 	ld	hl,(_SavedPC)
   21DB E5                  962 	push	hl
                            963 ;	genCall
   21DC CD 6A 05            964 	call	_WordToHex
   21DF F1                  965 	pop	af
   21E0 F1                  966 	pop	af
   21E1 C1                  967 	pop	bc
                            968 ;	genIpush
                            969 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   21E2 21 17 0F            970 	ld	hl,#0x0F17
   21E5 E5                  971 	push	hl
                            972 ;	genIpush
   21E6 C5                  973 	push	bc
                            974 ;	genCall
   21E7 CD F1 10            975 	call	_PutString
   21EA F1                  976 	pop	af
   21EB F1                  977 	pop	af
                            978 ;exceptions.c:134: Beep();
                            979 ;	genCall
                            980 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   21EC CD 39 25            981 	call	_Beep
                            982 ;exceptions.c:136: Resume();
                            983 ;	genCall
                            984 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   21EF CD 47 1C            985 	call	_Resume
                            986 ;exceptions.c:138: Sleep(350);
                            987 ;	genIpush
                            988 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   21F2 21 00 00            989 	ld	hl,#0x0000
   21F5 E5                  990 	push	hl
   21F6 21 5E 01            991 	ld	hl,#0x015E
   21F9 E5                  992 	push	hl
                            993 ;	genCall
   21FA CD D6 24            994 	call	_Sleep
   21FD F1                  995 	pop	af
   21FE F1                  996 	pop	af
                            997 ;exceptions.c:139: if(Type==alertHalt) for(;;);
                            998 ;	genCmpEq
                            999 ;	AOP_STK for 
                           1000 ; genCmpEq: left 1, right 1, result 0
   21FF DD 7E 04           1001 	ld	a,4(ix)
   2202 B7                 1002 	or	a,a
   2203 CA 09 22           1003 	jp	z,00120$
   03AB                    1004 00119$:
   2206 C3 0C 22           1005 	jp	00108$
   03AE                    1006 00120$:
                           1007 ;	genLabel
   03AE                    1008 00110$:
                           1009 ;	genGoto
   2209 C3 09 22           1010 	jp	00110$
                           1011 ;	genLabel
   03B1                    1012 00108$:
                           1013 ;exceptions.c:140: PutString("                                ", 18, 0);
                           1014 ;	genIpush
                           1015 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   220C 21 12 00           1016 	ld	hl,#0x0012
   220F E5                 1017 	push	hl
                           1018 ;	genIpush
   2210 21 EA 22           1019 	ld	hl,#__str_5
   2213 E5                 1020 	push	hl
                           1021 ;	genCall
   2214 CD F1 10           1022 	call	_PutString
   2217 F1                 1023 	pop	af
   2218 F1                 1024 	pop	af
                           1025 ;exceptions.c:141: PutString("                                ", 19, 0);
                           1026 ;	genIpush
                           1027 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   2219 21 13 00           1028 	ld	hl,#0x0013
   221C E5                 1029 	push	hl
                           1030 ;	genIpush
   221D 21 EA 22           1031 	ld	hl,#__str_5
   2220 E5                 1032 	push	hl
                           1033 ;	genCall
   2221 CD F1 10           1034 	call	_PutString
   2224 F1                 1035 	pop	af
   2225 F1                 1036 	pop	af
                           1037 ;exceptions.c:142: PutString("                                ", 20, 0);
                           1038 ;	genIpush
                           1039 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   2226 21 14 00           1040 	ld	hl,#0x0014
   2229 E5                 1041 	push	hl
                           1042 ;	genIpush
   222A 21 EA 22           1043 	ld	hl,#__str_5
   222D E5                 1044 	push	hl
                           1045 ;	genCall
   222E CD F1 10           1046 	call	_PutString
   2231 F1                 1047 	pop	af
   2232 F1                 1048 	pop	af
                           1049 ;exceptions.c:143: PutString("                                ", 21, 0);
                           1050 ;	genIpush
                           1051 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   2233 21 15 00           1052 	ld	hl,#0x0015
   2236 E5                 1053 	push	hl
                           1054 ;	genIpush
   2237 21 EA 22           1055 	ld	hl,#__str_5
   223A E5                 1056 	push	hl
                           1057 ;	genCall
   223B CD F1 10           1058 	call	_PutString
   223E F1                 1059 	pop	af
   223F F1                 1060 	pop	af
                           1061 ;exceptions.c:144: PutString("                                ", 22, 0);
                           1062 ;	genIpush
                           1063 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   2240 21 16 00           1064 	ld	hl,#0x0016
   2243 E5                 1065 	push	hl
                           1066 ;	genIpush
   2244 21 EA 22           1067 	ld	hl,#__str_5
   2247 E5                 1068 	push	hl
                           1069 ;	genCall
   2248 CD F1 10           1070 	call	_PutString
   224B F1                 1071 	pop	af
   224C F1                 1072 	pop	af
                           1073 ;exceptions.c:145: PutString("                                ", 23, 0);
                           1074 ;	genIpush
                           1075 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   224D 21 17 00           1076 	ld	hl,#0x0017
   2250 E5                 1077 	push	hl
                           1078 ;	genIpush
   2251 21 EA 22           1079 	ld	hl,#__str_5
   2254 E5                 1080 	push	hl
                           1081 ;	genCall
   2255 CD F1 10           1082 	call	_PutString
   2258 F1                 1083 	pop	af
   2259 F1                 1084 	pop	af
                           1085 ;exceptions.c:146: SetAttrib(SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 1);
                           1086 ;	genIpush
                           1087 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   225A 21 13 01           1088 	ld	hl,#0x0113
   225D E5                 1089 	push	hl
                           1090 ;	genIpush
   225E 3E 39              1091 	ld	a,#0x39
   2260 F5                 1092 	push	af
   2261 33                 1093 	inc	sp
                           1094 ;	genCall
   2262 CD D6 0F           1095 	call	_SetAttrib
   2265 F1                 1096 	pop	af
   2266 33                 1097 	inc	sp
                           1098 ;exceptions.c:147: SetAttrib(SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 2);
                           1099 ;	genIpush
                           1100 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   2267 21 13 02           1101 	ld	hl,#0x0213
   226A E5                 1102 	push	hl
                           1103 ;	genIpush
   226B 3E 39              1104 	ld	a,#0x39
   226D F5                 1105 	push	af
   226E 33                 1106 	inc	sp
                           1107 ;	genCall
   226F CD D6 0F           1108 	call	_SetAttrib
   2272 F1                 1109 	pop	af
   2273 33                 1110 	inc	sp
                           1111 ;exceptions.c:148: SetAttrib(SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 3);
                           1112 ;	genIpush
                           1113 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   2274 21 13 03           1114 	ld	hl,#0x0313
   2277 E5                 1115 	push	hl
                           1116 ;	genIpush
   2278 3E 39              1117 	ld	a,#0x39
   227A F5                 1118 	push	af
   227B 33                 1119 	inc	sp
                           1120 ;	genCall
   227C CD D6 0F           1121 	call	_SetAttrib
   227F F1                 1122 	pop	af
   2280 33                 1123 	inc	sp
                           1124 ;exceptions.c:149: SetAttrib(SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 4);
                           1125 ;	genIpush
                           1126 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   2281 21 13 04           1127 	ld	hl,#0x0413
   2284 E5                 1128 	push	hl
                           1129 ;	genIpush
   2285 3E 39              1130 	ld	a,#0x39
   2287 F5                 1131 	push	af
   2288 33                 1132 	inc	sp
                           1133 ;	genCall
   2289 CD D6 0F           1134 	call	_SetAttrib
   228C F1                 1135 	pop	af
   228D 33                 1136 	inc	sp
                           1137 ;exceptions.c:150: SetAttrib(SCRATTR_BLACKPAPER|SCRATTR_WHITEINK, 19, 5);
                           1138 ;	genIpush
                           1139 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   228E 21 13 05           1140 	ld	hl,#0x0513
   2291 E5                 1141 	push	hl
                           1142 ;	genIpush
   2292 3E 39              1143 	ld	a,#0x39
   2294 F5                 1144 	push	af
   2295 33                 1145 	inc	sp
                           1146 ;	genCall
   2296 CD D6 0F           1147 	call	_SetAttrib
   2299 F1                 1148 	pop	af
   229A 33                 1149 	inc	sp
                           1150 ;	genLabel
   0440                    1151 00112$:
                           1152 ;	genEndFunction
   229B DD F9              1153 	ld	sp,ix
   229D DD E1              1154 	pop	ix
   229F 3E 04              1155 	ld	a,#4
   22A1 CF                 1156 	rst	0x08
   22A2 C9                 1157 	ret
   0448                    1158 _Alert_end::
                    0448   1159 Fexceptions$_str_0$0$0 == .
   0448                    1160 __str_0:
   22A3 2D 2D 2D 2D 2D 2D  1161 	.ascii "-------------------"
        2D 2D 2D 2D 2D 2D
        2D 2D 2D 2D 2D 2D
        2D
   22B6 0A                 1162 	.db 0x0A
   22B7 00                 1163 	.db 0x00
                    045D   1164 Fexceptions$_str_1$0$0 == .
   045D                    1165 __str_1:
   22B8 42 52 45 41 4B 3A  1166 	.ascii "BREAK: "
        20
   22BF 00                 1167 	.db 0x00
                    0465   1168 Fexceptions$_str_2$0$0 == .
   0465                    1169 __str_2:
   22C0 0A                 1170 	.db 0x0A
   22C1 00                 1171 	.db 0x00
                    0467   1172 Fexceptions$_str_3$0$0 == .
   0467                    1173 __str_3:
   22C2 48 41 4C 54 3A 20  1174 	.ascii "HALT: "
   22C8 00                 1175 	.db 0x00
                    046E   1176 Fexceptions$_str_4$0$0 == .
   046E                    1177 __str_4:
   22C9 C4                 1178 	.db 0xC4
   22CA C4                 1179 	.db 0xC4
   22CB C4                 1180 	.db 0xC4
   22CC C4                 1181 	.db 0xC4
   22CD C4                 1182 	.db 0xC4
   22CE C4                 1183 	.db 0xC4
   22CF C4                 1184 	.db 0xC4
   22D0 C4                 1185 	.db 0xC4
   22D1 C4                 1186 	.db 0xC4
   22D2 C4                 1187 	.db 0xC4
   22D3 C4                 1188 	.db 0xC4
   22D4 C4                 1189 	.db 0xC4
   22D5 C4                 1190 	.db 0xC4
   22D6 C4                 1191 	.db 0xC4
   22D7 C4                 1192 	.db 0xC4
   22D8 C4                 1193 	.db 0xC4
   22D9 C4                 1194 	.db 0xC4
   22DA C4                 1195 	.db 0xC4
   22DB C4                 1196 	.db 0xC4
   22DC C4                 1197 	.db 0xC4
   22DD C4                 1198 	.db 0xC4
   22DE C4                 1199 	.db 0xC4
   22DF C4                 1200 	.db 0xC4
   22E0 C4                 1201 	.db 0xC4
   22E1 C4                 1202 	.db 0xC4
   22E2 C4                 1203 	.db 0xC4
   22E3 C4                 1204 	.db 0xC4
   22E4 C4                 1205 	.db 0xC4
   22E5 C4                 1206 	.db 0xC4
   22E6 C4                 1207 	.db 0xC4
   22E7 C4                 1208 	.db 0xC4
   22E8 C4                 1209 	.db 0xC4
   22E9 00                 1210 	.db 0x00
                    048F   1211 Fexceptions$_str_5$0$0 == .
   048F                    1212 __str_5:
   22EA 20 20 20 20 20 20  1213 	.ascii "                                "
        20 20 20 20 20 20
        20 20 20 20 20 20
        20 20 20 20 20 20
        20 20 20 20 20 20
        20 20
   230A 00                 1214 	.db 0x00
                    04B0   1215 Fexceptions$_str_6$0$0 == .
   04B0                    1216 __str_6:
   230B 20 42 52 45 41 4B  1217 	.ascii " BREAK "
        20
   2312 00                 1218 	.db 0x00
                    04B8   1219 Fexceptions$_str_7$0$0 == .
   04B8                    1220 __str_7:
   2313 20 48 41 4C 54 20  1221 	.ascii " HALT "
   2319 00                 1222 	.db 0x00
                    04BF   1223 Fexceptions$_str_8$0$0 == .
   04BF                    1224 __str_8:
   231A 20 41              1225 	.ascii " A"
   231C 00                 1226 	.db 0x00
                    04C2   1227 Fexceptions$_str_9$0$0 == .
   04C2                    1228 __str_9:
   231D 42 43              1229 	.ascii "BC"
   231F 00                 1230 	.db 0x00
                    04C5   1231 Fexceptions$_str_10$0$0 == .
   04C5                    1232 __str_10:
   2320 44 45              1233 	.ascii "DE"
   2322 00                 1234 	.db 0x00
                    04C8   1235 Fexceptions$_str_11$0$0 == .
   04C8                    1236 __str_11:
   2323 48 4C              1237 	.ascii "HL"
   2325 00                 1238 	.db 0x00
                    04CB   1239 Fexceptions$_str_12$0$0 == .
   04CB                    1240 __str_12:
   2326 49 58              1241 	.ascii "IX"
   2328 00                 1242 	.db 0x00
                    04CE   1243 Fexceptions$_str_13$0$0 == .
   04CE                    1244 __str_13:
   2329 49 59              1245 	.ascii "IY"
   232B 00                 1246 	.db 0x00
                    04D1   1247 Fexceptions$_str_14$0$0 == .
   04D1                    1248 __str_14:
   232C 53 50              1249 	.ascii "SP"
   232E 00                 1250 	.db 0x00
                    04D4   1251 Fexceptions$_str_15$0$0 == .
   04D4                    1252 __str_15:
   232F 50 43              1253 	.ascii "PC"
   2331 00                 1254 	.db 0x00
                           1255 ;exceptions.c:153: void Halt(char* ErrorMessage) {
                           1256 ;	genLabel
                           1257 ;	genFunction
                           1258 ;	---------------------------------
                           1259 ; Function Halt
                           1260 ; ---------------------------------
   04D7                    1261 _Halt_start::
   04D7                    1262 _Halt:
   2332 3E 03              1263 	ld	a,#3
   2334 CF                 1264 	rst	0x08
   2335 DD E5              1265 	push	ix
   2337 DD 21 00 00        1266 	ld	ix,#0
   233B DD 39              1267 	add	ix,sp
                           1268 ;exceptions.c:155: Alert(alertHalt, ErrorMessage);
                           1269 ;	genIpush
                           1270 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
                           1271 ;	AOP_STK for 
   233D DD 6E 04           1272 	ld	l,4(ix)
   2340 DD 66 05           1273 	ld	h,5(ix)
   2343 E5                 1274 	push	hl
                           1275 ;	genIpush
   2344 3E 00              1276 	ld	a,#0x00
   2346 F5                 1277 	push	af
   2347 33                 1278 	inc	sp
                           1279 ;	genCall
   2348 CD F5 1E           1280 	call	_Alert
   234B F1                 1281 	pop	af
   234C 33                 1282 	inc	sp
                           1283 ;	genLabel
   04F2                    1284 00101$:
                           1285 ;	genEndFunction
   234D DD E1              1286 	pop	ix
   234F 3E 04              1287 	ld	a,#4
   2351 CF                 1288 	rst	0x08
   2352 C9                 1289 	ret
   04F8                    1290 _Halt_end::
                           1291 ;exceptions.c:158: void Break(char* Message) {
                           1292 ;	genLabel
                           1293 ;	genFunction
                           1294 ;	---------------------------------
                           1295 ; Function Break
                           1296 ; ---------------------------------
   04F8                    1297 _Break_start::
   04F8                    1298 _Break:
   2353 3E 03              1299 	ld	a,#3
   2355 CF                 1300 	rst	0x08
   2356 DD E5              1301 	push	ix
   2358 DD 21 00 00        1302 	ld	ix,#0
   235C DD 39              1303 	add	ix,sp
                           1304 ;exceptions.c:159: LockObtain(SystemLock);
                           1305 ;	genIpush
                           1306 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   235E 3A 25 83           1307 	ld	a,(_SystemLock)
   2361 F5                 1308 	push	af
   2362 33                 1309 	inc	sp
                           1310 ;	genCall
   2363 CD 5B 17           1311 	call	_LockObtain
   2366 33                 1312 	inc	sp
                           1313 ;exceptions.c:170: _endasm;
                           1314 ;	genInline
                           1315 ;
   2367 FD 22 2A 83        1316 		       ld (_SavedIY),iy
   236B C1                 1317 		       pop bc
   236C 22 28 83           1318 		       ld (_SavedIX),hl
   236F E1                 1319 		       pop hl
   2370 D1                 1320 		       pop de
   2371 ED 53 26 83        1321 		       ld (_SavedPC),de
   2375 D5                 1322 		       push de
   2376 E5                 1323 		       push hl
   2377 C5                 1324 		       push bc
                           1325 		       
                           1326 ;exceptions.c:171: ExchangeRegs();
                           1327 ;	genCall
                           1328 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   2378 CD F4 03           1329 	call	_ExchangeRegs
                           1330 ;exceptions.c:172: Alert(alertBreak, Message);
                           1331 ;	genIpush
                           1332 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
                           1333 ;	AOP_STK for 
   237B DD 6E 04           1334 	ld	l,4(ix)
   237E DD 66 05           1335 	ld	h,5(ix)
   2381 E5                 1336 	push	hl
                           1337 ;	genIpush
   2382 3E 01              1338 	ld	a,#0x01
   2384 F5                 1339 	push	af
   2385 33                 1340 	inc	sp
                           1341 ;	genCall
   2386 CD F5 1E           1342 	call	_Alert
   2389 F1                 1343 	pop	af
   238A 33                 1344 	inc	sp
                           1345 ;exceptions.c:173: ExchangeRegs();
                           1346 ;	genCall
                           1347 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   238B CD F4 03           1348 	call	_ExchangeRegs
                           1349 ;exceptions.c:174: LockRelease(SystemLock);
                           1350 ;	genIpush
                           1351 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   238E 3A 25 83           1352 	ld	a,(_SystemLock)
   2391 F5                 1353 	push	af
   2392 33                 1354 	inc	sp
                           1355 ;	genCall
   2393 CD CE 17           1356 	call	_LockRelease
   2396 33                 1357 	inc	sp
                           1358 ;	genLabel
   053C                    1359 00101$:
                           1360 ;	genEndFunction
   2397 DD E1              1361 	pop	ix
   2399 3E 04              1362 	ld	a,#4
   239B CF                 1363 	rst	0x08
   239C C9                 1364 	ret
   0542                    1365 _Break_end::
                           1366 ;exceptions.c:177: void SystemMonitor() {
                           1367 ;	genLabel
                           1368 ;	genFunction
                           1369 ;	---------------------------------
                           1370 ; Function SystemMonitor
                           1371 ; ---------------------------------
   0542                    1372 _SystemMonitor_start::
   0542                    1373 _SystemMonitor:
   239D 3E 03              1374 	ld	a,#3
   239F CF                 1375 	rst	0x08
   23A0 DD E5              1376 	push	ix
   23A2 DD 21 00 00        1377 	ld	ix,#0
   23A6 DD 39              1378 	add	ix,sp
   23A8 21 00 FF           1379 	ld	hl,#-256
   23AB 39                 1380 	add	hl,sp
   23AC F9                 1381 	ld	sp,hl
                           1382 ;exceptions.c:179: ConsoleWrite("SYSTEM MONITOR\n");
                           1383 ;	genIpush
                           1384 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   23AD 21 00 24           1385 	ld	hl,#__str_16
   23B0 E5                 1386 	push	hl
                           1387 ;	genCall
   23B1 CD 84 14           1388 	call	_ConsoleWrite
   23B4 F1                 1389 	pop	af
                           1390 ;exceptions.c:180: do {
                           1391 ;	genLabel
   055A                    1392 00105$:
                           1393 ;exceptions.c:181: ConsoleWrite(") ");
                           1394 ;	genIpush
                           1395 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   23B5 21 10 24           1396 	ld	hl,#__str_17
   23B8 E5                 1397 	push	hl
                           1398 ;	genCall
   23B9 CD 84 14           1399 	call	_ConsoleWrite
   23BC F1                 1400 	pop	af
                           1401 ;exceptions.c:182: ConsoleReadLine(CommandLine);
                           1402 ;	genAddrOf
   23BD 21 00 00           1403 	ld	hl,#0x0000
   23C0 39                 1404 	add	hl,sp
   23C1 4D                 1405 	ld	c,l
   23C2 44                 1406 	ld	b,h
                           1407 ;	genIpush
                           1408 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   23C3 C5                 1409 	push	bc
   23C4 C5                 1410 	push	bc
                           1411 ;	genCall
   23C5 CD 50 15           1412 	call	_ConsoleReadLine
   23C8 F1                 1413 	pop	af
   23C9 C1                 1414 	pop	bc
                           1415 ;exceptions.c:183: if(!IsMultitasking()) Halt("PAUSE WITHOUT RESUME");
                           1416 ;	genCall
                           1417 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   23CA C5                 1418 	push	bc
   23CB CD 3F 1E           1419 	call	_IsMultitasking
   23CE C1                 1420 	pop	bc
                           1421 ;	genIfx
   23CF AF                 1422 	xor	a,a
   23D0 B5                 1423 	or	a,l
   23D1 C2 DE 23           1424 	jp	nz,00102$
                           1425 ;	genIpush
                           1426 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   23D4 C5                 1427 	push	bc
   23D5 21 13 24           1428 	ld	hl,#__str_18
   23D8 E5                 1429 	push	hl
                           1430 ;	genCall
   23D9 CD 32 23           1431 	call	_Halt
   23DC F1                 1432 	pop	af
   23DD C1                 1433 	pop	bc
                           1434 ;	genLabel
   0583                    1435 00102$:
                           1436 ;exceptions.c:184: if(SameString("HELP", CommandLine)) {
                           1437 ;	genIpush
                           1438 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   23DE C5                 1439 	push	bc
                           1440 ;	genIpush
   23DF 21 28 24           1441 	ld	hl,#__str_19
   23E2 E5                 1442 	push	hl
                           1443 ;	genCall
   23E3 CD 5E 04           1444 	call	_SameString
   23E6 F1                 1445 	pop	af
   23E7 F1                 1446 	pop	af
                           1447 ;	genIfx
   23E8 AF                 1448 	xor	a,a
   23E9 B5                 1449 	or	a,l
   23EA CA B5 23           1450 	jp	z,00105$
                           1451 ;exceptions.c:185: ConsoleWrite("THIS IS THE SYSTEM MONITOR OF\nLJL OS. THERE IS NO HELP SYSTEM\nAT THE MOMENT.\n");
                           1452 ;	genIpush
                           1453 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   23ED 21 2D 24           1454 	ld	hl,#__str_20
   23F0 E5                 1455 	push	hl
                           1456 ;	genCall
   23F1 CD 84 14           1457 	call	_ConsoleWrite
   23F4 F1                 1458 	pop	af
                           1459 ;exceptions.c:187: } while(1);
                           1460 ;	genGoto
   23F5 C3 B5 23           1461 	jp	00105$
                           1462 ;	genLabel
   059D                    1463 00108$:
                           1464 ;	genEndFunction
   23F8 DD F9              1465 	ld	sp,ix
   23FA DD E1              1466 	pop	ix
   23FC 3E 04              1467 	ld	a,#4
   23FE CF                 1468 	rst	0x08
   23FF C9                 1469 	ret
   05A5                    1470 _SystemMonitor_end::
                    05A5   1471 Fexceptions$_str_16$0$0 == .
   05A5                    1472 __str_16:
   2400 53 59 53 54 45 4D  1473 	.ascii "SYSTEM MONITOR"
        20 4D 4F 4E 49 54
        4F 52
   240E 0A                 1474 	.db 0x0A
   240F 00                 1475 	.db 0x00
                    05B5   1476 Fexceptions$_str_17$0$0 == .
   05B5                    1477 __str_17:
   2410 29 20              1478 	.ascii ") "
   2412 00                 1479 	.db 0x00
                    05B8   1480 Fexceptions$_str_18$0$0 == .
   05B8                    1481 __str_18:
   2413 50 41 55 53 45 20  1482 	.ascii "PAUSE WITHOUT RESUME"
        57 49 54 48 4F 55
        54 20 52 45 53 55
        4D 45
   2427 00                 1483 	.db 0x00
                    05CD   1484 Fexceptions$_str_19$0$0 == .
   05CD                    1485 __str_19:
   2428 48 45 4C 50        1486 	.ascii "HELP"
   242C 00                 1487 	.db 0x00
                    05D2   1488 Fexceptions$_str_20$0$0 == .
   05D2                    1489 __str_20:
   242D 54 48 49 53 20 49  1490 	.ascii "THIS IS THE SYSTEM MONITOR OF"
        53 20 54 48 45 20
        53 59 53 54 45 4D
        20 4D 4F 4E 49 54
        4F 52 20 4F 46
   244A 0A                 1491 	.db 0x0A
   244B 4C 4A 4C 20 4F 53  1492 	.ascii "LJL OS. THERE IS NO HELP SYSTE"
        2E 20 54 48 45 52
        45 20 49 53 20 4E
        4F 20 48 45 4C 50
        20 53 59 53 54 45
   2469 4D                 1493 	.ascii "M"
   246A 0A                 1494 	.db 0x0A
   246B 41 54 20 54 48 45  1495 	.ascii "AT THE MOMENT."
        20 4D 4F 4D 45 4E
        54 2E
   2479 0A                 1496 	.db 0x0A
   247A 00                 1497 	.db 0x00
                           1498 	.area _CODE
