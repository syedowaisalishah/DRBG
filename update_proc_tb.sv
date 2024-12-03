`timescale 1ns/1ps

module update_proc_tb;

    logic clk;
    logic rst;
    logic start;
    logic [383:0] provided_data;
    logic [255:0] key_in;
    logic [127:0] v_in;
    logic [255:0] key_out;
    logic [127:0] v_out;
    logic done;

    // Instantiate the DUT
    update_proc dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .provided_data(provided_data),
        .key_in(key_in),
        .v_in(v_in),
        .key_out(key_out),
        .v_out(v_out),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns clock period
    end

    // Test stimulus
    initial begin
        rst = 1;
        start = 0;
        provided_data = 384'hA5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5;
        key_in = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        v_in = 128'h123456789ABCDEF0123456789ABCDEF0;

        #10 rst = 0;
        #20 start = 1;
        #10 start = 0;

        // Wait for done
        wait(done);
        #10;

        // Check output
        $display("Key Out: %h", key_out);
        $display("V Out: %h", v_out);

        $stop;
    end

endmodule
