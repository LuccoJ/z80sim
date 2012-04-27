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


#ifndef H_EVAL
#define H_EVAL

#include "types.h"
#include "cpu.h"

// This structure is declared since we refer to it from the declaration of the type
// 'value'. This is because the type 'operation', which will be defined later as this
// structure, contains a reference to the type 'value'.

struct Operation;


// A value can be either a word (an immediate value), a register (the value is that of the
// register at the time of evaluation) or a subexpression (an operator and its operands).
// VAL_NONE is used as an error condition.

typedef struct {
        enum {
                VAL_NONE,
                VAL_SUBEXPR,
                VAL_REGISTER,
                VAL_WORD,
		VAL_SYMBOL
        } Type;
        union {
                regSpec Register;
                word Word;
                struct Operation* Subexpr;
        } Contents;
} value;


// OP_NONE is an operator used for subexpressions that are actually direct values.
// OperatorCount is not an operator, but is used to count how many operators there are.

typedef enum {
        OP_NONE,
        OP_END,
	OP_LEFTPAR,
	OP_RIGHTPAR,
        OP_DEREFERENCE,
	OP_SYMBOL,
        OP_SUM,
        OP_SUBTRACT,
        OP_AND,
        OP_OR,
        OP_XOR,
        OP_NOT,
	OP_EQUAL,
	OP_NOTEQUAL,
	OP_SMALLER,
	OP_GREATER,
	OP_SMALLEROREQ,
	OP_GREATEROREQ,
        OperatorCount
} operator;


// An operation or subexpression is made by an operator and its operand (Operands[0]) or its
// two operands (Operands[0] and Operands[1]).

typedef struct Operation {
        operator Operator;
        value Operands[2];
} operation;


// Scan a representation Expression of an expression and put in StringForm a string that, if
// parsed, would generate a representation equivalent to Expression.

logic StringifyExpression(operation* Expression, char* StringForm);

#endif
