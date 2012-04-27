typedef struct {
	char* Start;
	size_t Size;
} text;

text TextNew(const char String[]) {
	text Object;
	Object.Size=sizeof(String);
	Object.Start=malloc(Object.Size);
	strcpy(Object.Start, String);
	return Object;
}

void TextFree(text Object) {
	free(Object.Start);
}

void TextAppend(text Text, ) {
	
