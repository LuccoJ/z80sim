;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Feb  3 2010) (UNIX)
; This file was generated Fri Apr 27 12:42:17 2012
;--------------------------------------------------------
	.module strings
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _Power
	.globl _Divide
	.globl _Mod
	.globl _StringLength
	.globl _StringWrite
	.globl _SameString
	.globl _WordToHex
	.globl _WordToString
	.globl _IntToString
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
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
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	G$StringLength$0$0	= .
	.globl	G$StringLength$0$0
	C$strings.c$5$0$0	= .
	.globl	C$strings.c$5$0$0
;strings.c:5: int StringLength(char* String) {
;	---------------------------------
; Function StringLength
; ---------------------------------
_StringLength_start::
_StringLength:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	C$strings.c$8$1$1	= .
	.globl	C$strings.c$8$1$1
;strings.c:8: while(String[i]!='\0') i++;
	ld	bc,#0x0000
00101$:
	ld	a,4 (ix)
	add	a,c
	ld	e,a
	ld	a,5 (ix)
	adc	a,b
	ld	d,a
	ld	a,(de)
	or	a,a
	jr	Z,00103$
	inc	bc
	jr	00101$
00103$:
	C$strings.c$9$1$1	= .
	.globl	C$strings.c$9$1$1
;strings.c:9: return i;
	ld	l,c
	ld	h,b
	pop	ix
	ld	a,#4
	rst	0x08
	C$strings.c$10$1$1	= .
	.globl	C$strings.c$10$1$1
	XG$StringLength$0$0	= .
	.globl	XG$StringLength$0$0
	ret
_StringLength_end::
	G$StringWrite$0$0	= .
	.globl	G$StringWrite$0$0
	C$strings.c$12$1$1	= .
	.globl	C$strings.c$12$1$1
;strings.c:12: void StringWrite(char* Destination, const char* Source) {
;	---------------------------------
; Function StringWrite
; ---------------------------------
_StringWrite_start::
_StringWrite:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	C$strings.c$13$1$1	= .
	.globl	C$strings.c$13$1$1
;strings.c:13: MemoryCopy((void*)Destination, (void*)Source, StringLength(Source));
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	call	_StringLength
	pop	af
	ld	b,h
	ld	c,l
	ld	e,4 (ix)
	ld	d,5 (ix)
	push	bc
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	push	de
	call	_MemoryCopy
	pop	af
	pop	af
	pop	af
	pop	ix
	ld	a,#4
	rst	0x08
	C$strings.c$14$1$1	= .
	.globl	C$strings.c$14$1$1
	XG$StringWrite$0$0	= .
	.globl	XG$StringWrite$0$0
	ret
_StringWrite_end::
	G$SameString$0$0	= .
	.globl	G$SameString$0$0
	C$strings.c$16$1$1	= .
	.globl	C$strings.c$16$1$1
;strings.c:16: bool SameString(char* String1, char* String2) {
;	---------------------------------
; Function SameString
; ---------------------------------
_SameString_start::
_SameString:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	C$strings.c$19$1$1	= .
	.globl	C$strings.c$19$1$1
;strings.c:19: while(String1[i]!='\0') {
	ld	-2 (ix),#0x00
	ld	-1 (ix),#0x00
00103$:
	ld	a,4 (ix)
	add	a,-2 (ix)
	ld	e,a
	ld	a,5 (ix)
	adc	a,-1 (ix)
	ld	d,a
	ld	a,(de)
	ld	e,a
	or	a,a
	jr	Z,00105$
	C$strings.c$20$2$2	= .
	.globl	C$strings.c$20$2$2
;strings.c:20: if(String1[i]!=String2[i]) return FALSE;
	ld	a,6 (ix)
	add	a,-2 (ix)
	ld	d,a
	ld	a,7 (ix)
	adc	a,-1 (ix)
	ld	l,d
	ld	h,a
	ld	d,(hl)
	ld	a,e
	sub	d
	jr	Z,00102$
	ld	l,#0x00
	jr	00106$
00102$:
	C$strings.c$21$2$2	= .
	.globl	C$strings.c$21$2$2
;strings.c:21: i++;
	inc	-2 (ix)
	jr	NZ,00112$
	inc	-1 (ix)
00112$:
	jr	00103$
00105$:
	C$strings.c$23$1$1	= .
	.globl	C$strings.c$23$1$1
;strings.c:23: return TRUE;
	ld	l,#0x01
00106$:
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	C$strings.c$24$1$1	= .
	.globl	C$strings.c$24$1$1
	XG$SameString$0$0	= .
	.globl	XG$SameString$0$0
	ret
_SameString_end::
	G$Mod$0$0	= .
	.globl	G$Mod$0$0
	C$strings.c$26$1$1	= .
	.globl	C$strings.c$26$1$1
;strings.c:26: unsigned int Mod(unsigned int Dividend, unsigned int Divisor) {
;	---------------------------------
; Function Mod
; ---------------------------------
_Mod_start::
_Mod:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	C$strings.c$28$1$1	= .
	.globl	C$strings.c$28$1$1
;strings.c:28: Temp=Dividend;
	ld	c,4 (ix)
	ld	b,5 (ix)
	C$strings.c$29$1$1	= .
	.globl	C$strings.c$29$1$1
;strings.c:29: while(Temp>=Divisor) {
00101$:
	ld	a,c
	sub	a,6 (ix)
	ld	a,b
	sbc	a,7 (ix)
	jr	C,00103$
	C$strings.c$30$2$2	= .
	.globl	C$strings.c$30$2$2
;strings.c:30: Temp-=Divisor;
	ld	a,c
	sub	a,6 (ix)
	ld	c,a
	ld	a,b
	sbc	a,7 (ix)
	ld	b,a
	jr	00101$
00103$:
	C$strings.c$32$1$1	= .
	.globl	C$strings.c$32$1$1
;strings.c:32: return Temp;
	ld	l,c
	ld	h,b
	pop	ix
	ld	a,#4
	rst	0x08
	C$strings.c$33$1$1	= .
	.globl	C$strings.c$33$1$1
	XG$Mod$0$0	= .
	.globl	XG$Mod$0$0
	ret
_Mod_end::
	G$Divide$0$0	= .
	.globl	G$Divide$0$0
	C$strings.c$35$1$1	= .
	.globl	C$strings.c$35$1$1
;strings.c:35: unsigned int Divide(unsigned int Dividend, int Divisor) {
;	---------------------------------
; Function Divide
; ---------------------------------
_Divide_start::
_Divide:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	C$strings.c$39$1$1	= .
	.globl	C$strings.c$39$1$1
;strings.c:39: Temp=Dividend;
	ld	c,4 (ix)
	ld	b,5 (ix)
	C$strings.c$40$1$1	= .
	.globl	C$strings.c$40$1$1
;strings.c:40: while(Temp>=Divisor) {
	ld	e,6 (ix)
	ld	d,7 (ix)
	ld	-2 (ix),#0x00
	ld	-1 (ix),#0x00
00101$:
	ld	a,c
	sub	a,e
	ld	a,b
	sbc	a,d
	jr	C,00103$
	C$strings.c$41$2$2	= .
	.globl	C$strings.c$41$2$2
;strings.c:41: Temp-=Divisor;
	ld	6 (ix),e
	ld	7 (ix),d
	ld	a,c
	sub	a,6 (ix)
	ld	c,a
	ld	a,b
	sbc	a,7 (ix)
	ld	b,a
	C$strings.c$42$2$2	= .
	.globl	C$strings.c$42$2$2
;strings.c:42: i++;
	inc	-2 (ix)
	jr	NZ,00109$
	inc	-1 (ix)
00109$:
	jr	00101$
00103$:
	C$strings.c$44$1$1	= .
	.globl	C$strings.c$44$1$1
;strings.c:44: return i;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	C$strings.c$45$1$1	= .
	.globl	C$strings.c$45$1$1
	XG$Divide$0$0	= .
	.globl	XG$Divide$0$0
	ret
_Divide_end::
	G$Power$0$0	= .
	.globl	G$Power$0$0
	C$strings.c$48$1$1	= .
	.globl	C$strings.c$48$1$1
;strings.c:48: int Power(int Base, int Exponent) {
;	---------------------------------
; Function Power
; ---------------------------------
_Power_start::
_Power:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	C$strings.c$51$1$1	= .
	.globl	C$strings.c$51$1$1
;strings.c:51: Temp=1;
	ld	bc,#0x0001
	C$strings.c$52$1$1	= .
	.globl	C$strings.c$52$1$1
;strings.c:52: for(i=0; i<Exponent; i++) {
	ld	-2 (ix),#0x00
	ld	-1 (ix),#0x00
00101$:
	ld	a,-2 (ix)
	sub	a,6 (ix)
	ld	a,-1 (ix)
	sbc	a,7 (ix)
	jp	P,00104$
	C$strings.c$53$1$1	= .
	.globl	C$strings.c$53$1$1
;strings.c:53: Temp=Temp*Base;
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	push	bc
	call	__mulint_rrf_s
	pop	af
	pop	af
	ex	de,hl
	ld	c,e
	ld	b,d
	C$strings.c$52$1$1	= .
	.globl	C$strings.c$52$1$1
;strings.c:52: for(i=0; i<Exponent; i++) {
	inc	-2 (ix)
	jr	NZ,00110$
	inc	-1 (ix)
00110$:
	jr	00101$
00104$:
	C$strings.c$55$1$1	= .
	.globl	C$strings.c$55$1$1
;strings.c:55: return Temp;
	ld	l,c
	ld	h,b
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	C$strings.c$56$1$1	= .
	.globl	C$strings.c$56$1$1
	XG$Power$0$0	= .
	.globl	XG$Power$0$0
	ret
_Power_end::
	G$WordToHex$0$0	= .
	.globl	G$WordToHex$0$0
	C$strings.c$58$1$1	= .
	.globl	C$strings.c$58$1$1
;strings.c:58: void WordToHex(unsigned int Number, char* String) {
;	---------------------------------
; Function WordToHex
; ---------------------------------
_WordToHex_start::
_WordToHex:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-6
	add	hl,sp
	ld	sp,hl
	C$strings.c$61$1$1	= .
	.globl	C$strings.c$61$1$1
;strings.c:61: Temp=Number;
	ld	a,4 (ix)
	ld	-4 (ix),a
	ld	a,5 (ix)
	ld	-3 (ix),a
	C$strings.c$62$1$1	= .
	.globl	C$strings.c$62$1$1
;strings.c:62: for(i=3; i>=0; i--) {
	ld	-2 (ix),#0x03
	ld	-1 (ix),#0x00
00104$:
	bit	7,-1 (ix)
	jp	NZ,00107$
	C$strings.c$63$2$2	= .
	.globl	C$strings.c$63$2$2
;strings.c:63: Module=Temp&15;
	ld	a,-4 (ix)
	and	a,#0x0F
	ld	-6 (ix),a
	ld	-5 (ix),#0x00
	C$strings.c$64$2$2	= .
	.globl	C$strings.c$64$2$2
;strings.c:64: if(Module<10) String[i]=Module+'0'; else String[i]=Module+'A'-10;
	ld	a,-6 (ix)
	sub	a,#0x0A
	ld	a,-5 (ix)
	sbc	a,#0x00
	jr	NC,00102$
	ld	a,6 (ix)
	add	a,-2 (ix)
	ld	c,a
	ld	a,7 (ix)
	adc	a,-1 (ix)
	ld	b,a
	ld	e,-6 (ix)
	ld	a,e
	add	a,#0x30
	ld	(bc),a
	jr	00103$
00102$:
	ld	a,6 (ix)
	add	a,-2 (ix)
	ld	c,a
	ld	a,7 (ix)
	adc	a,-1 (ix)
	ld	b,a
	ld	e,-6 (ix)
	ld	a,e
	add	a,#0x37
	ld	(bc),a
00103$:
	C$strings.c$65$2$2	= .
	.globl	C$strings.c$65$2$2
;strings.c:65: Temp=(Temp>>4)&0xfff;
	ld	c,-4 (ix)
	ld	b,-3 (ix)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	-4 (ix),c
	ld	a,b
	and	a,#0x0F
	ld	-3 (ix),a
	C$strings.c$62$1$1	= .
	.globl	C$strings.c$62$1$1
;strings.c:62: for(i=3; i>=0; i--) {
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	dec	hl
	ld	-2 (ix),l
	ld	-1 (ix),h
	jp	00104$
00107$:
	C$strings.c$67$1$1	= .
	.globl	C$strings.c$67$1$1
;strings.c:67: String[4]='\0';
	ld	a,6 (ix)
	add	a,#0x04
	ld	c,a
	ld	a,7 (ix)
	adc	a,#0x00
	ld	b,a
	ld	a,#0x00
	ld	(bc),a
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	C$strings.c$68$1$1	= .
	.globl	C$strings.c$68$1$1
	XG$WordToHex$0$0	= .
	.globl	XG$WordToHex$0$0
	ret
_WordToHex_end::
	G$WordToString$0$0	= .
	.globl	G$WordToString$0$0
	C$strings.c$71$1$1	= .
	.globl	C$strings.c$71$1$1
;strings.c:71: void WordToString(unsigned int Number, char* String) {
;	---------------------------------
; Function WordToString
; ---------------------------------
_WordToString_start::
_WordToString:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	C$strings.c$74$1$1	= .
	.globl	C$strings.c$74$1$1
;strings.c:74: Temp=Number;
	ld	a,4 (ix)
	ld	-4 (ix),a
	ld	a,5 (ix)
	ld	-3 (ix),a
	C$strings.c$75$1$1	= .
	.globl	C$strings.c$75$1$1
;strings.c:75: for(i=0; i<7; i++) String[i]=' ';
	ld	bc,#0x0000
00104$:
	ld	a,c
	sub	a,#0x07
	ld	a,b
	sbc	a,#0x00
	jp	P,00107$
	ld	a,6 (ix)
	add	a,c
	ld	e,a
	ld	a,7 (ix)
	adc	a,b
	ld	d,a
	ld	a,#0x20
	ld	(de),a
	inc	bc
	jr	00104$
00107$:
	C$strings.c$77$1$1	= .
	.globl	C$strings.c$77$1$1
;strings.c:77: while(Temp!=0) {
	ld	-2 (ix),#0x00
	ld	-1 (ix),#0x00
00101$:
	ld	a,-4 (ix)
	or	a,-3 (ix)
	jr	Z,00103$
	C$strings.c$78$2$2	= .
	.globl	C$strings.c$78$2$2
;strings.c:78: String[5-i]=Mod(Temp, 10)+'0';
	ld	a,#0x05
	sub	a,-2 (ix)
	ld	e,a
	ld	a,#0x00
	sbc	a,-1 (ix)
	ld	d,a
	ld	a,6 (ix)
	add	a,e
	ld	e,a
	ld	a,7 (ix)
	adc	a,d
	ld	d,a
	push	de
	ld	hl,#0x000A
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	_Mod
	pop	af
	pop	af
	ld	c,l
	pop	de
	ld	a,c
	add	a,#0x30
	ld	(de),a
	C$strings.c$79$2$2	= .
	.globl	C$strings.c$79$2$2
;strings.c:79: Temp=Divide(Temp, 10);
	ld	hl,#0x000A
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	_Divide
	pop	af
	pop	af
	ld	b,h
	ld	-4 (ix),l
	ld	-3 (ix),b
	C$strings.c$80$2$2	= .
	.globl	C$strings.c$80$2$2
;strings.c:80: i++;
	inc	-2 (ix)
	jr	NZ,00116$
	inc	-1 (ix)
00116$:
	jp	00101$
00103$:
	C$strings.c$82$1$1	= .
	.globl	C$strings.c$82$1$1
;strings.c:82: String[6]='\0';
	ld	a,6 (ix)
	add	a,#0x06
	ld	c,a
	ld	a,7 (ix)
	adc	a,#0x00
	ld	b,a
	ld	a,#0x00
	ld	(bc),a
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	C$strings.c$83$1$1	= .
	.globl	C$strings.c$83$1$1
	XG$WordToString$0$0	= .
	.globl	XG$WordToString$0$0
	ret
_WordToString_end::
	G$IntToString$0$0	= .
	.globl	G$IntToString$0$0
	C$strings.c$86$1$1	= .
	.globl	C$strings.c$86$1$1
;strings.c:86: void IntToString(int Number, char* String) {
;	---------------------------------
; Function IntToString
; ---------------------------------
_IntToString_start::
_IntToString:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	C$strings.c$89$1$1	= .
	.globl	C$strings.c$89$1$1
;strings.c:89: Temp=Number;
	ld	a,4 (ix)
	ld	-2 (ix),a
	ld	a,5 (ix)
	ld	-1 (ix),a
	C$strings.c$90$1$1	= .
	.globl	C$strings.c$90$1$1
;strings.c:90: for(i=0; i<7; i++) String[i]=' ';
	ld	bc,#0x0000
00106$:
	ld	a,c
	sub	a,#0x07
	ld	a,b
	sbc	a,#0x00
	jp	P,00109$
	ld	a,6 (ix)
	add	a,c
	ld	e,a
	ld	a,7 (ix)
	adc	a,b
	ld	d,a
	ld	a,#0x20
	ld	(de),a
	inc	bc
	jr	00106$
00109$:
	C$strings.c$91$1$1	= .
	.globl	C$strings.c$91$1$1
;strings.c:91: i=0;
	ld	de,#0x0000
	C$strings.c$92$1$1	= .
	.globl	C$strings.c$92$1$1
;strings.c:92: if(Temp<0) {
	bit	7,-1 (ix)
	jr	Z,00116$
	C$strings.c$93$2$2	= .
	.globl	C$strings.c$93$2$2
;strings.c:93: Temp=-Temp;
	xor	a,a
	sbc	a,-2 (ix)
	ld	-2 (ix),a
	ld	a,#0x00
	sbc	a,-1 (ix)
	ld	-1 (ix),a
	C$strings.c$94$2$2	= .
	.globl	C$strings.c$94$2$2
;strings.c:94: String[i]='-';
	ld	c,6 (ix)
	ld	b,7 (ix)
	push	bc
	pop	iy
	ld	(iy),#0x2D
	C$strings.c$95$2$2	= .
	.globl	C$strings.c$95$2$2
;strings.c:95: i++;
	ld	de,#0x0001
	C$strings.c$97$1$1	= .
	.globl	C$strings.c$97$1$1
;strings.c:97: while(Temp!=0) {
00116$:
00103$:
	ld	a,-2 (ix)
	or	a,-1 (ix)
	jp	Z,00105$
	C$strings.c$98$2$3	= .
	.globl	C$strings.c$98$2$3
;strings.c:98: String[5-i]=Mod(Temp, 10)+'0';
	ld	a,#0x05
	sub	a,e
	ld	c,a
	ld	a,#0x00
	sbc	a,d
	ld	b,a
	ld	a,6 (ix)
	add	a,c
	ld	-4 (ix),a
	ld	a,7 (ix)
	adc	a,b
	ld	-3 (ix),a
	push	de
	ld	hl,#0x000A
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	call	_Mod
	pop	af
	pop	af
	ld	c,l
	pop	de
	ld	a,c
	add	a,#0x30
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(hl),a
	C$strings.c$99$2$3	= .
	.globl	C$strings.c$99$2$3
;strings.c:99: Temp=Divide(Temp, 10);
	push	de
	ld	hl,#0x000A
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	call	_Divide
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	pop	de
	ld	-2 (ix),c
	ld	-1 (ix),b
	C$strings.c$100$2$3	= .
	.globl	C$strings.c$100$2$3
;strings.c:100: i++;
	inc	de
	jp	00103$
00105$:
	C$strings.c$102$1$1	= .
	.globl	C$strings.c$102$1$1
;strings.c:102: String[6]='\0';
	ld	a,6 (ix)
	add	a,#0x06
	ld	c,a
	ld	a,7 (ix)
	adc	a,#0x00
	ld	b,a
	ld	a,#0x00
	ld	(bc),a
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	C$strings.c$103$1$1	= .
	.globl	C$strings.c$103$1$1
	XG$IntToString$0$0	= .
	.globl	XG$IntToString$0$0
	ret
_IntToString_end::
	.area _CODE
	.area _CABS
