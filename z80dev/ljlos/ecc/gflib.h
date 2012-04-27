#ifndef H_GFLIB
#define H_GFLIB

unsigned char gfmul (unsigned char mul1, unsigned char mul2);
unsigned char gfinv (unsigned char ivt);
unsigned char gfexp (unsigned char mant, unsigned char powr);
#define gfadd(add1, add2) ((add1)^(add2))


#endif
