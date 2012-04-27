void EncodeBlock(char* Data, char* Encoded) {
        rsencode(Data, Encoded);
}

bool DecodeBlock(char* Encoded, char* Data) {
        int Error;
        rsdecode(Encoded, Data);
        if(Error) return FALSE; else return TRUE;
}

