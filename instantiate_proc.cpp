#include "Vinstantiate_proc.h"  // Include the header generated by Verilator
#include "verilated.h"

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    Vinstantiate_proc* dut = new Vinstantiate_proc;  // Instantiate the DUT

    // Initialize signals for testing
    dut->clk = 0;
    dut->rst_n = 1;
    dut->requested_instantiation_security_strength = 128;
    dut->prediction_resistance_flag = 1;
    dut->prediction_resistance_supported = 1;

    // Assign the 128-bit personalization_string in 32-bit parts
    dut->personalization_string[0] = 0x12345678;
    dut->personalization_string[1] = 0x9ABCDEF0;
    dut->personalization_string[2] = 0xCAFEBABE;
    dut->personalization_string[3] = 0x12345678;

    // Simulate some clock cycles
    for (int i = 0; i < 10; i++) {
        dut->clk = !dut->clk;
        dut->eval();  // Evaluate the model
    }

    // Clean up
    delete dut;
    return 0;
}
