void Proofread(void* CodeStart, void* CodeEnd, void* DataStart, void* DataEnd, bool Supervisor) {
	char* Start;
	char* End;
	char* i;
	Start=(char*)CodeStart;
	End=(char*)CodeEnd;
	for(i=Start; i<=End; i++) {
		switch(*i) {
		case OP_EXAFAF1:
		case OP_EXX:
			if(!Supervisor) return OP_EXX;
			break;
		case OP_LD_PW_A:
		case OP_LD_PW_HL:
                        Operand=*(++i)|(*(++i)<<8);
                        if(Operand<DataStart || Operand>DataEnd) return OP_LD_PW_HL;
			break;
		case OP_LD_A_PW:
		case OP_LD_HL_PW:
			idem
                        Operand=*(++i)|(*(++i)<<8);
                        if(Operand<DataStart || Operand>DataEnd) return OP_LD_HL_PW;
                        break;
		case OP_DI:
			if(!Supervisor) return OP_DI;
			break;
		case OP_EI:
			if(!Supervisor) return OP_EI;
			break;
		case OP_HLT:
			if(!Supervisor) *i=OP_SWITCH;
			break;
		case OP_JP_WORD:
                case OP_JP_NZ_WORD:
                case OP_JP_Z_WORD:
                case OP_JP_NC_WORD:
                case OP_JP_C_WORD:
                case OP_JP_PO_WORD:
                case OP_JP_PE_WORD:
                case OP_JP_P_WORD:
                case OP_JP_M_WORD:
                        Operand=*(++i)|(*(++i)<<8);
                        if(Operand<CodeStart || Operand>CodeEnd) return OP_JP_WORD;
                        break;
                case OP_CALL_WORD:
                case OP_CALL_NZ_WORD:
                case OP_CALL_Z_WORD:
                case OP_CALL_NC_WORD:
                case OP_CALL_C_WORD:
                case OP_CALL_PO_WORD:
                case OP_CALL_PE_WORD:
                case OP_CALL_P_WORD:
                case OP_CALL_M_WORD:
                        Operand=*(++i)|(*(++i)<<8);
                        if(Operand<CodeStart || Operand>CodeEnd) return OP_CALL_WORD;
			break;
		case OP_RST00:
			if(!Supervisor) return OP_RST00;
			break;
		case OP_RST10:
			if(Supervisor) return OP_RST10;
			break;
		case OP_RST38:
			if(!Supervisor) return OP_RST38;
			break;
		case OP_IN_A_BYTE:
			if(!Supervisor) return OP_IN_A_BYTE;
			break;
		case OP_EDPREFIX:
			switch(*(++i)) {
			case OP_LD_A_I:
				if(!Supervisor) return OP_LD_A_I;
				break;
			case OP_LD_BC_PW:
			case OP_LD_DE_PW:
			case OP_LD_HL_PW:
	                        Operand=*(++i)|(*(++i)<<8);
				if(Operand<DataStart || Operand>DataEnd) return OP_LD_HL_PW;
				break;
			case OP_LD_SP_PW:
                                Operand=*(++i)|(*(++i)<<8);
                                if(Operand<StackStart || Operand>StackEnd) return OP_LD_SP_PW;
				break;
			
