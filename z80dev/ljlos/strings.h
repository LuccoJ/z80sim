#ifndef H_STRINGS
#define H_STRINGS

#include "types.h"

int StringLength(char*);
void StringWrite(char* Destination, char* Source);
bool SameString(char*, char*);
void IntToString(int, char*);
void WordToString(unsigned int, char*);
void WordToHex(unsigned int, char*);

#endif
