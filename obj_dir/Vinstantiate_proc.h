// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary model header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef VERILATED_VINSTANTIATE_PROC_H_
#define VERILATED_VINSTANTIATE_PROC_H_  // guard

#include "verilated.h"

class Vinstantiate_proc__Syms;
class Vinstantiate_proc___024root;

// This class is the main interface to the Verilated model
class Vinstantiate_proc VL_NOT_FINAL : public VerilatedModel {
  private:
    // Symbol table holding complete model state (owned by this class)
    Vinstantiate_proc__Syms* const vlSymsp;

  public:

    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    VL_IN8(&clk,0,0);
    VL_IN8(&rst_n,0,0);
    VL_IN8(&requested_instantiation_security_strength,7,0);
    VL_IN8(&prediction_resistance_flag,0,0);
    VL_IN8(&prediction_resistance_supported,0,0);
    VL_IN8(&max_personalization_string_length,7,0);
    VL_OUT8(&success,0,0);
    VL_OUT8(&error_flag,0,0);
    VL_OUT8(&catastrophic_error_flag,0,0);
    VL_OUT8(&security_strength,7,0);
    VL_INW(&personalization_string,127,0,4);
    VL_OUTW(&state_handle,127,0,4);

    // CELLS
    // Public to allow access to /* verilator public */ items.
    // Otherwise the application code can consider these internals.

    // Root instance pointer to allow access to model internals,
    // including inlined /* verilator public_flat_* */ items.
    Vinstantiate_proc___024root* const rootp;

    // CONSTRUCTORS
    /// Construct the model; called by application code
    /// If contextp is null, then the model will use the default global context
    /// If name is "", then makes a wrapper with a
    /// single model invisible with respect to DPI scope names.
    explicit Vinstantiate_proc(VerilatedContext* contextp, const char* name = "TOP");
    explicit Vinstantiate_proc(const char* name = "TOP");
    /// Destroy the model; called (often implicitly) by application code
    virtual ~Vinstantiate_proc();
  private:
    VL_UNCOPYABLE(Vinstantiate_proc);  ///< Copying not allowed

  public:
    // API METHODS
    /// Evaluate the model.  Application must call when inputs change.
    void eval() { eval_step(); }
    /// Evaluate when calling multiple units/models per time step.
    void eval_step();
    /// Evaluate at end of a timestep for tracing, when using eval_step().
    /// Application must call after all eval() and before time changes.
    void eval_end_step() {}
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    /// Retrieve name of this model instance (as passed to constructor).
    const char* name() const;

    // Abstract methods from VerilatedModel
    const char* hierName() const override final;
    const char* modelName() const override final;
    unsigned threads() const override final;
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
