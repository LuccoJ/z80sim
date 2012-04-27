#include <stdio.h>

void main() {
	int i=0;
	while(!feof(stdin) && i<0x4000) {
		fputc(fgetc(stdin), stdout);
		i++;
	}
	while(i<0x4000) {
		fputc(0xFF, stdout);
		i++;
	}
}
