void ROMSystemInit() {
_asm
di
jp _main
nop
nop
nop
nop
ret
nop
nop
nop
nop
nop
nop
nop
ret
nop
nop
nop
nop
nop
nop
nop
ret
nop
nop
nop
nop
nop
nop
nop
ret
nop
nop
nop
nop
nop
nop
nop
ret
nop
nop
nop
nop

; if interrupt function gets compiled naked

nop
nop
nop
jp __SystemRequest
nop
nop
nop
nop
nop
di
jp __InterruptService

_endasm;
}
