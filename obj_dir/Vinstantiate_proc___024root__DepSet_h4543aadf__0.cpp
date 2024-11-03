// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vinstantiate_proc.h for the primary calling header

#include "verilated.h"

#include "Vinstantiate_proc___024root.h"

VL_INLINE_OPT void Vinstantiate_proc___024root___sequent__TOP__0(Vinstantiate_proc___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vinstantiate_proc__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vinstantiate_proc___024root___sequent__TOP__0\n"); );
    // Init
    VlWide<4>/*127:0*/ DRBG_Instantiate__DOT__nonce;
    CData/*3:0*/ __Vdly__DRBG_Instantiate__DOT__state;
    // Body
    __Vdly__DRBG_Instantiate__DOT__state = vlSelf->DRBG_Instantiate__DOT__state;
    if (vlSelf->rst_n) {
        if ((8U & (IData)(vlSelf->DRBG_Instantiate__DOT__state))) {
            if ((4U & (IData)(vlSelf->DRBG_Instantiate__DOT__state))) {
                __Vdly__DRBG_Instantiate__DOT__state = 0U;
            } else if ((2U & (IData)(vlSelf->DRBG_Instantiate__DOT__state))) {
                if ((1U & (IData)(vlSelf->DRBG_Instantiate__DOT__state))) {
                    vlSelf->success = 0U;
                    __Vdly__DRBG_Instantiate__DOT__state = 0U;
                } else {
                    vlSelf->success = 1U;
                    __Vdly__DRBG_Instantiate__DOT__state = 0U;
                }
            } else if ((1U & (IData)(vlSelf->DRBG_Instantiate__DOT__state))) {
                vlSelf->state_handle[0U] = 0xebadcafeU;
                vlSelf->state_handle[1U] = 0xe0badcafU;
                vlSelf->state_handle[2U] = 0xfebadcafU;
                vlSelf->state_handle[3U] = 0xbadcaU;
                __Vdly__DRBG_Instantiate__DOT__state = 0xaU;
            } else {
                __Vdly__DRBG_Instantiate__DOT__state = 9U;
            }
        } else if ((4U & (IData)(vlSelf->DRBG_Instantiate__DOT__state))) {
            if ((2U & (IData)(vlSelf->DRBG_Instantiate__DOT__state))) {
                if ((1U & (IData)(vlSelf->DRBG_Instantiate__DOT__state))) {
                    DRBG_Instantiate__DOT__nonce[0U] = 0xdeadbeefU;
                    DRBG_Instantiate__DOT__nonce[1U] = 0xdeadbeefU;
                    DRBG_Instantiate__DOT__nonce[2U] = 0xdeadbeefU;
                    DRBG_Instantiate__DOT__nonce[3U] = 0xdeadbeefU;
                    __Vdly__DRBG_Instantiate__DOT__state = 8U;
                } else if ((0U == (((vlSelf->DRBG_Instantiate__DOT__entropy_input[0U] 
                                     | vlSelf->DRBG_Instantiate__DOT__entropy_input[1U]) 
                                    | vlSelf->DRBG_Instantiate__DOT__entropy_input[2U]) 
                                   | vlSelf->DRBG_Instantiate__DOT__entropy_input[3U]))) {
                    vlSelf->error_flag = 1U;
                    __Vdly__DRBG_Instantiate__DOT__state = 0xbU;
                } else {
                    __Vdly__DRBG_Instantiate__DOT__state = 7U;
                }
            } else if ((1U & (IData)(vlSelf->DRBG_Instantiate__DOT__state))) {
                vlSelf->DRBG_Instantiate__DOT__entropy_input[0U] = 0x12345678U;
                vlSelf->DRBG_Instantiate__DOT__entropy_input[1U] = 0x9abcdef0U;
                vlSelf->DRBG_Instantiate__DOT__entropy_input[2U] = 0x12345678U;
                vlSelf->DRBG_Instantiate__DOT__entropy_input[3U] = 0xcafebabeU;
                __Vdly__DRBG_Instantiate__DOT__state = 6U;
            } else {
                {
                    if ((0x70U >= (IData)(vlSelf->requested_instantiation_security_strength))) {
                        vlSelf->security_strength = 0x70U;
                        __Vdly__DRBG_Instantiate__DOT__state = 5U;
                        goto __Vlabel1;
                    }
                    if ((0x80U >= (IData)(vlSelf->requested_instantiation_security_strength))) {
                        vlSelf->security_strength = 0x80U;
                        __Vdly__DRBG_Instantiate__DOT__state = 5U;
                        goto __Vlabel1;
                    }
                    if ((0xc0U >= (IData)(vlSelf->requested_instantiation_security_strength))) {
                        vlSelf->security_strength = 0xc0U;
                        __Vdly__DRBG_Instantiate__DOT__state = 5U;
                        goto __Vlabel1;
                    }
                    vlSelf->security_strength = 0xffU;
                    __Vdly__DRBG_Instantiate__DOT__state = 5U;
                    __Vlabel1: ;
                }
            }
        } else if ((2U & (IData)(vlSelf->DRBG_Instantiate__DOT__state))) {
            if ((1U & (IData)(vlSelf->DRBG_Instantiate__DOT__state))) {
                if ((0x80U > (IData)(vlSelf->max_personalization_string_length))) {
                    vlSelf->error_flag = 1U;
                    __Vdly__DRBG_Instantiate__DOT__state = 0xbU;
                } else {
                    __Vdly__DRBG_Instantiate__DOT__state = 4U;
                }
            } else if (((IData)(vlSelf->prediction_resistance_flag) 
                        & (~ (IData)(vlSelf->prediction_resistance_supported)))) {
                vlSelf->error_flag = 1U;
                __Vdly__DRBG_Instantiate__DOT__state = 0xbU;
            } else {
                __Vdly__DRBG_Instantiate__DOT__state = 3U;
            }
        } else if ((1U & (IData)(vlSelf->DRBG_Instantiate__DOT__state))) {
            if ((0xfeU < (IData)(vlSelf->requested_instantiation_security_strength))) {
                vlSelf->error_flag = 1U;
                __Vdly__DRBG_Instantiate__DOT__state = 0xbU;
            } else {
                __Vdly__DRBG_Instantiate__DOT__state = 2U;
            }
        } else {
            __Vdly__DRBG_Instantiate__DOT__state = 1U;
        }
    } else {
        __Vdly__DRBG_Instantiate__DOT__state = 0U;
        vlSelf->success = 0U;
        vlSelf->error_flag = 0U;
        vlSelf->catastrophic_error_flag = 0U;
        vlSelf->security_strength = 0U;
        vlSelf->state_handle[0U] = 0U;
        vlSelf->state_handle[1U] = 0U;
        vlSelf->state_handle[2U] = 0U;
        vlSelf->state_handle[3U] = 0U;
    }
    vlSelf->DRBG_Instantiate__DOT__state = __Vdly__DRBG_Instantiate__DOT__state;
}

