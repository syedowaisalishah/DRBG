`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2025 03:15:38 AM
// Design Name: 
// Module Name: tb_instantiate
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


module tb_instantiate();
    reg clk;
    reg rst;
    reg start;
    reg [383:0] entropy_input;
    reg [383:0] personalization_string;
    wire [255:0] initial_key;
    wire [127:0] initial_v;
    wire [31:0] reseed_counter;
    wire done;

    // Instantiate DUT
    instantiate dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .entropy_input(entropy_input),
        .personalization_string(personalization_string),
        .initial_key(initial_key),
        .initial_v(initial_v),
        .reseed_counter(reseed_counter),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus
    initial begin
        // Initialize signals
        rst = 1;
        start = 0;
        entropy_input = 384'h0;
        personalization_string = 384'h0;
        #100;

        // Release reset
        rst = 0;
        #100;

        // Set test values
        entropy_input = 384'h123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF;
        personalization_string = 384'h000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
        
        // Start instantiation
        start = 1;
        #10;
        start = 0;

        // Wait for completion
        wait(done);
        
        // Display results
        $display("Initial Key: %h", initial_key);
        $display("Initial V: %h", initial_v);
        $display("Reseed Counter: %d", reseed_counter);
        
        #1000;
        $finish;
    end

endmodule