#ifndef H_SCREEN
#define H_SCREEN

#define ScreenMemory ((char *)0x4000)
#define AttribMemory ((char *)0x5800)

#define SCRATTR_FLASH (1<<7)
#define SCRATTR_BLACKPAPER (7<<3)
#define SCRATTR_WHITEINK (1)

typedef short color;

void ScreenClear(color Paper, color Ink);
void PutCharacter(char, short Row, short Column);
void SetAttrib(char Attrib, short Row, short Column);
void PutString(char*, short Row, short Column);

#endif
