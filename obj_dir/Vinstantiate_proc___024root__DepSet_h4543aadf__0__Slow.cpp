// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vinstantiate_proc.h for the primary calling header

#include "verilated.h"

#include "Vinstantiate_proc___024root.h"

VL_ATTR_COLD void Vinstantiate_proc___024root___eval_initial(Vinstantiate_proc___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vinstantiate_proc__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vinstantiate_proc___024root___eval_initial\n"); );
    // Body
    vlSelf->__Vclklast__TOP__clk = vlSelf->clk;
    vlSelf->__Vclklast__TOP__rst_n = vlSelf->rst_n;
}

VL_ATTR_COLD void Vinstantiate_proc___024root___eval_settle(Vinstantiate_proc___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vinstantiate_proc__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vinstantiate_proc___024root___eval_settle\n"); );
}

VL_ATTR_COLD void Vinstantiate_proc___024root___final(Vinstantiate_proc___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vinstantiate_proc__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vinstantiate_proc___024root___final\n"); );
}

VL_ATTR_COLD void Vinstantiate_proc___024root___ctor_var_reset(Vinstantiate_proc___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vinstantiate_proc__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vinstantiate_proc___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->clk = VL_RAND_RESET_I(1);
    vlSelf->rst_n = VL_RAND_RESET_I(1);
    vlSelf->requested_instantiation_security_strength = VL_RAND_RESET_I(8);
    vlSelf->prediction_resistance_flag = VL_RAND_RESET_I(1);
    vlSelf->prediction_resistance_supported = VL_RAND_RESET_I(1);
    VL_RAND_RESET_W(128, vlSelf->personalization_string);
    vlSelf->max_personalization_string_length = VL_RAND_RESET_I(8);
    vlSelf->success = VL_RAND_RESET_I(1);
    vlSelf->error_flag = VL_RAND_RESET_I(1);
    vlSelf->catastrophic_error_flag = VL_RAND_RESET_I(1);
    vlSelf->security_strength = VL_RAND_RESET_I(8);
    VL_RAND_RESET_W(128, vlSelf->state_handle);
    VL_RAND_RESET_W(128, vlSelf->DRBG_Instantiate__DOT__entropy_input);
    vlSelf->DRBG_Instantiate__DOT__state = VL_RAND_RESET_I(4);
}
