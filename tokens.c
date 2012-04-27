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


#include "tokens.h"

#include <stdlib.h>
#include <limits.h>

#include <assert.h>

struct Tokens {
	struct Tokens* Characters[UCHAR_MAX];
	int TokenId;
};

tokens* NewTree() {
	tokens* Tree;
	int i;
	Tree=malloc(sizeof(tokens));
	if(Tree!=NULL) {
		for(i=0; i<UCHAR_MAX; i++) Tree->Characters[i]=NULL;
		Tree->TokenId=0;
	}
	return Tree;
}

tokens* CreateTokenTable() {
	return NewTree();
}

void CreateToken(tokens* Branch, const char* Lexeme, int Id) {
	int i;
	assert(Branch && Lexeme);
	for(i=0; i<strlen(Lexeme); i++) {
		if(Branch->Characters[Lexeme[i]]==NULL) Branch->Characters[Lexeme[i]]=NewTree();
		Branch=Branch->Characters[Lexeme[i]];
	}
	Branch->TokenId=Id;
}

int ExtractToken(const tokens* Branch, const char** Expression, char* Lexeme, logic Completion) {
	const char* String=*Expression;
	int i;
	assert(Branch && Expression && *Expression);
	for(i=0; i<strlen(String); i++) {
		if(Branch->Characters[String[i]]==NULL) break;
                Branch=Branch->Characters[String[i]];
		if(Lexeme!=NULL) Lexeme[i]=String[i];
	}
        *Expression+=i;
	if(Branch->TokenId==0 && Completion) {
		int BranchesFound;
		int Attempt;
		char TakenBranch;
		do {
			BranchesFound=0;
			for(Attempt=0; Attempt<UCHAR_MAX; Attempt++) {
				if(Branch->TokenId==0 && Branch->Characters[Attempt]!=NULL) {
					BranchesFound++;
					TakenBranch=(char)Attempt;
				}
				if(BranchesFound>1) break;
			}
			if(BranchesFound==1) {
				Branch=Branch->Characters[TakenBranch];
				if(Lexeme!=NULL) Lexeme[i++]=TakenBranch;
			}
		} while(BranchesFound==1);
	}
	if(Lexeme!=NULL) Lexeme[i]='\0';
	return Branch->TokenId;
}

logic ExtractFreeform(const tokens* Branch, const char** Expression, char* Freeform) {
	int i;
	assert(Branch && Expression && *Expression && Freeform);
	while(ExtractToken(Branch, Expression, Freeform, FALSE)==0 && strlen(Freeform)!=0);
	for(i=0; i<strlen(*Expression); i++) {
		int Id;
		const char* TrimmedExpression;
		TrimmedExpression=&(*Expression)[i];
		Id=ExtractToken(Branch, &TrimmedExpression, NULL, FALSE);
		if(&(*Expression)[i]!=TrimmedExpression) break;
		assert(Id==0);
		if(Freeform!=NULL) Freeform[i]=(*Expression)[i];
	}
	*Expression+=i;
	Freeform[i]='\0';
	if(i>0) return TRUE; else return FALSE;
}
