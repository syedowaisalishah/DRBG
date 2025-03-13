`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2025 07:16:45 AM
// Design Name: 
// Module Name: ctr_drbg_top
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

module ctr_drbg_top (
    input wire clk,
    input wire rst,
    input wire start,
    input wire [1:0] operation,    // 00: instantiate, 01: generate, 10: reseed
    
    // Common inputs
    input wire [383:0] entropy_input,
    input wire [383:0] additional_input,
    input wire [31:0] requested_bits,
    
    // Working state
    output reg [255:0] key,        
    output reg [127:0] v,          
    output reg [31:0] reseed_counter,
    
    // Outputs
    output reg [255:0] random_bits,
    output reg done,
    output reg error,
    output reg needs_reseed
);

    // Operation types
    localparam [1:0] INSTANTIATE = 2'b00;
    localparam [1:0] GENERATE   = 2'b01;
    localparam [1:0] RESEED    = 2'b10;

    // Internal signals for instantiate module
    wire inst_done;
    wire [255:0] inst_key;
    wire [127:0] inst_v;
    wire [31:0] inst_reseed_counter;

    // Internal signals for generate module
    wire gen_done;
    wire gen_error;
    wire [255:0] gen_key;
    wire [127:0] gen_v;
    wire [31:0] gen_reseed_counter;
    wire [255:0] gen_random_bits;

    // Internal signals for reseed module
    wire reseed_done;
    wire reseed_error;
    wire [255:0] reseed_key;
    wire [127:0] reseed_v;
    wire [31:0] reseed_reseed_counter;

    // Control signals
    reg inst_start, gen_start, reseed_start;
    reg internal_error;

    // Instantiate modules
    instantiate u_instantiate(
        .clk(clk),
        .rst(rst),
        .start(inst_start),
        .entropy_input(entropy_input),
        .personalization_string(additional_input),
        .initial_key(inst_key),
        .initial_v(inst_v),
        .reseed_counter(inst_reseed_counter),
        .done(inst_done)
    );

    generate_drbg u_generate(
        .clk(clk),
        .rst(rst),
        .start(gen_start),
        .key_in(key),
        .v_in(v),
        .reseed_counter_in(reseed_counter),
        .additional_input(additional_input),
        .requested_bits(requested_bits),
        .key_out(gen_key),
        .v_out(gen_v),
        .reseed_counter_out(gen_reseed_counter),
        .random_bits(gen_random_bits),
        .done(gen_done),
        .error(gen_error)
    );

    reseed_drbg u_reseed(
        .clk(clk),
        .rst(rst),
        .start(reseed_start),
        .key_in(key),
        .v_in(v),
        .reseed_counter_in(reseed_counter),
        .entropy_input(entropy_input),
        .additional_input(additional_input),
        .key_out(reseed_key),
        .v_out(reseed_v),
        .reseed_counter_out(reseed_reseed_counter),
        .done(reseed_done),
        .error(reseed_error)
    );

    // Reseed threshold check
    localparam [47:0] RESEED_INTERVAL = 48'h1000_0000_0000;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            needs_reseed <= 0;
        end else begin
            needs_reseed <= (reseed_counter >= RESEED_INTERVAL);
        end
    end

    // Main control logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            key <= 256'b0;
            v <= 128'b0;
            reseed_counter <= 32'b0;
            random_bits <= 256'b0;
            done <= 1'b0;
            error <= 1'b0;
            internal_error <= 1'b0;
            inst_start <= 1'b0;
            gen_start <= 1'b0;
            reseed_start <= 1'b0;
        end else begin
            // Default values
            inst_start <= 1'b0;
            gen_start <= 1'b0;
            reseed_start <= 1'b0;
            done <= 1'b0;

            // Error handling
            if (gen_error || reseed_error || internal_error) begin
                error <= 1'b1;
            end else begin
                error <= 1'b0;
            end

            if (start) begin
                case (operation)
                    INSTANTIATE: begin
                        inst_start <= 1'b1;
                        internal_error <= 1'b0;
                    end
                    
                    GENERATE: begin
                        if (needs_reseed) begin
                            internal_error <= 1'b1;
                            done <= 1'b1;
                        end else begin
                            gen_start <= 1'b1;
                            internal_error <= 1'b0;
                        end
                    end
                    
                    RESEED: begin
                        reseed_start <= 1'b1;
                        internal_error <= 1'b0;
                    end
                    
                    default: begin
                        internal_error <= 1'b1;
                        done <= 1'b1;
                    end
                endcase
            end

            // Update outputs based on completed operations
            if (inst_done) begin
                key <= inst_key;
                v <= inst_v;
                reseed_counter <= inst_reseed_counter;
                done <= 1'b1;
            end else if (gen_done) begin
                key <= gen_key;
                v <= gen_v;
                reseed_counter <= gen_reseed_counter;
                random_bits <= gen_random_bits;
                done <= 1'b1;
            end else if (reseed_done) begin
                key <= reseed_key;
                v <= reseed_v;
                reseed_counter <= reseed_reseed_counter;
                done <= 1'b1;
            end
        end
    end

endmodule