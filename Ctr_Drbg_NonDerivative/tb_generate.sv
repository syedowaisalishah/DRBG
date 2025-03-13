`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2025 03:38:58 AM
// Design Name: 
// Module Name: tb_generate
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



module tb_generate;
    // Inputs
    reg clk;
    reg rst;
    reg start;
    reg [255:0] key_in;
    reg [127:0] v_in;
    reg [31:0] reseed_counter_in;
    reg [383:0] additional_input;
    reg [31:0] requested_bits;

    // Outputs
    wire [255:0] key_out;
    wire [127:0] v_out;
    wire [31:0] reseed_counter_out;
    wire [255:0] random_bits;
    wire done;
    wire error;

    // Instantiate the Unit Under Test (UUT)
    generate_drbg uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .key_in(key_in),
        .v_in(v_in),
        .reseed_counter_in(reseed_counter_in),
        .additional_input(additional_input),
        .requested_bits(requested_bits),
        .key_out(key_out),
        .v_out(v_out),
        .reseed_counter_out(reseed_counter_out),
        .random_bits(random_bits),
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
        reseed_counter_in = 32'h00000001;
        additional_input = 384'h0;
        requested_bits = 32'h00000100;

        // Wait 100 ns for global reset
        #100;
        rst = 0;
        #20;

        // Start test
        start = 1;
        #10;
        start = 0;

        // Wait for done signal
        wait(done);
        
        // Display results
        $display("Test Complete");
        $display("Key out: %h", key_out);
        $display("V out: %h", v_out);
        $display("Random bits: %h", random_bits);
        $display("Reseed counter: %d", reseed_counter_out);
        
        #100;
        $finish;
    end

endmodule