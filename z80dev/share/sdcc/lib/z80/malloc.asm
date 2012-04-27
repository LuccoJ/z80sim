;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.5 Sat Oct  4 00:15:26 2003

;--------------------------------------------------------
	.module malloc
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __sdcc_heap_init
	.globl _malloc
	.globl _free
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
;malloc.c:25: _sdcc_heap_init(void)
;	genLabel
;	genFunction
;	---------------------------------
; Function _sdcc_heap_init
; ---------------------------------
__sdcc_heap_init_start::
__sdcc_heap_init:
;malloc.c:27: MEMHEADER *pbase = &_sdcc_heap_start;
;malloc.c:28: unsigned int size = &_sdcc_heap_end - (char *)pbase;
;	genMinus
	ld	a,#<__sdcc_heap_end
	sub	a,#<__sdcc_heap_start
	ld	l,a
	ld	a,#>__sdcc_heap_end
	sbc	a,#>__sdcc_heap_start
	ld	h,a
;	genAssign
;malloc.c:30: pbase->next = (MEMHEADER *)((char *)pbase + size - HEADER_SIZE);
;	genPlus
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,#<__sdcc_heap_start
	add	a,l
	ld	l,a
	ld	a,#>__sdcc_heap_start
	adc	a,h
	ld	h,a
;	genMinus
	ld	a,l
	add	a,#0xFA
	ld	c,a
	ld	a,h
	adc	a,#0xFF
	ld	b,a
;	genAssign (pointer)
;	isBitvar = 0
	ld	hl,#__sdcc_heap_start
	ld	(hl),c
	inc	hl
	ld	(hl),b
;malloc.c:31: pbase->next->next = NULL; //And mark it as last
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,c
	ld	h,b
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;malloc.c:32: pbase->prev       = NULL; //and mark first as first
;	genPlus
;	genPlusIncr
	ld	hl,#__sdcc_heap_start + 2
;	genAssign (pointer)
;	isBitvar = 0
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;malloc.c:33: pbase->len        = 0;    //Empty and ready.
;	genPlus
;	genPlusIncr
	ld	hl,#__sdcc_heap_start + 4
;	genAssign (pointer)
;	isBitvar = 0
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;	genLabel
00101$:
;	genEndFunction
	ret
__sdcc_heap_init_end::
;malloc.c:37: malloc (unsigned int size)
;	genLabel
;	genFunction
;	---------------------------------
; Function malloc
; ---------------------------------
_malloc_start::
_malloc:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-6
	add	hl,sp
	ld	sp,hl
;malloc.c:42: if (size>(0xFFFF-HEADER_SIZE))
;	genCmpGt
;	AOP_STK for 
	ld	a,#0xF9
	sub	a,4(ix)
	ld	a,#0xFF
	sbc	a,5(ix)
	jp	nc,00102$
;malloc.c:44: return NULL; //To prevent overflow in next line
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 2
	ld	hl,#0x0000
	jp	00115$
;	genLabel
00102$:
;malloc.c:47: size += HEADER_SIZE; //We need a memory for header too
;	genPlus
;	AOP_STK for 
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,4(ix)
	add	a,#0x06
	ld	4(ix),a
	ld	a,5(ix)
	adc	a,#0x00
	ld	5(ix),a
;malloc.c:48: current_header = &_sdcc_heap_start;
;	genAssign
	ld	de,#__sdcc_heap_start
