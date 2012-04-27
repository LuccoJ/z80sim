#include "keyboard.h"

#include "types.h"
#include "main.h"
#include "scheduling.h"
#include "sound.h"

#include "simulator.h"
#include "console.h"

char KeyTable[8];

void PollKeyboard();

char KeyboardBuffer[MAX_KEYBOARDBUFFER];
short KeyboardBufferCount;
short KeyboardPollCount;

bool KeyboardInited; void KeyboardInit() {
	if(!KeyboardInited) {
		RegisterInterrupt(PollKeyboard);
		KeyboardBufferCount=0;
		KeyboardPollCount=0;
		_SimPrintString("Keyboard initialized\n");
	}
}

void PollKeyboard() {
	char Char;
        _asm;
        push af
        push bc
        push hl
        ld bc,#0xfefe
        ld hl,#_KeyTable
        KeyboardLoop:
        in a,(c)
	cpl
        ld (hl),a
        inc hl
        rlc b
        jp c,KeyboardLoop
        pop af
        pop bc
        pop hl
        _endasm;
        if(KeyboardPollCount>0) {
                KeyboardPollCount--;
        } else {
		Char='\0';
		if(KeyTable[0]&0x02) Char='z';
		else if(KeyTable[0]&0x04) Char='x';
		else if(KeyTable[0]&0x08) Char='c';
       		else if(KeyTable[0]&0x10) Char='v';
       		if(KeyTable[1]&0x01) Char='a';
	       	else if(KeyTable[1]&0x02) Char='s';
	       	else if(KeyTable[1]&0x04) Char='d';
	        else if(KeyTable[1]&0x08) Char='f';
	        else if(KeyTable[1]&0x10) Char='g';
	        if(KeyTable[2]&0x01) Char='q';
	        else if(KeyTable[2]&0x02) Char='w';
	        else if(KeyTable[2]&0x04) Char='e';
	        else if(KeyTable[2]&0x08) Char='r';
	        else if(KeyTable[2]&0x10) Char='t';
	        if(KeyTable[3]&0x01) Char='1';
	        else if(KeyTable[3]&0x02) Char='2';
	        else if(KeyTable[3]&0x04) Char='3';
	        else if(KeyTable[3]&0x08) Char='4';
	        else if(KeyTable[3]&0x10) Char='5';
	        if(KeyTable[4]&0x01) Char='0';
	        else if(KeyTable[4]&0x02) Char='9';
	        else if(KeyTable[4]&0x04) Char='8';
	        else if(KeyTable[4]&0x08) Char='7';
	        else if(KeyTable[4]&0x10) Char='6';
	        if(KeyTable[5]&0x01) Char='p';
	        else if(KeyTable[5]&0x02) Char='o';
	        else if(KeyTable[5]&0x04) Char='i';
	        else if(KeyTable[5]&0x08) Char='u';
	        else if(KeyTable[5]&0x10) Char='y';
	        if(KeyTable[6]&0x01) Char='\n';
	        else if(KeyTable[6]&0x02) Char='l';
	        else if(KeyTable[6]&0x04) Char='k';
	        else if(KeyTable[6]&0x08) Char='j';
	        else if(KeyTable[6]&0x10) Char='h';
	        if(KeyTable[7]&0x01) Char=' ';
	        else if(KeyTable[7]&0x02) Char=' ';
	        else if(KeyTable[7]&0x04) Char='m';
	        else if(KeyTable[7]&0x08) Char='n';
	        else if(KeyTable[7]&0x10) Char='b';
		if(Char>='a' && Char<='z') if(KeyTable[0]&0x01) Char=Char+('A'-'a');
		if(Char!='\0') {
			if(KeyboardBufferCount>=MAX_KEYBOARDBUFFER) Beep(); else {
				KeyboardBuffer[KeyboardBufferCount]=Char;
				KeyboardBufferCount++;
				KeyboardPollCount=6;
			}
		}
	}
}

char GetKeypress() {
	char Keypress;
	short i;
	Pause();
	if(KeyboardBufferCount) {
		Keypress=KeyboardBuffer[0];
		for(i=1; i<KeyboardBufferCount; i++) KeyboardBuffer[i-1]=KeyboardBuffer[i];
		KeyboardBufferCount--;
	} else {
		Keypress='\0';
	}
	Resume();
	return Keypress;
}
