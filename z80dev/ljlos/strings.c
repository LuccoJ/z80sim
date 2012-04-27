#include "strings.h"

#include "memory.h"

int StringLength(char* String) {
        int i;
	i=0;
        while(String[i]!='\0') i++;
        return i;
}

void StringWrite(char* Destination, const char* Source) {
	MemoryCopy((void*)Destination, (void*)Source, StringLength(Source));
}

bool SameString(char* String1, char* String2) {
	int i;
	i=0;
	while(String1[i]!='\0') {
		if(String1[i]!=String2[i]) return FALSE;
		i++;
	}
	return TRUE;
}

unsigned int Mod(unsigned int Dividend, unsigned int Divisor) {
	unsigned int Temp;
	Temp=Dividend;
	while(Temp>=Divisor) {
		Temp-=Divisor;
	}
	return Temp;
}

unsigned int Divide(unsigned int Dividend, int Divisor) {
        unsigned int Temp;
	unsigned int i;
	i=0;
        Temp=Dividend;
        while(Temp>=Divisor) {
                Temp-=Divisor;
		i++;
        }
        return i;
}


int Power(int Base, int Exponent) {
	int Temp;
	int i;
	Temp=1;
	for(i=0; i<Exponent; i++) {
		Temp=Temp*Base;
	}
	return Temp;
}

void WordToHex(unsigned int Number, char* String) {
        int i;
        unsigned int Temp, Module;
        Temp=Number;
        for(i=3; i>=0; i--) {
		Module=Temp&15;
		if(Module<10) String[i]=Module+'0'; else String[i]=Module+'A'-10;
		Temp=(Temp>>4)&0xfff;
        }
        String[4]='\0';
}


void WordToString(unsigned int Number, char* String) {
        int i;
        unsigned int Temp;
        Temp=Number;
        for(i=0; i<7; i++) String[i]=' ';
	i=0;
        while(Temp!=0) {
                String[5-i]=Mod(Temp, 10)+'0';
                Temp=Divide(Temp, 10);
                i++;
        }
        String[6]='\0';
}


void IntToString(int Number, char* String) {
	int i;
	int Temp;
	Temp=Number;
	for(i=0; i<7; i++) String[i]=' ';
	i=0;
	if(Temp<0) {
		Temp=-Temp;
		String[i]='-';
		i++;
	}
	while(Temp!=0) {
		String[5-i]=Mod(Temp, 10)+'0';
		Temp=Divide(Temp, 10);
		i++;
	}
	String[6]='\0';
}