;malloc.c:50: while (1)
;	genLabel
00108$:
;malloc.c:59: if ((((unsigned int)current_header->next) -
;	genPointerGet
;	AOP_STK for _malloc__1_0
	ld	l,e
	ld	h,d
	ld	a,(hl)
	ld	-2(ix),a
	inc	hl
	ld	a,(hl)
	ld	-1(ix),a
;	genCast
;	AOP_STK for _malloc__1_0
	ld	l,-2(ix)
	ld	h,-1(ix)
;malloc.c:60: ((unsigned int)current_header) -
;	genCast
	ld	c,e
	ld	b,d
;	genMinus
	ld	a,l
	sub	a,c
	ld	c,a
	ld	a,h
	sbc	a,b
	ld	b,a
;malloc.c:61: current_header->len) >= size) 
;	genPlus
;	AOP_STK for _malloc__1_0
;	genPlusIncr
;	Can't optimise plus by inc, falling back to the normal way
	ld	a,e
	add	a,#0x04
	ld	-4(ix),a
	ld	a,d
	adc	a,#0x00
	ld	-3(ix),a
;	genPointerGet
;	AOP_STK for _malloc__1_0
;	AOP_STK for _malloc__1_0
	ld	l,-4(ix)
	ld	h,-3(ix)
	ld	a,(hl)
	ld	-6(ix),a
	inc	hl
	ld	a,(hl)
	ld	-5(ix),a
;	genMinus
;	AOP_STK for _malloc__1_0
	ld	a,c
	sub	a,-6(ix)
	ld	l,a
	ld	a,b
	sbc	a,-5(ix)
	ld	h,a
;	genCmpLt
;	AOP_STK for 
	ld	a,l
	sub	a,4(ix)
	ld	a,h
	sbc	a,5(ix)
	jp	nc,00109$
;malloc.c:65: current_header = current_header->next;    //else try next             
;	genAssign
;	AOP_STK for _malloc__1_0
	ld	l,-2(ix)
	ld	h,-1(ix)
;	genAssign
;malloc.c:66: if (!current_header->next)  
;	genPointerGet
	ld	e,l
	ld	d,h
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
;	genIfx
	ld	l,a
	or	a,h
	jp	nz,00108$
;malloc.c:68: return NULL;  //if end_of_list reached    
;	genRet
; Dump of IC_LEFT: type AOP_LIT size 2
	ld	hl,#0x0000
	jp	00115$
;	genLabel
00109$:
;malloc.c:72: if (!current_header->len)
;	genIfx
;	AOP_STK for _malloc__1_0
	ld	a,-6(ix)
	or	a,-5(ix)
	jp	nz,00113$
;malloc.c:74: current_header->len = size; //for first allocation
;	genAssign (pointer)
;	AOP_STK for _malloc__1_0
;	AOP_STK for 
;	isBitvar = 0
	ld	l,-4(ix)
	ld	h,-3(ix)
	ld	a,4(ix)
	ld	(hl),a
	inc	hl
	ld	a,5(ix)
	ld	(hl),a
;malloc.c:75: return &current_header->mem;
;	genPlus
;	genPlusIncr
	ld	hl,#0x0006
	add	hl,de
;	genRet
; Dump of IC_LEFT: type AOP_STR size 2
	jp	00115$
;	genLabel
00113$:
;malloc.c:80: new_header = (MEMHEADER * )((char *)current_header + current_header->len);
;	genPlus
;	AOP_STK for _malloc__1_0
;	Can't optimise plus by inc, falling back to the normal way
	ld	l,-6(ix)
	ld	h,-5(ix)
	add	hl,de
;	genAssign
;malloc.c:81: new_header->next = current_header->next; //and plug it into the chain
;	genAssign (pointer)
;	AOP_STK for _malloc__1_0
;	isBitvar = 0
	ld	c,l
	ld	b,h
	ld	a,-2(ix)
	ld	(hl),a
	inc	hl
	ld	a,-1(ix)
	ld	(hl),a
;malloc.c:82: new_header->prev = current_header;
;	genPlus
;	genPlusIncr
	ld	l,c
	ld	h,b
	inc	hl
	inc	hl
;	genAssign (pointer)
;	isBitvar = 0
	ld	(hl),e
	inc	hl
	ld	(hl),d
;malloc.c:83: current_header->next  = new_header;
;	genAssign (pointer)
;	isBitvar = 0
	ld	l,e
	ld	h,d
	ld	(hl),c
	inc	hl
	ld	(hl),b
