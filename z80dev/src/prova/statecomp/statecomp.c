#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <assert.h>

#define MAX_NAME 64
#define MAX_VARS 64

typedef enum {FALSE, TRUE} bool;

bool NoDifferences;

typedef struct {
	unsigned int Count;
	char Name[MAX_NAME][MAX_VARS];
	char Value[MAX_NAME][MAX_VARS];
} varList;

typedef struct {
	unsigned long Number;
	varList Vars;
} frame;

void AddVariable(frame* Frame, char* Name, char* Value) {
	strcpy(Frame->Vars.Name[Frame->Vars.Count], Name);
	strcpy(Frame->Vars.Value[Frame->Vars.Count], Value);
	Frame->Vars.Count++;
}

char* GetVariable(frame* Frame, char* Name) {
	int i;
	for(i=0; i<Frame->Vars.Count; i++) {
		if(!strcmp(Frame->Vars.Name[i], Name)) {
			return Frame->Vars.Value[i];
		}
	}
	return NULL;
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
		strcpy(VarName, Token);
		fscanf(Handle, "%s", Token);
		if(Token[0]=='<' && Token[strlen(Token)-1]=='>') {
			strcpy(VarValue, &Token[1]);
			VarValue[strlen(VarValue)-1]='\0';
			AddVariable(Frame, VarName, VarValue);
		} else {
			/* error */
		}
                fscanf(Handle, "%s", Token);
	}
}

void ReportDifference(unsigned long FrameNumber, char* VarName, char* VarValue1, char* VarValue2) {
        if(NoDifferences) {
                NoDifferences=FALSE;
                fprintf(stderr, "At frame %ld states diverge\n", FrameNumber);
        }
        fprintf(stderr, "\t%s <%s> (log 1) - <%s> (log 2)\n", VarName, VarValue1, VarValue2);
}


bool CompareFrames(frame* Frame1, frame* Frame2) {
	int i;
	char* Var1;
	char* Var2;
	for(i=0; i<Frame1->Vars.Count; i++) {
		Var1=Frame1->Vars.Value[i];
		Var2=GetVariable(Frame2, Frame1->Vars.Name[i]);
		if(Var2) {
			if('0'<=Var1[0] && Var1[0]<='9' && '0'<=Var2[0] && Var2[0]<='9') {
				if(strtol(Var1, NULL, 0)!=strtol(Var2, NULL, 0)) {
					ReportDifference(Frame1->Number, Frame1->Vars.Name[i], Var1, Var2);
				}
			} else {
				if(strcmp(Var1, Var2)) {
                                        ReportDifference(Frame1->Number, Frame1->Vars.Name[i], Var1, Var2);
				}
			}
		}
	}
	return NoDifferences;
}

int main(int argc, char* argv[]) {
	FILE* Log1;
	FILE* Log2;
	frame CurrentFrame1;
	frame CurrentFrame2;
	bool HoldLog1;
	bool HoldLog2;
	HoldLog1=HoldLog2=FALSE;
	NoDifferences=TRUE;
	if(argc!=3) {
		fprintf(stderr, "Requires 2 arguments\n");
		exit(1);
	}
	Log1=fopen(argv[1], "r");
	if(!Log1) {
		fprintf(stderr, "Could not open file '%s'\n", argv[1]);
		exit(1);
	}
        Log2=fopen(argv[2], "r");
        if(!Log2) {
                fprintf(stderr, "Could not open file '%s'\n", argv[2]);
                exit(1);
        }
	while(!feof(Log1) && !feof(Log2)) {
		if(!HoldLog1) ParseFrame(Log1, &CurrentFrame1); else HoldLog1=FALSE;
		if(!HoldLog2) ParseFrame(Log2, &CurrentFrame2); else HoldLog2=FALSE;
		if(CurrentFrame1.Number==CurrentFrame2.Number) {
			if(!CompareFrames(&CurrentFrame1, &CurrentFrame2)) exit(0);
		} else {
			if(CurrentFrame1.Number>CurrentFrame2.Number) {
				fprintf(stderr, "Frame number %ld does not appear in log 1\n", CurrentFrame2.Number);
				HoldLog1=TRUE;
			} else {
                                fprintf(stderr, "Frame number %ld does not appear in log 2\n", CurrentFrame1.Number);
                                HoldLog2=TRUE;
			}
		}
	}
	fprintf(stderr, "Logs match\n");
	exit(0);
}
