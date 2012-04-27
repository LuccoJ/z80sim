/*
   Z80Sim - A simulator/debugger for the Zilog Z80 processor
   Copyright (C) 2003 Lorenzo J. Lucchini

   This program is free software; you can redistribute it
   and/or modify it under the terms of the GNU General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later
   version. This program is distributed in the hope that it
   will be useful, but WITHOUT ANY WARRANTY; without even the
   implied warranty of MERCHANTABILITY or FITNESS FOR A
   PARTICULAR PURPOSE. See the GNU General Public License for
   more details. You should have received a copy of the GNU
   General Public License along with this program; if not,
   write to the Free Software Foundation, Inc., 59 Temple
   Place, Suite 330, Boston, MA 02111-1307 USA
*/


#include "types.h"
#include "sizes.h"
#include "cpu.h"
#include "opcodes.h"
#include "symbols.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#define METACALL_QUIT		0x00
#define METACALL_PUTCHARACTER	0x01
#define METACALL_GETCLOCK	0x02
#define METACALL_ENTER		0x03
#define METACALL_EXIT		0x04
#define METACALL_ENTERLEAF	0x05
#define METACALL_DUMPREGS	0x06
#define METACALL_PUTWORD	0x07
#define METACALL_WRITEPROTECT	0x08
#define METACALL_READPROTECT	0x09
#define METACALL_RWPROTECT	0x0a
#define METACALL_UNPROTECT	0x0b

#define PROTECT_WRITE		1<<0
#define PROTECT_READ		1<<1

typedef union {
	word Word;
	struct {
		byte L;
		byte H;
	} Bytes;
} reg;

inline byte ReadMemory(word Address);
void WriteMemory(word Address, byte Value);

void Push(word);
void Pop(word*);

byte Memory[SIZE_MEMORY];
short Protections[SIZE_MEMORY];

byte IR;

reg AF, SP, PC;
reg BC, DE;
reg HL, IX, IY;

reg AF1;
reg BC1, DE1;
reg HL1;

logic InterruptRequest;
logic EnableInterrupts;
logic IFF1, IFF2;

logic FlagZ, FlagNZ;
logic FlagC, FlagNC;
logic FlagPO, FlagPE;
logic FlagM, FlagP;
logic FlagN, FlagH;
logic Flag3, Flag5;

unsigned long TStates;
unsigned long InstructionsExecuted;

logic UsefulInstruction;

logic Indexing;
logic IndirectMemoryWrite;
logic MemoryWrite;
byte MemoryData;
word MemoryAddress;
reg* PointerReg;
byte Index;

trap Exception;

#warning FIXME: DOES NOT GIVE THE RIGHT T-STATES, SHOULD BE MOVED OUT OF OperandR AND THE REST
int PHLOverhead;


// Protect a zone of the main memory as specified by Flags

void ProtectRange(word Start, word End, short Flags) {
	int i;
	for(i=Start; i<=End; i++) {
		Protections[i]=Flags;
	}
}

// Return the bit specifying the sign in a 2's complement value of type 'byte'.

inline logic SignBit(byte Value) {
	if(Value&0x80) return TRUE; else return FALSE;
}


// Return TRUE if the parity of Byte is even, otherwise FALSE.

inline logic Parity(byte Byte) {
        byte Temp;
	Temp=Byte;
        Temp=Temp^(Temp>>4);
        Temp=Temp^(Temp>>2);
        Temp=Temp^(Temp>>1);
        return ((Temp&1)!=0?FALSE:TRUE);
}


// Copy the contents of the Flag* logic variables into the actual F register.

void StoreFlags() {
	assert(FlagZ==!FlagNZ);
	assert(FlagC==!FlagNC);
	assert(FlagPE==!FlagPO);
	assert(FlagP==!FlagM);
	AF.Bytes.L=(
		(FlagC?(1<<0):0) |
		(FlagN?(1<<1):0) |
		(FlagPE?(1<<2):0)|
		(Flag3?(1<<3):0) |
		(FlagH?(1<<4):0) |
		(Flag5?(1<<5):0) |
		(FlagZ?(1<<6):0) |
		(FlagM?(1<<7):0)
	);
}


// Set the Flag* variables depending on the contents of Datum, except those
// that cannot be inferred from it alone. Don't set the actual F register.
// Also calculate parity and store it into FlagPE/FlagPO if GiveParity==TRUE.

void SetFlags(byte Datum) {
	Flag3=(Datum&0x08)!=0;
	Flag5=(Datum&0x20)!=0;
	if(Datum==0) FlagZ=1; else FlagZ=0;
	FlagNZ=!FlagZ;
	FlagP=!SignBit(Datum);
        FlagM=!FlagP;
	FlagPE=Parity(Datum);
	FlagPO=!FlagPE;
}


// Add Operand to *Register, and store the result into *Register. Set the Flag*
// variables accordingly.

void AddByte(byte* Register, byte Operand) {
	byte Op1=*Register, Op2=Operand;
        long Sum;
        Sum=Op1+Op2;
        *Register=(byte)Sum;
        SetFlags(*Register);
        if((Op1&0x08)^(Op2&0x08)^(Sum&0x08)) FlagH=1; else FlagH=0;
        if(Sum>(word)0xFF) FlagNC=!(FlagC=1); else FlagC=!(FlagNC=1);
	if(SignBit(Op1)==SignBit(Op2) && SignBit(Sum)!=SignBit(Op1)) FlagPO=!(FlagPE=1); else FlagPO=!(FlagPE=0);
        FlagN=0;
        TStates+=4;
}


// Subtract Operand from *Register, and store the result into *Register. Set the Flag*
// variables accordingly.

void SubByte(byte* Register, byte Operand) {
        byte Op1=*Register, Op2=-Operand;
        long Sum;
        Sum=Op1+Op2;
        *Register=(byte)Sum;
        SetFlags(*Register);
        if((Op1&0x08)^(Op2&0x08)^(Sum&0x08)) FlagH=0; else FlagH=1;
        if(Sum>(word)0xFF) FlagNC=!(FlagC=0); else FlagC=!(FlagNC=0);
        if(SignBit(Op1)==SignBit(Op2) && SignBit(Sum)!=SignBit(Op1)) FlagPO=!(FlagPE=1); else FlagPO=!(FlagPE=0);
        FlagN=0;
        TStates+=4;
}


// As per AddByte(), but do it for two words, and only set the flags required by
// a word addition.

void AddWord(word* Register, word Operand) {
	long Sum;
	Sum=*Register+Operand;
        if(((*Register)&0x0F00)+(Operand&0x0F00)>0x0F00) FlagH=1; else FlagH=0;
	*Register=(word)Sum;
	if(Sum>0xFFFF) FlagNC=!(FlagC=1); else FlagC=!(FlagNC=1);
	FlagN=0;
	TStates+=11;
}


// Logical And of two bytes, store result into *Register and set the Flag*s.

void And(byte* Register, byte Operand) {
	*Register=*Register&Operand;
	// Flags should be correct
	SetFlags(*Register);
	FlagNC=!(FlagC=0);
	FlagN=0;
	//StoreFlags();
	TStates+=4;
}


// Logical exclusive Or of two bytes, store result into *Register and set the Flag*s.

void XOr(byte* Register, byte Operand) {
	*Register=*Register^Operand;
	// Flags should be correct, but aren't
	SetFlags(*Register);
	FlagNC=!(FlagC=0);
	FlagN=0;
	FlagH=0;
	//StoreFlags();
	TStates+=4;
}


// Logical Or of two bytes, store result into *Register and set the Flag*s.

void Or(byte* Register, byte Operand) {
	*Register=*Register|Operand;
	// Flags should be correct
	SetFlags(*Register);
	FlagNC=!(FlagC=0);
	FlagN=0;
	//StoreFlags();
	TStates+=4;
}


// Subtract Operand to *Register; don't store the result anywhere, only set the Flag*s.

void Compare(byte* Register, byte Operand) {
	byte Temp=*Register;
	SubByte(&Temp, Operand);
        FlagN=1;
	TStates+=4;
}


// Fetch a direct operand of the length of a word (16 bits).

word GetWordOperand() {
	reg WordOperand;
        WordOperand.Bytes.L=ReadMemory(PC.Word++);
        WordOperand.Bytes.H=ReadMemory(PC.Word++);
	return WordOperand.Word;
}


// Branch to NewAddress.

void JumpAbsolute(word NewAddress) {
	PC.Word=NewAddress;
	TStates+=10;
	UsefulInstruction=TRUE;
}


// Branch to PC+Index.

void JumpRelative(byte Index) {
        PC.Word+=(word)(sbyte)Index;
	TStates+=12;
	UsefulInstruction=TRUE;
}


// Store PC into the stack, then branch to ProcAddress.

void Call(word ProcAddress) {
        Push(PC.Word);
	JumpAbsolute(ProcAddress);
	MarkEntryPoint(PC.Word);
	TStates-=4;
}


// Push Register into the stack.

void Push(word Register) {
	WriteMemory(SP.Word-2, (Register&0x00FF)>>0);
        WriteMemory(SP.Word-1, (Register&0xFF00)>>8);
	SP.Word-=2;
	TStates+=11;
}


// Pop a value from the stack and store it into *Register.

void Pop(word* Register) {
	*Register=ReadMemory(SP.Word++);
	(*Register)|=ReadMemory(SP.Word++)<<8;
	if(Register==&AF.Word) {
		FlagNC=!(FlagC=(AF.Bytes.L>>0)&1);
		FlagNZ=!(FlagZ=(AF.Bytes.L>>6)&1);
		FlagPO=!(FlagPE=(AF.Bytes.L>>2)&1);
		FlagP=!(FlagM=(AF.Bytes.L>>7)&1);
		FlagN=(AF.Bytes.L>>1)&1;
		FlagH=(AF.Bytes.L>>4)&1;
		Flag3=(AF.Bytes.L>>3)&1;
		Flag5=(AF.Bytes.L>>5)&1;
	}
	TStates+=10;
}


// Swap two words.

void Swap(word* Reg1, word* Reg2) {
	word Temp;
	Temp=*Reg1;
	*Reg1=*Reg2;
	*Reg2=Temp;
}


// Return the address of the register specified in Opcode, with Opcode being
// a Z80 opcode whose bits 3..5 specify a register.

byte* OperandR(byte Opcode) {
        if(OPARG_R_A(Opcode)) return &AF.Bytes.H;
	if(OPARG_R_B(Opcode)) return &BC.Bytes.H;
	if(OPARG_R_C(Opcode)) return &BC.Bytes.L;
	if(OPARG_R_D(Opcode)) return &DE.Bytes.H;
        if(OPARG_R_E(Opcode)) return &DE.Bytes.L;
        if(OPARG_R_H(Opcode)) return &HL.Bytes.H;
        if(OPARG_R_L(Opcode)) return &HL.Bytes.L;
        if(OPARG_R_PHL(Opcode)) {
		TStates+=PHLOverhead;
                IndirectMemoryWrite=TRUE;
                MemoryData=ReadMemory(PointerReg->Word+(word)(sbyte)Index);
                return &MemoryData;
        }
        fprintf(stdout, "ERROR: Unrecognized destination register\n");
	return &AF.Bytes.H;
}


// Return the address of the register specified in Opcode, with Opcode being
// a Z80 opcode whose bits 0..2 specify a register.

byte* OperandS(byte Opcode) {
        if(OPARG_S_A(Opcode)) return &AF.Bytes.H;
        if(OPARG_S_B(Opcode)) return &BC.Bytes.H;
        if(OPARG_S_C(Opcode)) return &BC.Bytes.L;
        if(OPARG_S_D(Opcode)) return &DE.Bytes.H;
        if(OPARG_S_E(Opcode)) return &DE.Bytes.L;
        if(OPARG_S_H(Opcode)) return &HL.Bytes.H;
        if(OPARG_S_L(Opcode)) return &HL.Bytes.L;
        if(OPARG_S_PHL(Opcode)) {
		TStates+=PHLOverhead;
		MemoryData=ReadMemory(PointerReg->Word+(word)(sbyte)Index);
		return &MemoryData;
	}
	fprintf(stdout, "ERROR: Unrecognized source register\n");
	return &AF.Bytes.H;
}


// Return the address of the register pair specified in Opcode, with Opcode
// being a Z80 opcode whose bits 4 and 5 specify a register pair.

word* OperandP(byte Opcode) {
        if(OPARG_P_BC(Opcode)) return &BC.Word;
        if(OPARG_P_DE(Opcode)) return &DE.Word;
        if(OPARG_P_HL(Opcode)) return &(PointerReg->Word);
        if(OPARG_P_SP(Opcode)) return &SP.Word;
	return NULL;
}


// Return the address of a Flag* variable as specified in Opcode, with
// Opcode being a z80 opcode whose bits 3..5 specify a flag.

logic* OperandF(byte Opcode) {
        if(OPARG_F_NZ(Opcode)) return &FlagNZ;
        if(OPARG_F_Z(Opcode)) return &FlagZ;
        if(OPARG_F_NC(Opcode)) return &FlagNC;
        if(OPARG_F_C(Opcode)) return &FlagC;
        if(OPARG_F_PO(Opcode)) return &FlagPO;
        if(OPARG_F_PE(Opcode)) return &FlagPE;
        if(OPARG_F_P(Opcode)) return &FlagP;
        if(OPARG_F_M(Opcode)) return &FlagM;
	return NULL;
}


// As per OperandF(), but works with those opcode that only accept one
// of four flags instead of eight in bits 3 and 4

logic* OperandSF(byte Opcode) {
        if(OPARG_SF_NZ(Opcode)) return &FlagNZ;
        if(OPARG_SF_Z(Opcode)) return &FlagZ;
        if(OPARG_SF_NC(Opcode)) return &FlagNC;
        if(OPARG_SF_C(Opcode)) return &FlagC;
	return NULL;
}


// Store a string in Name containing the human-readable name of the flag
// which is a Flag* variable at address *Flag.

void NameFlag(logic* Flag, char* Name) {
	if(Flag==&FlagNZ) strcpy(Name, "nz"); else
        if(Flag==&FlagZ) strcpy(Name, "z"); else
        if(Flag==&FlagNC) strcpy(Name, "nc"); else
        if(Flag==&FlagC) strcpy(Name, "c"); else
        if(Flag==&FlagPO) strcpy(Name, "po"); else
        if(Flag==&FlagPE) strcpy(Name, "pe"); else
        if(Flag==&FlagP) strcpy(Name, "p"); else
        if(Flag==&FlagM) strcpy(Name, "m"); else strcpy(Name, "?f");
}


// Store a string in Name containing the human-readable name of the (byte)
// register at address *Register.

void NameRegister(byte* Register, char* Name) {
	if(Register==&AF.Bytes.H) strcpy(Name, "a"); else
        if(Register==&AF.Bytes.L) strcpy(Name, "f"); else
        if(Register==&BC.Bytes.H) strcpy(Name, "b"); else
        if(Register==&BC.Bytes.L) strcpy(Name, "c"); else
        if(Register==&DE.Bytes.H) strcpy(Name, "d"); else
        if(Register==&DE.Bytes.L) strcpy(Name, "e"); else
        if(Register==&HL.Bytes.H) strcpy(Name, "h"); else
        if(Register==&HL.Bytes.L) strcpy(Name, "l"); else
	if(Register==&MemoryData) {
		if(PointerReg==&HL) strcpy(Name, "(hl)"); else
		if(PointerReg==&IX) strcpy(Name, "(ix)"); else
		if(PointerReg==&IY) strcpy(Name, "(iy)");
		else strcpy(Name, "?i");
	} else strcpy(Name, "?r");
}


// Store a string in Name containing the human-readable name of the
// register pair at address *Register.

void NameRegisterPair(word* Register, char* Name) {
	if(Register==&AF.Word) strcpy(Name, "af"); else
        if(Register==&BC.Word) strcpy(Name, "bc"); else
        if(Register==&DE.Word) strcpy(Name, "de"); else
        if(Register==&HL.Word) strcpy(Name, "hl"); else
        if(Register==&SP.Word) strcpy(Name, "sp"); else
        if(Register==&IX.Word) strcpy(Name, "ix"); else
        if(Register==&IY.Word) strcpy(Name, "iy"); else strcpy(Name, "?p");
}


// Return the contents of cell number Address in main memory.

inline byte ReadMemory(word Address) {
	MemoryAddress=Address;
	if(Protections[Address]&PROTECT_READ) Exception=TRAP_MEMORY;
	MemoryData=Memory[Address];
	return MemoryData;
}


// Write the contents of Value to cell number Address in main memory,
// if this is allowed.

void WriteMemory(word Address, byte Value) {
        MemoryAddress=Address;
	MemoryData=Value;
	MemoryWrite=TRUE;
	if(Protections[Address]&PROTECT_WRITE) {
                Exception=TRAP_MEMORY;
	} else {
                Memory[Address]=Value;
	}
}

inline byte ReadIO(byte Port) {
	return 0;
}

void WriteIO(byte Port, byte Value) {
	fprintf(stdout, "WARNING: Writing %02x into port %02x\n", Value, Port);
}

// Initialize the Z80 simulation.

void Init() {
	int i;
	AF.Word=BC.Word=DE.Word=HL.Word=IX.Word=IY.Word=SP.Word=PC.Word=AF1.Word=BC1.Word=DE1.Word=HL1.Word=0x0000;
	FlagNZ=!(FlagZ=0);
	FlagNC=!(FlagC=0);
	FlagPO=!(FlagPE=0);
	FlagP=!(FlagM=0);
	Flag3=0;
	Flag5=0;
	FlagN=0;
	FlagH=0;
	TStates=0;
	InstructionsExecuted=0;
	for(i=0; i<0x1000; i++) {
		Memory[i]=0x00; // rand();
	}
	//ProtectRange(0x0000, 0x3fff, PROTECT_WRITE);
	ProtectRange(0x0000, 0xffff, 0);
	fprintf(stdout, "Z80 initialized\n");
}

void LoadROM(FILE* Handle) {
	fread(Memory, 1, 0x10000, Handle);
}

void MetaCall(byte Number) {
	switch(Number) {
	case METACALL_ENTER:
		//MarkEntryPoint();
		break;
	case METACALL_EXIT:
		//MarkExitPoint();
		break;
	case METACALL_PUTCHARACTER:
		fprintf(stderr, "%c", HL.Bytes.L);
		fflush(stderr);
		break;
	case METACALL_PUTWORD:
		fprintf(stderr, "%04x", HL.Word);
		fflush(stderr);
		break;
	case METACALL_WRITEPROTECT:
		ProtectRange(HL.Word, DE.Word, PROTECT_WRITE);
		break;
	case METACALL_READPROTECT:
		ProtectRange(HL.Word, DE.Word, PROTECT_READ);
		break;
	case METACALL_RWPROTECT:
		ProtectRange(HL.Word, DE.Word, PROTECT_WRITE|PROTECT_READ);
		break;
	case METACALL_UNPROTECT:
		ProtectRange(HL.Word, DE.Word, 0);
		break;
	default:
		fprintf(stdout, "WARNING: Unimplemented metacall %02x\n", Number);
		Exception=TRAP_METACALL;
	}
	UsefulInstruction=TRUE;
}

void SnapshotState(FILE* Handle) {
	char Mnemonic[MAX_NAME];
	word InstructionAddress;
	InstructionAddress=PC.Word;
	fprintf(Handle, "Frame %ld Begin\n", InstructionsExecuted);
	fprintf(Handle, "\tPC <0x%04x> SP <0x%04x>\n", PC.Word, SP.Word);
	fprintf(Handle, "\tA <0x%02x>\n", AF.Bytes.H);
	fprintf(Handle, "\tfS <%d> fZ <%d> f5 <%d> fH <%d> f3 <%d> fP <%d> fN <%d> fC <%d>\n", ((AF.Bytes.L>>7)&1), ((AF.Bytes.L>>6)&1), ((AF.Bytes.L>>5)&1), ((AF.Bytes.L>>4)&1), ((AF.Bytes.L>>3)&1), ((AF.Bytes.L>>2)&1), ((AF.Bytes.L>>1)&1), ((AF.Bytes.L>>7)&0)); 
	fprintf(Handle, "\tHL <0x%04x>\n", HL.Word);
	fprintf(Handle, "\tIX <0x%04x> IY <0x%04x>\n", IX.Word, IY.Word),
	fprintf(Handle, "\tBC <0x%04x> DE <0x%04x>\n", BC.Word, DE.Word);
	fprintf(Handle, "\tMAR <0x%04x> MDR <0x%02x>\n", MemoryAddress, MemoryData);
        if(MemoryWrite) fprintf(Handle, "\tStore <TRUE>\n"); else fprintf(Handle, "\tStore <FALSE>\n");
	fprintf(Handle, "\tStack <0x%02x%02x>\n", Memory[(word)(SP.Word+1)], Memory[(word)(SP.Word+0)]);
        Disassemble(&InstructionAddress, Mnemonic);
	fprintf(Handle, "\tMnemonic <%s>\n", Mnemonic);
	fprintf(Handle, "End\n");
}


void PrintRegisters(FILE *Handle) {
        fprintf(Handle, "SP:%04x AF:%04x BC:%04x DE:%04x HL:%04x IX:%04x IY:%04x", SP.Word, AF.Word, BC.Word, DE.Word, HL.Word, IX.Word, IY.Word);
}


inline word FetchAddress(word* Address) {
	return Memory[(*Address)++] | (Memory[(*Address)++]<<8);
}

// Disassemble the Z80 instruction starting at Address.

void Disassemble(word* Address, char* Mnemonic) {
	char NameR[MAX_NAME], NameS[MAX_NAME], NameP[MAX_NAME], NameI[MAX_NAME], NameF[MAX_NAME], Symbol[MAX_NAME];
	byte Opcode;
	Opcode=Memory[(*Address)++];
        if(OP_IXPREFIX(Opcode)) {
                Opcode=ReadMemory((*Address)++);
                PointerReg=&IX;
                Indexing=TRUE;
        } else if(OP_IYPREFIX(Opcode)) {
                Opcode=ReadMemory((*Address)++);
                PointerReg=&IY;
                Indexing=TRUE;
        } else {
                PointerReg=&HL;
                Indexing=FALSE;
        }
        if(OP_HLT(Opcode)) {
		sprintf(Mnemonic, "halt");
        } else if(OP_LD_R_S(Opcode)) {
                NameRegister(OperandR(Opcode), NameR);
		NameRegister(OperandS(Opcode), NameS);
                if(Indexing) {
			if(OPARG_R_PHL(Opcode)) sprintf(Mnemonic, "ld #%02x %s, %s", Memory[(*Address)++], NameR, NameS);
			else if(OPARG_S_PHL(Opcode)) sprintf(Mnemonic, "ld %s, #%02x %s", NameR, Memory[(*Address)++], NameS);
		} else sprintf(Mnemonic, "ld %s, %s", NameR, NameS);
        } else if(OP_LD_R_B(Opcode)) {
                NameRegister(OperandR(Opcode), NameR);
		if(Indexing) sprintf(Mnemonic, "ld #%02x %s, #%02x", Memory[(*Address)++], NameR, Memory[(*Address)++]);
		else sprintf(Mnemonic, "ld %s, #%02x", NameR, Memory[(*Address)++]);
	} else if(OP_LD_P_W(Opcode)) {
		NameRegisterPair(OperandP(Opcode), NameP);
		sprintf(Mnemonic, "ld %s, #%02x%02x", NameP, Memory[(*Address)++], Memory[(*Address)++]);
	} else if(OP_LD_SP_HL(Opcode)) {
		NameRegisterPair(&PointerReg->Word, NameI);
		sprintf(Mnemonic, "ld sp, %s", NameI);
	} else if(OP_LD_A_PBC(Opcode)) {
		sprintf(Mnemonic, "ld a, (bc)");
        } else if(OP_LD_A_PDE(Opcode)) {
                sprintf(Mnemonic, "ld a, (de)");
        } else if(OP_LD_A_PW(Opcode)) {
                sprintf(Mnemonic, "ld a, (%02x%02x)", Memory[(*Address)++], Memory[(*Address)++]);
        } else if(OP_LD_PW_A(Opcode)) {
                sprintf(Mnemonic, "ld (%02x%02x), a", Memory[(*Address)++], Memory[(*Address)++]);
	} else if(OP_LD_HL_PW(Opcode)) {
		sprintf(Mnemonic, "ld hl, (%02x%02x)", Memory[(*Address)++], Memory[(*Address)++]);
	} else if(OP_LD_PBC_A(Opcode)) {
		sprintf(Mnemonic, "ld (bc), a");
	} else if(OP_LD_PDE_A(Opcode)) {
		sprintf(Mnemonic, "ld (de), a");
        } else if(OP_ADD_S(Opcode)) {
		NameRegister(OperandS(Opcode), NameS);
                if(OPMOD_CARRYIN(Opcode)) sprintf(Mnemonic, "adc a, %s", NameS);
		else sprintf(Mnemonic, "add a, %s", NameS);
        } else if(OP_ADD_B(Opcode)) {
                if(OPMOD_CARRYIN(Opcode)) sprintf(Mnemonic, "adc a, #%02x", Memory[(*Address)++]);
		else sprintf(Mnemonic, "add a, #%02x", Memory[(*Address)++]);
        } else if(OP_SUB_S(Opcode)) {
                NameRegister(OperandS(Opcode), NameS);
		if(OPMOD_CARRYIN(Opcode)) sprintf(Mnemonic, "sbc a, %s", NameS);
		else sprintf(Mnemonic, "sub a, %s", NameS);
        } else if(OP_SUB_B(Opcode)) {
                if(OPMOD_CARRYIN(Opcode)) sprintf(Mnemonic, "sbc a, #%02x", Memory[(*Address)++]);
		else sprintf(Mnemonic, "sub a, #%02x", Memory[(*Address)++]);
        } else if(OP_ADD_HL_P(Opcode)) {
		NameRegisterPair(&PointerReg->Word, NameI);
                NameRegisterPair(OperandP(Opcode), NameP);
		sprintf(Mnemonic, "add %s, %s", NameI, NameP);
        } else if(OP_INC_R(Opcode)) {
                NameRegister(OperandR(Opcode), NameR);
		sprintf(Mnemonic, "inc %s", NameR);
        } else if(OP_DEC_R(Opcode)) {
                NameRegister(OperandR(Opcode), NameR);
		sprintf(Mnemonic, "dec %s", NameR);
        } else if(OP_INC_P(Opcode)) {
		NameRegisterPair(OperandP(Opcode), NameP);
                sprintf(Mnemonic, "inc %s", NameP);
        } else if(OP_DEC_P(Opcode)) {
                NameRegisterPair(OperandP(Opcode), NameP);
                sprintf(Mnemonic, "dec %s", NameP);
        } else if(OP_AND_S(Opcode)) {
                NameRegister(OperandS(Opcode), NameS);
		sprintf(Mnemonic, "and a, %s", NameS);
        } else if(OP_AND_B(Opcode)) {
                sprintf(Mnemonic, "and a, #%02x", Memory[(*Address)++]);
        } else if(OP_XOR_S(Opcode)) {
                NameRegister(OperandS(Opcode), NameS);
		sprintf(Mnemonic, "xor a, %s", NameS);
        } else if(OP_XOR_B(Opcode)) {
                sprintf(Mnemonic, "xor a, #%02x", Memory[(*Address)++]);
        } else if(OP_OR_S(Opcode)) {
                NameRegister(OperandS(Opcode), NameS);
		sprintf(Mnemonic, "or a, %s", NameS);
        } else if(OP_OR_B(Opcode)) {
                sprintf(Mnemonic, "or a, #%02x", Memory[(*Address)++]);
        } else if(OP_CP_S(Opcode)) {
                NameRegister(OperandS(Opcode), NameS);
		sprintf(Mnemonic, "cp a, %s", NameS);
        } else if(OP_CP_B(Opcode)) {
                sprintf(Mnemonic, "cp a, #%02x", Memory[(*Address)++]);
        } else if(OP_JP_W(Opcode)) {
		LookupSymbol(FetchAddress(Address), Symbol);
                sprintf(Mnemonic, "jp %s", Symbol);
        } else if(OP_JP_F_W(Opcode)) {
		NameFlag(OperandF(Opcode), NameF);
                LookupSymbol(FetchAddress(Address), Symbol);
                sprintf(Mnemonic, "jp %s, %s", NameF, Symbol);
        } else if(OP_JP_PHL(Opcode)) {
                sprintf(Mnemonic, "jp (HL)");
        } else if(OP_JR_B(Opcode)) {
                sprintf(Mnemonic, "jr %02x", Memory[(*Address)++]);
        } else if(OP_JR_SF_B(Opcode)) {
		NameFlag(OperandF(Opcode), NameF);
                sprintf(Mnemonic, "jr %s, %02x", NameF, Memory[(*Address)++]);
	} else if(OP_DJNZ_B(Opcode)) {
		sprintf(Mnemonic, "djnz %02x", Memory[(*Address)++]);
	} else if(OP_CPL(Opcode)) {
		sprintf(Mnemonic, "cpl");
        } else if(OP_DI(Opcode)) {
                sprintf(Mnemonic, "di");
        } else if(OP_EI(Opcode)) {
                sprintf(Mnemonic, "ei");
        } else if(OP_CALL_W(Opcode)) {
                LookupSymbol(FetchAddress(Address), Symbol);
                sprintf(Mnemonic, "call %s", Symbol);
        } else if(OP_CALL_F_W(Opcode)) {
                NameFlag(OperandF(Opcode), NameF);
                LookupSymbol(FetchAddress(Address), Symbol);
                sprintf(Mnemonic, "call %s, %s", NameF, Symbol);
        } else if(OP_RET(Opcode)) {
                sprintf(Mnemonic, "ret");
        } else if(OP_RET_F(Opcode)) {
                NameFlag(OperandF(Opcode), NameF);
                sprintf(Mnemonic, "ret %s", NameF);
        } else if(OP_EXDEHL(Opcode)) {
                sprintf(Mnemonic, "ex de, HL");
        } else if(OP_EXPSPHL(Opcode)) {
                sprintf(Mnemonic, "ex (sp), HL");
        } else if(OP_EXAFAF1(Opcode)) {
                sprintf(Mnemonic, "ex af, af'");
        } else if(OP_EXX(Opcode)) {
                sprintf(Mnemonic, "exx");
        } else if(OP_PUSH_P(Opcode)) {
		if(OperandP(Opcode)==&SP.Word) strcpy(NameP, "AF"); else NameRegisterPair(OperandP(Opcode), NameP);
                sprintf(Mnemonic, "push %s", NameP);
        } else if(OP_POP_P(Opcode)) {
                if(OperandP(Opcode)==&SP.Word) strcpy(NameP, "AF"); else NameRegisterPair(OperandP(Opcode), NameP);
                sprintf(Mnemonic, "pop %s", NameP);
	} else if(OP_RLA(Opcode)) {
		sprintf(Mnemonic, "rla");
        } else if(OP_RLCA(Opcode)) {
                sprintf(Mnemonic, "rlca");
        } else if(OP_RRCA(Opcode)) {
                sprintf(Mnemonic, "rrca");
        } else if(OP_RRA(Opcode)) {
                sprintf(Mnemonic, "rra");
        } else if(OP_IN_B(Opcode)) {
                sprintf(Mnemonic, "in a, %02x", Memory[(*Address)++]);
        } else if(OP_OUT_B(Opcode)) {
                sprintf(Mnemonic, "out %02x, a", Memory[(*Address)++]);
        } else if(OP_RST00(Opcode)) {
                sprintf(Mnemonic, "rst 0x00");
        } else if(OP_RST08(Opcode)) {
                sprintf(Mnemonic, "rst 0x08 (META)");
        } else if(OP_RST10(Opcode)) {
                sprintf(Mnemonic, "rst 0x10");
        } else if(OP_RST18(Opcode)) {
                sprintf(Mnemonic, "rst 0x18");
        } else if(OP_RST20(Opcode)) {
                sprintf(Mnemonic, "rst 0x20");
        } else if(OP_RST28(Opcode)) {
                sprintf(Mnemonic, "rst 0x28");
        } else if(OP_RST30(Opcode)) {
                sprintf(Mnemonic, "rst 0x30");
        } else if(OP_RST38(Opcode)) {
                sprintf(Mnemonic, "rst 0x38");
        } else if(OP_NOP(Opcode)) {
                sprintf(Mnemonic, "nop");
	} else if(OP_CB(Opcode)) {
		Opcode=Memory[(*Address)++];
		if(OP_CB_RLC(Opcode)) {
	                NameRegister(OperandS(Opcode), NameS);
			sprintf(Mnemonic, "rlc %s", NameS);
		} else if(OP_CB_RL(Opcode)) {
                        NameRegister(OperandS(Opcode), NameS);
                        sprintf(Mnemonic, "rl %s", NameS);
                } else if(OP_CB_RRC(Opcode)) {
                        NameRegister(OperandS(Opcode), NameS);
                        sprintf(Mnemonic, "rrc %s", NameS);
                } else if(OP_CB_SLA(Opcode)) {
                        NameRegister(OperandS(Opcode), NameS);
                        sprintf(Mnemonic, "sla %s", NameS);
		} else if(OP_CB_BIT_N_S(Opcode)) {
			NameRegister(OperandS(Opcode), NameS);
			sprintf(Mnemonic, "bit %d, %s", OPPARM_N(Opcode), NameS);
		} else {
			sprintf(Mnemonic, "???");
		}
	} else if(OP_ED(Opcode)) {
		Opcode=Memory[(*Address)++];
		if(OP_ED_LD_P_PW(Opcode)) {
			NameRegisterPair(OperandP(Opcode), NameP);
			LookupSymbol(FetchAddress(Address), Symbol);
			sprintf(Mnemonic, "ld %s, (%s)", NameP, Symbol);
		} else if(OP_ED_LD_PW_SP(Opcode)) {
			LookupSymbol(FetchAddress(Address), Symbol);
			sprintf(Mnemonic, "ld (%s), sp", Symbol);
		} else if(OP_ED_IM0(Opcode)) {
			sprintf(Mnemonic, "im 0");
                } else if(OP_ED_IM1(Opcode)) {
                        sprintf(Mnemonic, "im 1");
                } else if(OP_ED_IM2(Opcode)) {
                        sprintf(Mnemonic, "im 2");
		} else if(OP_ED_IN_R_C(Opcode)) {
			NameRegister(OperandR(Opcode), NameR);
			sprintf(Mnemonic, "in %s, (c)", NameR);
		} else {
			sprintf(Mnemonic, "???");
		}
	} else {
		sprintf(Mnemonic, "???");
	}
}


