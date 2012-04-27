#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
        int Spaces=atoi(argv[1]);
        char Line[512];
        int i;
	short Meaningful;
        while(!feof(stdin)) {
		Meaningful=0;
                fgets(Line, 512, stdin);
                for(i=0; i<strlen(Line); i++) {
			if(Line[i]>0x21 && Line[i]<0x7e) {
				Meaningful=1;
				break;
			}
		}
                if(!feof(stdin) && Meaningful) {
                        for(i=0; i<Spaces; i++) printf(" ");
                        printf("%s", Line);
                }
        }
}

