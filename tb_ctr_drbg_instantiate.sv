`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2025 04:49:57 PM
// Design Name: 
// Module Name: tb_ctr_drbg_instantiate
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_ctr_drbg_instantiate;
    logic clk;
    logic rst;
    logic [383:0] entropy_input;
    logic [383:0] personalization_string;
    logic [255:0] new_key;
    logic [127:0] new_V;
    logic [31:0] reseed_counter;

    // Instantiate the DRBG instantiation module
    ctr_drbg_instantiate dut (
        .clk(clk),
        .rst(rst),
        .entropy_input(entropy_input),
        .personalization_string(personalization_string),
        .new_key(new_key),
        .new_V(new_V),
        .reseed_counter(reseed_counter)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 time units clock period
    end

    // Test sequence
    initial begin
        rst = 1;
        entropy_input = 384'hF1A2_B3C4_D5E6_F7E8_A1B2_C3D4_E5F6_A7B8_C1D2_E3F4_A5B6;
        personalization_string = 384'h1234_5678_9ABC_DEF0_1234_5678_9ABC_DEF0_1234_5678_9ABC_DEF0;

        #10 rst = 0;

        #50;  // Wait for the update process to complete

        $display("New Key: %h", new_key);
        $display("New V: %h", new_V);
        $display("Reseed Counter: %d", reseed_counter);

        $finish;
    end
endmodule
