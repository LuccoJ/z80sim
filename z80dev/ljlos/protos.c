/* Declarations */

void* MemoryAllocate(unsigned int, memType);
void MemoryFree(void*);
lock LockCreate();
void LockObtain(lock Handle);
void LockRelease(lock Handle);

/* Definitions */ 

void* MemoryAllocate(unsigned int, memType) {
    _asm
    pop hl
    ld a,#0x00
    rst 0x08
    push hl
    ret
    _endasm;
}

void MemoryFree(void*) {
    _asm
    pop hl
    ld a,#0x01
    rst 0x08
    push hl
    ret
    _endasm;
}

lock LockCreate() {
    _asm
    pop hl
    ld a,#0x02
    rst 0x08
    push hl
    ret
    _endasm;
}

void LockObtain(lock Handle) {
    _asm
    pop hl
    ld a,#0x03
    rst 0x08
    push hl
    ret
    _endasm;
}

void LockRelease(lock Handle) {
    _asm
    pop hl
    ld a,#0x04
    rst 0x08
    push hl
    ret
    _endasm;
}
