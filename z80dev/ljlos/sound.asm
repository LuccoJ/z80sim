;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Fri Apr 27 12:30:19 2012

;--------------------------------------------------------
	.module sound
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _SystemLock
	.globl _Beep
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
G$SystemLock$0$0==.
_SystemLock::
	.ds 1
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area _OVERLAY
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _CODE
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;sound.c:5: void Beep() {
;	genLabel
;	genFunction
;	---------------------------------
; Function Beep
; ---------------------------------
_Beep_start::
_Beep:
	ld	a,#3
	rst	0x08
;sound.c:6: Pause();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_Pause
;sound.c:85: _endasm;
;	genInline
;
		       push af
		       push bc
		       push de
		       push hl
		       push ix
		       push iy
		       ld hl,#0x036B
		       ld de,#0x0100
        L03B5:
	DI	; Disable Interrupts so they don't disturb timing'
		       LD A,L ;
		       SRL L ;
		       SRL L ; L = medium part of tone period
		       CPL ;
		       AND #0x03 ; A = 3 - fine part of tone period
		       LD C,A ;
		       LD B,#0x00 ;
		       LD IX,#L03D1 ; Address BE-IX+3
		       ADD IX,BC ; IX holds address of entry into the loop
		                               ; the loop will contain 0-3 NOPs, implementing
		                               ; the fine part of the tone period.
		       IN A,(0xFE) ; BORDCR
		       ;AND #0x38 ; bits 5..3 contain border colour
		       ;RRCA ; border colour bits moved to 2..0
		       ;RRCA ; to match border bits on port #FE
		       ;RRCA ;
		       OR #0x08 ; bit 3 set (tape output bit on port #FE)
		                               ; for loud sound output
;;	BE-IX+3
L03D1:
	NOP	;(4) ; optionally executed NOPs for small
		                               ; adjustments to tone period
;;	BE-IX+2
L03D2:
	NOP	;(4) ;
	
;;	BE-IX+1
L03D3:
	NOP	;(4) ;
	
;;	BE-IX+0
L03D4:
	INC	B ;(4) ;
		       INC C ;(4) ;
	
;;	BE-H&L-LP
L03D6:
	DEC	C ;(4) ; timing loop for duration of
		       JR NZ,L03D6 ;(12/7); high or low pulse of waveform
	
		       LD C,#0x3F ;(7) ;
		       DEC B ;(4) ;
		       JP NZ,L03D6 ;(10) ; to BE-H&L-LP
	
		       XOR #0x10 ;(7) ; toggle output beep bit
		       OUT (0xFE),A ;(11) ; output pulse
		       LD B,H ;(4) ; B = coarse part of tone period
		       LD C,A ;(4) ; save port #FE output byte
		       BIT 4,A ;(8) ; if new output bit is high, go
		       JR NZ,L03F2 ;(12/7); to BE-AGAIN
	
		       LD A,D ;(4) ; one cycle of waveform has completed
		       OR E ;(4) ; (low->low). if cycle countdown = 0
		       JR Z,L03F6 ;(12/7); go to BE-END
	
		       LD A,C ;(4) ; restore output byte for port #FE
		       LD C,L ;(4) ; C = medium part of tone period
		       DEC DE ;(6) ; decrement cycle count
		       JP (IX) ;(8) ; do another cycle
	
;;	BE-AGAIN ; halfway through cycle
L03F2:
	LD	C,L ;(4) ; C = medium part of tone period
		       INC C ;(4) ; adds 16 cycles to make duration of high = duration of low
		       JP (IX) ;(8) ; do high pulse of tone
	
		       ;; BE-END
        L03F6:
		       pop iy
		       pop ix
		       pop hl
		       pop de
		       pop bc
		       pop af
		       
;sound.c:86: Resume();
;	genCall
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	call	_Resume
;	genLabel
00101$:
;	genEndFunction
	ld	a,#4
	rst	0x08
	ret
_Beep_end::
	.area _CODE
