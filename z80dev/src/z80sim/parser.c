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


#include "parser.h"

#include "types.h"
#include "sizes.h"
#include "symbols.h"
#include "tokens.h"
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include <assert.h>

#define MAX_OPERATORS 256
#define MAX_VALUES 256
#define MAX_TOKEN 64


// A terminal is simply the internal representation of a token; thus it can be an operator
// or a value. TERM_NONE is used to return error condition, while TERM_EMPTY indicates that
// a new token should be parsed and a new terminal representation generated.

typedef struct {
	enum {
		TERM_NONE,
		TERM_EMPTY,
		TERM_OPERATOR,
		TERM_VALUE
	} Type;
	union {
		operator Operator;
		value Value;
	} Contents;
} terminal;


// Actions are chosen depending on the last fetched operator and the operator on top of the
// stack. Actions for every combination are defined in OperandsTable. ACT_NONE is an error.

typedef enum {
	ACT_NONE,
	ACT_SHIFT,
	ACT_REDUCE,
	ACT_ACCEPT
} action;


// When the action to perform on an operator is ACT_SHIFT, the representation of an
// operator is pushed on top of OperatorsStack. The operator on top of it is popped out
// when an ACT_REDUCE is performed.

static struct {
	operator Value[MAX_OPERATORS];
	int Top;
} OperatorsStack;


// As soon as it has been estabilished that a token is a value, its representation is
// pushed on top of ValuesStack. The (two) value(s) on top of ValuesStack are replaced
// by a result when an ACT_REDUCE is performed.

static struct {
        value Value[MAX_VALUES];
        int Top;
} ValuesStack;


// Operations defined on the two stacks

// Initialize an empty stack
static void InitOperatorsStack(void);
static void InitValuesStack(void);

// Push an operator on the stack
static void PushOperatorsStack(operator);
static void PushValuesStack(value);

// Pop an operator from the stack
static operator PopOperatorsStack(void);
static value PopValuesStack(void);

// Return the operator on top of the stack
static operator PeekOperatorsStack(void);
static value PeekValuesStack(void);


// Operations on expressions

// Reduce the operation on top of the stacks to its representation
static operation* Reduce(void);

// Parse the first operator or value found in *Expression, and strip it out from *Expression
static terminal ParseToken(const char** Expression);

// When we encounter an operator (Input) during parsing, we can decide to
// 1) shift it into the operators stack, and leave it there for the moment
// 2) reduce the (two) value(s) we have on top of the values stack to their result
// 3) accept the value on top of the values stack (hopefully the only value there) as our result
// 4) leave both stacks alone and think hard about how to tell the user that she's done a mistake
// We take this decision based on what operator (Stack) is on top of the operator stack.

#define N ACT_NONE
#define S ACT_SHIFT
#define R ACT_REDUCE
#define A ACT_ACCEPT

static action OperatorsTable[OperatorCount][OperatorCount]={
/////////////////////////////////////////////////////////////////////////////////
//  ?  §  (  )  *  s  +  -  &  |  ~  !  == != <  >  <= >=  //  Input  /  Stack //
/////////////////////////////////////////////////////////////////////////////////
   {N, N, N, N, N, N, N, N, N, N, N, N, N, N, N, N, N, N}, // ?  (None)        //
   {N, A, S, R, S, S, S, S, S, S, S, S, S, S, S, S, S, S}, // §  (End)         //
   {N, N, S, S, S, R, S, S, S, S, S, S, S, S, S, S, S, S}, // (  (LeftPar)     //
   {N, R, N, R, R, R, R, R, R, R, R, R, R, R, R, R, R, R}, // )  (RightPar)    //
   {N, R, S, R, R, R, R, R, R, R, R, R, R, R, R, R, R, R}, // *  (Dereference) //
   {N, R, N, R, R, R, R, R, R, R, R, R, R, R, R, R, R, R}, // s  (SymbolDeref) //
   {N, R, S, R, S, R, R, R, S, S, S, S, R, R, R, R, R, R}, // +  (Sum)         //
   {N, R, S, R, S, R, R, R, S, S, S, S, R, R, R, R, R, R}, // -  (Subtract)    //
   {N, R, S, R, S, R, R, R, R, R, R, R, R, R, R, R, R, R}, // &  (And)         //
   {N, R, S, R, S, R, R, R, R, R, R, R, R, R, R, R, R, R}, // |  (Or)          //
   {N, R, S, R, S, R, R, R, R, R, R, R, R, R, R, R, R, R}, // ~  (XOr)         //
   {N, R, S, R, S, R, R, R, R, R, R, R, R, R, R, R, R, R}, // !  (Not)         //
   {N, R, S, R, S, R, S, S, S, S, S, S, R, R, R, R, R, R}, // =  (Equal)       //
   {N, R, S, R, S, R, S, S, S, S, S, S, R, R, R, R, R, R}, // != (NotEqual)    //
   {N, R, S, R, S, R, S, S, S, S, S, S, R, R, R, R, R, R}, // <  (Smaller)     //
   {N, R, S, R, S, R, S, S, S, S, S, S, R, R, R, R, R, R}, // >  (Greater)     //
   {N, R, S, R, S, R, S, S, S, S, S, S, R, R, R, R, R, R}, // <= (SmallerOrEq) //
   {N, R, S, R, S, R, S, S, S, S, S, S, R, R, R, R, R, R}, // >= (GreaterOrEq) //
/////////////////////////////////////////////////////////////////////////////////
};

