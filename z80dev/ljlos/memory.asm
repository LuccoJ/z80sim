;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Feb  3 2010) (UNIX)
; This file was generated Fri Apr 27 12:42:17 2012
;--------------------------------------------------------
	.module memory
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _MemoryInited
	.globl _NextFreeBlock
	.globl _MemoryInit
	.globl _MemoryCopy
	.globl _MemoryAllocate
	.globl _MemoryFree
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
G$NextFreeBlock$0$0==.
_NextFreeBlock::
	.ds 2
G$MemoryInited$0$0==.
_MemoryInited::
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
	G$MemoryInit$0$0	= .
	.globl	G$MemoryInit$0$0
	C$memory.c$10$0$0	= .
	.globl	C$memory.c$10$0$0
;memory.c:10: bool MemoryInited; void MemoryInit() {
;	---------------------------------
; Function MemoryInit
; ---------------------------------
_MemoryInit_start::
_MemoryInit:
	ld	a,#3
	rst	0x08
	C$memory.c$11$1$1	= .
	.globl	C$memory.c$11$1$1
;memory.c:11: if(!MemoryInited) {
	xor	a,a
	ld	hl,#_MemoryInited + 0
	or	a,(hl)
	jr	NZ,00103$
	C$memory.c$12$2$2	= .
	.globl	C$memory.c$12$2$2
;memory.c:12: NextFreeBlock=(char*)0xe000;
	ld	hl,#_NextFreeBlock + 0
	ld	(hl), #0x00
	ld	hl,#_NextFreeBlock + 1
	ld	(hl), #0xE0
	C$memory.c$13$2$2	= .
	.globl	C$memory.c$13$2$2
;memory.c:13: MemoryInited=TRUE;
	ld	hl,#_MemoryInited + 0
	ld	(hl), #0x01
	C$memory.c$14$2$2	= .
	.globl	C$memory.c$14$2$2
;memory.c:14: _SimRWProtect((void*)0x8600, 0xffd0);
	ld	hl,#0xFFD0
	push	hl
	ld	hl,#0x8600
	push	hl
	call	__Z80SimRWProtect
	pop	af
	pop	af
	C$memory.c$15$2$2	= .
	.globl	C$memory.c$15$2$2
;memory.c:15: _SimPrintString("Memory initialized\n");
	ld	hl,#__str_0
	push	hl
	call	__Z80SimPrintString
	pop	af
00103$:
	ld	a,#4
	rst	0x08
	C$memory.c$17$2$1	= .
	.globl	C$memory.c$17$2$1
	XG$MemoryInit$0$0	= .
	.globl	XG$MemoryInit$0$0
	ret
_MemoryInit_end::
Fmemory$_str_0$0$0 == .
__str_0:
	.ascii "Memory initialized"
	.db 0x0A
	.db 0x00
	G$MemoryCopy$0$0	= .
	.globl	G$MemoryCopy$0$0
	C$memory.c$19$2$1	= .
	.globl	C$memory.c$19$2$1
;memory.c:19: void MemoryCopy(void* Destination, void* Source, unsigned int Length) {
;	---------------------------------
; Function MemoryCopy
; ---------------------------------
_MemoryCopy_start::
_MemoryCopy:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-6
	add	hl,sp
	ld	sp,hl
	C$memory.c$21$2$2	= .
	.globl	C$memory.c$21$2$2
;memory.c:21: for(i=0; i<Length; i++) {
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	a,6 (ix)
	ld	-4 (ix),a
	ld	a,7 (ix)
	ld	-3 (ix),a
	ld	-2 (ix),#0x00
	ld	-1 (ix),#0x00
00101$:
	ld	a,-2 (ix)
	sub	a,8 (ix)
	ld	a,-1 (ix)
	sbc	a,9 (ix)
	jr	NC,00105$
	C$memory.c$22$2$2	= .
	.globl	C$memory.c$22$2$2
;memory.c:22: *((char*)Destination+i)=*((char*)Source+i);
	ld	a,c
	add	a,-2 (ix)
	ld	-6 (ix),a
	ld	a,b
	adc	a,-1 (ix)
	ld	-5 (ix),a
	ld	a,-4 (ix)
	add	a,-2 (ix)
	ld	e,a
	ld	a,-3 (ix)
	adc	a,-1 (ix)
	ld	d,a
	ld	a,(de)
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	(hl),a
	C$memory.c$21$1$1	= .
	.globl	C$memory.c$21$1$1
;memory.c:21: for(i=0; i<Length; i++) {
	inc	-2 (ix)
	jr	NZ,00110$
	inc	-1 (ix)
00110$:
	jr	00101$
00105$:
	ld	sp,ix
	pop	ix
	ld	a,#4
	rst	0x08
	C$memory.c$24$1$1	= .
	.globl	C$memory.c$24$1$1
	XG$MemoryCopy$0$0	= .
	.globl	XG$MemoryCopy$0$0
	ret
_MemoryCopy_end::
	G$MemoryAllocate$0$0	= .
	.globl	G$MemoryAllocate$0$0
	C$memory.c$26$1$1	= .
	.globl	C$memory.c$26$1$1
;memory.c:26: void* MemoryAllocate(unsigned int Bytes, memType Type) {
;	---------------------------------
; Function MemoryAllocate
; ---------------------------------
_MemoryAllocate_start::
_MemoryAllocate:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	C$memory.c$28$1$1	= .
	.globl	C$memory.c$28$1$1
;memory.c:28: if(NextFreeBlock<(char*)0x9000) Halt("OUT OF MEMORY");
	ld	a,(#_NextFreeBlock+0)
	sub	a,#0x00
	ld	a,(#_NextFreeBlock+1)
	sbc	a,#0x90
	jp	P,00102$
	ld	hl,#__str_1
	push	hl
	call	_Halt
	pop	af
00102$:
	C$memory.c$29$1$1	= .
	.globl	C$memory.c$29$1$1
;memory.c:29: Pointer=NextFreeBlock;
	ld	bc,(_NextFreeBlock)
	C$memory.c$30$1$1	= .
	.globl	C$memory.c$30$1$1
;memory.c:30: NextFreeBlock=NextFreeBlock-Bytes;
	ld	e,4 (ix)
	ld	d,5 (ix)
	ld	hl,#_NextFreeBlock
	ld	a,(hl)
	sub	a,e
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	sbc	a,d
	ld	(hl),a
	C$memory.c$31$1$1	= .
	.globl	C$memory.c$31$1$1
;memory.c:31: _SimUnprotect(NextFreeBlock, Pointer);
	ld	de,(_NextFreeBlock)
	push	bc
	push	bc
	push	de
	call	__Z80SimUnprotect
	pop	af
	pop	af
	pop	bc
	C$memory.c$32$1$1	= .
	.globl	C$memory.c$32$1$1
;memory.c:32: if(Type==memSTACK) {
	xor	a,a
	or	a,6 (ix)
	jr	NZ,00104$
	C$memory.c$33$2$2	= .
	.globl	C$memory.c$33$2$2
;memory.c:33: return (void*)Pointer;
	ld	l,c
	ld	h,b
	jr	00106$
00104$:
	C$memory.c$35$2$3	= .
	.globl	C$memory.c$35$2$3
;memory.c:35: return (void*)NextFreeBlock;
	ld	hl,(_NextFreeBlock)
00106$:
	pop	ix
	ld	a,#4
	rst	0x08
	C$memory.c$37$1$1	= .
	.globl	C$memory.c$37$1$1
	XG$MemoryAllocate$0$0	= .
	.globl	XG$MemoryAllocate$0$0
	ret
_MemoryAllocate_end::
Fmemory$_str_1$0$0 == .
__str_1:
	.ascii "OUT OF MEMORY"
	.db 0x00
	G$MemoryFree$0$0	= .
	.globl	G$MemoryFree$0$0
	C$memory.c$39$1$1	= .
	.globl	C$memory.c$39$1$1
;memory.c:39: void MemoryFree(void* Pointer) {
;	---------------------------------
; Function MemoryFree
; ---------------------------------
_MemoryFree_start::
_MemoryFree:
	ld	a,#3
	rst	0x08
	push	ix
	ld	ix,#0
	add	ix,sp
	C$memory.c$41$1$1	= .
	.globl	C$memory.c$41$1$1
;memory.c:41: Pointer;
	pop	ix
	ld	a,#4
	rst	0x08
	C$memory.c$42$1$1	= .
	.globl	C$memory.c$42$1$1
	XG$MemoryFree$0$0	= .
	.globl	XG$MemoryFree$0$0
	ret
_MemoryFree_end::
	.area _CODE
	.area _CABS
