#include "console.h"

void Interrupt(void) interrupt 0 {
        ConsoleWrite("A");
}
