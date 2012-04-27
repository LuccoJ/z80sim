                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.5 Sat Nov 29 23:14:22 2003
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module memory
                              7 	.optsdcc -mz80
                              8 	
                              9 ;--------------------------------------------------------
                             10 ; Public variables in this module
                             11 ;--------------------------------------------------------
                             12 	.globl _main
                             13 	.globl _MyGlobalVar
                             14 ;--------------------------------------------------------
                             15 ;  ram data
                             16 ;--------------------------------------------------------
                             17 	.area _DATA
                    0000     18 G$MyGlobalVar$0$0==.
   0000                      19 _MyGlobalVar::
   0000                      20 	.ds 258
                             21 ;--------------------------------------------------------
                             22 ; overlayable items in  ram 
                             23 ;--------------------------------------------------------
                             24 	.area _OVERLAY
                             25 ;--------------------------------------------------------
                             26 ; external initialized ram data
                             27 ;--------------------------------------------------------
                             28 ;--------------------------------------------------------
                             29 ; global & static initialisations
                             30 ;--------------------------------------------------------
                             31 	.area _GSINIT
                             32 	.area _GSFINAL
                             33 	.area _GSINIT
                             34 ;--------------------------------------------------------
                             35 ; Home
                             36 ;--------------------------------------------------------
                             37 	.area _HOME
                             38 	.area _CODE
                             39 ;--------------------------------------------------------
                             40 ; code
                             41 ;--------------------------------------------------------
                             42 	.area _CODE
                             43 ;memory.c:20: _SimProtectedCodeBegins
                             44 ;	genLabel
                             45 ;	genFunction
                             46 ;	---------------------------------
                             47 ; Function _Z80SimProtectedCodeBegins
                             48 ; ---------------------------------
   0000                      49 __Z80SimProtectedCodeBegins_start::
   0000                      50 __Z80SimProtectedCodeBegins:
   003D 3E 03                51 	ld	a,#3
   003F CF                   52 	rst	0x08
                             53 ;	genLabel
   0003                      54 00101$:
                             55 ;	genEndFunction
   0040 3E 04                56 	ld	a,#4
   0042 CF                   57 	rst	0x08
   0043 C9                   58 	ret
   0007                      59 __Z80SimProtectedCodeBegins_end::
                             60 ;memory.c:22: void main() {
                             61 ;	genLabel
                             62 ;	genFunction
                             63 ;	---------------------------------
                             64 ; Function main
                             65 ; ---------------------------------
   0007                      66 _main_start::
   0007                      67 _main:
   0044 3E 03                68 	ld	a,#3
   0046 CF                   69 	rst	0x08
   0047 DD E5                70 	push	ix
   0049 DD 21 00 00          71 	ld	ix,#0
   004D DD 39                72 	add	ix,sp
   004F 21 FE FE             73 	ld	hl,#-258
   0052 39                   74 	add	hl,sp
   0053 F9                   75 	ld	sp,hl
                             76 ;memory.c:25: _SimPrintString("Z80Sim memory protection demo by LjL\n");
                             77 ;	genIpush
                             78 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0054 21 C4 00             79 	ld	hl,#__str_0
   0057 E5                   80 	push	hl
                             81 ;	genCall
   0058 CD 7C 01             82 	call	__Z80SimPrintString
   005B F1                   83 	pop	af
                             84 ;memory.c:26: _SimPrintString("Protecting ...\n");
                             85 ;	genIpush
                             86 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   005C 21 EA 00             87 	ld	hl,#__str_1
   005F E5                   88 	push	hl
                             89 ;	genCall
   0060 CD 7C 01             90 	call	__Z80SimPrintString
   0063 F1                   91 	pop	af
                             92 ;memory.c:27: _SimWriteProtectVar(MyGlobalVar);
                             93 ;	genCast
   0064 2E 00                94 	ld	l,#<_MyGlobalVar
   0066 26 80                95 	ld	h,#>_MyGlobalVar
                             96 ;	genPlus
                             97 ;	genPlusIncr
   0068 01 02 01             98 	ld	bc,#0x0102
   006B 09                   99 	add	hl,bc
                            100 ;	genCast
                            101 ; Removed redundent load
                            102 ; Removed redundent load
                            103 ;	genIpush
                            104 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   006C E5                  105 	push	hl
                            106 ;	genIpush
   006D 21 00 80            107 	ld	hl,#_MyGlobalVar
   0070 E5                  108 	push	hl
                            109 ;	genCall
   0071 CD CE 01            110 	call	__Z80SimWriteProtect
   0074 F1                  111 	pop	af
   0075 F1                  112 	pop	af
                            113 ;memory.c:28: _SimPrintString("Protecting program code...\n");
                            114 ;	genIpush
                            115 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0076 21 FA 00            116 	ld	hl,#__str_2
   0079 E5                  117 	push	hl
                            118 ;	genCall
   007A CD 7C 01            119 	call	__Z80SimPrintString
   007D F1                  120 	pop	af
                            121 ;memory.c:29: _SimWriteProtectVar(MyLocalVar);
                            122 ;	genAddrOf
   007E 21 00 00            123 	ld	hl,#0x0000
   0081 39                  124 	add	hl,sp
                            125 ;	genCast
   0082 4D                  126 	ld	c,l
   0083 44                  127 	ld	b,h
                            128 ;	genPlus
                            129 ;	genPlusIncr
   0084 11 02 01            130 	ld	de,#0x0102
   0087 19                  131 	add	hl,de
                            132 ;	genCast
                            133 ; Removed redundent load
                            134 ; Removed redundent load
                            135 ;	genIpush
                            136 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0088 E5                  137 	push	hl
                            138 ;	genIpush
   0089 C5                  139 	push	bc
                            140 ;	genCall
   008A CD CE 01            141 	call	__Z80SimWriteProtect
   008D F1                  142 	pop	af
   008E F1                  143 	pop	af
                            144 ;memory.c:30: _SimProtectCode();
                            145 ;	genAssign
   008F 21 59 01            146 	ld	hl,#__Z80SimProtectedCodeEnds
                            147 ;	genAssign
   0092 01 3D 00            148 	ld	bc,#__Z80SimProtectedCodeBegins
                            149 ;	genIpush
                            150 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   0095 E5                  151 	push	hl
                            152 ;	genIpush
   0096 C5                  153 	push	bc
                            154 ;	genCall
   0097 CD CE 01            155 	call	__Z80SimWriteProtect
   009A F1                  156 	pop	af
   009B F1                  157 	pop	af
                            158 ;memory.c:31: _SimPrintString("Attempting to write 0xDEAD to every word of memory...\n");
                            159 ;	genIpush
                            160 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   009C 21 16 01            161 	ld	hl,#__str_3
   009F E5                  162 	push	hl
                            163 ;	genCall
   00A0 CD 7C 01            164 	call	__Z80SimPrintString
   00A3 F1                  165 	pop	af
                            166 ;memory.c:32: _SimPrintWord((unsigned int)&MyGlobalVar+sizeof(MyGlobalVar));
                            167 ;	genCast
   00A4 2E 00               168 	ld	l,#<_MyGlobalVar
   00A6 26 80               169 	ld	h,#>_MyGlobalVar
                            170 ;	genPlus
                            171 ;	genPlusIncr
   00A8 01 02 01            172 	ld	bc,#0x0102
   00AB 09                  173 	add	hl,bc
                            174 ;	genIpush
                            175 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   00AC E5                  176 	push	hl
                            177 ;	genCall
   00AD CD A4 01            178 	call	__Z80SimPrintWord
   00B0 F1                  179 	pop	af
                            180 ;memory.c:33: i=0; do {
                            181 ;	genAssign
   00B1 21 00 00            182 	ld	hl,#0x0000
                            183 ;	genLabel
   0077                     184 00101$:
                            185 ;memory.c:34: *(unsigned int*)i=0xDEAD;
                            186 ;	genAssign (pointer)
                            187 ;	isBitvar = 0
   00B4 36 AD               188 	ld	(hl),#0xAD
   00B6 23                  189 	inc	hl
   00B7 36 DE               190 	ld	(hl),#0xDE
                            191 ;memory.c:35: } while(i<=0xFFFF);
                            192 ;	genGoto
   00B9 C3 B4 00            193 	jp	00101$
                            194 ;memory.c:36: _SimPrintString("Completed.\n");
                            195 ;	genLabel
   007F                     196 00104$:
                            197 ;	genEndFunction
   00BC DD F9               198 	ld	sp,ix
   00BE DD E1               199 	pop	ix
   00C0 3E 04               200 	ld	a,#4
   00C2 CF                  201 	rst	0x08
   00C3 C9                  202 	ret
   0087                     203 _main_end::
                    0087    204 Fmemory$_str_0$0$0 == .
   0087                     205 __str_0:
   00C4 5A 38 30 53 69 6D   206 	.ascii "Z80Sim memory protection demo by LjL"
        20 6D 65 6D 6F 72
        79 20 70 72 6F 74
        65 63 74 69 6F 6E
        20 64 65 6D 6F 20
        62 79 20 4C 6A 4C
   00E8 0A                  207 	.db 0x0A
   00E9 00                  208 	.db 0x00
                    00AD    209 Fmemory$_str_1$0$0 == .
   00AD                     210 __str_1:
   00EA 50 72 6F 74 65 63   211 	.ascii "Protecting ..."
        74 69 6E 67 20 2E
        2E 2E
   00F8 0A                  212 	.db 0x0A
   00F9 00                  213 	.db 0x00
                    00BD    214 Fmemory$_str_2$0$0 == .
   00BD                     215 __str_2:
   00FA 50 72 6F 74 65 63   216 	.ascii "Protecting program code..."
        74 69 6E 67 20 70
        72 6F 67 72 61 6D
        20 63 6F 64 65 2E
        2E 2E
   0114 0A                  217 	.db 0x0A
   0115 00                  218 	.db 0x00
                    00D9    219 Fmemory$_str_3$0$0 == .
   00D9                     220 __str_3:
   0116 41 74 74 65 6D 70   221 	.ascii "Attempting to write 0xDEAD to every word of memory..."
        74 69 6E 67 20 74
        6F 20 77 72 69 74
        65 20 30 78 44 45
        41 44 20 74 6F 20
        65 76 65 72 79 20
        77 6F 72 64 20 6F
        66 20 6D 65 6D 6F
        72 79 2E 2E 2E
   014B 0A                  222 	.db 0x0A
   014C 00                  223 	.db 0x00
                    0110    224 Fmemory$_str_4$0$0 == .
   0110                     225 __str_4:
   014D 43 6F 6D 70 6C 65   226 	.ascii "Completed."
        74 65 64 2E
   0157 0A                  227 	.db 0x0A
   0158 00                  228 	.db 0x00
                            229 ;memory.c:39: _SimProtectedCodeEnds
                            230 ;	genLabel
                            231 ;	genFunction
                            232 ;	---------------------------------
                            233 ; Function _Z80SimProtectedCodeEnds
                            234 ; ---------------------------------
   011C                     235 __Z80SimProtectedCodeEnds_start::
   011C                     236 __Z80SimProtectedCodeEnds:
   0159 3E 03               237 	ld	a,#3
   015B CF                  238 	rst	0x08
                            239 ;	genLabel
   011F                     240 00101$:
                            241 ;	genEndFunction
   015C 3E 04               242 	ld	a,#4
   015E CF                  243 	rst	0x08
   015F C9                  244 	ret
   0123                     245 __Z80SimProtectedCodeEnds_end::
                            246 	.area _CODE
