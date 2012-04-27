                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.5 Fri Apr 27 12:30:19 2012
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module sound
                              7 	.optsdcc -mz80
                              8 	
                              9 ;--------------------------------------------------------
                             10 ; Public variables in this module
                             11 ;--------------------------------------------------------
                             12 	.globl _SystemLock
                             13 	.globl _Beep
                             14 ;--------------------------------------------------------
                             15 ;  ram data
                             16 ;--------------------------------------------------------
                             17 	.area _DATA
                    0000     18 G$SystemLock$0$0==.
   0000                      19 _SystemLock::
   0000                      20 	.ds 1
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
                             43 ;sound.c:5: void Beep() {
                             44 ;	genLabel
                             45 ;	genFunction
                             46 ;	---------------------------------
                             47 ; Function Beep
                             48 ; ---------------------------------
   0000                      49 _Beep_start::
   0000                      50 _Beep:
   2539 3E 03                51 	ld	a,#3
   253B CF                   52 	rst	0x08
                             53 ;sound.c:6: Pause();
                             54 ;	genCall
                             55 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   253C CD 2A 1C             56 	call	_Pause
                             57 ;sound.c:85: _endasm;
                             58 ;	genInline
                             59 ;
   253F F5                   60 		       push af
   2540 C5                   61 		       push bc
   2541 D5                   62 		       push de
   2542 E5                   63 		       push hl
   2543 DD E5                64 		       push ix
   2545 FD E5                65 		       push iy
   2547 21 6B 03             66 		       ld hl,#0x036B
   254A 11 00 01             67 		       ld de,#0x0100
   0014                      68         L03B5:
   254D F3                   69 	DI	; Disable Interrupts so they don't disturb timing'
   254E 7D                   70 		       LD A,L ;
   254F CB 3D                71 		       SRL L ;
   2551 CB 3D                72 		       SRL L ; L = medium part of tone period
   2553 2F                   73 		       CPL ;
   2554 E6 03                74 		       AND #0x03 ; A = 3 - fine part of tone period
   2556 4F                   75 		       LD C,A ;
   2557 06 00                76 		       LD B,#0x00 ;
   2559 DD 21 63 25          77 		       LD IX,#L03D1 ; Address BE-IX+3
   255D DD 09                78 		       ADD IX,BC ; IX holds address of entry into the loop
                             79 		                               ; the loop will contain 0-3 NOPs, implementing
                             80 		                               ; the fine part of the tone period.
   255F DB FE                81 		       IN A,(0xFE) ; BORDCR
                             82 		       ;AND #0x38 ; bits 5..3 contain border colour
                             83 		       ;RRCA ; border colour bits moved to 2..0
                             84 		       ;RRCA ; to match border bits on port #FE
                             85 		       ;RRCA ;
   2561 F6 08                86 		       OR #0x08 ; bit 3 set (tape output bit on port #FE)
                             87 		                               ; for loud sound output
                             88 ;;	BE-IX+3
   002A                      89 L03D1:
   2563 00                   90 	NOP	;(4) ; optionally executed NOPs for small
                             91 		                               ; adjustments to tone period
                             92 ;;	BE-IX+2
   002B                      93 L03D2:
   2564 00                   94 	NOP	;(4) ;
                             95 	
                             96 ;;	BE-IX+1
   002C                      97 L03D3:
   2565 00                   98 	NOP	;(4) ;
                             99 	
                            100 ;;	BE-IX+0
   002D                     101 L03D4:
   2566 04                  102 	INC	B ;(4) ;
   2567 0C                  103 		       INC C ;(4) ;
                            104 	
                            105 ;;	BE-H&L-LP
   002F                     106 L03D6:
   2568 0D                  107 	DEC	C ;(4) ; timing loop for duration of
   2569 20 FD               108 		       JR NZ,L03D6 ;(12/7); high or low pulse of waveform
                            109 	
   256B 0E 3F               110 		       LD C,#0x3F ;(7) ;
   256D 05                  111 		       DEC B ;(4) ;
   256E C2 68 25            112 		       JP NZ,L03D6 ;(10) ; to BE-H&L-LP
                            113 	
   2571 EE 10               114 		       XOR #0x10 ;(7) ; toggle output beep bit
   2573 D3 FE               115 		       OUT (0xFE),A ;(11) ; output pulse
   2575 44                  116 		       LD B,H ;(4) ; B = coarse part of tone period
   2576 4F                  117 		       LD C,A ;(4) ; save port #FE output byte
   2577 CB 67               118 		       BIT 4,A ;(8) ; if new output bit is high, go
   2579 20 09               119 		       JR NZ,L03F2 ;(12/7); to BE-AGAIN
                            120 	
   257B 7A                  121 		       LD A,D ;(4) ; one cycle of waveform has completed
   257C B3                  122 		       OR E ;(4) ; (low->low). if cycle countdown = 0
   257D 28 09               123 		       JR Z,L03F6 ;(12/7); go to BE-END
                            124 	
   257F 79                  125 		       LD A,C ;(4) ; restore output byte for port #FE
   2580 4D                  126 		       LD C,L ;(4) ; C = medium part of tone period
   2581 1B                  127 		       DEC DE ;(6) ; decrement cycle count
   2582 DD E9               128 		       JP (IX) ;(8) ; do another cycle
                            129 	
                            130 ;;	BE-AGAIN ; halfway through cycle
   004B                     131 L03F2:
   2584 4D                  132 	LD	C,L ;(4) ; C = medium part of tone period
   2585 0C                  133 		       INC C ;(4) ; adds 16 cycles to make duration of high = duration of low
   2586 DD E9               134 		       JP (IX) ;(8) ; do high pulse of tone
                            135 	
                            136 		       ;; BE-END
   004F                     137         L03F6:
   2588 FD E1               138 		       pop iy
   258A DD E1               139 		       pop ix
   258C E1                  140 		       pop hl
   258D D1                  141 		       pop de
   258E C1                  142 		       pop bc
   258F F1                  143 		       pop af
                            144 		       
                            145 ;sound.c:86: Resume();
                            146 ;	genCall
                            147 ; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
   2590 CD 47 1C            148 	call	_Resume
                            149 ;	genLabel
   005A                     150 00101$:
                            151 ;	genEndFunction
   2593 3E 04               152 	ld	a,#4
   2595 CF                  153 	rst	0x08
   2596 C9                  154 	ret
   005E                     155 _Beep_end::
                            156 	.area _CODE
