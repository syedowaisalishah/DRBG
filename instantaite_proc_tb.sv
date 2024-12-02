`timescale 1ns/1ps

module instantiation_proc_tb;

    // Testbench signals
    logic [255:0] entropy;
    logic [383:0] persnolstring;
    logic clk;
    logic rst;
    logic [255:0] key;
    logic [127:0] value;
    logic [31:0] reseedcounter;
    logic [383:0] padded_persnolstring;
    logic [255:0] seedmaterial;

    // Instantiate the DUT (Design Under Test)
    instantiation_proc uut (
        .entropy(entropy),
        .persnolstring(persnolstring),
        .clk(clk),
        .rst(rst),
        .key(key),
        .value(value),
        .reseedcounter(reseedcounter),
        .padded_persnolstring(padded_persnolstring),
        .seedmaterial(seedmaterial)
    );

    // Clock generation (10ns clock period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle clock every 5ns
    end

    // Testbench stimulus
    initial begin
        // Initialize inputs
        entropy = 256'hA5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5;
        persnolstring = 384'hF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0;

        // Apply reset
        rst = 1;
        #20 rst = 0;  // Deassert reset after 20ns

        // Wait for some clock cycles to observe the outputs
        #100;

        // End simulation
        $stop;
    end

endmodule