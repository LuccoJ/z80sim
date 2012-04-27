#include "console.h"

#include "screen.h"
#include "keyboard.h"
#include "strings.h"
#include "locks.h"
#include "scheduling.h"

#include "simulator.h"

short Row, Column;
short CursorRow, CursorColumn;

lock ConsoleLock;

void ConsoleCursor(short Row, short Column);

bool ConsoleInited; void ConsoleInit() {
	if(!ConsoleInited) {
		LocksInit();
		ScreenClear(0, 7);
		Row=0; Column=0;
		CursorRow=0; CursorColumn=0;
		ConsoleLock=LockCreate();
		ConsoleWrite("(C) 2003 LORENZO J. LUCCHINI\n\n\n");
		ConsoleInited=TRUE;
		_SimPrintString("Console initialized, lock number ");
		_SimPrintWord((unsigned int)ConsoleLock);
		_SimPrintString("\n");
	}
}

void CursorDraw(short Row, short Column) {
//	CursorRow=Row; CursorColumn=Column;
        PutCharacter(' ', Row, Column);
        SetAttrib((1<<7)|(1<<3)|(7<<0), Row, Column);
}

void CursorUndraw() {
	SetAttrib(0, CursorRow, CursorColumn);
}

/*

void ScrollUp() {
	_asm;
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	ld b,#0x17
L0E00:  CALL    L0E9B           ; routine CL-ADDR gets screen address in HL.
        LD      C,#0x08           ; there are 8 pixel lines to scroll.

;; CL-SCR-1
L0E05:  PUSH    BC              ; save counters.
        PUSH    HL              ; and initial address.
        LD      A,B             ; get line count.
        AND     #0x07             ; will set zero if all third to be scrolled.
        LD      A,B             ; re-fetch the line count.
        JR      NZ,L0E19        ; forward to CL-SCR-3 if partial scroll.

; HL points to top line of third and must be copied to bottom of previous 3rd.
; ( so HL = $4800 or $5000 ) ( but also sometimes $4000 )

;; CL-SCR-2
L0E0D:  EX      DE,HL           ; copy HL to DE.
        LD      HL,#0xF8E0        ; subtract $08 from H and add $E0 to L -
        ADD     HL,DE           ; to make destination bottom line of previous
                                ; third.
        EX      DE,HL           ; restore the source and destination.
        LD      BC,#0x0020        ; thirty-two bytes are to be copied.
        DEC     A               ; decrement the line count.
        LDIR                    ; copy a pixel line to previous third.

;; CL-SCR-3
L0E19:  EX      DE,HL           ; save source in DE.
        LD      HL,#0xFFE0        ; load the value -32.
        ADD     HL,DE           ; add to form destination in HL.
        EX      DE,HL           ; switch source and destination
        LD      B,A             ; save the count in B.
        AND     #0x07             ; mask to find count applicable to current
        RRCA                    ; third and
        RRCA                    ; multiply by
        RRCA                    ; thirty two (same as 5 RLCAs)

        LD      C,A             ; transfer byte count to C ($E0 at most)
        LD      A,B             ; store line count to A
        LD      B,#0x00           ; make B zero
        LDIR                    ; copy bytes (BC=0, H incremented, L=0)
        LD      B,#0x07           ; set B to 7, C is zero.
        ADD     HL,BC           ; add 7 to H to address next third.
        AND     #0xF8             ; has last third been done ?
        JR      NZ,L0E0D        ; back to CL-SCR-2 if not.

        POP     HL              ; restore topmost address.
        INC     H               ; next pixel line down.
        POP     BC              ; restore counts.
        DEC     C               ; reduce pixel line count.
        JR      NZ,L0E05        ; back to CL-SCR-1 if all eight not done.

        CALL    L0E88           ; routine CL-ATTR gets address in attributes
                                ; from current 'ninth line', count in BC.

        LD      HL,#0xFFE0        ; set HL to the 16-bit value -32.
        ADD     HL,DE           ; and add to form destination address.
        EX      DE,HL           ; swap source and destination addresses.
        LDIR                    ; copy bytes scrolling the linear attributes.
        LD      B,#0x01           ; continue to clear the bottom line.

;; CL-LINE
L0E44:  PUSH    BC              ; save line count
        CALL    L0E9B           ; routine CL-ADDR gets top address
        LD      C,#0x08           ; there are eight screen lines to a text line.

;; CL-LINE-1
L0E4A:  PUSH    BC              ; save pixel line count
        PUSH    HL              ; and save the address
        LD      A,B             ; transfer the line to A (1-24).

;; CL-LINE-2
L0E4D:  AND     #0x07             ; mask 0-7 to consider thirds at a time
        RRCA                    ; multiply
        RRCA                    ; by 32  (same as five RLCA instructions)
        RRCA                    ; now 32 - 256(0)
        LD      C,A             ; store result in C
        LD      A,B             ; save line in A (1-24)
        LD      B,#0x00           ; set high byte to 0, prepare for ldir.
        DEC     C               ; decrement count 31-255.
        LD      D,H             ; copy HL
        LD      E,L             ; to DE.
        LD      (HL),#0x00        ; blank the first byte.
        INC     DE              ; make DE point to next byte.
        LDIR                    ; ldir will clear lines.
        LD      DE,#0x0701        ; now address next third adjusting
        ADD     HL,DE           ; register E to address left hand side
        DEC     A               ; decrease the line count.
        AND     #0xF8             ; will be 16, 8 or 0  (AND $18 will do).
        LD      B,A             ; transfer count to B.
        JR      NZ,L0E4D        ; back to CL-LINE-2 if 16 or 8 to do
                                ; the next third.

        POP     HL              ; restore start address.
        INC     H               ; address next line down.
        POP     BC              ; fetch counts.
        DEC     C               ; decrement pixel line count
        JR      NZ,L0E4A        ; back to CL-LINE-1 till all done.

        CALL    L0E88           ; routine CL-ATTR gets attribute address
                                ; in DE and B * 32 in BC.

        LD      H,D             ; transfer the address
        LD      L,E             ; to HL.

        INC     DE              ; make DE point to next location.

        LD      A,(0x5C8D)       ; fetch ATTR_P - permanent attributes
        BIT     0,0x02(iy)      ; test TV_FLAG  - lower screen in use ?
        JR      Z,L0E80         ; skip to CL-LINE-3 if not.

        LD      A,(0x5C48)       ; else lower screen uses BORDCR as attribute.

;; CL-LINE-3
L0E80:  LD      (HL),A          ; put attribute in first byte.
        DEC     BC              ; decrement the counter.
        LDIR                    ; copy bytes to set all attributes.
        POP     BC              ; restore the line $01-$24.
        LD      C,#0x21           ; make column $21. (No use is made of this)
        RET                     ; return to the calling routine.

;; CL-ATTR
L0E88:  LD      A,H             ; fetch H to A - $48, $50, or $58.
        RRCA                    ; divide by
        RRCA                    ; eight.
        RRCA                    ; $09, $0A or $0B.
        DEC     A               ; $08, $09 or $0A.
        OR      #0x50             ; $58, $59 or $5A.
        LD      H,A             ; save high byte of attributes.

        EX      DE,HL           ; transfer attribute address to DE
        LD      H,C             ; set H to zero - from last LDIR.
        LD      L,B             ; load L with the line from B.
        ADD     HL,HL           ; multiply
        ADD     HL,HL           ; by
        ADD     HL,HL           ; thirty two
        ADD     HL,HL           ; to give count of attribute
        ADD     HL,HL           ; cells to the end of display.

        LD      B,H             ; transfer the result
        LD      C,L             ; to register BC.

        RET                     ; return.

;; CL-ADDR
L0E9B:  LD      A,#0x18           ; reverse the line number
        SUB     B               ; to range $00 - $17.
        LD      D,A             ; save line in D for later.
        RRCA                    ; multiply
        RRCA                    ; by
        RRCA                    ; thirty-two.

        AND     #0xE0             ; mask off low bits to make
        LD      L,A             ; L a multiple of 32.

        LD      A,D             ; bring back the line to A.

        AND     #0x18             ; now $00, $08 or $10.

        OR      #0x40             ; add the base address of screen.

        LD      H,A             ; HL now has the correct address.
	RET

endscroll:	

        pop iy
	pop ix
	pop hl
	pop de
	pop bc
	pop af
	_endasm;
}

*/

