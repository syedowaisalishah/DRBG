// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VCTR_DRBG_UPDATE__SYMS_H_
#define VERILATED_VCTR_DRBG_UPDATE__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "VCtr_Drbg_update.h"

// INCLUDE MODULE CLASSES
#include "VCtr_Drbg_update___024root.h"

// SYMS CLASS (contains all model state)
class VCtr_Drbg_update__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    VCtr_Drbg_update* const __Vm_modelp;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    VCtr_Drbg_update___024root     TOP;

    // CONSTRUCTORS
    VCtr_Drbg_update__Syms(VerilatedContext* contextp, const char* namep, VCtr_Drbg_update* modelp);
    ~VCtr_Drbg_update__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
