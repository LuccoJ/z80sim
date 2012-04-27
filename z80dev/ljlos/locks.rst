                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.5 Fri Apr 27 12:30:18 2012
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module locks
                              7 	.optsdcc -mz80
                              8 	
                              9 ;--------------------------------------------------------
                             10 ; Public variables in this module
                             11 ;--------------------------------------------------------
                             12 	.globl _LocksInited
                             13 	.globl _LockCount
                             14 	.globl _Locks
                             15 	.globl _SystemLock
                             16 	.globl _LocksInit
                             17 	.globl _LockCreate
                             18 	.globl _LockObtain
                             19 	.globl _LockRelease
                             20 	.globl _LockQuery
                             21 ;--------------------------------------------------------
                             22 ;  ram data
                             23 ;--------------------------------------------------------
                             24 	.area _DATA
                    0000     25 G$SystemLock$0$0==.
   0000                      26 _SystemLock::
   0000                      27 	.ds 1
                    0001     28 G$Locks$0$0==.
   0001                      29 _Locks::
   0001                      30 	.ds 256
                    0101     31 G$LockCount$0$0==.
   0101                      32 _LockCount::
   0101                      33 	.ds 1
                    0102     34 G$LocksInited$0$0==.
   0102                      35 _LocksInited::
   0102                      36 	.ds 1
                             37 ;--------------------------------------------------------
                             38 ; overlayable items in  ram 
                             39 ;--------------------------------------------------------
                             40 	.area _OVERLAY
                             41 ;--------------------------------------------------------
                             42 ; external initialized ram data
                             43 ;--------------------------------------------------------
                             44 ;--------------------------------------------------------
                             45 ; global & static initialisations
                             46 ;--------------------------------------------------------
                             47 	.area _GSINIT
                             48 	.area _GSFINAL
                             49 	.area _GSINIT
                             50 ;--------------------------------------------------------
                             51 ; Home
                             52 ;--------------------------------------------------------
                             53 	.area _HOME
                             54 	.area _CODE
                             55 ;--------------------------------------------------------
                             56 ; code
                             57 ;--------------------------------------------------------
                             58 	.area _CODE
                             59 ;locks.c:13: bool LocksInited; void LocksInit() {
                             60 ;	genLabel
                             61 ;	genFunction
                             62 ;	---------------------------------
                             63 ; Function LocksInit
                             64 ; ---------------------------------
   0000                      65 _LocksInit_start::
   0000                      66 _LocksInit:
   16F6 3E 03                67 	ld	a,#3
   16F8 CF                   68 	rst	0x08
                             69 ;locks.c:14: if(!LocksInited) {
                             70 ;	genIfx
   16F9 AF                   71 	xor	a,a
   16FA FD 21 12 81          72 	ld	iy,#_LocksInited
   16FE FD B6 00             73 	or	a,0(iy)
   1701 C2 1F 17             74 	jp	nz,00103$
                             75 ;locks.c:15: LockCount=0;
                             76 ;	genAssign
   1704 FD 21 11 81          77 	ld	iy,#_LockCount
   1708 FD 36 00 00          78 	ld	0(iy),#0x00
                             79 ;locks.c:16: SchedulingInit();
                             80 ;	genCall
                             81 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   170C CD 16 19             82 	call	_SchedulingInit
                             83 ;locks.c:17: LocksInited=TRUE;
                             84 ;	genAssign
   170F FD 21 12 81          85 	ld	iy,#_LocksInited
   1713 FD 36 00 01          86 	ld	0(iy),#0x01
                             87 ;locks.c:18: _SimPrintString("Locks initialized\n");
                             88 ;	genIpush
                             89 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1717 21 23 17             90 	ld	hl,#__str_0
   171A E5                   91 	push	hl
                             92 ;	genCall
   171B CD CA 2A             93 	call	__Z80SimPrintString
   171E F1                   94 	pop	af
                             95 ;	genLabel
   0029                      96 00103$:
                             97 ;	genEndFunction
   171F 3E 04                98 	ld	a,#4
   1721 CF                   99 	rst	0x08
   1722 C9                  100 	ret
   002D                     101 _LocksInit_end::
                    002D    102 Flocks$_str_0$0$0 == .
   002D                     103 __str_0:
   1723 4C 6F 63 6B 73 20   104 	.ascii "Locks initialized"
        69 6E 69 74 69 61
        6C 69 7A 65 64
   1734 0A                  105 	.db 0x0A
   1735 00                  106 	.db 0x00
                            107 ;locks.c:22: lock LockCreate() {
                            108 ;	genLabel
                            109 ;	genFunction
                            110 ;	---------------------------------
                            111 ; Function LockCreate
                            112 ; ---------------------------------
   0040                     113 _LockCreate_start::
   0040                     114 _LockCreate:
   1736 3E 03               115 	ld	a,#3
   1738 CF                  116 	rst	0x08
                            117 ;locks.c:24: Pause();
                            118 ;	genCall
                            119 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1739 CD 2A 1C            120 	call	_Pause
                            121 ;locks.c:25: NewLock=LockCount;
                            122 ;	genAssign
   173C FD 21 11 81         123 	ld	iy,#_LockCount
   1740 FD 4E 00            124 	ld	c,0(iy)
                            125 ;locks.c:26: Locks[NewLock]=FALSE;
                            126 ;	genPlus
                            127 ;	Can't optimise plus by inc, falling back to the normal way
   1743 3E 11               128 	ld	a,#<_Locks
   1745 81                  129 	add	a,c
   1746 6F                  130 	ld	l,a
   1747 3E 80               131 	ld	a,#>_Locks
   1749 CE 00               132 	adc	a,#0x00
   174B 67                  133 	ld	h,a
                            134 ;	genAssign (pointer)
                            135 ;	isBitvar = 0
   174C 36 00               136 	ld	(hl),#0x00
                            137 ;locks.c:27: LockCount++;
                            138 ;	genPlus
                            139 ;	genPlusIncr
   174E FD 34 00            140 	inc	0(iy)
                            141 ;locks.c:28: Resume();
                            142 ;	genCall
                            143 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1751 C5                  144 	push	bc
   1752 CD 47 1C            145 	call	_Resume
   1755 C1                  146 	pop	bc
                            147 ;locks.c:29: return NewLock;
                            148 ;	genRet
                            149 ; Dump of IC_LEFT: type AOP_REG size 1
                            150 ;	 reg = c
   1756 69                  151 	ld	l,c
                            152 ;	genLabel
   0061                     153 00101$:
                            154 ;	genEndFunction
   1757 3E 04               155 	ld	a,#4
   1759 CF                  156 	rst	0x08
   175A C9                  157 	ret
   0065                     158 _LockCreate_end::
                            159 ;locks.c:33: void LockObtain(lock Handle) {
                            160 ;	genLabel
                            161 ;	genFunction
                            162 ;	---------------------------------
                            163 ; Function LockObtain
                            164 ; ---------------------------------
   0065                     165 _LockObtain_start::
   0065                     166 _LockObtain:
   175B 3E 03               167 	ld	a,#3
   175D CF                  168 	rst	0x08
   175E DD E5               169 	push	ix
   1760 DD 21 00 00         170 	ld	ix,#0
   1764 DD 39               171 	add	ix,sp
                            172 ;locks.c:34: if(!IsMultitasking() && LockQuery(Handle)) Halt("DEADLOCK IN KERNEL MODE");
                            173 ;	genCall
                            174 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1766 CD 3F 1E            175 	call	_IsMultitasking
                            176 ;	genIfx
   1769 AF                  177 	xor	a,a
   176A B5                  178 	or	a,l
   176B C2 84 17            179 	jp	nz,00104$
                            180 ;	genIpush
                            181 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
                            182 ;	AOP_STK for 
   176E DD 7E 04            183 	ld	a,4(ix)
   1771 F5                  184 	push	af
   1772 33                  185 	inc	sp
                            186 ;	genCall
   1773 CD FD 17            187 	call	_LockQuery
   1776 33                  188 	inc	sp
                            189 ;	genIfx
   1777 AF                  190 	xor	a,a
   1778 B5                  191 	or	a,l
   1779 CA 84 17            192 	jp	z,00104$
                            193 ;	genIpush
                            194 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   177C 21 B6 17            195 	ld	hl,#__str_1
   177F E5                  196 	push	hl
                            197 ;	genCall
   1780 CD 32 23            198 	call	_Halt
   1783 F1                  199 	pop	af
                            200 ;locks.c:35: while(LockQuery(Handle)) AwaitEvent(EVENT_UNLOCK);
                            201 ;	genLabel
   008E                     202 00104$:
                            203 ;	genIpush
                            204 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
                            205 ;	AOP_STK for 
   1784 DD 7E 04            206 	ld	a,4(ix)
   1787 F5                  207 	push	af
   1788 33                  208 	inc	sp
                            209 ;	genCall
   1789 CD FD 17            210 	call	_LockQuery
   178C 33                  211 	inc	sp
                            212 ;	genIfx
   178D AF                  213 	xor	a,a
   178E B5                  214 	or	a,l
   178F CA 9D 17            215 	jp	z,00106$
                            216 ;	genIpush
                            217 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1792 21 01 00            218 	ld	hl,#0x0001
   1795 E5                  219 	push	hl
                            220 ;	genCall
   1796 CD 0A 1D            221 	call	_AwaitEvent
   1799 F1                  222 	pop	af
                            223 ;	genGoto
   179A C3 84 17            224 	jp	00104$
                            225 ;	genLabel
   00A7                     226 00106$:
                            227 ;locks.c:36: Pause();
                            228 ;	genCall
                            229 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   179D CD 2A 1C            230 	call	_Pause
                            231 ;locks.c:37: Locks[Handle]=TRUE;
                            232 ;	genPlus
                            233 ;	AOP_STK for 
                            234 ;	Can't optimise plus by inc, falling back to the normal way
   17A0 3E 11               235 	ld	a,#<_Locks
   17A2 DD 86 04            236 	add	a,4(ix)
   17A5 6F                  237 	ld	l,a
   17A6 3E 80               238 	ld	a,#>_Locks
   17A8 CE 00               239 	adc	a,#0x00
   17AA 67                  240 	ld	h,a
                            241 ;	genAssign (pointer)
                            242 ;	isBitvar = 0
   17AB 36 01               243 	ld	(hl),#0x01
                            244 ;locks.c:38: Resume();
                            245 ;	genCall
                            246 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   17AD CD 47 1C            247 	call	_Resume
                            248 ;	genLabel
   00BA                     249 00107$:
                            250 ;	genEndFunction
   17B0 DD E1               251 	pop	ix
   17B2 3E 04               252 	ld	a,#4
   17B4 CF                  253 	rst	0x08
   17B5 C9                  254 	ret
   00C0                     255 _LockObtain_end::
                    00C0    256 Flocks$_str_1$0$0 == .
   00C0                     257 __str_1:
   17B6 44 45 41 44 4C 4F   258 	.ascii "DEADLOCK IN KERNEL MODE"
        43 4B 20 49 4E 20
        4B 45 52 4E 45 4C
        20 4D 4F 44 45
   17CD 00                  259 	.db 0x00
                            260 ;locks.c:41: void LockRelease(lock Handle) {
                            261 ;	genLabel
                            262 ;	genFunction
                            263 ;	---------------------------------
                            264 ; Function LockRelease
                            265 ; ---------------------------------
   00D8                     266 _LockRelease_start::
   00D8                     267 _LockRelease:
   17CE 3E 03               268 	ld	a,#3
   17D0 CF                  269 	rst	0x08
   17D1 DD E5               270 	push	ix
   17D3 DD 21 00 00         271 	ld	ix,#0
   17D7 DD 39               272 	add	ix,sp
                            273 ;locks.c:42: Pause();
                            274 ;	genCall
                            275 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   17D9 CD 2A 1C            276 	call	_Pause
                            277 ;locks.c:43: if(Locks[Handle]) {
                            278 ;	genPlus
                            279 ;	AOP_STK for 
                            280 ;	Can't optimise plus by inc, falling back to the normal way
   17DC 3E 11               281 	ld	a,#<_Locks
   17DE DD 86 04            282 	add	a,4(ix)
   17E1 6F                  283 	ld	l,a
   17E2 3E 80               284 	ld	a,#>_Locks
   17E4 CE 00               285 	adc	a,#0x00
   17E6 67                  286 	ld	h,a
                            287 ;	genPointerGet
   17E7 7E                  288 	ld	a,(hl)
                            289 ;	genIfx
   17E8 B7                  290 	or	a,a
   17E9 CA F4 17            291 	jp	z,00102$
                            292 ;locks.c:44: Locks[Handle]=FALSE;
                            293 ;	genAssign (pointer)
                            294 ;	isBitvar = 0
   17EC 36 00               295 	ld	(hl),#0x00
                            296 ;locks.c:45: Resume();
                            297 ;	genCall
                            298 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   17EE CD 47 1C            299 	call	_Resume
                            300 ;	genGoto
   17F1 C3 F7 17            301 	jp	00104$
                            302 ;	genLabel
   00FE                     303 00102$:
                            304 ;locks.c:47: } else Resume();
                            305 ;	genCall
                            306 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   17F4 CD 47 1C            307 	call	_Resume
                            308 ;	genLabel
   0101                     309 00104$:
                            310 ;	genEndFunction
   17F7 DD E1               311 	pop	ix
   17F9 3E 04               312 	ld	a,#4
   17FB CF                  313 	rst	0x08
   17FC C9                  314 	ret
   0107                     315 _LockRelease_end::
                            316 ;locks.c:50: bool LockQuery(lock Handle) {
                            317 ;	genLabel
                            318 ;	genFunction
                            319 ;	---------------------------------
                            320 ; Function LockQuery
                            321 ; ---------------------------------
   0107                     322 _LockQuery_start::
   0107                     323 _LockQuery:
   17FD 3E 03               324 	ld	a,#3
   17FF CF                  325 	rst	0x08
   1800 DD E5               326 	push	ix
   1802 DD 21 00 00         327 	ld	ix,#0
   1806 DD 39               328 	add	ix,sp
                            329 ;locks.c:52: Pause();
                            330 ;	genCall
                            331 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   1808 CD 2A 1C            332 	call	_Pause
                            333 ;locks.c:53: State=Locks[Handle];
                            334 ;	genPlus
                            335 ;	AOP_STK for 
                            336 ;	Can't optimise plus by inc, falling back to the normal way
   180B 3E 11               337 	ld	a,#<_Locks
   180D DD 86 04            338 	add	a,4(ix)
   1810 6F                  339 	ld	l,a
   1811 3E 80               340 	ld	a,#>_Locks
   1813 CE 00               341 	adc	a,#0x00
   1815 67                  342 	ld	h,a
                            343 ;	genPointerGet
   1816 6E                  344 	ld	l,(hl)
                            345 ;	genAssign
   1817 4D                  346 	ld	c,l
                            347 ;locks.c:54: Resume();
                            348 ;	genCall
                            349 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
   1818 C5                  350 	push	bc
   1819 CD 47 1C            351 	call	_Resume
   181C C1                  352 	pop	bc
                            353 ;locks.c:55: return State;
                            354 ;	genRet
                            355 ; Dump of IC_LEFT: type AOP_REG size 1
                            356 ;	 reg = c
   181D 69                  357 	ld	l,c
                            358 ;	genLabel
   0128                     359 00101$:
                            360 ;	genEndFunction
   181E DD E1               361 	pop	ix
   1820 3E 04               362 	ld	a,#4
   1822 CF                  363 	rst	0x08
   1823 C9                  364 	ret
   012E                     365 _LockQuery_end::
                            366 	.area _CODE