void ScrollUp() {
	unsigned int j, k, l;
	register unsigned short i;
	unsigned int Sum;
	for(l=0; l<6114; l+=2048) {
		for(k=0; k<224; k+=32) {
			for(j=0; j<2048; j+=256) {
				Sum=j+k+l;
	                        for(i=0; i<32; i++) {
        	                        ScreenMemory[i+Sum]=ScreenMemory[32+i+Sum];
                        	}
			}
		}
                for(j=0; j<2048; j+=256) {
                        for(i=0; i<32; i++) {
                                ScreenMemory[i+j+224+l]=ScreenMemory[32+i+j+0+l+2048];
                        }
                }
	}
}

void ConsoleWrite(char* String) {
        int i;
	int Length;
        LockObtain(ConsoleLock);
 	// CursorUndraw();
	Length=StringLength(String);
	for(i=0; i<Length; i++) {
		if(Row>23) {
			Row=23;
			ScrollUp();
		}
                if(String[i]=='\n') {
                        Row++;
                        Column=0;
                } else {
                        PutCharacter(String[i], Row, Column);
                        if(Column==31) {
                                Row++;
                                Column=0;
                        } else Column++;
                }
        }
	// ConsoleCursor(Row, Column+1);
	LockRelease(ConsoleLock);
	_SimPrintString(String);
}

unsigned short ConsoleReadLine(char* String) {
        unsigned short i;
        char Character[2];
        Character[1]='\0';
        i=0;
	ConsoleWrite("#");
        do {
                Character[0]=GetKeypress();
                if(Character[0]!='\0') {
                        ConsoleWrite(Character);
                        String[i]=Character[0];
                        i++;
                }
        } while(Character[0]!='\n' && i<256);
        String[i-1]='\0';
        return i;
}
