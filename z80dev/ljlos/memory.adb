M:memory
F:G$MemoryInit$0$0({2}DF,SV:S),Z,0,0,0,0,0
F:G$MemoryCopy$0$0({2}DF,SV:S),Z,0,2,0,0,0
S:LMemoryCopy$Destination$1$1({2}DG,SV:S),B,1,4
S:LMemoryCopy$Source$1$1({2}DG,SV:S),B,1,6
S:LMemoryCopy$Length$1$1({2}SI:U),B,1,8
S:LMemoryCopy$i$1$1({2}SI:U),B,1,-2
S:LMemoryCopy$$1$0({2}DG,SC:S),B,1,-4
S:LMemoryCopy$$1$0({2}DG,SC:S),B,1,-6
F:G$MemoryAllocate$0$0({2}DF,DG,SV:S),Z,0,0,0,0,0
S:LMemoryAllocate$Bytes$1$1({2}SI:U),B,1,4
S:LMemoryAllocate$Type$1$1({1}SC:U),B,1,6
S:LMemoryAllocate$Pointer$1$1({2}DG,SC:S),R,0,0,[c,b]
F:G$MemoryFree$0$0({2}DF,SV:S),Z,0,0,0,0,0
S:LMemoryFree$Pointer$1$1({2}DG,SV:S),B,1,4
S:G$NextFreeBlock$0$0({2}DG,SC:S),E,0,0
S:G$MemoryInited$0$0({1}SC:S),E,0,0
S:G$Break$0$0({2}DF,SV:S),C,0,0
S:G$Halt$0$0({2}DF,SV:S),C,0,0
S:G$SystemMonitor$0$0({2}DF,SV:S),C,0,0
S:G$_Z80SimTerminate$0$0({2}DF,SV:S),C,0,0
S:G$_Z80SimPrintCharacter$0$0({2}DF,SV:S),C,0,0
S:G$_Z80SimPrintString$0$0({2}DF,SV:S),C,0,0
S:G$_Z80SimPrintWord$0$0({2}DF,SV:S),C,0,0
S:G$_Z80SimEnterProfile$0$0({2}DF,SV:S),C,0,0
S:G$_Z80SimExitProfile$0$0({2}DF,SV:S),C,0,0
S:G$_Z80SimWriteProtect$0$0({2}DF,SV:S),C,0,0
S:G$_Z80SimReadProtect$0$0({2}DF,SV:S),C,0,0
S:G$_Z80SimRWProtect$0$0({2}DF,SV:S),C,0,0
S:G$_Z80SimUnprotect$0$0({2}DF,SV:S),C,0,0
S:G$_Z80SimWriteProtectCode$0$0({2}DF,SV:S),C,0,0
S:Fmemory$_Z80SimProtectedCodeBegins$0$0({2}DF,SV:S),C,0,0
S:Fmemory$_Z80SimProtectedCodeEnds$0$0({2}DF,SV:S),C,0,0
