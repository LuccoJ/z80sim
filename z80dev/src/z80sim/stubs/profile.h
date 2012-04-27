#ifndef _SIM_PROFILE_H
#define _SIM_PROFILE_H

extern void _Z80SimTerminate();
extern void _Z80SimPrintCharacter(char);
extern void _Z80SimPrintString(char*);
extern void _Z80SimPrintWord(unsigned int);
extern void _Z80SimEnterProfile();
extern void _Z80SimExitProfile();
extern void _Z80SimWriteProtect(void* Start, void* End);
extern void _Z80SimReadProtect(void* Start, void* End);
extern void _Z80SimRWProtect(void* Start, void* End);
extern void _Z80SimUnprotect(void* Start, void* End);

extern void _Z80SimWriteProtectCode();
static void _Z80SimProtectedCodeBegins(void);
static void _Z80SimProtectedCodeEnds(void);

#ifndef NDEBUG

#define _SimTerminate(none)          _Z80SimTerminate(none)
#define _SimPrintCharacter(Var)      _Z80SimPrintCharacter(Var)
#define _SimPrintString(Var)         _Z80SimPrintString(Var)
#define _SimPrintWord(Var)           _Z80SimPrintWord(Var)
#define _SimEnterProfile(none)       _Z80SimEnterProfile(none)
#define _SimExitProfile(none)        _Z80SimExitProfile(none)
#define _SimWriteProtect(Var1, Var2) _Z80SimWriteProtect(Var1, Var2)
#define _SimWriteProtectVar(Var)     _Z80SimWriteProtect(&Var, (unsigned int)&Var+sizeof(Var))
#define _SimReadProtect(Var1, Var2)  _Z80SimReadProtect(Var1, Var2)
#define _SimReadProtectVar(Var)      _Z80SimReadProtect(&Var, (unsigned int)&Var+sizeof(Var))
#define _SimRWProtect(Var1, Var2)    _Z80SimRWProtect(Var1, Var2)
#define _SimRWProtectVar(Var)        _Z80SimRWProtect(&Var, (unsigned int)&Var+sizeof(Var))
#define _SimUnprotect(Var1, Var2)    _Z80SimUnprotect(Var1, Var2)
#define _SimUnprotectVar(Var)        _Z80SimUnprotect(&Var, (unsigned int)&Var+sizeof(Var))

#define _SimProtectCode(none)        _Z80SimWriteProtect((void*)_Z80SimProtectedCodeBegins, (void*)_Z80SimProtectedCodeEnds)
#define _SimProtectedCodeBegins      void _Z80SimProtectedCodeBegins(void) {}
#define _SimProtectedCodeEnds        void _Z80SimProtectedCodeEnds(void) {}

#else

#define _SimTerminate(none)
#define _SimPrintCharacter(Var)
#define _SimPrintString(Var)
#define _SimPrintWord(Var)
#define _SimEnterProfile(none)
#define _SimExitProfile(none)
#define _SimWriteProtect(Var1, Var2)
#define _SimWriteProtectVar(Var)

#endif

#endif

