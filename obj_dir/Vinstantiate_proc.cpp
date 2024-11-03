// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vinstantiate_proc.h"
#include "Vinstantiate_proc__Syms.h"

//============================================================
// Constructors

Vinstantiate_proc::Vinstantiate_proc(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vinstantiate_proc__Syms(contextp(), _vcname__, this)}
    , clk{vlSymsp->TOP.clk}
    , rst_n{vlSymsp->TOP.rst_n}
    , requested_instantiation_security_strength{vlSymsp->TOP.requested_instantiation_security_strength}
    , prediction_resistance_flag{vlSymsp->TOP.prediction_resistance_flag}
    , prediction_resistance_supported{vlSymsp->TOP.prediction_resistance_supported}
    , max_personalization_string_length{vlSymsp->TOP.max_personalization_string_length}
    , success{vlSymsp->TOP.success}
    , error_flag{vlSymsp->TOP.error_flag}
    , catastrophic_error_flag{vlSymsp->TOP.catastrophic_error_flag}
    , security_strength{vlSymsp->TOP.security_strength}
    , personalization_string{vlSymsp->TOP.personalization_string}
    , state_handle{vlSymsp->TOP.state_handle}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vinstantiate_proc::Vinstantiate_proc(const char* _vcname__)
    : Vinstantiate_proc(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vinstantiate_proc::~Vinstantiate_proc() {
    delete vlSymsp;
}

//============================================================
// Evaluation loop

void Vinstantiate_proc___024root___eval_initial(Vinstantiate_proc___024root* vlSelf);
void Vinstantiate_proc___024root___eval_settle(Vinstantiate_proc___024root* vlSelf);
void Vinstantiate_proc___024root___eval(Vinstantiate_proc___024root* vlSelf);
#ifdef VL_DEBUG
void Vinstantiate_proc___024root___eval_debug_assertions(Vinstantiate_proc___024root* vlSelf);
#endif  // VL_DEBUG
void Vinstantiate_proc___024root___final(Vinstantiate_proc___024root* vlSelf);

static void _eval_initial_loop(Vinstantiate_proc__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    Vinstantiate_proc___024root___eval_initial(&(vlSymsp->TOP));
    // Evaluate till stable
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial loop\n"););
        Vinstantiate_proc___024root___eval_settle(&(vlSymsp->TOP));
        Vinstantiate_proc___024root___eval(&(vlSymsp->TOP));
    } while (0);
}

void Vinstantiate_proc::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vinstantiate_proc::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vinstantiate_proc___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        Vinstantiate_proc___024root___eval(&(vlSymsp->TOP));
    } while (0);
    // Evaluate cleanup
}

//============================================================
// Utilities

const char* Vinstantiate_proc::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

VL_ATTR_COLD void Vinstantiate_proc::final() {
    Vinstantiate_proc___024root___final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vinstantiate_proc::hierName() const { return vlSymsp->name(); }
const char* Vinstantiate_proc::modelName() const { return "Vinstantiate_proc"; }
unsigned Vinstantiate_proc::threads() const { return 1; }