;malloc.c:84: if (new_header->next)
;	genIfx
;	AOP_STK for _malloc__1_0
	ld	a,-2(ix)
	or	a,-1(ix)
	jp	z,00111$
;malloc.c:86: new_header->next->prev = new_header;
;	genPointerGet
	ld	l,c
	ld	h,b
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
;	genPlus
;	genPlusIncr
; Removed redundent load
; Removed redundent load
	inc	hl
	inc	hl
;	genAssign (pointer)
;	isBitvar = 0
	ld	(hl),c
	inc	hl
	ld	(hl),b
;	genLabel
00111$:
;malloc.c:88: new_header->len  = size; //mark as used
;	genPlus
;	genPlusIncr
	ld	hl,#0x0004
	add	hl,bc
;	genAssign (pointer)
;	AOP_STK for 
;	isBitvar = 0
	ld	a,4(ix)
	ld	(hl),a
	inc	hl
	ld	a,5(ix)
	ld	(hl),a
;malloc.c:89: return &new_header->mem;
;	genPlus
;	genPlusIncr
	ld	hl,#0x0006
	add	hl,bc
;	genRet
; Dump of IC_LEFT: type AOP_STR size 2
;	genLabel
00115$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
_malloc_end::
;malloc.c:94: free (void *p)
;	genLabel
;	genFunction
;	---------------------------------
; Function free
; ---------------------------------
_free_start::
_free:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-2
	add	hl,sp
	ld	sp,hl
;malloc.c:98: if ( p ) //For allocated pointers only!
;	genIfx
;	AOP_STK for 
	ld	a,4(ix)
	or	a,5(ix)
	jp	z,00108$
;malloc.c:100: pthis = (MEMHEADER * )((char *)  p - HEADER_SIZE); //to start of header
;	genAssign
;	AOP_STK for 
	ld	l,4(ix)
	ld	h,5(ix)
;	genMinus
	ld	a,l
	add	a,#0xFA
	ld	c,a
	ld	a,h
	adc	a,#0xFF
	ld	b,a
;malloc.c:101: if ( pthis->prev ) // For the regular header
;	genPlus
;	genPlusIncr
	ld	l,c
	ld	h,b
	inc	hl
	inc	hl
;	genPointerGet
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
;	genIfx
	ld	l,a
	or	a,h
	jp	z,00104$
;malloc.c:103: prev_header = pthis->prev;
;	genAssign
;	genAssign
;	AOP_STK for _free_prev_header_1_1
	ld	-2(ix),l
	ld	-1(ix),h
;malloc.c:104: prev_header->next = pthis->next;
;	genPointerGet
	ld	l,c
	ld	h,b
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
;	genAssign (pointer)
;	AOP_STK for _free_prev_header_1_1
;	isBitvar = 0
	ld	l,-2(ix)
	ld	h,-1(ix)
	ld	(hl),e
	inc	hl
	ld	(hl),d
;malloc.c:105: if (pthis->next)
;	genIfx
	ld	a,e
	or	a,d
	jp	z,00108$
;malloc.c:107: pthis->next->prev = prev_header;
;	genPlus
;	genPlusIncr
	ld	l,e
	ld	h,d
	inc	hl
	inc	hl
;	genAssign (pointer)
;	AOP_STK for _free_prev_header_1_1
;	isBitvar = 0
	ld	a,-2(ix)
	ld	(hl),a
	inc	hl
	ld	a,-1(ix)
	ld	(hl),a
;	genGoto
	jp	00108$
;	genLabel
00104$:
;malloc.c:112: pthis->len = 0; //For the first header
;	genPlus
;	genPlusIncr
	ld	hl,#0x0004
	add	hl,bc
;	genAssign (pointer)
;	isBitvar = 0
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;	genLabel
00108$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
_free_end::
	.area _CODE
