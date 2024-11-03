// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VINSTANTIATE_PROC__SYMS_H_
#define VERILATED_VINSTANTIATE_PROC__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vinstantiate_proc.h"

// INCLUDE MODULE CLASSES
#include "Vinstantiate_proc___024root.h"

// SYMS CLASS (contains all model state)
class Vinstantiate_proc__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vinstantiate_proc* const __Vm_modelp;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vinstantiate_proc___024root    TOP;

    // CONSTRUCTORS
    Vinstantiate_proc__Syms(VerilatedContext* contextp, const char* namep, Vinstantiate_proc* modelp);
    ~Vinstantiate_proc__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
