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


#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <assert.h>

#define MAX_NAME 64
#define MAX_VARS 64
#define MAX_CONDS 64
#define NO_CONDITION "No condition"

typedef enum {FALSE, TRUE} bool;

bool NoDifferences;

typedef struct {
	char Name[MAX_NAME];
	char Value[MAX_NAME];
} variable;

typedef struct {
	short Count;
	variable Elements[MAX_VARS];
} variables;

typedef struct {
	unsigned long Number;
	variables Vars;
} frame;

typedef enum {condNULL, condFALSE, condTRUE, condEQUAL, condDIFFERENT} condType;

typedef struct {
	condType Type;
	char* TestVar;
	char* TestValue;
	char* Variable;
} condition;

typedef struct {
	condition Elements[MAX_CONDS];
	short Count;
} conditions;

conditions Conditions;
variables RememberedVars;

void AddCondition(condType Type, char* TestVar, char* TestValue, char* Variable) {
	Conditions.Elements[Conditions.Count].Type=Type;
	if(TestVar) {
		Conditions.Elements[Conditions.Count].TestVar=malloc(sizeof(TestVar)+1);
		strcpy(Conditions.Elements[Conditions.Count].TestVar, TestVar);
	} else Conditions.Elements[Conditions.Count].TestVar=NULL;
	if(TestValue) {
	        Conditions.Elements[Conditions.Count].TestValue=malloc(sizeof(TestValue)+1);
	        strcpy(Conditions.Elements[Conditions.Count].TestValue, TestValue);
	} else Conditions.Elements[Conditions.Count].TestValue=NULL;
	if(Variable) {
	        Conditions.Elements[Conditions.Count].Variable=malloc(sizeof(Variable)+1);
        	strcpy(Conditions.Elements[Conditions.Count].Variable, Variable);
	} else Conditions.Elements[Conditions.Count].Variable=NULL;
	Conditions.Count++;
}


void AddVariable(frame* Frame, char* Name, char* Value) {
	strcpy(Frame->Vars.Elements[Frame->Vars.Count].Name, Name);
	strcpy(Frame->Vars.Elements[Frame->Vars.Count].Value, Value);
	Frame->Vars.Count++;
}

char* GetVariable(frame* Frame, char* Name) {
	short i;
	for(i=0; i<Frame->Vars.Count; i++) {
		if(!strcmp(Frame->Vars.Elements[i].Name, Name)) {
			return Frame->Vars.Elements[i].Value;
		}
	}
	return NULL;
}

void ScanValue(FILE* Handle, char* Value) {
	short i;
	while(fgetc(Handle)!='<');
        i=0; while((Value[i]=fgetc(Handle))!='>') i++;
	Value[i]='\0';
}

unsigned long SkipFrame(FILE* Handle) {
	unsigned long Number;
	char Token[MAX_NAME];
	do {
		do fscanf(Handle, "%s", Token); while(strcmp(Token, "Frame"));
		fscanf(Handle, "%ld", &Number);
		fscanf(Handle, "%s", Token);
	} while(strcmp(Token, "Begin"));
	do fscanf(Handle, "%s", Token); while(strcmp(Token, "End"));
	return Number;
}

void ParseFrame(FILE* Handle, frame* Frame) {
	char Token[MAX_NAME];
	char VarName[MAX_NAME];
	char VarValue[MAX_NAME];
	do fscanf(Handle, "%s", Token); while(!feof(Handle) && strcmp(Token, "Frame"));
	if(feof(Handle)) exit(1);
	fscanf(Handle, "%ld", &(Frame->Number));
	fscanf(Handle, "%s", Token);
	if(strcmp(Token, "Begin")) fprintf(stderr, "No 'Begin' at frame %ld\n", Frame->Number);
        fscanf(Handle, "%s", Token);
	Frame->Vars.Count=0;
	while(strcmp(Token, "End") && !feof(Handle)) {
		int i;
		strcpy(VarName, Token);
		ScanValue(Handle, VarValue);
		AddVariable(Frame, VarName, VarValue);
                fscanf(Handle, "%s", Token);
	}
}

