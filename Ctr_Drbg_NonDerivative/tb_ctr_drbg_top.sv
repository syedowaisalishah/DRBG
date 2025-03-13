`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2025 07:18:08 AM
// Design Name: 
// Module Name: tb_ctr_drbg_top
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


module tb_ctr_drbg_top;
    reg clk;
    reg rst;
    reg start;
    reg [1:0] operation;
    reg [383:0] entropy_input;
    reg [383:0] additional_input;
    reg [31:0] requested_bits;
    
    wire [255:0] key;
    wire [127:0] v;
    wire [31:0] reseed_counter;
    wire [255:0] random_bits;
    wire done;
    wire error;
    wire needs_reseed;

    // Instantiate top module
    ctr_drbg_top dut(
        .clk(clk),
        .rst(rst),
        .start(start),
        .operation(operation),
        .entropy_input(entropy_input),
        .additional_input(additional_input),
        .requested_bits(requested_bits),
        .key(key),
        .v(v),
        .reseed_counter(reseed_counter),
        .random_bits(random_bits),
        .done(done),
        .error(error),
        .needs_reseed(needs_reseed)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus
    initial begin
        // Initialize
        rst = 1;
        start = 0;
        operation = 2'b00;
        entropy_input = 384'h0;
        additional_input = 384'h0;
        requested_bits = 32'h0;

        #100;
        rst = 0;
        #20;

        // Test instantiate
        entropy_input = 384'h123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0;
        operation = 2'b00;
        start = 1;
        #10;
        start = 0;
        
        wait(done);
        #100;

        // Test generate
        operation = 2'b01;
        requested_bits = 32'h100;
        start = 1;
        #10;
        start = 0;
        
        wait(done);
        #100;

        // Test reseed
        operation = 2'b10;
        entropy_input = 384'hFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210FEDCBA9876543210;
        start = 1;
        #10;
        start = 0;
        
        wait(done);
        #100;

        $finish;
    end

endmodule
