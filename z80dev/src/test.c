#include <stdio.h>

void main() {
	int i;
	for(i=0; i<256; i++) {
		fprintf(stdout, "%c", i);
	}
}
