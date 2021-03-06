/*
   Z80Sim - A simulator/debugger for the Zilog Z80 processor
   Copyright (C) 2003 Lorenzo J. Lucchini

   This program is free software; you can redistribute it
   and/or modify it under the terms of the GNU General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later
   version. This program is distributed in the hope that it
   will be useful, but WITHOUT ANY WARRANTY; without even the
   implied warranty of MERCHANTABILITY or FITNESS FOR A
   PARTICULAR PURPOSE. See the GNU General Public License for
   more details. You should have received a copy of the GNU
   General Public License along with this program; if not,
   write to the Free Software Foundation, Inc., 59 Temple
   Place, Suite 330, Boston, MA 02111-1307 USA
*/


#ifndef H_TOKENS
#define H_TOKENS

#include "types.h"

struct Tokens;
typedef struct Tokens tokens;

tokens* CreateTokenTable(void);
void CreateToken(tokens* Handle, const char* Symbol, int Id);
int ExtractToken(const tokens* Handle, const char** Expression, char* Token, logic Completion);
logic ExtractFreeform(const tokens* Handle, const char** Expression, char* Freeform);

#endif
