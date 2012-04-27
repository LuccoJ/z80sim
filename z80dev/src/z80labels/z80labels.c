#include <stdio.h>
#include <string.h>

void main() {
	char Line[256];
	char LabelName[256], Address[256];
	while(!feof(stdin)) {
		fgets(Line, 256, stdin);
		if(Line[0]!=';') {
			if(Line[2]==':') {
				sscanf(&Line[3], "%s %s", Address, LabelName);
				//if(strcmp(&LabelName[strlen(LabelName)-4], "_end")) {
					printf("%s: equa %s\n\r", &LabelName[1], Address);
				//}
			}
		}
	}
	printf("fixlabels\n\r");
}
 
