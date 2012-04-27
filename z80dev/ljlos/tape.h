#ifndef H_TAPE
#define H_TAPE

void TapeInit();
void TapeLoad(void* Start, void* End);
void TapeSave(void* Start, void* End);
void SaveBlock(void* Beginning);
void CrashAndBurn();

#endif
