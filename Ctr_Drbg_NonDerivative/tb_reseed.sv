`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2025 06:52:26 AM
// Design Name: 
// Module Name: tb_reseed
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

module tb_reseed;
    reg clk;
    reg rst;
    reg start;
    reg [255:0] key_in;
    reg [127:0] v_in;
    reg [31:0] reseed_counter_in;
    reg [383:0] entropy_input;
    reg [383:0] additional_input;
    wire [255:0] key_out;
    wire [127:0] v_out;
    wire [31:0] reseed_counter_out;
    wire done;
    wire error;

    // Instantiate reseed module
    reseed_drbg uut(
        .clk(clk),
        .rst(rst),
        .start(start),
        .key_in(key_in),
        .v_in(v_in),
        .reseed_counter_in(reseed_counter_in),
        .entropy_input(entropy_input),
        .additional_input(additional_input),
        .key_out(key_out),
        .v_out(v_out),
        .reseed_counter_out(reseed_counter_out),
        .done(done),
        .error(error)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus
    initial begin
        // Initialize inputs
        rst = 1;
        start = 0;
        key_in = 256'h000102030405060708090A0B0C0D0E0F101112131415161718191a1b1c1d1e1f;
        v_in = 128'h000102030405060708090A0B0C0D0E0F;
        reseed_counter_in = 32'h1000_0000; // High value to trigger reseed
        entropy_input = 384'h123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0;
        additional_input = 384'h0; // No additional input for this test

        // Wait 100 ns for global reset
        #100;
        rst = 0;
        #20;

        // Start reseed operation
        start = 1;
        #10;
        start = 0;

        // Wait for completion
        wait(done);
        
        // Display results
        $display("Reseed Complete");
        $display("New Key: %h", key_out);
        $display("New V: %h", v_out);
        $display("New Reseed Counter: %d", reseed_counter_out);
        
        #100;
        $finish;
    end

endmodule