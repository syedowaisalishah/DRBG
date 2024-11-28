// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "VCtr_Drbg_update__Syms.h"
#include "VCtr_Drbg_update.h"
#include "VCtr_Drbg_update___024root.h"

// FUNCTIONS
VCtr_Drbg_update__Syms::~VCtr_Drbg_update__Syms()
{
}

VCtr_Drbg_update__Syms::VCtr_Drbg_update__Syms(VerilatedContext* contextp, const char* namep, VCtr_Drbg_update* modelp)
    : VerilatedSyms{contextp}
    // Setup internal state of the Syms class
    , __Vm_modelp{modelp}
    // Setup module instances
    , TOP{this, namep}
{
    // Configure time unit / time precision
    _vm_contextp__->timeunit(-12);
    _vm_contextp__->timeprecision(-12);
    // Setup each module's pointers to their submodules
    // Setup each module's pointer back to symbol table (for public functions)
    TOP.__Vconfigure(true);
}
