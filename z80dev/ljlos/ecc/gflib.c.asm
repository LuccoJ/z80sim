;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Wed Oct 15 22:42:05 2003

;--------------------------------------------------------
	.module gflib
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gfexp
	.globl _gfinv
	.globl _gfmul
	.globl _v2e
	.globl _e2v
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
;ecc/gflib.c:71: unsigned char gfmul(unsigned char mul1, unsigned char mul2) {
;	genLabel
;	genFunction
;	---------------------------------
; Function gfmul
; ---------------------------------
_gfmul_start::
_gfmul:
	push	ix
	ld	ix,#0
	add	ix,sp
;ecc/gflib.c:73: if(mul1 == 0 || mul2 == 0) mul3 = 0;
;	genCmpEq
;	AOP_STK for 
; genCmpEq: left 1, right 1, result 0
	ld	a,4(ix)
	or	a,a
	jp	z,00101$
00108$:
;	genCmpEq
;	AOP_STK for 
; genCmpEq: left 1, right 1, result 0
	ld	a,5(ix)
	or	a,a
	jp	z,00110$
00109$:
	jp	00102$
00110$:
;	genLabel
00101$:
;	genAssign
	ld	c,#0x00
;	genGoto
	jp	00103$
;	genLabel
00102$:
;ecc/gflib.c:74: else mul3 = e2v[(v2e[mul1] + v2e[mul2]) % 255];
;	genPlus
;	AOP_STK for 
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<_v2e
	add	a,4(ix)
	ld	l,a
	ld	a,#>_v2e
	adc	a,#0x00
	ld	h,a
;	genPointerGet
	ld	b,(hl)
;	genPlus
;	AOP_STK for 
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<_v2e
	add	a,5(ix)
	ld	l,a
	ld	a,#>_v2e
	adc	a,#0x00
	ld	h,a
;	genPointerGet
	ld	l,(hl)
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,b
	add	a,l
	ld	b,a
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	a,#0xFF
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	__moduchar_rrx_s
	ld	b,l
	pop	af
	ld	a,b
	pop	bc
	ld	b,a
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<_e2v
	add	a,b
	ld	l,a
	ld	a,#>_e2v
	adc	a,#0x00
	ld	h,a
;	genPointerGet
	ld	l,(hl)
;	genAssign
	ld	c,l
;	genLabel
00103$:
;ecc/gflib.c:75: return (mul3);
;	genRet
; Dump of IC_LEFT: type AOP_REG size 1
;	 reg = c
	ld	l,c
;	genLabel
00105$:
;	genEndFunction
	pop	ix
	ret
_gfmul_end::
_e2v:
	.db #0x01
	.db #0x02
	.db #0x04
	.db #0x08
	.db #0x10
	.db #0x20
	.db #0x40
	.db #0x80
	.db #0x1D
	.db #0x3A
	.db #0x74
	.db #0xE8
	.db #0xCD
	.db #0x87
	.db #0x13
	.db #0x26
	.db #0x4C
	.db #0x98
	.db #0x2D
	.db #0x5A
	.db #0xB4
	.db #0x75
	.db #0xEA
	.db #0xC9
	.db #0x8F
	.db #0x03
	.db #0x06
	.db #0x0C
	.db #0x18
	.db #0x30
	.db #0x60
	.db #0xC0
	.db #0x9D
	.db #0x27
	.db #0x4E
	.db #0x9C
	.db #0x25
	.db #0x4A
	.db #0x94
	.db #0x35
	.db #0x6A
	.db #0xD4
	.db #0xB5
	.db #0x77
	.db #0xEE
	.db #0xC1
	.db #0x9F
	.db #0x23
	.db #0x46
	.db #0x8C
	.db #0x05
	.db #0x0A
	.db #0x14
	.db #0x28
	.db #0x50
	.db #0xA0
	.db #0x5D
	.db #0xBA
	.db #0x69
	.db #0xD2
	.db #0xB9
	.db #0x6F
	.db #0xDE
	.db #0xA1
	.db #0x5F
	.db #0xBE
	.db #0x61
	.db #0xC2
	.db #0x99
	.db #0x2F
	.db #0x5E
	.db #0xBC
	.db #0x65
	.db #0xCA
	.db #0x89
	.db #0x0F
	.db #0x1E
	.db #0x3C
	.db #0x78
	.db #0xF0
	.db #0xFD
	.db #0xE7
	.db #0xD3
	.db #0xBB
	.db #0x6B
	.db #0xD6
	.db #0xB1
	.db #0x7F
	.db #0xFE
	.db #0xE1
	.db #0xDF
	.db #0xA3
	.db #0x5B
	.db #0xB6
	.db #0x71
	.db #0xE2
	.db #0xD9
	.db #0xAF
	.db #0x43
	.db #0x86
	.db #0x11
	.db #0x22
	.db #0x44
	.db #0x88
	.db #0x0D
	.db #0x1A
	.db #0x34
	.db #0x68
	.db #0xD0
	.db #0xBD
	.db #0x67
	.db #0xCE
	.db #0x81
	.db #0x1F
	.db #0x3E
	.db #0x7C
	.db #0xF8
	.db #0xED
	.db #0xC7
	.db #0x93
	.db #0x3B
	.db #0x76
	.db #0xEC
	.db #0xC5
	.db #0x97
	.db #0x33
	.db #0x66
	.db #0xCC
	.db #0x85
	.db #0x17
	.db #0x2E
	.db #0x5C
	.db #0xB8
	.db #0x6D
	.db #0xDA
	.db #0xA9
	.db #0x4F
	.db #0x9E
	.db #0x21
	.db #0x42
	.db #0x84
	.db #0x15
	.db #0x2A
	.db #0x54
	.db #0xA8
	.db #0x4D
	.db #0x9A
	.db #0x29
	.db #0x52
	.db #0xA4
	.db #0x55
	.db #0xAA
	.db #0x49
	.db #0x92
	.db #0x39
	.db #0x72
	.db #0xE4
	.db #0xD5
	.db #0xB7
	.db #0x73
	.db #0xE6
	.db #0xD1
	.db #0xBF
	.db #0x63
	.db #0xC6
	.db #0x91
	.db #0x3F
	.db #0x7E
	.db #0xFC
	.db #0xE5
	.db #0xD7
	.db #0xB3
	.db #0x7B
	.db #0xF6
	.db #0xF1
	.db #0xFF
	.db #0xE3
	.db #0xDB
	.db #0xAB
	.db #0x4B
	.db #0x96
	.db #0x31
	.db #0x62
	.db #0xC4
	.db #0x95
	.db #0x37
	.db #0x6E
	.db #0xDC
	.db #0xA5
	.db #0x57
	.db #0xAE
	.db #0x41
	.db #0x82
	.db #0x19
	.db #0x32
	.db #0x64
	.db #0xC8
	.db #0x8D
	.db #0x07
	.db #0x0E
	.db #0x1C
	.db #0x38
	.db #0x70
	.db #0xE0
	.db #0xDD
	.db #0xA7
	.db #0x53
	.db #0xA6
	.db #0x51
	.db #0xA2
	.db #0x59
	.db #0xB2
	.db #0x79
	.db #0xF2
	.db #0xF9
	.db #0xEF
	.db #0xC3
	.db #0x9B
	.db #0x2B
	.db #0x56
	.db #0xAC
	.db #0x45
	.db #0x8A
	.db #0x09
	.db #0x12
	.db #0x24
	.db #0x48
	.db #0x90
	.db #0x3D
	.db #0x7A
	.db #0xF4
	.db #0xF5
	.db #0xF7
	.db #0xF3
	.db #0xFB
	.db #0xEB
	.db #0xCB
	.db #0x8B
	.db #0x0B
	.db #0x16
	.db #0x2C
	.db #0x58
	.db #0xB0
	.db #0x7D
	.db #0xFA
	.db #0xE9
	.db #0xCF
	.db #0x83
	.db #0x1B
	.db #0x36
	.db #0x6C
	.db #0xD8
	.db #0xAD
	.db #0x47
	.db #0x8E
	.db #0x01
_v2e:
	.db #0xFF
	.db #0x00
	.db #0x01
	.db #0x19
	.db #0x02
	.db #0x32
	.db #0x1A
	.db #0xC6
	.db #0x03
	.db #0xDF
	.db #0x33
	.db #0xEE
	.db #0x1B
	.db #0x68
	.db #0xC7
	.db #0x4B
	.db #0x04
	.db #0x64
	.db #0xE0
	.db #0x0E
	.db #0x34
	.db #0x8D
	.db #0xEF
	.db #0x81
	.db #0x1C
	.db #0xC1
	.db #0x69
	.db #0xF8
	.db #0xC8
	.db #0x08
	.db #0x4C
	.db #0x71
	.db #0x05
	.db #0x8A
	.db #0x65
	.db #0x2F
	.db #0xE1
	.db #0x24
	.db #0x0F
	.db #0x21
	.db #0x35
	.db #0x93
	.db #0x8E
	.db #0xDA
	.db #0xF0
	.db #0x12
	.db #0x82
	.db #0x45
	.db #0x1D
	.db #0xB5
	.db #0xC2
	.db #0x7D
	.db #0x6A
	.db #0x27
	.db #0xF9
	.db #0xB9
	.db #0xC9
	.db #0x9A
	.db #0x09
	.db #0x78
	.db #0x4D
	.db #0xE4
	.db #0x72
	.db #0xA6
	.db #0x06
	.db #0xBF
	.db #0x8B
	.db #0x62
	.db #0x66
	.db #0xDD
	.db #0x30
	.db #0xFD
	.db #0xE2
	.db #0x98
	.db #0x25
	.db #0xB3
	.db #0x10
	.db #0x91
	.db #0x22
	.db #0x88
	.db #0x36
	.db #0xD0
	.db #0x94
	.db #0xCE
	.db #0x8F
	.db #0x96
	.db #0xDB
	.db #0xBD
	.db #0xF1
	.db #0xD2
	.db #0x13
	.db #0x5C
	.db #0x83
	.db #0x38
	.db #0x46
	.db #0x40
	.db #0x1E
	.db #0x42
	.db #0xB6
	.db #0xA3
	.db #0xC3
	.db #0x48
	.db #0x7E
	.db #0x6E
	.db #0x6B
	.db #0x3A
	.db #0x28
	.db #0x54
	.db #0xFA
	.db #0x85
	.db #0xBA
	.db #0x3D
	.db #0xCA
	.db #0x5E
	.db #0x9B
	.db #0x9F
	.db #0x0A
	.db #0x15
	.db #0x79
	.db #0x2B
	.db #0x4E
	.db #0xD4
	.db #0xE5
	.db #0xAC
	.db #0x73
	.db #0xF3
	.db #0xA7
	.db #0x57
	.db #0x07
	.db #0x70
	.db #0xC0
	.db #0xF7
	.db #0x8C
	.db #0x80
	.db #0x63
	.db #0x0D
	.db #0x67
	.db #0x4A
	.db #0xDE
	.db #0xED
	.db #0x31
	.db #0xC5
	.db #0xFE
	.db #0x18
	.db #0xE3
	.db #0xA5
	.db #0x99
	.db #0x77
	.db #0x26
	.db #0xB8
	.db #0xB4
	.db #0x7C
	.db #0x11
	.db #0x44
	.db #0x92
	.db #0xD9
	.db #0x23
	.db #0x20
	.db #0x89
	.db #0x2E
	.db #0x37
	.db #0x3F
	.db #0xD1
	.db #0x5B
	.db #0x95
	.db #0xBC
	.db #0xCF
	.db #0xCD
	.db #0x90
	.db #0x87
	.db #0x97
	.db #0xB2
	.db #0xDC
	.db #0xFC
	.db #0xBE
	.db #0x61
	.db #0xF2
	.db #0x56
	.db #0xD3
	.db #0xAB
	.db #0x14
	.db #0x2A
	.db #0x5D
	.db #0x9E
	.db #0x84
	.db #0x3C
	.db #0x39
	.db #0x53
	.db #0x47
	.db #0x6D
	.db #0x41
	.db #0xA2
	.db #0x1F
	.db #0x2D
	.db #0x43
	.db #0xD8
	.db #0xB7
	.db #0x7B
	.db #0xA4
	.db #0x76
	.db #0xC4
	.db #0x17
	.db #0x49
	.db #0xEC
	.db #0x7F
	.db #0x0C
	.db #0x6F
	.db #0xF6
	.db #0x6C
	.db #0xA1
	.db #0x3B
	.db #0x52
	.db #0x29
	.db #0x9D
	.db #0x55
	.db #0xAA
	.db #0xFB
	.db #0x60
	.db #0x86
	.db #0xB1
	.db #0xBB
	.db #0xCC
	.db #0x3E
	.db #0x5A
	.db #0xCB
	.db #0x59
	.db #0x5F
	.db #0xB0
	.db #0x9C
	.db #0xA9
	.db #0xA0
	.db #0x51
	.db #0x0B
	.db #0xF5
	.db #0x16
	.db #0xEB
	.db #0x7A
	.db #0x75
	.db #0x2C
	.db #0xD7
	.db #0x4F
	.db #0xAE
	.db #0xD5
	.db #0xE9
	.db #0xE6
	.db #0xE7
	.db #0xAD
	.db #0xE8
	.db #0x74
	.db #0xD6
	.db #0xF4
	.db #0xEA
	.db #0xA8
	.db #0x50
	.db #0x58
	.db #0xAF
;ecc/gflib.c:93: unsigned char gfinv(unsigned char ivt) {
;	genLabel
;	genFunction
;	---------------------------------
; Function gfinv
; ---------------------------------
_gfinv_start::
_gfinv:
	push	ix
	ld	ix,#0
	add	ix,sp
;ecc/gflib.c:96: ivtd = e2v[255 - v2e[ivt]];
;	genPlus
;	AOP_STK for 
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<_v2e
	add	a,4(ix)
	ld	l,a
	ld	a,#>_v2e
	adc	a,#0x00
	ld	h,a
;	genPointerGet
	ld	l,(hl)
;	genMinus
	ld	a,#0xFF
	sub	a,l
	ld	l,a
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<_e2v
	add	a,l
	ld	l,a
	ld	a,#>_e2v
	adc	a,#0x00
	ld	h,a
;	genPointerGet
	ld	l,(hl)
;	genAssign
;ecc/gflib.c:97: return (ivtd);
;	genRet
; Dump of IC_LEFT: type AOP_STR size 1
;	genLabel
00101$:
;	genEndFunction
	pop	ix
	ret
_gfinv_end::
;ecc/gflib.c:103: unsigned char gfexp(unsigned char mant, unsigned char powr) {
;	genLabel
;	genFunction
;	---------------------------------
; Function gfexp
; ---------------------------------
_gfexp_start::
_gfexp:
	push	ix
	ld	ix,#0
	add	ix,sp
;ecc/gflib.c:105: if(mant == 0) expt = 0;
;	genCmpEq
;	AOP_STK for 
; genCmpEq: left 1, right 1, result 0
	ld	a,4(ix)
	or	a,a
	jp	z,00108$
00107$:
	jp	00102$
00108$:
;	genAssign
	ld	c,#0x00
;	genGoto
	jp	00103$
;	genLabel
00102$:
;ecc/gflib.c:106: else expt = e2v[(v2e[mant] * powr) % 255];
;	genPlus
;	AOP_STK for 
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<_v2e
	add	a,4(ix)
	ld	l,a
	ld	a,#>_v2e
	adc	a,#0x00
	ld	h,a
;	genPointerGet
	ld	b,(hl)
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
;	AOP_STK for 
	ld	a,5(ix)
	push	af
	inc	sp
;	genIpush
	push    bc
	inc     sp
;	genCall
	call	__muluchar_rrx_s
	ld	d,h
	ld	e,l
	pop	af
	pop	bc
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 1 deSending: 0
	push	bc
	ld	hl,#0x00FF
	push	hl
;	genIpush
	push	de
;	genCall
	call	__moduint_rrx_s
	ld	d,h
	ld	e,l
	pop	af
	pop	af
	pop	bc
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
	ld	hl,#_e2v
	add	hl,de
;	genPointerGet
	ld	l,(hl)
;	genAssign
	ld	c,l
;	genLabel
00103$:
;ecc/gflib.c:107: return (expt);
;	genRet
; Dump of IC_LEFT: type AOP_REG size 1
;	 reg = c
	ld	l,c
;	genLabel
00104$:
;	genEndFunction
	pop	ix
	ret
_gfexp_end::
	.area _CODE
