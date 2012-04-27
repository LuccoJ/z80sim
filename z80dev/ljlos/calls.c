extern void* _JumpTable;

void _SystemRequest() {
	_asm
	ld ix,£_JumpTable
	push hl
	ld h,#0
	ld l,a
	add hl,ix
	jp (hl)
	_endasm;
}
