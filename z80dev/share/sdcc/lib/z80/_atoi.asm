;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:24 2003

;--------------------------------------------------------
	.module _atoi
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _atoi
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
;_atoi.c:25: int atoi(char * s)
;	genLabel
;	genFunction
;	---------------------------------
; Function atoi
; ---------------------------------
_atoi_start::
_atoi:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-2
	add	hl,sp
	ld	sp,hl
;_atoi.c:27: register int rv=0; 
;	genAssign
;	AOP_STK for _atoi_rv_1_1
	ld	-2(ix),#0x00
	ld	-1(ix),#0x00
;_atoi.c:31: while (*s) {
;	genAssign
;	AOP_STK for 
	ld	e,4(ix)
	ld	d,5(ix)
;	genLabel
00107$:
;	genPointerGet
	ld	a,(de)
	ld	l,a
;	genIfx
	xor	a,a
	or	a,l
	jp	z,00109$
;_atoi.c:32: if (*s <= '9' && *s >= '0')
;	genAssign
	ld	c,l
;	genCmpGt
	ld	a,#0x39
	sub	a,c
	jp	c,00102$
;	genAssign
	ld	c,l
;	genCmpLt
	ld	a,c
	sub	a,#0x30
	jp	nc,00109$
;_atoi.c:33: break;
;	genLabel
00102$:
;_atoi.c:34: if (*s == '-' || *s == '+') 
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	a,l
	cp	a,#0x2D
	jp	z,00109$
00133$:
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	a,l
	cp	a,#0x2B
	jp	z,00109$
00134$:
;_atoi.c:36: s++;
;	genPlus
;	genPlusIncr
	inc	de
;	genGoto
	jp	00107$
;	genLabel
00109$:
;_atoi.c:39: sign = (*s == '-');
;	genAssign
;	AOP_STK for 
	ld	4(ix),e
	ld	5(ix),d
;	genCmpEq
; genCmpEq: left 1, right 1, result 1
;4
	ld	a,l
	cp	a,#0x2D
	jp	nz,00135$
	ld	a,#0x01
	jp	00136$
00135$:
	xor	a,a
00136$:
;6
	ld	c,a
;	genAssign
	ld	b,c
;_atoi.c:40: if (*s == '-' || *s == '+') s++;
;	genIfx
	xor	a,a
	or	a,c
	jp	nz,00110$
;	genCmpEq
; genCmpEq: left 1, right 1, result 0
	ld	a,l
	cp	a,#0x2B
	jp	z,00138$
00137$:
	jp	00131$
00138$:
;	genLabel
00110$:
;	genPlus
;	AOP_STK for 
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,e
	add	a,#0x01
	ld	4(ix),a
	ld	a,d
	adc	a,#0x00
	ld	5(ix),a
;_atoi.c:42: while (*s && *s >= '0' && *s <= '9') {
;	genLabel
00131$:
;	genAssign
;	(operands are equal 3)
;	genLabel
00115$:
;	genPointerGet
;	AOP_STK for 
	ld	l,4(ix)
	ld	h,5(ix)
	ld	c,(hl)
;	genIfx
	xor	a,a
	or	a,c
	jp	z,00117$
;	genAssign
	ld	l,c
;	genCmpLt
	ld	a,l
	sub	a,#0x30
	jp	c,00117$
;	genAssign
	ld	l,c
;	genCmpGt
	ld	a,#0x39
	sub	a,l
	jp	c,00117$
;_atoi.c:43: rv = (rv * 10) + (*s - '0');
;	genMult
;	AOP_STK for _atoi_rv_1_1
	ld	e,-2(ix)
	ld	d,-1(ix)
	ld	l,e
	ld	h,d
	add	hl,hl
	add	hl,hl
	add	hl,de
	add	hl,hl
	ld	e,l
	ld	d,h
;	genMinus
	ld	a,c
	add	a,#0xD0
	ld	l,a
;	genCast
; Removed redundent load
	ld	h,#0x00
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
	add	hl,de
;	genAssign
;	AOP_STK for _atoi_rv_1_1
	ld	-2(ix),l
	ld	-1(ix),h
;_atoi.c:44: s++;
;	genPlus
;	AOP_STK for 
;	genPlusIncr
	inc	4(ix)
	jp	nz,00139$
	inc	5(ix)
00139$:
;	genGoto
	jp	00115$
;	genLabel
00117$:
;_atoi.c:47: return (sign ? -rv : rv);
;	genIfx
	xor	a,a
	or	a,b
	jp	z,00120$
;	genUminus
;	AOP_STK for _atoi_rv_1_1
	xor     a,a
	sbc	a,-2(ix)
	ld	c,a
	ld	a,#0x00
	sbc	a,-1(ix)
	ld	b,a
;	genGoto
	jp	00121$
;	genLabel
00120$:
;	genAssign
;	AOP_STK for _atoi_rv_1_1
	ld	c,-2(ix)
	ld	b,-1(ix)
;	genLabel
00121$:
;	genRet
; Dump of IC_LEFT: type AOP_REG size 2
;	 reg = bc
	ld	l,c
	ld	h,b
;	genLabel
00118$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
_atoi_end::
	.area _CODE
