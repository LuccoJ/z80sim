#include "hash.h"

#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <limits.h>
#include <assert.h>

typedef struct Page {
	char* String;
	token Id;
	struct Page* Next;
} page;

page* Tokens[UCHAR_MAX];


logic SameToken(const char* Token1, const char* Token2);
void AddPage(unsigned char Hash, const char* String, token Token);
unsigned char CalculateHash(const char*);

logic CharDigit(char Character) {
	if(isdigit((unsigned char)Character)) return TRUE;
	else return FALSE;
}

logic CharLetter(char Character) {
        if(isalpha((unsigned char)Character)) return TRUE;
        else return FALSE;
}

logic CharSpace(char Character) {
        if(isspace((unsigned char)Character)) return TRUE;
        else return FALSE;
}

logic FetchToken(const char* String[], char* Token, logic (*IsDelimiter)(char)) {
	size_t i;
	assert(String!=NULL);
	assert(Token!=NULL);
	i=0;
	while(IsDelimiter((*String)[i])) i++;
	while(i<strlen(*String)) {
		if(IsDelimiter((*String)[i])) break;
		else Token[i]=(*String)[i];
		i++;
	}
	Token[i]='\0';
	*String+=i+1;
	return TRUE;
}

logic SameToken(const char* Token1, const char* Token2) {
	if(strlen(Token1)!=strlen(Token2)) return FALSE; else {
		size_t i;
		for(i=0; i<strlen(Token1); i++) {
			if(Token1[i]!=Token2[i]) return FALSE;
		}
		return TRUE;
	}
}

void AddPage(unsigned char Hash, const char* String, token Id) {
	page* NewPage;
	NewPage=malloc(sizeof(page));
	NewPage->Next=Tokens[Hash];
	NewPage->String=malloc(strlen(String)+1);
	strcpy(NewPage->String, String);
	NewPage->Id=Id;
	Tokens[Hash]=NewPage;
}

unsigned char CalculateHash(const char* String) {
	unsigned char Hash=0;
	int i;
        for(i=0; i<strlen(String); i++) {
                Hash^=String[i];
        }
	return Hash;
}

void CreateToken(const char* String, token Id) {
	static logic Initialized=FALSE;
	if(!Initialized) {
		int i;
		for(i=0; i<UCHAR_MAX; i++) Tokens[i]=0;
		Initialized=TRUE;
	}
	AddPage(CalculateHash(String), String, Id);
}

token MatchToken(const char* String) {
	page* Page=Tokens[CalculateHash(String)];
	while(Page!=NULL) {
		if(SameToken(Page->String, String)) return Page->Id;
		Page=Page->Next;
	}
	return 0;
}
