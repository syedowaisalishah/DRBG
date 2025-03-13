`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2025 03:38:08 AM
// Design Name: 
// Module Name: generate_drbg
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

module generate_drbg(
    input wire clk,
    input wire rst,
    input wire start,
    input wire [255:0] key_in,
    input wire [127:0] v_in,
    input wire [31:0] reseed_counter_in,
    input wire [383:0] additional_input,
    input wire [31:0] requested_bits,
    output reg [255:0] key_out,
    output reg [127:0] v_out,
    output reg [31:0] reseed_counter_out,
    output reg [255:0] random_bits,
    output reg done,
    output reg error
);

    // Constants
    parameter RESEED_INTERVAL = 48'h1000_0000_0000;
    
    // State machine states
    parameter IDLE = 4'd0;
    parameter CHECK_RESEED = 4'd1;
    parameter PROCESS_ADD_INPUT = 4'd2;
    parameter WAIT_UPDATE1 = 4'd3;
    parameter GENERATE_BITS = 4'd4;
    parameter ENCRYPT_BLOCK = 4'd5;
    parameter BACKTRACK_UPDATE = 4'd6;
    parameter WAIT_UPDATE2 = 4'd7;
    parameter COMPLETE = 4'd8;
    parameter ERROR_STATE = 4'd9;

    reg [3:0] current_state;
    reg [3:0] next_state;
    reg [255:0] working_key;
    reg [127:0] working_v;
    reg [31:0] working_counter;
    reg [383:0] padded_additional_input;
    reg update_start;
    wire update_done;
    wire [255:0] updated_key;
    wire [127:0] updated_v;
    
    // Static test value
    wire [255:0] static_key;
    assign static_key = 256'h0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef;
    
    // Instantiate update module
    update u_update(
        .clk(clk),
        .rst(rst),
        .start(update_start),
        .provided_data(padded_additional_input),
        .key(updated_key),
        .v(updated_v),
        .done(update_done)
    );

    // State machine sequential logic
     always @(posedge clk or posedge rst) begin
           if (rst) begin
               current_state <= IDLE;
               working_key <= 256'b0;
               working_v <= 128'b0;
               working_counter <= 32'b0;
               update_start <= 1'b0;
               done <= 1'b0;
               error <= 1'b0;
               key_out <= 256'b0;
               v_out <= 128'b0;
               reseed_counter_out <= 32'b0;
               random_bits <= 256'b0;
               padded_additional_input <= 384'b0;
           end else begin
               current_state <= next_state;
               
               case (current_state)
                   IDLE: begin
                       if (start) begin
                           working_key <= key_in;
                           working_v <= v_in;
                           working_counter <= reseed_counter_in;
                           done <= 1'b0;
                           error <= 1'b0;
                       end
                   end
   
                   CHECK_RESEED: begin
                       if (working_counter > RESEED_INTERVAL) begin
                           error <= 1'b1;
                       end
                   end
   
                   PROCESS_ADD_INPUT: begin
                       padded_additional_input <= additional_input;
                       if (|additional_input) begin
                           update_start <= 1'b1;
                       end
                   end
   
                   WAIT_UPDATE1: begin
                       update_start <= 1'b0;
                       if (update_done) begin
                           working_key <= updated_key;
                           working_v <= updated_v;
                       end
                   end
   
                   GENERATE_BITS: begin
                       working_v <= working_v + 1;  // Increment V for block generation
                       // Don't update outputs yet
                   end
   
                   ENCRYPT_BLOCK: begin
                       // For simulation, using static value for AES output
                       random_bits <= static_key;  // This would be AES(working_key, working_v) in real implementation
                   end
   
                   BACKTRACK_UPDATE: begin
                       update_start <= 1'b1;
                       padded_additional_input <= {working_key, working_v};  // Use current state for update
                   end
   
                   WAIT_UPDATE2: begin
                       update_start <= 1'b0;
                       if (update_done) begin
                           // Update all outputs at once for consistency
                           key_out <= updated_key;
                           v_out <= updated_v;
                           reseed_counter_out <= working_counter + 1;
                           working_key <= updated_key;
                           working_v <= updated_v;
                       end
                   end
   
                   COMPLETE: begin
                       done <= 1'b1;
                   end
   
                   ERROR_STATE: begin
                       done <= 1'b1;
                       error <= 1'b1;
                   end
   
                   default: begin
                       current_state <= IDLE;
                   end
               endcase
           end
       end

    // Next state logic
    always @(*) begin
        next_state = current_state;
        
        case (current_state)
            IDLE: begin
                if (start) next_state = CHECK_RESEED;
            end

            CHECK_RESEED: begin
                if (error)
                    next_state = ERROR_STATE;
                else
                    next_state = PROCESS_ADD_INPUT;
            end

            PROCESS_ADD_INPUT: begin
                if (|additional_input) 
                    next_state = WAIT_UPDATE1;
                else 
                    next_state = GENERATE_BITS;
            end

            WAIT_UPDATE1: begin
                if (update_done) next_state = GENERATE_BITS;
            end

            GENERATE_BITS: begin
                next_state = ENCRYPT_BLOCK;
            end

            ENCRYPT_BLOCK: begin
                next_state = BACKTRACK_UPDATE;
            end

            BACKTRACK_UPDATE: begin
                next_state = WAIT_UPDATE2;
            end

            WAIT_UPDATE2: begin
                if (update_done) next_state = COMPLETE;
            end

            COMPLETE: begin
                next_state = IDLE;
            end

            ERROR_STATE: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule