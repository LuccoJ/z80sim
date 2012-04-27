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


#ifndef H_BYTEOPS
#define H_BYTEOPS

#define OP_IXPREFIX(Byte)	((0xFF & (Byte)) == 0xDD)
#define OP_IYPREFIX(Byte)	((0xFF & (Byte)) == 0xFD)

#define OP_HLT(Byte)		((0xFF & (Byte)) == 0x76)

#define OP_LD_R_S(Byte)		((0xC0 & (Byte)) == 0x40)
#define OP_LD_R_B(Byte)		((0xC7 & (Byte)) == 0x06)
#define OP_LD_P_W(Byte)		((0xCF & (Byte)) == 0x01)
#define OP_LD_SP_HL(Byte)	((0xFF & (Byte)) == 0xF9)
#define OP_LD_A_PBC(Byte)	((0xFF & (Byte)) == 0x0A)
#define OP_LD_A_PDE(Byte)       ((0xFF & (Byte)) == 0x1A)
#define OP_LD_A_PW(Byte)	((0xFF & (Byte)) == 0x3A)
#define OP_LD_PW_A(Byte)	((0xFF & (Byte)) == 0x32)
#define OP_LD_HL_PW(Byte)	((0xFF & (Byte)) == 0x2A)
#define OP_LD_PBC_A(Byte)       ((0xFF & (Byte)) == 0x02)
#define OP_LD_PDE_A(Byte)	((0xFF & (Byte)) == 0x12)

#define OP_ADD_S(Byte)		((0xF0 & (Byte)) == 0x80)
#define OP_ADD_B(Byte)          ((0xF7 & (Byte)) == 0xC6)
#define OP_ADD_HL_P(Byte)	((0xCF & (Byte)) == 0x09)
#define OP_SUB_S(Byte)        	((0xF0 & (Byte)) == 0x90)
#define OP_SUB_B(Byte)		((0xF7 & (Byte)) == 0xD6)

#define OP_INC_R(Byte)		((0xC7 & (Byte)) == 0x04)
#define OP_INC_P(Byte)		((0xCF & (Byte)) == 0x03)
#define OP_DEC_R(Byte)		((0xC7 & (Byte)) == 0x05)
#define OP_DEC_P(Byte)		((0xCF & (Byte)) == 0x0B)

#define OP_AND_S(Byte)		((0xF8 & (Byte)) == 0xA0)
#define OP_AND_B(Byte)		((0xFF & (Byte)) == 0xE6)
#define OP_XOR_S(Byte)          ((0xF8 & (Byte)) == 0xA8)
#define OP_XOR_B(Byte)		((0xFF & (Byte)) == 0xEE)
#define OP_OR_S(Byte)           ((0xF8 & (Byte)) == 0xB0)
#define OP_OR_B(Byte)		((0xFF & (Byte)) == 0xF6)

#define OP_CP_S(Byte)           ((0xF8 & (Byte)) == 0xB8)
#define OP_CP_B(Byte)		((0xFF & (Byte)) == 0xFE)

#define OP_JP_W(Byte)		((0xFF & (Byte)) == 0xC3)
#define OP_JP_F_W(Byte)		((0xC7 & (Byte)) == 0xC2)
#define OP_JP_PHL(Byte)		((0xFF & (Byte)) == 0xE9)
#define OP_JR_B(Byte)		((0xFF & (Byte)) == 0x18)
#define OP_JR_SF_B(Byte)	((0xE7 & (Byte)) == 0x20)
#define OP_DJNZ_B(Byte)		((0xFF & (Byte)) == 0x10)

#define OP_CPL(Byte)		((0xFF & (Byte)) == 0x2F)

#define OP_DI(Byte)		((0xFF & (Byte)) == 0xF3)
#define OP_EI(Byte)		((0xFF & (Byte)) == 0xFB)

#define OP_NOP(Byte)		((0xFF & (Byte)) == 0x00)

#define OP_CALL_W(Byte)		((0xFF & (Byte)) == 0xCD)
#define OP_CALL_F_W(Byte)	((0xC7 & (Byte)) == 0xC4)

#define OP_RET(Byte)		((0xFF & (Byte)) == 0xC9)
#define OP_RET_F(Byte)		((0xC7 & (Byte)) == 0xC0)

#define OP_RST00(Byte)		((0xFF & (Byte)) == 0xC7)
#define OP_RST08(Byte)          ((0xFF & (Byte)) == 0xCF)
#define OP_RST10(Byte)          ((0xFF & (Byte)) == 0xD7)
#define OP_RST18(Byte)          ((0xFF & (Byte)) == 0xDF)
#define OP_RST20(Byte)          ((0xFF & (Byte)) == 0xE7)
#define OP_RST28(Byte)          ((0xFF & (Byte)) == 0xEF)
#define OP_RST30(Byte)          ((0xFF & (Byte)) == 0xF7)
#define OP_RST38(Byte)          ((0xFF & (Byte)) == 0xFF)

#define OP_PUSH_P(Byte)		((0xCF & (Byte)) == 0xC5)
#define OP_POP_P(Byte)		((0xCF & (Byte)) == 0xC1)

#define OP_IN_B(Byte)		((0xFF & (Byte)) == 0xDB)
#define OP_OUT_B(Byte)		((0xFF & (Byte)) == 0xD3)

