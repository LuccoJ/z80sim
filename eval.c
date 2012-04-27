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


#include "eval.h"

#include "types.h"
#include "sizes.h"
#include "cpu.h"
#include <stdio.h>

#include "parser.h"
#include <assert.h>
#include <string.h>

short OperandsTaken[OperatorCount]={
	1,  // OP_NONE
	1,  // OP_END
	0,  // OP_LEFTPAR
	1,  // OP_RIGHTPAR
	1,  // OP_DEREFERENCE
	1,  // OP_SYMBOL
	2,  // OP_SUM
	2,  // OP_SUBTRACT
	2,  // OP_AND
	2,  // OR_OR
	2,  // OP_XOR
	2,  // OP_NOT
	2,  // OP_EQUAL
	2,  // OP_NOTEQUAL
	2,  // OP_SMALLER
	2,  // OP_GREATER
	2,  // OP_SMALLEROREQ
	2   // OP_GREATEROREQ
};

logic StringifyExpression(operation* Expr, char* StringForm) {
	char OpString[2][MAX_NAME];
	int i;
	for(i=0; i<OperandsTaken[Expr->Operator]; i++) {
		switch(Expr->Operands[i].Type) {
			char Symbol[MAX_NAME];
		case VAL_SYMBOL:
			LookupSymbol(Expr->Operands[i].Contents.Word, Symbol);
			sprintf(OpString[i], "%s", Symbol);
			break;
		case VAL_WORD:
			if(Expr->Operands[i].Contents.Word<10) sprintf(OpString[i], "%d", Expr->Operands[i].Contents.Word);
			else sprintf(OpString[i], "0x%04x", Expr->Operands[i].Contents.Word);
			break;
		case VAL_REGISTER:
			switch(Expr->Operands[i].Contents.Register) {
			case REG_AF:
				sprintf(OpString[i], "$AF");
				break;
			case REG_BC:
                                sprintf(OpString[i], "$BC");
                                break;
                        case REG_DE:
                                sprintf(OpString[i], "$DE");
                                break;
                        case REG_HL:
                                sprintf(OpString[i], "$HL");
                                break;
                        case REG_IX:
                                sprintf(OpString[i], "$IX");
                                break;
                        case REG_IY:
                                sprintf(OpString[i], "$IY");
                                break;
                        case REG_SP:
                                sprintf(OpString[i], "$SP");
                                break;
                        case REG_PC:
                                sprintf(OpString[i], "$PC");
                                break;
			default:
				fprintf(stdout, "Unprintable register\n");
				return FALSE;
			}
			break;
		case VAL_SUBEXPR:
			if(!StringifyExpression(Expr->Operands[i].Contents.Subexpr, OpString[i])) {
				fprintf(stdout, "Unprintable subexpression\n");
				return FALSE;
			}
			break;
		default:
			fprintf(stdout, "Unprintable value type %d\n", Expr->Operands[i].Type);
			return FALSE;
		}
	}	
	switch(Expr->Operator) {
	case OP_NONE:
		sprintf(StringForm, "(%s)", OpString[0]);
		break;
	case OP_DEREFERENCE:
		sprintf(StringForm, "*(%s)", OpString[0]);
		break;
	case OP_SYMBOL:
		sprintf(StringForm, "%s", OpString[0]);
		break;
	case OP_NOT:
		sprintf(StringForm, "~(%s)", OpString[0]);
		break;
	case OP_SUM:
		sprintf(StringForm, "(%s+%s)", OpString[0], OpString[1]);
		break;
	case OP_SUBTRACT:
		sprintf(StringForm, "(%s-%s)", OpString[0], OpString[1]);
		break;
	case OP_AND:
		sprintf(StringForm, "(%s&%s)", OpString[0], OpString[1]);
		break;
	case OP_OR:
		sprintf(StringForm, "(%s|%s)", OpString[0], OpString[1]);
		break;
	case OP_XOR:
		sprintf(StringForm, "(%s^%s)", OpString[0], OpString[1]);
		break;
	case OP_EQUAL:
		sprintf(StringForm, "(%s==%s)", OpString[0], OpString[1]);
		break;
        case OP_NOTEQUAL:
                sprintf(StringForm, "(%s!=%s)", OpString[0], OpString[1]);
                break;
        case OP_SMALLER:
                sprintf(StringForm, "(%s<%s)", OpString[0], OpString[1]);
                break;
        case OP_GREATER:
                sprintf(StringForm, "(%s>%s)", OpString[0], OpString[1]);
                break;
        case OP_SMALLEROREQ:
                sprintf(StringForm, "(%s<=%s)", OpString[0], OpString[1]);
                break;
        case OP_GREATEROREQ:
                sprintf(StringForm, "(%s>=%s)", OpString[0], OpString[1]);
                break;
	default:
		fprintf(stdout, "Unprintable operation %d\n", Expr->Operator);
		return FALSE;
	}
	return TRUE;
}

