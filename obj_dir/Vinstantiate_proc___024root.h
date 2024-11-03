// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vinstantiate_proc.h for the primary calling header

#ifndef VERILATED_VINSTANTIATE_PROC___024ROOT_H_
#define VERILATED_VINSTANTIATE_PROC___024ROOT_H_  // guard

#include "verilated.h"

class Vinstantiate_proc__Syms;

class Vinstantiate_proc___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clk,0,0);
    VL_IN8(rst_n,0,0);
    VL_IN8(requested_instantiation_security_strength,7,0);
    VL_IN8(prediction_resistance_flag,0,0);
    VL_IN8(prediction_resistance_supported,0,0);
    VL_IN8(max_personalization_string_length,7,0);
    VL_OUT8(success,0,0);
    VL_OUT8(error_flag,0,0);
    VL_OUT8(catastrophic_error_flag,0,0);
    VL_OUT8(security_strength,7,0);
    CData/*3:0*/ DRBG_Instantiate__DOT__state;
    CData/*0:0*/ __Vclklast__TOP__clk;
    CData/*0:0*/ __Vclklast__TOP__rst_n;
    VL_INW(personalization_string,127,0,4);
    VL_OUTW(state_handle,127,0,4);
    VlWide<4>/*127:0*/ DRBG_Instantiate__DOT__entropy_input;

    // INTERNAL VARIABLES
    Vinstantiate_proc__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vinstantiate_proc___024root(Vinstantiate_proc__Syms* symsp, const char* name);
    ~Vinstantiate_proc___024root();
    VL_UNCOPYABLE(Vinstantiate_proc___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
