#ifndef H_Z80
#define H_Z80

#define ImmediateReturn() \
_asm     \
ret      \
_endasm; \

#define FunctionArgToReg(Higher, Lower) \
_asm            \
ld ix,£0        \
add ix,sp       \
ld Lower,4(ix)  \
ld Higher,5(ix) \
_endasm;

#define SaveIndexes() \
_asm          \
ld hl,£0xEFFF \
ld sp,hl      \
push ix       \
push iy       \
_endasm;

#define ReloadIndexes() \
_asm            \
ld ix,(0xEFFD)  \
ld iy,(0xEFFB)  \
_endasm;

#define SetStackPointerASM(Variable) \
_asm             \
ld sp,(Variable) \
_endasm;

#define SetStackPointerREG(RegisterPair) \
_asm               \
ld sp,RegisterPair \
_endasm;


#define GetStackPointerASM(Variable) \
_asm             \
ld (Variable),sp \
_endasm;

#define IntsOff() \
_asm     \
di       \
_endasm;

#define IntsOn() \
_asm     \
im 1     \
ei       \
_endasm;

#define SaveContext() \
_asm     \
push af  \
push bc  \
push de  \
push hl  \
push ix  \
push iy  \
_endasm;

#define LoadContext() \
_asm     \
pop iy   \
pop ix   \
pop hl   \
pop de   \
pop bc   \
pop af   \
_endasm; \

#define TestAndSet(Lock) \
_asm                 \
ld l,£1              \
inc (_ ## Lock)      \
jp z, EndTAS ## Lock \
Contention ## Lock:  \
dec (_ ## Lock)      \
ld l,£0              \
EndTAS ## Lock:      \
_endasm;


void HardwareInit();
void ExchangeRegs();

#endif
