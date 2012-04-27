#include <stdlib.h>
#include <stdio.h>

#define MAX_STRING 1024

struct {
	FILE* Elements[256];
	short Count;
} Listings;

int main(int argc, char* argv[]) {
	int i;
	Listings.Count=0;
	fprintf(stdout, "Sources\n");
	for(i=1; i<argc; i++) {
		Listings.Elements[Listings.Count]=fopen(argv[i], "r");
		if(Listings.Elements[Listings.Count]) {
			fprintf(stdout, "\t%d %s\n", Listings.Count, argv[i]);
                        Listings.Count++;
		}
	}
	fprintf(stdout, "EndSources\n");
	for(i=0; i<Listings.Count; i++) {
		FILE* Handle=Listings.Elements[i];
                char FileLine[MAX_STRING];
		fprintf(stderr, "Doing file %d\n", i);
		do {
			int j;
			unsigned char Character;
			unsigned int Address;
			char FileName[MAX_STRING];
			char SourceLine[MAX_STRING];
			char LineNumberStr[MAX_STRING];
			while(isspace(Character=fgetc(Handle)));
			if(!isdigit(Character)) continue;
			while(isdigit(Character=fgetc(Handle)));
			if(Character!=' ') continue;
			if(fgetc(Handle)!=';') continue;
			j=0; while(isalpha(Character=fgetc(Handle))) FileName[j++]=Character;
			if(j==0) continue;
			FileName[j]='\0';
			if(Character!='.') continue;
			if(fgetc(Handle)!='c') continue;
			if(fgetc(Handle)!=':') continue;
			j=0; while(isdigit(Character=fgetc(Handle))) LineNumberStr[j++]=Character;
			LineNumberStr[j]='\0';
			if(Character!=':') continue;
			if(fgetc(Handle)!=' ') continue;
			fgets(SourceLine, MAX_STRING, Handle);
			fprintf(stderr, "%s", SourceLine);
			while(fgets(FileLine, MAX_STRING, Handle)) {
				char* StrippedLine;
				j=0;
				while(FileLine[j]==' ') j++;
				if(j<7 && (Address=strtol(&FileLine[j], &StrippedLine, 16))) {
					int LineNumber=strtol(LineNumberStr, NULL, 0);
					if(isxdigit((unsigned char)StrippedLine[1]) && isxdigit((unsigned char)StrippedLine[2])) {
						fprintf(stdout, "0x%04x S %d %d %s", Address, i, LineNumber, SourceLine); 
						break;
					}
				}
			}
		} while(fgets(FileLine, MAX_STRING, Handle)!=NULL);
	}
}
