#ifndef H_TOKENS
#define H_TOKENS

#include "types.h"

typedef int token;

extern inline logic CharDigit(char Character);
extern inline logic CharLetter(char Character);
extern inline logic CharSpace(char Character);

extern void CreateToken(const char* String, int Id);
extern token MatchToken(const char* String);
extern logic FetchToken(const char* String[], char* Token, logic (*IsDelimiter)(char));

#endif
