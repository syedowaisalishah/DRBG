// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "VCtr_Drbg_update.h"
#include "VCtr_Drbg_update__Syms.h"

//============================================================
// Constructors

VCtr_Drbg_update::VCtr_Drbg_update(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new VCtr_Drbg_update__Syms(contextp(), _vcname__, this)}
    , provided_data{vlSymsp->TOP.provided_data}
    , Key_in{vlSymsp->TOP.Key_in}
    , V_in{vlSymsp->TOP.V_in}
    , Key_out{vlSymsp->TOP.Key_out}
    , V_out{vlSymsp->TOP.V_out}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

VCtr_Drbg_update::VCtr_Drbg_update(const char* _vcname__)
    : VCtr_Drbg_update(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

VCtr_Drbg_update::~VCtr_Drbg_update() {
    delete vlSymsp;
}

//============================================================
// Evaluation loop

void VCtr_Drbg_update___024root___eval_initial(VCtr_Drbg_update___024root* vlSelf);
void VCtr_Drbg_update___024root___eval_settle(VCtr_Drbg_update___024root* vlSelf);
void VCtr_Drbg_update___024root___eval(VCtr_Drbg_update___024root* vlSelf);
#ifdef VL_DEBUG
void VCtr_Drbg_update___024root___eval_debug_assertions(VCtr_Drbg_update___024root* vlSelf);
#endif  // VL_DEBUG
void VCtr_Drbg_update___024root___final(VCtr_Drbg_update___024root* vlSelf);

static void _eval_initial_loop(VCtr_Drbg_update__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    VCtr_Drbg_update___024root___eval_initial(&(vlSymsp->TOP));
    // Evaluate till stable
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial loop\n"););
        VCtr_Drbg_update___024root___eval_settle(&(vlSymsp->TOP));
        VCtr_Drbg_update___024root___eval(&(vlSymsp->TOP));
    } while (0);
}

void VCtr_Drbg_update::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate VCtr_Drbg_update::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    VCtr_Drbg_update___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        VCtr_Drbg_update___024root___eval(&(vlSymsp->TOP));
    } while (0);
    // Evaluate cleanup
}

//============================================================
// Utilities

const char* VCtr_Drbg_update::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

VL_ATTR_COLD void VCtr_Drbg_update::final() {
    VCtr_Drbg_update___024root___final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* VCtr_Drbg_update::hierName() const { return vlSymsp->name(); }
const char* VCtr_Drbg_update::modelName() const { return "VCtr_Drbg_update"; }
unsigned VCtr_Drbg_update::threads() const { return 1; }
