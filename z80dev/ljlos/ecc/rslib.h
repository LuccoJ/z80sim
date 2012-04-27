#ifndef H_RSLIB
#define H_RSLIB

void rsencode (unsigned char m[249], unsigned char c[255]);
void rsdecode (unsigned char code[255], unsigned char mesg[249], int* errcode);

#endif