#undef N
#undef S
#undef R
#undef A


// Token contexts for the parser
static tokens* OpTokens;
static tokens* RegTokens;


void InitParser() {
	OpTokens=CreateTokenTable();
	CreateToken(OpTokens, " ", 0);
	CreateToken(OpTokens, "(", OP_LEFTPAR);
	CreateToken(OpTokens, ")", OP_RIGHTPAR);
	CreateToken(OpTokens, "*", OP_DEREFERENCE);
	CreateToken(OpTokens, "+", OP_SUM);
	CreateToken(OpTokens, "-", OP_SUBTRACT);
	CreateToken(OpTokens, "&", OP_AND);
	CreateToken(OpTokens, "|", OP_OR);
	CreateToken(OpTokens, "~", OP_NOT);
	CreateToken(OpTokens, "==", OP_EQUAL);
	CreateToken(OpTokens, "!=", OP_NOTEQUAL);
	CreateToken(OpTokens, "<", OP_SMALLER);
	CreateToken(OpTokens, ">", OP_GREATER);
	CreateToken(OpTokens, "<=", OP_SMALLEROREQ);
	CreateToken(OpTokens, ">=", OP_GREATEROREQ);
        RegTokens=CreateTokenTable();
	CreateToken(RegTokens, " ", 0);
	CreateToken(RegTokens, "$AF", REG_AF);
	CreateToken(RegTokens, "$BC", REG_BC);
	CreateToken(RegTokens, "$DE", REG_DE);
	CreateToken(RegTokens, "$HL", REG_HL);
	CreateToken(RegTokens, "$IX", REG_IX);
	CreateToken(RegTokens, "$IY", REG_IY);
	CreateToken(RegTokens, "$PC", REG_PC);
	CreateToken(RegTokens, "$SP", REG_SP);
}

void InitOperatorsStack() {
	OperatorsStack.Top=0;
}

void InitValuesStack() {
	ValuesStack.Top=0;
}

void PushOperatorsStack(operator Op) {
	assert(OperatorsStack.Top<MAX_OPERATORS);
	OperatorsStack.Value[OperatorsStack.Top++]=Op;
}

void PushValuesStack(value Val) {
        assert(ValuesStack.Top<MAX_VALUES);
	ValuesStack.Value[ValuesStack.Top++]=Val;
}

operator PopOperatorsStack() {
	assert(OperatorsStack.Top>0);
	return OperatorsStack.Value[--OperatorsStack.Top];
}

value PopValuesStack() {
	assert(ValuesStack.Top>0);
	return ValuesStack.Value[--ValuesStack.Top];
}

operator PeekOperatorsStack() {
	assert(OperatorsStack.Top>0);
	return OperatorsStack.Value[OperatorsStack.Top-1];
}

value PeekValuesStack() {
	assert(ValuesStack.Top>0);
	return ValuesStack.Value[ValuesStack.Top-1];
}

terminal ParseToken(const char** Expression) {
	operator Operator;
	value Value;
	terminal Terminal;
	Operator=OP_NONE;
	Value.Type=VAL_NONE;
	Operator=ExtractToken(OpTokens, Expression, NULL, FALSE);
	if(Operator==OP_NONE) {
		if((*Expression)[0]=='\0') Operator=OP_END; else {
	                Value.Contents.Register=ExtractToken(RegTokens, Expression, NULL, FALSE);
			if(Value.Contents.Register!=REG_NONE) Value.Type=VAL_REGISTER; else {
				char Symbol[MAX_STRING];
				ExtractFreeform(OpTokens, Expression, Symbol);
				if(isdigit((unsigned char)Symbol[0])) {
       	                 		Value.Type=VAL_WORD;
       	                 		Value.Contents.Word=(word)(strtol(Symbol, NULL, 0)%MAX_WORD);
				} else if(ExistsSymbol(Symbol)) {
					Value.Type=VAL_SYMBOL;
       	                 		Value.Contents.Word=GetSymbol(Symbol);
				} else {
       	                 		fprintf(stderr, "Wrong value '%s'\n", Symbol);
       	                 		Value.Type=VAL_NONE;
       	        		}
			}
		}
	}
	// Either we have a value or an operator. In both cases, we assign what we have to Terminal,
	// which is what we'll return. If we have no value *and* no operator, something is wrong.
	if(Value.Type!=VAL_NONE) {
		Terminal.Type=TERM_VALUE;
		Terminal.Contents.Value=Value;
	} else if(Operator!=OP_NONE) {
		Terminal.Type=TERM_OPERATOR;
		Terminal.Contents.Operator=Operator;
	} else Terminal.Type=TERM_NONE;
	return Terminal;
}

