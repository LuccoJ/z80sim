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


#include "watch.h"

#include "parser.h"
#include "sizes.h"

#include <assert.h>

#define MAX_WATCHPOINTS 256


typedef struct {
        watchpoint Elements[MAX_WATCHPOINTS];
        short Count;
} watchpoints;

watchpoints Watchpoints;


void InitWatchpoints() {
	Watchpoints.Count=1;
}

short AddWatchpoint(operation* Watchpoint, logic Enabled) {
        assert(Watchpoint!=NULL);
        Watchpoints.Elements[Watchpoints.Count].Trigger=Watchpoint;
        Watchpoints.Elements[Watchpoints.Count].StableValue=EvaluateExpression(Watchpoint);
        Watchpoints.Elements[Watchpoints.Count].Active=Enabled;
        return Watchpoints.Count++;
}

void WatchpointActivation(short Number, logic Enabled) {
	assert(Number<Watchpoints.Count);
	Watchpoints.Elements[Number].Active=Enabled;
}

void ListWatchpoints(FILE* Handle) {
        if(Watchpoints.Count<=1) {
                fprintf(Handle, "No breakpoints or watchpoints.\n");
        } else {
                char Expression[MAX_STRING];
                short i;
                fprintf(Handle, "Num Type           Disp Enb What\n");
                for(i=1; i<Watchpoints.Count; i++) {
                        StringifyExpression(Watchpoints.Elements[i].Trigger, Expression);
                        fprintf(Handle, "%-3d watchpoint     keep %c   %s\n", i, Watchpoints.Elements[i].Active?'y':'n', Expression);
                }
        }
}

watchpoint* CheckWatchpoints() {
        short i;
        for(i=1; i<Watchpoints.Count; i++) {
                word CurrentValue;
                if(Watchpoints.Elements[i].Active) {
                        CurrentValue=EvaluateExpression(Watchpoints.Elements[i].Trigger);
                        if(CurrentValue!=Watchpoints.Elements[i].StableValue) return &(Watchpoints.Elements[i]);
                }
        }
        return NULL;
}

logic ExistsWatchpoint(short Number) {
	if(Number<Watchpoints.Count) return TRUE;
	else return FALSE;
}