void ApplyCommutative(operation* Expr) {
        value Temp=Expr->Operands[0];
        Expr->Operands[0]=Temp;
        Expr->Operands[1]=Expr->Operands[0];
}

void ApplyAssociative(operation* Expr, short Operand) {
        value Temp;
        assert(Expr->Operands[Operand].Type==VAL_SUBEXPR);
        Temp=Expr->Operands[Operand].Contents.Subexpr->Operands[1];
        Expr->Operands[Operand].Contents.Subexpr->Operands[1]=Expr->Operands[!Operand];
        Expr->Operands[!Operand]=Temp;
}

/*
void SimplifyExpression(operation* Expr) {
        if(Expr->Operands[0].Type==VAL_SUBEXPR && Expr->Operands[1].Type==VAL_WORD) {
                ApplyAssociative(Expr, 0);
        } else if(Expr->Operands[0].Type==VAL_S && Expr->Operands[1].Type==VAL_WORD) {
                ApplyAssociative(Expr, 1);
        }
}
*/

word EvaluateExpression(operation* Expr) {
	word Op[2];
	int i;
	for(i=0; i<OperandsTaken[Expr->Operator]; i++) {
		switch(Expr->Operands[i].Type) {
		case VAL_WORD:
		case VAL_SYMBOL:
			Op[i]=Expr->Operands[i].Contents.Word;
			break;
		case VAL_REGISTER:
			Op[i]=GetRegister(Expr->Operands[i].Contents.Register);
			break;
		case VAL_SUBEXPR:
			Op[i]=EvaluateExpression(Expr->Operands[i].Contents.Subexpr);
			break;
		default:
			fprintf(stdout, "Value of type %d cannot be evaluated\n", Expr->Operands[i].Type);
			Op[i]=0;
		}
	}
	switch(Expr->Operator) {
	case OP_NONE:        return Op[0];
	case OP_DEREFERENCE: return GetMemoryByte(Op[0]);
	case OP_SYMBOL:      return GetMemoryByte(Op[0]);
	case OP_SUM:         return (Op[0]+Op[1])%MAX_WORD;
	case OP_SUBTRACT:    return (Op[0]-Op[1])%MAX_WORD;
	case OP_AND:         return Op[0]&Op[1];
	case OP_OR:          return Op[0]|Op[1];
	case OP_XOR:         return Op[0]^Op[1];
	case OP_NOT:         return ~Op[0];
	case OP_EQUAL:       return Op[0]==Op[1];
        case OP_NOTEQUAL:    return Op[0]!=Op[1];
        case OP_SMALLER:     return Op[0]<Op[1];
        case OP_GREATER:     return Op[0]>Op[1];
        case OP_SMALLEROREQ: return Op[0]<=Op[1];
        case OP_GREATEROREQ: return Op[0]>=Op[1];
	default:
		fprintf(stdout, "Operator %d can't evaluate its operands\n", Expr->Operator);
		return 0;
	}
}
