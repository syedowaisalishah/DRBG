// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VCtr_Drbg_update.h for the primary calling header

#include "verilated.h"

#include "VCtr_Drbg_update___024root.h"

VL_ATTR_COLD void VCtr_Drbg_update___024root___initial__TOP__0(VCtr_Drbg_update___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VCtr_Drbg_update__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VCtr_Drbg_update___024root___initial__TOP__0\n"); );
    // Init
    VlWide<8>/*255:0*/ CTR_DRBG_Update__DOT__temp;
    VlWide<4>/*127:0*/ CTR_DRBG_Update__DOT__V_temp;
    VlWide<4>/*127:0*/ CTR_DRBG_Update__DOT__Key_temp;
    // Body
    CTR_DRBG_Update__DOT__temp[0U] = vlSelf->provided_data[0U];
    CTR_DRBG_Update__DOT__temp[1U] = vlSelf->provided_data[1U];
    CTR_DRBG_Update__DOT__temp[2U] = vlSelf->provided_data[2U];
    CTR_DRBG_Update__DOT__temp[3U] = vlSelf->provided_data[3U];
    CTR_DRBG_Update__DOT__temp[4U] = vlSelf->provided_data[4U];
    CTR_DRBG_Update__DOT__temp[5U] = vlSelf->provided_data[5U];
    CTR_DRBG_Update__DOT__temp[6U] = vlSelf->provided_data[6U];
    CTR_DRBG_Update__DOT__temp[7U] = vlSelf->provided_data[7U];
    CTR_DRBG_Update__DOT__Key_temp[0U] = CTR_DRBG_Update__DOT__temp[4U];
    CTR_DRBG_Update__DOT__Key_temp[1U] = CTR_DRBG_Update__DOT__temp[5U];
    CTR_DRBG_Update__DOT__Key_temp[2U] = CTR_DRBG_Update__DOT__temp[6U];
    CTR_DRBG_Update__DOT__Key_temp[3U] = CTR_DRBG_Update__DOT__temp[7U];
    CTR_DRBG_Update__DOT__V_temp[0U] = CTR_DRBG_Update__DOT__temp[0U];
    CTR_DRBG_Update__DOT__V_temp[1U] = CTR_DRBG_Update__DOT__temp[1U];
    CTR_DRBG_Update__DOT__V_temp[2U] = CTR_DRBG_Update__DOT__temp[2U];
    CTR_DRBG_Update__DOT__V_temp[3U] = CTR_DRBG_Update__DOT__temp[3U];
    vlSelf->Key_out[0U] = CTR_DRBG_Update__DOT__Key_temp[0U];
    vlSelf->Key_out[1U] = CTR_DRBG_Update__DOT__Key_temp[1U];
    vlSelf->Key_out[2U] = CTR_DRBG_Update__DOT__Key_temp[2U];
    vlSelf->Key_out[3U] = CTR_DRBG_Update__DOT__Key_temp[3U];
    vlSelf->V_out[0U] = CTR_DRBG_Update__DOT__V_temp[0U];
    vlSelf->V_out[1U] = CTR_DRBG_Update__DOT__V_temp[1U];
    vlSelf->V_out[2U] = CTR_DRBG_Update__DOT__V_temp[2U];
    vlSelf->V_out[3U] = CTR_DRBG_Update__DOT__V_temp[3U];
}

VL_ATTR_COLD void VCtr_Drbg_update___024root___eval_initial(VCtr_Drbg_update___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VCtr_Drbg_update__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VCtr_Drbg_update___024root___eval_initial\n"); );
    // Body
    VCtr_Drbg_update___024root___initial__TOP__0(vlSelf);
}

VL_ATTR_COLD void VCtr_Drbg_update___024root___eval_settle(VCtr_Drbg_update___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VCtr_Drbg_update__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VCtr_Drbg_update___024root___eval_settle\n"); );
}

VL_ATTR_COLD void VCtr_Drbg_update___024root___final(VCtr_Drbg_update___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VCtr_Drbg_update__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VCtr_Drbg_update___024root___final\n"); );
}

VL_ATTR_COLD void VCtr_Drbg_update___024root___ctor_var_reset(VCtr_Drbg_update___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VCtr_Drbg_update__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VCtr_Drbg_update___024root___ctor_var_reset\n"); );
    // Body
    VL_RAND_RESET_W(256, vlSelf->provided_data);
    VL_RAND_RESET_W(128, vlSelf->Key_in);
    VL_RAND_RESET_W(128, vlSelf->V_in);
    VL_RAND_RESET_W(128, vlSelf->Key_out);
    VL_RAND_RESET_W(128, vlSelf->V_out);
}
