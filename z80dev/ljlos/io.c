#include "io.h"

#include "console.h"
#include "keyboard.h"

int GetLine(char* String) {
	int i;
	char Character[2];
	Character[1]='\0';
	i=0;
	do {
		Character[0]=GetKeypress();
		if(Character[0]!='\0') {
			ConsoleWrite(Character);
			String[i]=Character[0];
			i++;
		}
	} while(Character[0]!='\n');
       	String[i]='\0';
	return i;
}