#define OP_EXDEHL(Byte)		((0xFF & (Byte)) == 0xEB)
#define OP_EXPSPHL(Byte)	((0xFF & (Byte)) == 0xE3)
#define OP_EXAFAF1(Byte)        ((0xFF & (Byte)) == 0x08)
#define OP_EXX(Byte)		((0xFF & (Byte)) == 0xD9)

#define OP_RLCA(Byte)           ((0xFF & (Byte)) == 0x07)
#define OP_RRCA(Byte)		((0xFF & (Byte)) == 0x0F)
#define OP_RLA(Byte)		((0xFF & (Byte)) == 0x17)
#define OP_RRA(Byte)		((0xFF & (Byte)) == 0x1F)


#define OP_CB(Byte)		((0xFF & (Byte)) == 0xCB)
#define OP_ED(Byte)		((0xFF & (Byte)) == 0xED)


#define OP_CB_RLC(Byte)		((0xF8 & (Byte)) == 0x00)
#define OP_CB_RL(Byte)		((0xF8 & (Byte)) == 0x10)
#define OP_CB_RRC(Byte)		((0xF8 & (Byte)) == 0x08)

#define OP_CB_SLA(Byte)		((0xF8 & (Byte)) == 0x20)

#define OP_CB_BIT_N_S(Byte)	((0xC0 & (Byte)) == 0x40)


#define OP_ED_LD_P_PW(Byte)	((0xCF & (Byte)) == 0x4B)
#define OP_ED_LD_PW_SP(Byte)	((0xFF & (Byte)) == 0x73)

#define OP_ED_IM0(Byte)		((0xFF & (Byte)) == 0x46)
#define OP_ED_IM1(Byte)		((0xFF & (Byte)) == 0x56)
#define OP_ED_IM2(Byte)		((0xFF & (Byte)) == 0x5E)

#define OP_ED_IN_R_C(Byte)	((0xC7 & (Byte)) == 0x40)

#define OPMOD_CARRYIN(Byte)	((0xA8 & (Byte)) == 0x88)
#define OPMOD_BYTEARG(Byte)	((0x47 & (Byte)) == 0x46)

#define OPARG_R_B(Byte)		((0x38 & (Byte)) == 0x00)
#define OPARG_R_C(Byte)		((0x38 & (Byte)) == 0x08)
#define OPARG_R_D(Byte)         ((0x38 & (Byte)) == 0x10)
#define OPARG_R_E(Byte)         ((0x38 & (Byte)) == 0x18)
#define OPARG_R_H(Byte)         ((0x38 & (Byte)) == 0x20)
#define OPARG_R_L(Byte)         ((0x38 & (Byte)) == 0x28)
#define OPARG_R_PHL(Byte)	((0x38 & (Byte)) == 0x30)
#define OPARG_R_A(Byte)         ((0x38 & (Byte)) == 0x38)

#define OPARG_S_B(Byte)         ((0x07 & (Byte)) == 0x00)
#define OPARG_S_C(Byte)         ((0x07 & (Byte)) == 0x01)
#define OPARG_S_D(Byte)         ((0x07 & (Byte)) == 0x02)
#define OPARG_S_E(Byte)         ((0x07 & (Byte)) == 0x03)
#define OPARG_S_H(Byte)         ((0x07 & (Byte)) == 0x04)
#define OPARG_S_L(Byte)         ((0x07 & (Byte)) == 0x05)
#define OPARG_S_PHL(Byte)       ((0x07 & (Byte)) == 0x06)
#define OPARG_S_A(Byte)         ((0x07 & (Byte)) == 0x07)

#define OPARG_P_BC(Byte)	((0x30 & (Byte)) == 0x00)
#define OPARG_P_DE(Byte)        ((0x30 & (Byte)) == 0x10)
#define OPARG_P_HL(Byte)        ((0x30 & (Byte)) == 0x20)
#define OPARG_P_SP(Byte)        ((0x30 & (Byte)) == 0x30)

#define OPARG_F_NZ(Byte)	((0x38 & (Byte)) == 0x00)
#define OPARG_F_Z(Byte)         ((0x38 & (Byte)) == 0x08)
#define OPARG_F_NC(Byte)        ((0x38 & (Byte)) == 0x10)
#define OPARG_F_C(Byte)         ((0x38 & (Byte)) == 0x18)
#define OPARG_F_PO(Byte)        ((0x38 & (Byte)) == 0x20)
#define OPARG_F_PE(Byte)        ((0x38 & (Byte)) == 0x28)
#define OPARG_F_P(Byte)         ((0x38 & (Byte)) == 0x30)
#define OPARG_F_M(Byte)         ((0x38 & (Byte)) == 0x38)

#define OPARG_SF_NZ(Byte)       ((0x18 & (Byte)) == 0x00)
#define OPARG_SF_Z(Byte)        ((0x18 & (Byte)) == 0x08)
#define OPARG_SF_NC(Byte)       ((0x18 & (Byte)) == 0x10)
#define OPARG_SF_C(Byte)        ((0x18 & (Byte)) == 0x18)

#define OPPARM_N(Byte)		(0x38 & Byte)

#endif
