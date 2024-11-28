// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See VCtr_Drbg_update.h for the primary calling header

#ifndef VERILATED_VCTR_DRBG_UPDATE___024ROOT_H_
#define VERILATED_VCTR_DRBG_UPDATE___024ROOT_H_  // guard

#include "verilated.h"

class VCtr_Drbg_update__Syms;

class VCtr_Drbg_update___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_INW(provided_data,255,0,8);
    VL_INW(Key_in,127,0,4);
    VL_INW(V_in,127,0,4);
    VL_OUTW(Key_out,127,0,4);
    VL_OUTW(V_out,127,0,4);

    // INTERNAL VARIABLES
    VCtr_Drbg_update__Syms* const vlSymsp;

    // CONSTRUCTORS
    VCtr_Drbg_update___024root(VCtr_Drbg_update__Syms* symsp, const char* name);
    ~VCtr_Drbg_update___024root();
    VL_UNCOPYABLE(VCtr_Drbg_update___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
