#include <iostream>
#include <bitset>
#include <cassert>
#include "VCTR_DRBG_Update.h" // Verilator-generated header file for the module
#include "verilated.h"

#define SEEDLEN 256
#define BLOCKLEN 128
#define KEYLEN 128

// XOR-based placeholder for AES encryption function
std::bitset<BLOCKLEN> Block_Encrypt(std::bitset<KEYLEN> key, std::bitset<BLOCKLEN> V) {
    return key ^ V; // Simplified logic, replace with AES for real test
}

// Software reference for CTR_DRBG_Update function
void CTR_DRBG_Update_Ref(
    std::bitset<SEEDLEN> provided_data,
    std::bitset<KEYLEN> key_in,
    std::bitset<BLOCKLEN> V_in,
    std::bitset<KEYLEN> &key_out,
    std::bitset<BLOCKLEN> &V_out
) {
    std::bitset<SEEDLEN> temp;
    std::bitset<BLOCKLEN> V_temp = V_in;
    std::bitset<BLOCKLEN> output_block;

    // Generate seedlen bits
    while (temp.count() < SEEDLEN) {
        V_temp = V_temp.to_ulong() + 1; // Increment V
        output_block = Block_Encrypt(key_in, V_temp);
        temp = (temp << BLOCKLEN) | output_block; // Concatenate blocks
    }

    // Truncate temp and XOR with provided_data
    temp ^= provided_data;

    // Update Key and V
    key_out = std::bitset<KEYLEN>(temp.to_string().substr(0, KEYLEN));
    V_out = std::bitset<BLOCKLEN>(temp.to_string().substr(KEYLEN, BLOCKLEN));
}

int main() {
    Verilated::commandArgs(0, nullptr);
    VCTR_DRBG_Update* drbg = new VCTR_DRBG_Update;

    // Test Vectors (replace with real vectors for full testing)
    std::bitset<SEEDLEN> provided_data("1101101101111010101010101101010101001101101001010101001010101001"
                                       "1101101101111010101010101101010101001101101001010101001010101001");
    std::bitset<KEYLEN> key_in("10101010101010101010101010101010");
    std::bitset<BLOCKLEN> V_in("11110000111100001111000011110000");

    // Software reference output
    std::bitset<KEYLEN> key_out_ref;
    std::bitset<BLOCKLEN> V_out_ref;

    CTR_DRBG_Update_Ref(provided_data, key_in, V_in, key_out_ref, V_out_ref);

    // Apply inputs to Verilog module
    drbg->provided_data = provided_data.to_ulong();
    drbg->Key_in = key_in.to_ulong();
    drbg->V_in = V_in.to_ulong();

    // Simulate
    drbg->eval();

    // Capture output from Verilog module
    std::bitset<KEYLEN> key_out_verilog(drbg->Key_out);
    std::bitset<BLOCKLEN> V_out_verilog(drbg->V_out);

    // Compare software reference with hardware results
    assert(key_out_ref == key_out_verilog && "Key mismatch!");
    assert(V_out_ref == V_out_verilog && "V mismatch!");

    std::cout << "Test Passed: Software and Hardware outputs match!" << std::endl;

    delete drbg;
    return 0;
}