// Process an interrupt request

void ProcessIRQ() {
	Push(PC.Word);
	PC.Word=0x0038;
	InterruptRequest=FALSE;
}


// Execute the Z80 instruction pointed to by PC.

trap Step() {
	reg OldAF, OldSP, OldPC, OldBC, OldDE, OldHL, OldIX, OldIY;
	logic OldIFF1, OldIFF2;
        word Word;
	byte Byte;
	Exception=TRAP_NONE;
	IR=ReadMemory(PC.Word++);
	OldAF=AF;
	OldSP=SP;
	OldPC=PC;
	OldBC=BC;
	OldDE=DE;
	OldHL=HL;
	OldIX=IX;
	OldIY=IY;
	OldIFF1=IFF1;
	OldIFF2=IFF2;
	UsefulInstruction=FALSE;
	IndirectMemoryWrite=MemoryWrite=FALSE;
	if(EnableInterrupts) IFF1=TRUE;
	if(OP_IXPREFIX(IR)) {
	        IR=ReadMemory(PC.Word++);
		PointerReg=&IX;
		Indexing=TRUE;
		TStates+=4;
	} else if(OP_IYPREFIX(IR)) {
	        IR=ReadMemory(PC.Word++);
		PointerReg=&IY;
		Indexing=TRUE;
		TStates+=4;
	} else {
		PointerReg=&HL;
		Indexing=FALSE;
	}
	Index=0x00;
	PHLOverhead=3;
	if(OP_HLT(IR)) {
		PC.Word--;
		TStates+=4;
		UsefulInstruction=TRUE;
	} else if(OP_LD_R_S(IR)) {
		if(Indexing) Index=ReadMemory(PC.Word++);
		*OperandR(IR)=*OperandS(IR);
		TStates+=4;
	} else if(OP_LD_R_B(IR)) {
	        if(Indexing) Index=ReadMemory(PC.Word++);
		*OperandR(IR)=ReadMemory(PC.Word++);
		TStates+=7;
        } else if(OP_LD_P_W(IR)) {
                *OperandP(IR)=ReadMemory(PC.Word++)|(ReadMemory(PC.Word++)<<8);
		TStates+=10;
        } else if(OP_LD_SP_HL(IR)) {
		SP.Word=PointerReg->Word;
		TStates+=10;
	} else if(OP_LD_A_PBC(IR)) {
		AF.Bytes.H=ReadMemory(BC.Word);
		TStates+=7;
        } else if(OP_LD_A_PDE(IR)) {
                AF.Bytes.H=ReadMemory(DE.Word);
                TStates+=7;
        } else if(OP_LD_A_PW(IR)) {
                AF.Bytes.H=ReadMemory(ReadMemory(PC.Word++)|(ReadMemory(PC.Word++)<<8));
                TStates+=13;
        } else if(OP_LD_PW_A(IR)) {
                WriteMemory(ReadMemory(PC.Word++)|(ReadMemory(PC.Word++)<<8), AF.Bytes.H);
                TStates+=13;
	} else if(OP_LD_HL_PW(IR)) {
		word Address=ReadMemory(PC.Word++)|(ReadMemory(PC.Word++)<<8);
		PointerReg->Word=ReadMemory(Address)|(ReadMemory(Address+1)<<8);
		TStates+=16;
	} else if(OP_LD_PBC_A(IR)) {
		WriteMemory(BC.Word, AF.Bytes.H);
		TStates+=7;
	} else if(OP_LD_PDE_A(IR)) {
		WriteMemory(DE.Word, AF.Bytes.H);
		TStates+=7;
	} else if(OP_ADD_S(IR)) {
	        if(Indexing) Index=ReadMemory(PC.Word++);
		if(OPMOD_CARRYIN(IR)) AddByte(&AF.Bytes.H, *OperandS(IR)+(FlagC?1:0)); else AddByte(&AF.Bytes.H, *OperandS(IR));
	} else if(OP_ADD_B(IR)) {
                if(OPMOD_CARRYIN(IR)) AddByte(&AF.Bytes.H, ReadMemory(PC.Word++)+(FlagC?1:0)); else AddByte(&AF.Bytes.H, ReadMemory(PC.Word++));
                TStates+=3;
	} else if(OP_SUB_S(IR)) {
                if(Indexing) Index=ReadMemory(PC.Word++);
	        if(OPMOD_CARRYIN(IR)) SubByte(&AF.Bytes.H, *OperandS(IR)+(FlagC?1:0)); else SubByte(&AF.Bytes.H, *OperandS(IR));
		FlagN=1;
        } else if(OP_SUB_B(IR)) {
                if(OPMOD_CARRYIN(IR)) /* ... */ ;
                SubByte(&AF.Bytes.H, ReadMemory(PC.Word++));
		FlagN=1;
                TStates+=3;
	} else if(OP_ADD_HL_P(IR)) {
		AddWord(&PointerReg->Word, *OperandP(IR));
	} else if(OP_INC_R(IR)) {
	        byte* Operand; logic Negative;
		if(Indexing) Index=ReadMemory(PC.Word++);
                Operand=OperandR(IR);
		Negative=SignBit(*Operand);
		SetFlags(++(*Operand));
		if(Negative^(SignBit(*Operand))) FlagPO=!(FlagPE=TRUE); else FlagPO=!(FlagPE=FALSE);// Overflow
                FlagN=0;
		TStates+=4;
	} else if(OP_DEC_R(IR)) {
	        if(Indexing) Index=ReadMemory(PC.Word++);
		SetFlags(--(*OperandR(IR)));
		FlagN=1;
		TStates+=4;
	} else if(OP_INC_P(IR)) {
		(*OperandP(IR))++;
		TStates+=6;
	} else if(OP_DEC_P(IR)) {
	        (*OperandP(IR))--;
		TStates+=6;
	} else if(OP_AND_S(IR)) {
	        if(Indexing) Index=ReadMemory(PC.Word++);
		And(&AF.Bytes.H, *OperandS(IR));
	} else if(OP_AND_B(IR)) {
		And(&AF.Bytes.H, ReadMemory(PC.Word++));
	} else if(OP_XOR_S(IR)) {
	        if(Indexing) Index=ReadMemory(PC.Word++);
	        XOr(&AF.Bytes.H, *OperandS(IR));
        } else if(OP_XOR_B(IR)) {
                XOr(&AF.Bytes.H, ReadMemory(PC.Word++));
	} else if(OP_OR_S(IR)) {
	        if(Indexing) Index=ReadMemory(PC.Word++);
	        Or(&AF.Bytes.H, *OperandS(IR));
        } else if(OP_OR_B(IR)) {
                Or(&AF.Bytes.H, ReadMemory(PC.Word++));
	} else if(OP_CP_S(IR)) {
	        if(Indexing) Index=ReadMemory(PC.Word++);
	        Compare(&AF.Bytes.H, *OperandS(IR));
        } else if(OP_CP_B(IR)) {
                Compare(&AF.Bytes.H, ReadMemory(PC.Word++));
		TStates+=3;
	} else if(OP_JP_W(IR)) {
		JumpAbsolute(GetWordOperand());
	} else if(OP_JP_F_W(IR)) {
		Word=GetWordOperand();
		if(*OperandF(IR)) JumpAbsolute(Word); else TStates+=10;
		UsefulInstruction=TRUE;
	} else if(OP_JP_PHL(IR)) {
		PC.Word=HL.Word;
		TStates+=4;
	} else if(OP_JR_B(IR)) {
		JumpRelative(ReadMemory(PC.Word++));
	} else if(OP_JR_SF_B(IR)) {
		Byte=ReadMemory(PC.Word++);
		if(*OperandF(IR)) JumpRelative(Byte); else TStates+=7;
		UsefulInstruction=TRUE;
	} else if(OP_DJNZ_B(IR)) {
		Byte=ReadMemory(PC.Word++);
		BC.Bytes.H--;
		if(BC.Bytes.H!=0) {
			JumpRelative(Byte);		
			TStates+=1;
		} else TStates+=8;
	} else if(OP_CPL(IR)) {
		AF.Bytes.H=~AF.Bytes.H;
		FlagN=FlagH=1;
		TStates+=4;
	} else if(OP_DI(IR)) {
		IFF1=FALSE;
		TStates+=4;
	} else if(OP_EI(IR)) {
		EnableInterrupts=TRUE;
		TStates+=4;
	} else if(OP_CALL_W(IR)) {
		Call(GetWordOperand());
	} else if(OP_CALL_F_W(IR)) {
		Word=GetWordOperand();
		if(*OperandF(IR)) Call(Word); else TStates+=10;
		UsefulInstruction=TRUE;
	} else if(OP_RET(IR)) {
		Pop(&(PC.Word));
		MarkExitPoint();
	} else if(OP_RET_F(IR)) {
		if(*OperandF(IR)) {
			Pop(&PC.Word);
			TStates+=1;
		} else TStates+=5;
		UsefulInstruction=TRUE;
		MarkExitPoint();
        } else if(OP_EXDEHL(IR)) {
                Swap(&DE.Word, &HL.Word);
                TStates+=4;
        } else if(OP_EXPSPHL(IR)) {
                byte TempH, TempL;
                TempL=ReadMemory((word)(SP.Word+0));
                TempH=ReadMemory((word)(SP.Word+1));
                WriteMemory((word)(SP.Word+0), PointerReg->Bytes.L);
                WriteMemory((word)(SP.Word+1), PointerReg->Bytes.H);
                PointerReg->Bytes.H=TempH;
                PointerReg->Bytes.L=TempL;
                if(Indexing) TStates+=23; else TStates+=4;
        } else if(OP_EXAFAF1(IR)) {
                Swap(&AF.Word, &AF1.Word);
                TStates+=4;
        } else if(OP_EXX(IR)) {
                Swap(&BC.Word, &BC1.Word);
                Swap(&DE.Word, &DE1.Word);
                Swap(&HL.Word, &HL1.Word);
                TStates+=4;
        } else if(OP_PUSH_P(IR)) {
                Push((OperandP(IR)==&SP.Word)?(AF.Word):(*OperandP(IR)));
        } else if(OP_POP_P(IR)) {
		if(OperandP(IR)==&SP.Word) Pop(&AF.Word); else Pop(OperandP(IR));
	} else if(OP_RLA(IR)) {
		logic Carry;
		Carry=SignBit(AF.Bytes.H);
		AF.Bytes.H=((AF.Bytes.H)<<1)+(FlagC?1:0);
		FlagNC=!(FlagC=Carry);
		FlagN=FlagH=0;
		TStates+=4;
        } else if(OP_RLCA(IR)) {
                if(SignBit(AF.Bytes.H)) FlagNC=!(FlagC=TRUE); else FlagC=!(FlagNC=FALSE);
                AF.Bytes.H=(AF.Bytes.H)<<1+(FlagC?1:0);
		FlagN=FlagH=0;
	} else if(OP_RRCA(IR)) {
                if(AF.Bytes.H&1) FlagNC=!(FlagC=TRUE); else FlagC=!(FlagNC=FALSE);
                AF.Bytes.H=(AF.Bytes.H)>>1+(FlagC?(1<<7):(0<<7));
                FlagN=FlagH=0;
		TStates+=4;
        } else if(OP_RRA(IR)) {
                logic Carry;
                Carry=AF.Bytes.H&1;
                AF.Bytes.H=((AF.Bytes.H)>>1)+(FlagC?(1<<7):(0<<7));
                FlagNC=!(FlagC=Carry);
                FlagN=FlagH=0;
		TStates+=4;
        } else if(OP_IN_B(IR)) {
                AF.Bytes.H=ReadIO(ReadMemory(PC.Word++));
                TStates+=11;
	} else if(OP_OUT_B(IR)) {
		WriteIO(ReadMemory(PC.Word++), AF.Bytes.H);
		TStates+=11;
	} else if(OP_RST00(IR)) {
		Push(PC.Word);
		PC.Word=0x0000;
	} else if(OP_RST08(IR)) {
		MetaCall(AF.Bytes.H);
	        // Push(PC.Word);
	        // PC.Word=0x0008;
	} else if(OP_RST10(IR)) {
	        Push(PC.Word);
	        PC.Word=0x0010;
	} else if(OP_RST18(IR)) {
	        Push(PC.Word);
	        PC.Word=0x0018;
	} else if(OP_RST20(IR)) {
	        Push(PC.Word);
	        PC.Word=0x0020;
	} else if(OP_RST28(IR)) {
	        Push(PC.Word);
	        PC.Word=0x0028;
	} else if(OP_RST30(IR)) {
	        Push(PC.Word);
	        PC.Word=0x0030;
	} else if(OP_RST38(IR)) {
	        Push(PC.Word);
	        PC.Word=0x0038;
        } else if(OP_NOP(IR)) {
                TStates+=4;
		UsefulInstruction=TRUE;
        } else if(OP_CB(IR)) {
                IR=ReadMemory(PC.Word++);
		PHLOverhead=7;
                if(OP_CB_RLC(IR)) {
			if(SignBit(*OperandS(IR))) FlagNC=!(FlagC=TRUE); else FlagNC=!(FlagC=FALSE);
			*OperandS(IR)=(*OperandS(IR))<<1+(FlagC?1:0);
			SetFlags(*OperandS(IR));
			TStates+=8;
		} else if(OP_CB_RL(IR)) {
                        logic Carry;
			if(SignBit(*OperandS(IR))) Carry=TRUE; else Carry=FALSE;
                        *OperandS(IR)=(*OperandS(IR))<<1+(FlagC?1:0);
			FlagNC=!(FlagC=Carry);
                        SetFlags(*OperandS(IR));
			TStates+=8;
                } else if(OP_CB_RRC(IR)) {
                        if((*OperandS(IR))&0x01) FlagNC=!(FlagC=TRUE); else FlagNC=!(FlagC=FALSE);
                        *OperandS(IR)=(*OperandS(IR))>>1+(FlagC?0x80:0);
                        SetFlags(*OperandS(IR));
			TStates+=8;
		} else if(OP_CB_SLA(IR)) {
			if(SignBit(*OperandS(IR))) FlagNC=!(FlagC=TRUE); else FlagNC=!(FlagC=FALSE);
			*OperandS(IR)=(*OperandS(IR))<<1;
                        SetFlags(*OperandS(IR));
			FlagN=0;
			FlagH=0;
			TStates+=8;
                } else if(OP_CB_BIT_N_S(IR)) {
			FlagZ=!(FlagNZ=(*OperandS(IR))&(1<<OPPARM_N(IR)));
			FlagN=0;
			FlagH=1;
			TStates+=8;
                } else {
	                fprintf(stdout, "ERROR: Unimplemented CB opcode %02x at %04x\n", IR, PC.Word-1);
			Exception=TRAP_ILLEGAL;
	                UsefulInstruction=TRUE;
                }
	} else if(OP_ED(IR)) {
		IR=ReadMemory(PC.Word++);
		if(OP_ED_LD_P_PW(IR)) {
                        int Addr;
                        Addr=ReadMemory(PC.Word++)|(ReadMemory(PC.Word++)<<8);
			*OperandP(IR)=ReadMemory(Addr+1)|(ReadMemory(Addr)<<8); Addr+=1;
			TStates+=20;
		} else if(OP_ED_LD_PW_SP(IR)) {
	                int Addr;
			Addr=ReadMemory(PC.Word++)|(ReadMemory(PC.Word++)<<8);
			WriteMemory(Addr, SP.Bytes.L); Addr++;
			WriteMemory(Addr, SP.Bytes.L);
			TStates+=20;
		} else if(OP_ED_IM0(IR)) {
			#warning TODO: Switch to interrupt mode 0
                } else if(OP_ED_IM1(IR)) {
                        #warning TODO: Switch to interrupt mode 1
                } else if(OP_ED_IM2(IR)) {
                        #warning TODO: Switch to interrupt mode 2
		} else if(OP_ED_IN_R_C(IR)) {
			BC.Bytes.L=ReadIO(*OperandR(IR));
			TStates+=12;
		} else {
			fprintf(stdout, "ERROR: Unimplemented ED opcode %02x at %04x\n", IR, PC.Word-1);
			Exception=TRAP_ILLEGAL;
	                UsefulInstruction=TRUE;
		}
	} else {
		fprintf(stdout, "ERROR: Unimplemented simple opcode %02x at %04x\n", IR, PC.Word-1);
		Exception=TRAP_ILLEGAL;
		UsefulInstruction=TRUE;
	}
	StoreFlags();
	if(IndirectMemoryWrite) {
		MemoryAddress=PointerReg->Word+(word)(sbyte)Index;
		WriteMemory(MemoryAddress, MemoryData);
	} else if(!MemoryWrite && !UsefulInstruction && AF.Word==OldAF.Word && BC.Word==OldBC.Word && DE.Word==OldDE.Word && HL.Word==OldHL.Word && IX.Word==OldIX.Word && IY.Word==OldIY.Word && SP.Word==OldSP.Word && IFF1==OldIFF1 && IFF2==OldIFF2) {
		//fprintf(stderr, "WARNING: instruction %02x at %04x had no effect\n", IR, PC.Word-1);
		Exception=TRAP_NOEFFECT;
	}
	InstructionsExecuted++;
	if(InterruptRequest && IFF1) ProcessIRQ();
	return Exception;
}

word GetRegister(regSpec Reg) {
	switch(Reg) {
	case REG_PC: return PC.Word;
	case REG_SP: return SP.Word;
	case REG_AF: return AF.Word;
	case REG_BC: return BC.Word;
        case REG_DE: return DE.Word;
        case REG_HL: return HL.Word;
        case REG_IX: return IX.Word;
        case REG_IY: return IY.Word;
	default:
	fprintf(stderr, "Undefined register mentioned, aborting.\n");
	abort();
	}
}

inline byte GetMemoryByte(word Address) {
	return Memory[Address];
}

inline word GetMemoryWord(word Address) {
	return Memory[Address] | (Memory[Address+1]<<8);
}

inline unsigned long GetFrame() {
	return InstructionsExecuted;
}

void RaiseIRQ() {
	InterruptRequest=TRUE;
}
