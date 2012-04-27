                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.5 Fri Apr 27 12:30:18 2012
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module memory
                              7 	.optsdcc -mz80
                              8 	
                              9 ;--------------------------------------------------------
                             10 ; Public variables in this module
                             11 ;--------------------------------------------------------
                             12 	.globl _MemoryInited
                             13 	.globl _NextFreeBlock
                             14 	.globl _MemoryInit
                             15 	.globl _MemoryCopy
                             16 	.globl _MemoryAllocate
                             17 	.globl _MemoryFree
                             18 ;--------------------------------------------------------
                             19 ;  ram data
                             20 ;--------------------------------------------------------
                             21 	.area _DATA
                    0000     22 G$NextFreeBlock$0$0==.
   0000                      23 _NextFreeBlock::
   0000                      24 	.ds 2
                    0002     25 G$MemoryInited$0$0==.
   0002                      26 _MemoryInited::
   0002                      27 	.ds 1
                             28 ;--------------------------------------------------------
                             29 ; overlayable items in  ram 
                             30 ;--------------------------------------------------------
                             31 	.area _OVERLAY
                             32 ;--------------------------------------------------------
                             33 ; external initialized ram data
                             34 ;--------------------------------------------------------
                             35 ;--------------------------------------------------------
                             36 ; global & static initialisations
                             37 ;--------------------------------------------------------
                             38 	.area _GSINIT
                             39 	.area _GSFINAL
                             40 	.area _GSINIT
                             41 ;--------------------------------------------------------
                             42 ; Home
                             43 ;--------------------------------------------------------
                             44 	.area _HOME
                             45 	.area _CODE
                             46 ;--------------------------------------------------------
                             47 ; code
                             48 ;--------------------------------------------------------
                             49 	.area _CODE
                             50 ;memory.c:10: bool MemoryInited; void MemoryInit() {
                             51 ;	genLabel
                             52 ;	genFunction
                             53 ;	---------------------------------
                             54 ; Function MemoryInit
                             55 ; ---------------------------------
   0000                      56 _MemoryInit_start::
   0000                      57 _MemoryInit:
   15E2 3E 03                58 	ld	a,#3
   15E4 CF                   59 	rst	0x08
                             60 ;memory.c:11: if(!MemoryInited) {
                             61 ;	genIfx
   15E5 AF                   62 	xor	a,a
   15E6 FD 21 0F 80          63 	ld	iy,#_MemoryInited
   15EA FD B6 00             64 	or	a,0(iy)
   15ED C2 19 16             65 	jp	nz,00103$
                             66 ;memory.c:12: NextFreeBlock=(char*)0xe000;
                             67 ;	genAssign
   15F0 FD 21 0D 80          68 	ld	iy,#_NextFreeBlock
   15F4 FD 36 00 00          69 	ld	0(iy),#0x00
   15F8 FD 36 01 E0          70 	ld	1(iy),#0xE0
                             71 ;memory.c:13: MemoryInited=TRUE;
                             72 ;	genAssign
   15FC FD 21 0F 80          73 	ld	iy,#_MemoryInited
   1600 FD 36 00 01          74 	ld	0(iy),#0x01
                             75 ;memory.c:14: _SimRWProtect((void*)0x8600, 0xffd0);
                             76 ;	genIpush
                             77 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1604 21 D0 FF             78 	ld	hl,#0xFFD0
   1607 E5                   79 	push	hl
                             80 ;	genIpush
   1608 21 00 86             81 	ld	hl,#0x8600
   160B E5                   82 	push	hl
                             83 ;	genCall
   160C CD 5C 2B             84 	call	__Z80SimRWProtect
   160F F1                   85 	pop	af
   1610 F1                   86 	pop	af
                             87 ;memory.c:15: _SimPrintString("Memory initialized\n");
                             88 ;	genIpush
                             89 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1611 21 1D 16             90 	ld	hl,#__str_0
   1614 E5                   91 	push	hl
                             92 ;	genCall
   1615 CD CA 2A             93 	call	__Z80SimPrintString
   1618 F1                   94 	pop	af
                             95 ;	genLabel
   0037                      96 00103$:
                             97 ;	genEndFunction
   1619 3E 04                98 	ld	a,#4
   161B CF                   99 	rst	0x08
   161C C9                  100 	ret
   003B                     101 _MemoryInit_end::
                    003B    102 Fmemory$_str_0$0$0 == .
   003B                     103 __str_0:
   161D 4D 65 6D 6F 72 79   104 	.ascii "Memory initialized"
        20 69 6E 69 74 69
        61 6C 69 7A 65 64
   162F 0A                  105 	.db 0x0A
   1630 00                  106 	.db 0x00
                            107 ;memory.c:19: void MemoryCopy(void* Destination, void* Source, unsigned int Length) {
                            108 ;	genLabel
                            109 ;	genFunction
                            110 ;	---------------------------------
                            111 ; Function MemoryCopy
                            112 ; ---------------------------------
   004F                     113 _MemoryCopy_start::
   004F                     114 _MemoryCopy:
   1631 3E 03               115 	ld	a,#3
   1633 CF                  116 	rst	0x08
   1634 DD E5               117 	push	ix
   1636 DD 21 00 00         118 	ld	ix,#0
   163A DD 39               119 	add	ix,sp
   163C 21 FE FF            120 	ld	hl,#-2
   163F 39                  121 	add	hl,sp
   1640 F9                  122 	ld	sp,hl
                            123 ;memory.c:21: for(i=0; i<Length; i++) {
                            124 ;	genAssign
                            125 ;	AOP_STK for 
   1641 DD 4E 04            126 	ld	c,4(ix)
   1644 DD 46 05            127 	ld	b,5(ix)
                            128 ;	genAssign
                            129 ;	(operands are equal 3)
                            130 ;	genAssign
   1647 11 00 00            131 	ld	de,#0x0000
                            132 ;	genLabel
   0068                     133 00101$:
                            134 ;	genCmpLt
                            135 ;	AOP_STK for 
   164A 7B                  136 	ld	a,e
   164B DD 96 08            137 	sub	a,8(ix)
   164E 7A                  138 	ld	a,d
   164F DD 9E 09            139 	sbc	a,9(ix)
   1652 D2 72 16            140 	jp	nc,00105$
                            141 ;memory.c:22: *((char*)Destination+i)=*((char*)Source+i);
                            142 ;	genPlus
                            143 ;	AOP_STK for _MemoryCopy__1_0
                            144 ;	Can't optimise plus by inc, falling back to the normal way
   1655 79                  145 	ld	a,c
   1656 83                  146 	add	a,e
   1657 DD 77 FE            147 	ld	-2(ix),a
   165A 78                  148 	ld	a,b
   165B 8A                  149 	adc	a,d
   165C DD 77 FF            150 	ld	-1(ix),a
                            151 ;	genPlus
                            152 ;	AOP_STK for 
                            153 ;	Can't optimise plus by inc, falling back to the normal way
   165F DD 6E 06            154 	ld	l,6(ix)
   1662 DD 66 07            155 	ld	h,7(ix)
   1665 19                  156 	add	hl,de
                            157 ;	genPointerGet
   1666 7E                  158 	ld	a,(hl)
                            159 ;	genAssign (pointer)
                            160 ;	AOP_STK for _MemoryCopy__1_0
                            161 ;	isBitvar = 0
   1667 DD 6E FE            162 	ld	l,-2(ix)
   166A DD 66 FF            163 	ld	h,-1(ix)
   166D 77                  164 	ld	(hl),a
                            165 ;memory.c:21: for(i=0; i<Length; i++) {
                            166 ;	genPlus
                            167 ;	genPlusIncr
   166E 13                  168 	inc	de
                            169 ;	genGoto
   166F C3 4A 16            170 	jp	00101$
                            171 ;	genLabel
   0090                     172 00105$:
                            173 ;	genEndFunction
   1672 DD F9               174 	ld	sp,ix
   1674 DD E1               175 	pop	ix
   1676 3E 04               176 	ld	a,#4
   1678 CF                  177 	rst	0x08
   1679 C9                  178 	ret
   0098                     179 _MemoryCopy_end::
                            180 ;memory.c:26: void* MemoryAllocate(unsigned int Bytes, memType Type) {
                            181 ;	genLabel
                            182 ;	genFunction
                            183 ;	---------------------------------
                            184 ; Function MemoryAllocate
                            185 ; ---------------------------------
   0098                     186 _MemoryAllocate_start::
   0098                     187 _MemoryAllocate:
   167A 3E 03               188 	ld	a,#3
   167C CF                  189 	rst	0x08
   167D DD E5               190 	push	ix
   167F DD 21 00 00         191 	ld	ix,#0
   1683 DD 39               192 	add	ix,sp
                            193 ;memory.c:28: if(NextFreeBlock<(char*)0x9000) Halt("OUT OF MEMORY");
                            194 ;	genCmpLt
   1685 FD 21 0D 80         195 	ld	iy,#_NextFreeBlock
   1689 FD 7E 00            196 	ld	a,0(iy)
   168C D6 00               197 	sub	a,#0x00
   168E FD 7E 01            198 	ld	a,1(iy)
   1691 DE 90               199 	sbc	a,#0x90
   1693 F2 9E 16            200 	jp	p,00102$
                            201 ;	genIpush
                            202 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1696 21 D7 16            203 	ld	hl,#__str_1
   1699 E5                  204 	push	hl
                            205 ;	genCall
   169A CD 32 23            206 	call	_Halt
   169D F1                  207 	pop	af
                            208 ;	genLabel
   00BC                     209 00102$:
                            210 ;memory.c:29: Pointer=NextFreeBlock;
                            211 ;	genAssign
   169E ED 4B 0D 80         212 	ld	bc,(_NextFreeBlock)
                            213 ;memory.c:30: NextFreeBlock=NextFreeBlock-Bytes;
                            214 ;	genAssign
                            215 ;	AOP_STK for 
   16A2 DD 5E 04            216 	ld	e,4(ix)
   16A5 DD 56 05            217 	ld	d,5(ix)
                            218 ;	genMinus
                            219 ;	Shift into pair idx 0
   16A8 21 0D 80            220 	ld	hl,#_NextFreeBlock
   16AB 7E                  221 	ld	a,(hl)
   16AC 93                  222 	sub	a,e
   16AD 77                  223 	ld	(hl),a
   16AE 23                  224 	inc	hl
   16AF 7E                  225 	ld	a,(hl)
   16B0 9A                  226 	sbc	a,d
   16B1 77                  227 	ld	(hl),a
                            228 ;memory.c:31: _SimUnprotect(NextFreeBlock, Pointer);
                            229 ;	genAssign
   16B2 ED 5B 0D 80         230 	ld	de,(_NextFreeBlock)
                            231 ;	genIpush
                            232 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   16B6 C5                  233 	push	bc
   16B7 C5                  234 	push	bc
                            235 ;	genIpush
   16B8 D5                  236 	push	de
                            237 ;	genCall
   16B9 CD 7C 2B            238 	call	__Z80SimUnprotect
   16BC F1                  239 	pop	af
   16BD F1                  240 	pop	af
   16BE C1                  241 	pop	bc
                            242 ;memory.c:32: if(Type==memSTACK) {
                            243 ;	genCmpEq
                            244 ;	AOP_STK for 
                            245 ; genCmpEq: left 1, right 1, result 0
   16BF DD 7E 06            246 	ld	a,6(ix)
   16C2 B7                  247 	or	a,a
   16C3 CA C9 16            248 	jp	z,00111$
   00E4                     249 00110$:
   16C6 C3 CE 16            250 	jp	00104$
   00E7                     251 00111$:
                            252 ;memory.c:33: return (void*)Pointer;
                            253 ;	genRet
                            254 ; Dump of IC_LEFT: type AOP_REG size 2
                            255 ;	 reg = bc
   16C9 69                  256 	ld	l,c
   16CA 60                  257 	ld	h,b
   16CB C3 D1 16            258 	jp	00106$
                            259 ;	genLabel
   00EC                     260 00104$:
                            261 ;memory.c:35: return (void*)NextFreeBlock;
                            262 ;	genAssign
   16CE 2A 0D 80            263 	ld	hl,(_NextFreeBlock)
                            264 ;	genRet
                            265 ; Dump of IC_LEFT: type AOP_STR size 2
                            266 ;	genLabel
   00EF                     267 00106$:
                            268 ;	genEndFunction
   16D1 DD E1               269 	pop	ix
   16D3 3E 04               270 	ld	a,#4
   16D5 CF                  271 	rst	0x08
   16D6 C9                  272 	ret
   00F5                     273 _MemoryAllocate_end::
                    00F5    274 Fmemory$_str_1$0$0 == .
   00F5                     275 __str_1:
   16D7 4F 55 54 20 4F 46   276 	.ascii "OUT OF MEMORY"
        20 4D 45 4D 4F 52
        59
   16E4 00                  277 	.db 0x00
                            278 ;memory.c:39: void MemoryFree(void* Pointer) {
                            279 ;	genLabel
                            280 ;	genFunction
                            281 ;	---------------------------------
                            282 ; Function MemoryFree
                            283 ; ---------------------------------
   0103                     284 _MemoryFree_start::
   0103                     285 _MemoryFree:
   16E5 3E 03               286 	ld	a,#3
   16E7 CF                  287 	rst	0x08
   16E8 DD E5               288 	push	ix
   16EA DD 21 00 00         289 	ld	ix,#0
   16EE DD 39               290 	add	ix,sp
                            291 ;memory.c:41: Pointer;
                            292 ;	genLabel
   010E                     293 00101$:
                            294 ;	genEndFunction
   16F0 DD E1               295 	pop	ix
   16F2 3E 04               296 	ld	a,#4
   16F4 CF                  297 	rst	0x08
   16F5 C9                  298 	ret
   0114                     299 _MemoryFree_end::
                            300 	.area _CODE
