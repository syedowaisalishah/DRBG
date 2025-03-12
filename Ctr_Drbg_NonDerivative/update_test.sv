timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2025 07:33:26 AM
// Design Name: 
// Module Name: update_test
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


module update_test;
    
    logic clk;
    logic rst;
    logic start;
    logic [383:0] provided_data;
    logic [255:0] key;
    logic [127:0] v;
    logic done;

    // Instantiate DUT (Device Under Test)
    update uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .provided_data(provided_data),
        .key(key),
        .v(v),
        .done(done)
    );

    // Clock Generation
    always #5 clk = ~clk;

    // Test Sequence
  initial begin
        clk = 0;
        rst = 1;
        start = 0;
        provided_data = 384'h0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef;
        
        #10 rst = 0;
        #10 start = 1;   // Keep start HIGH for multiple cycles
        #50 start = 0;   // After 50ns, deassert it
        
        #100;  // Allow enough time for updates
        $display("Updated Key: %h", key);
        $display("Updated V: %h", v);
        $finish;
    end


endmodule

