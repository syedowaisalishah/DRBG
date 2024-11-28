// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VCtr_Drbg_update.h for the primary calling header

#include "verilated.h"

#include "VCtr_Drbg_update__Syms.h"
#include "VCtr_Drbg_update___024root.h"

void VCtr_Drbg_update___024root___ctor_var_reset(VCtr_Drbg_update___024root* vlSelf);

VCtr_Drbg_update___024root::VCtr_Drbg_update___024root(VCtr_Drbg_update__Syms* symsp, const char* name)
    : VerilatedModule{name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    VCtr_Drbg_update___024root___ctor_var_reset(this);
}

void VCtr_Drbg_update___024root::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

VCtr_Drbg_update___024root::~VCtr_Drbg_update___024root() {
}
