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


#include "symbols.h"

#include "sizes.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define MAX_SOURCES 16384

logic InString(const char* String, const char* Part);

char* Symbols[SIZE_MEMORY];

source SourceCode[SIZE_MEMORY];

void InitSymbols() {
	int i;
	for(i=0; i<SIZE_MEMORY; i++) {
		Symbols[i]=NULL;
		SourceCode[i].File=NULL;
	}
}

logic InString(const char* String, const char* Part) {
        size_t i, j;
        logic Found=FALSE;
        if(strlen(Part)>strlen(String)) return FALSE;
        for(i=0; i<strlen(String); i++) {
                for(j=0; j<strlen(Part); j++) {
                        Found=TRUE;
                        if(Part[j]!=String[i+j]) {
                                Found=FALSE;
                                break;
                        }
                }
                if(Found) return TRUE;
        }
        return FALSE;
}

logic LoadSymbols(FILE* Handle) {
        char Line[MAX_STRING];
        char Name[MAX_NAME];
        word Address;
        if(!Handle) return FALSE;
	while(fgets(Line, MAX_STRING, Handle)) {
                if(strlen(Line)>7) if(Line[2]==':' && Line[7]==' ') {
                        sscanf(Line, "00:%04hx %s", &Address, Name);
                        if(Symbols[Address]==NULL || (!InString(Name, "_start") && !InString(Name, "_end"))) {
                                Symbols[Address]=malloc(strlen(Name)+1);
                                if(Symbols[Address]==NULL) return FALSE;
				strcpy(Symbols[Address], &Name[1]);
                        }
                }
        }
	return TRUE;
}

void LoadSourcePointers(FILE* Handle) {
	FILE* Handles[MAX_SOURCES];
	char Line[MAX_STRING];
	char Token[MAX_NAME];
	while(fgets(Line, MAX_STRING, Handle)) {
		sscanf(Line, "%s", Token);
		if(!strcmp(Token, "Sources")) break;
	}
	while(fgets(Line, MAX_STRING, Handle)) {
		int FileNumber;
		char FileName[MAX_NAME];
		sscanf(Line, "%s", Token);
		if(!strcmp(Token, "EndSources")) break;
		sscanf(Line, "%d %s", &FileNumber, FileName);
		Handles[FileNumber]=fopen(FileName, "r");
		if(!Handles[FileNumber]) fprintf(stderr, "Could NOT open %s, file number %d\n", FileName, FileNumber);
	}
	while(fgets(Line, MAX_STRING, Handle)) {
		int FileNumber;
		int Address;
		unsigned int SourceLine;
		sscanf(Line, "%x S %d %d", &Address, &FileNumber, &SourceLine);
		Address%=SIZE_MEMORY;
		SourceCode[Address].File=Handles[FileNumber];
		SourceCode[Address].Line=SourceLine;
	}
}

source SearchSource(word Address) {
	word i=Address;
	while(SourceCode[i].File==NULL && i>0) i--;
	return SourceCode[i];
}

logic HasSource(word Address) {
	if(SourceCode[Address].File!=NULL) return TRUE;
	else return FALSE;
}

logic SearchSymbol(word Address, char* Name) {
        word i=Address;
        while(Symbols[i]==NULL && i>0) i--;
	if(Symbols[i]) {
		strcpy(Name, Symbols[i]);
		return TRUE;
	} else return FALSE;
}

logic LookupSymbol(word Address, char* Name) {
        if(Symbols[Address]==NULL) {
		sprintf(Name, "0x%04x", Address);
		return FALSE;
	} else {
		strcpy(Name, Symbols[Address]);
		return TRUE;
	}
}

word GetSymbol(const char* Name) {
	static word CachedAddress=0;
	int i;
	if(Symbols[CachedAddress]) if(!strcmp(Symbols[CachedAddress], Name)) return CachedAddress;
	for(i=0; i<SIZE_MEMORY; i++) {
		if(Symbols[i]) if(!strcmp(Symbols[i], Name)) return CachedAddress=(word)i;
	}
	return 0;
}

logic ExistsSymbol(const char* Name) {
	if(Symbols[0]) if(!strcmp(Symbols[0], Name)) return TRUE;
	if(GetSymbol(Name)!=0) return TRUE; else return FALSE;
}