void Vinstantiate_proc___024root___eval(Vinstantiate_proc___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vinstantiate_proc__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vinstantiate_proc___024root___eval\n"); );
    // Body
    if ((((IData)(vlSelf->clk) & (~ (IData)(vlSelf->__Vclklast__TOP__clk))) 
         | ((~ (IData)(vlSelf->rst_n)) & (IData)(vlSelf->__Vclklast__TOP__rst_n)))) {
        Vinstantiate_proc___024root___sequent__TOP__0(vlSelf);
    }
    // Final
    vlSelf->__Vclklast__TOP__clk = vlSelf->clk;
    vlSelf->__Vclklast__TOP__rst_n = vlSelf->rst_n;
}

#ifdef VL_DEBUG
void Vinstantiate_proc___024root___eval_debug_assertions(Vinstantiate_proc___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vinstantiate_proc__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vinstantiate_proc___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((vlSelf->rst_n & 0xfeU))) {
        Verilated::overWidthError("rst_n");}
    if (VL_UNLIKELY((vlSelf->prediction_resistance_flag 
                     & 0xfeU))) {
        Verilated::overWidthError("prediction_resistance_flag");}
    if (VL_UNLIKELY((vlSelf->prediction_resistance_supported 
                     & 0xfeU))) {
        Verilated::overWidthError("prediction_resistance_supported");}
}
#endif  // VL_DEBUG