void ReportDifference(frame* Frame1, frame* Frame2, char* VarName) {
	int i;
	for(i=0; i<Conditions.Count; i++) {
	        if(!strcmp(Conditions.Elements[i].Variable, VarName)) {
			char* ConditionValue;
			ConditionValue=GetVariable(Frame1, Conditions.Elements[i].TestVar);
			switch(Conditions.Elements[i].Type) {
			case condNULL:
				return;
				break;
			case condFALSE:
				if(ConditionValue) if(!strcmp(ConditionValue, "FALSE")) return;
				break;
			case condTRUE:
    	   	         	if(ConditionValue) if(!strcmp(ConditionValue, "TRUE")) return;
        	        	break;
			case condEQUAL:
				if(ConditionValue) if(!strcmp(ConditionValue, Conditions.Elements[i].TestValue)) return;
				break;
			case condDIFFERENT:
				if(ConditionValue) if(strcmp(ConditionValue, Conditions.Elements[i].TestValue)) return;
				break;
			}
		}
	}
        if(NoDifferences) {
		int Count=0;
		char Values[MAX_NAME];
                NoDifferences=FALSE;
                fprintf(stderr, "At frame %ld states diverge\n", Frame1->Number);
		for(i=0; i<Frame1->Vars.Count; i++) {
			char* VarName;
			char* Var1;
			char* Var2;
			VarName=Frame1->Vars.Elements[i].Name;
                	Var1=GetVariable(Frame1, VarName);
                	Var2=GetVariable(Frame2, VarName);
			if(Var2) {
				if(!strcmp(Var1, Var2)) {
					sprintf(Values, "<%s>1,2", Var1);
				} else {
					sprintf(Values, "<%s>1 <%s>2", Var1, Var2);
				}
			} else {
				sprintf(Values, "<%s>1", Var1);
			}
			fprintf(stderr, "\t%-10s %-20s", VarName, Values);
			Count++;
			if(Count%2==0) fprintf(stderr, "\n");
		}
		for(i=0; i<Frame2->Vars.Count; i++) {
			if(!GetVariable(Frame1, Frame2->Vars.Elements[i].Name)) {
				sprintf(Values, "<%s>2", GetVariable(Frame2, Frame2->Vars.Elements[i].Name));
                                fprintf(stderr, "\t%-10s %-20s", Frame2->Vars.Elements[i].Name, Values);
        	                Count++;
	                        if(Count%2==0) fprintf(stderr, "\n");
			}
		}
		if(Count%2!=0) fprintf(stderr, "\n");
		fprintf(stderr, "Relevant differences:\n");
	}
        fprintf(stderr, "\t%s <%s> (log 1) - <%s> (log 2)\n", VarName, GetVariable(Frame1, VarName), GetVariable(Frame2, VarName));
}


bool CompareFrames(frame* Frame1, frame* Frame2) {
	int i;
	char* Var1;
	char* Var2;
	for(i=0; i<Frame1->Vars.Count; i++) {
		Var1=Frame1->Vars.Elements[i].Value;
		Var2=GetVariable(Frame2, Frame1->Vars.Elements[i].Name);
		if(Var2) {
			if('0'<=Var1[0] && Var1[0]<='9' && '0'<=Var2[0] && Var2[0]<='9') {
				if(strtol(Var1, NULL, 0)!=strtol(Var2, NULL, 0)) {
					ReportDifference(Frame1, Frame2, Frame1->Vars.Elements[i].Name);
				}
			} else {
				if(strcmp(Var1, Var2)) {
                                        ReportDifference(Frame1, Frame2, Frame1->Vars.Elements[i].Name);
				}
			}
		}
	}
	return NoDifferences;
}

void ParseConfig(FILE* Handle) {
	condType CondType;
	char CondVar[MAX_NAME], CondValue[MAX_NAME];
	char Token[MAX_NAME];
	while(!feof(Handle)) {
		fscanf(Handle, "%s", Token); if(feof(Handle)) return;
		CondType=condNULL;
		CondVar[0]='\0';
		CondValue[0]='\0';
		if(!strcmp(Token, "Remember")) {
			fscanf(Handle, "%s", Token);
			strcpy(RememberedVars.Elements[RememberedVars.Count++].Name, Token);
		} else {
			if(!strcmp(Token, "If")) {
				fscanf(Handle, "%s", Token);
				if(!strcmp(Token, "Eq")) {
					fscanf(Handle, "%s", CondVar);
					ScanValue(Handle, CondValue);
					fscanf(Handle, "%s", Token);
					CondType=condEQUAL;
				} else if(!strcmp(Token, "NotEq")) {
	       	                        fscanf(Handle, "%s", CondVar);
	       	                        ScanValue(Handle, CondValue);
	                                fscanf(Handle, "%s", Token);
	                                CondType=condDIFFERENT;
				} else if(Token[0]=='!') {
					strcpy(CondVar, &Token[1]);
					fscanf(Handle, "%s", Token);
					CondType=condFALSE;
				} else {
					strcpy(CondVar, Token);
			                fscanf(Handle, "%s", Token);
					CondType=condTRUE;
				}
			}
			if(!strcmp(Token, "Ignore")) {
				fscanf(Handle, "%s", Token);
				AddCondition(CondType, CondVar, CondValue, Token);
			} else {
				fprintf(stderr, "Wrong command '%s'\n", Token);
				exit(1);
			}
		}
	}
}