operation* Reduce() {
	// We'll put a value back in the stack. It can be a 'real' value, or a subexpression that cannot
	// be evaluated at parsing time.
        value Value;
	// We return a subexpression in any case; if we can actually compute a real value, the
	// subexpression consists of the operator OP_NONE and of the real value in Operands[0].
	operation* Subexpression=malloc(sizeof(operation));
	if(Subexpression==NULL) return NULL;
	Subexpression->Operator=PopOperatorsStack();
	switch(Subexpression->Operator) {
	case OP_END:
		Subexpression->Operator=OP_NONE;
		Subexpression->Operands[0]=PopValuesStack();
		if(ValuesStack.Top!=0) fprintf(stderr, "More than one value in stack at end of parsing\n");
		break;
	case OP_RIGHTPAR:
		assert(PopOperatorsStack()==OP_LEFTPAR);
		break;
	case OP_DEREFERENCE:
	case OP_SYMBOL:
		Subexpression->Operands[0]=PopValuesStack();
		break;
	case OP_SUM:
	case OP_SUBTRACT:
	case OP_EQUAL:
        case OP_NOTEQUAL:
        case OP_SMALLER:
        case OP_GREATER:
	case OP_SMALLEROREQ:
	case OP_GREATEROREQ:
                Subexpression->Operands[1]=PopValuesStack();
                Subexpression->Operands[0]=PopValuesStack();
		break;
	default:
		fprintf(stderr, "Operator not implemented\n");
		return NULL;
	}
	if(Subexpression->Operator==OP_NONE) {
		Value.Type=VAL_WORD;
		Value.Contents.Word=Subexpression->Operands[0].Contents.Word;
	} else {
		Value.Type=VAL_SUBEXPR;
		Value.Contents.Subexpr=Subexpression;
	}
	PushValuesStack(Value);
	return Subexpression;
}

operation* ParseExpression(char const* Expression) {
	terminal Terminal;
	logic SyntaxError=FALSE;
	operation* Representation=NULL;
	{
		operator EndOperator=OP_END;
		InitOperatorsStack();
		InitValuesStack();
		PushOperatorsStack(EndOperator);
	}
	Terminal.Type=TERM_EMPTY;
	do {
		switch(Terminal.Type) {
		case TERM_EMPTY:
                        Terminal=ParseToken(&Expression);
			break;
		case TERM_VALUE:
			PushValuesStack(Terminal.Contents.Value);
                        if(Terminal.Contents.Value.Type==VAL_SYMBOL) {
				Terminal.Type=TERM_OPERATOR;
				Terminal.Contents.Operator=OP_SYMBOL;
			} else Terminal.Type=TERM_EMPTY;
			break;
		case TERM_OPERATOR:
			switch(OperatorsTable[PeekOperatorsStack()][Terminal.Contents.Operator]) {
			case ACT_SHIFT:
				if(Terminal.Contents.Operator==OP_RIGHTPAR) assert(PopOperatorsStack()==OP_LEFTPAR);
				else PushOperatorsStack(Terminal.Contents.Operator);
				Terminal.Type=TERM_EMPTY;
				break;
			case ACT_REDUCE:
				Representation=Reduce();
				break;
			case ACT_ACCEPT:
				if(Representation==NULL) Representation=Reduce();
				return Representation;
			default:
				fprintf(stdout, "Unknown action requested\n");
				return NULL;
			}
			break;
		default:
			fprintf(stdout, "No terminal symbol\n");
			return NULL;
		}
	} while(!SyntaxError);
	fprintf(stdout, "Syntax error\n");
	return NULL;
}

logic FreeExpression(operation* Expr) {
	int i;
	if(Expr==NULL) return FALSE;
	for(i=0; i<2; i++) {
		if(Expr->Operands[i].Type==VAL_SUBEXPR) {
			if(!FreeExpression(Expr->Operands[i].Contents.Subexpr)) return FALSE;
		}
	}
	free(Expr);
	return TRUE;
}