// !!! This does *NOT* work correctly when there are missing frames in (one of) the log(s).
// The bug might be here on in main()

void ForwardToFrame(unsigned long Frame, FILE* Log1, FILE* Log2) {
	unsigned long FrameNumber1=0, FrameNumber2=0;
	long Position1, Position2;
        while(FrameNumber1<Frame && FrameNumber2<Frame && !feof(Log1) && !feof(Log2)) {
                if(Frame-FrameNumber1>2) fseek(Log1, (Frame-FrameNumber1-2)*strlen("Frame n Begin End")-2, SEEK_CUR);
                if(Frame-FrameNumber2>2) fseek(Log2, (Frame-FrameNumber2-2)*strlen("Frame n Begin End")-2, SEEK_CUR);
		Position1=ftell(Log1);
		Position2=ftell(Log2);
                FrameNumber1=SkipFrame(Log1);
                FrameNumber2=SkipFrame(Log2);
		if(FrameNumber1>=Frame) fseek(Log1, Position1, SEEK_SET);
		if(FrameNumber2>=Frame) fseek(Log2, Position2, SEEK_SET);
                while(FrameNumber1<FrameNumber2) FrameNumber1=SkipFrame(Log1);
                while(FrameNumber2<FrameNumber1) FrameNumber2=SkipFrame(Log2);
        }
}

int main(int argc, char* argv[]) {
	FILE* Log1;
	FILE* Log2;
	FILE* Opt;
	unsigned long StartFrame;
	frame CurrentFrame1;
	frame CurrentFrame2;
	unsigned long OldFrameNumber;
	bool HoldLog1;
	bool HoldLog2;
	HoldLog1=HoldLog2=FALSE;
	NoDifferences=TRUE;
	RememberedVars.Count=0;
	if(argc!=5) {
		fprintf(stderr, "Requires 4 arguments\n");
		exit(1);
	}
	StartFrame=strtol(argv[1], NULL, 0);
	Log1=fopen(argv[2], "r");
	if(!Log1) {
		fprintf(stderr, "Could not open file '%s'\n", argv[1]);
		exit(1);
	}
        Log2=fopen(argv[3], "r");
        if(!Log2) {
                fprintf(stderr, "Could not open file '%s'\n", argv[2]);
                exit(1);
        }
	Opt=fopen(argv[4], "r");
	if(!Opt) {
		fprintf(stderr, "Could not open options file '%s'\n", argv[3]);
		exit(1);
	}
	ParseConfig(Opt);
	fclose(Opt);
	if(StartFrame!=0) {
		fprintf(stderr, "Skipping initial frames...\n", StartFrame);
		ForwardToFrame(StartFrame-1, Log1, Log2);
	}
	fprintf(stderr, "Comparing logs at frame %d...\n", StartFrame);
	while(!feof(Log1) && !feof(Log2)) {
		int i;
		if(!HoldLog1) ParseFrame(Log1, &CurrentFrame1); else HoldLog1=FALSE;
		if(!HoldLog2) ParseFrame(Log2, &CurrentFrame2); else HoldLog2=FALSE;
		if(CurrentFrame1.Number==CurrentFrame2.Number) {
			if(!CompareFrames(&CurrentFrame1, &CurrentFrame2)) {
				int i;
				fprintf(stderr, "At previous frame (%d):\n", OldFrameNumber);
				for(i=0; i<RememberedVars.Count; i++) {
					fprintf(stderr, "\t%-10s <%s>\n", RememberedVars.Elements[i].Name, RememberedVars.Elements[i].Value);
				}
				exit(0);
			}
		} else {
			if(CurrentFrame1.Number>CurrentFrame2.Number) {
				fprintf(stderr, "Frame number %ld does not appear in log 1\n", CurrentFrame2.Number);
				HoldLog1=TRUE;
			} else {
                                fprintf(stderr, "Frame number %ld does not appear in log 2\n", CurrentFrame1.Number);
                                HoldLog2=TRUE;
			}
		}
		OldFrameNumber=CurrentFrame1.Number;
		for(i=0; i<RememberedVars.Count; i++) {
			strcpy(RememberedVars.Elements[i].Value, GetVariable(&CurrentFrame1, RememberedVars.Elements[i].Name));
		}
	}
	fprintf(stderr, "Logs match\n");
	exit(0);
}
