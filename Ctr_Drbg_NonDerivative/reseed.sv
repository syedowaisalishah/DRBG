`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2025 06:51:09 AM
// Design Name: 
// Module Name: reseed_drbg
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

module reseed_drbg(
    input wire clk,
    input wire rst,
    input wire start,
    input wire [255:0] key_in,
    input wire [127:0] v_in,
    input wire [31:0] reseed_counter_in,
    input wire [383:0] entropy_input,
    input wire [383:0] additional_input,
    output reg [255:0] key_out,
    output reg [127:0] v_out,
    output reg [31:0] reseed_counter_out,
    output reg done,
    output reg error
);

    // State machine states
    parameter IDLE = 3'd0;
    parameter PREPARE_SEED = 3'd1;
    parameter UPDATE = 3'd2;
    parameter WAIT_UPDATE = 3'd3;
    parameter COMPLETE = 3'd4;

    reg [2:0] current_state, next_state;
    reg [383:0] seed_material;
    reg update_start;
    wire update_done;
    wire [255:0] updated_key;
    wire [127:0] updated_v;

    // Instantiate update module
    update u_update(
        .clk(clk),
        .rst(rst),
        .start(update_start),
        .provided_data(seed_material),
        .key(updated_key),
        .v(updated_v),
        .done(update_done)
    );

    // Sequential logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= IDLE;
            seed_material <= 384'b0;
            update_start <= 1'b0;
            key_out <= 256'b0;
            v_out <= 128'b0;
            reseed_counter_out <= 32'b0;
            done <= 1'b0;
            error <= 1'b0;
        end else begin
            current_state <= next_state;
            
            case (current_state)
                IDLE: begin
                    if (start) begin
                        done <= 1'b0;
                        error <= 1'b0;
                    end
                end

                PREPARE_SEED: begin
                    // Step 3: seed_material = entropy_input ⊕ additional_input
                    seed_material <= entropy_input ^ additional_input;
                    update_start <= 1'b1;
                end

                UPDATE: begin
                    update_start <= 1'b0;
                end

                WAIT_UPDATE: begin
                    if (update_done) begin
                        // Step 4: Update key and v
                        key_out <= updated_key;
                        v_out <= updated_v;
                        // Step 5: Reset reseed counter
                        reseed_counter_out <= 32'd1;
                    end
                end

                COMPLETE: begin
                    done <= 1'b1;
                end
            endcase
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;
        
        case (current_state)
            IDLE: begin
                if (start) next_state = PREPARE_SEED;
            end

            PREPARE_SEED: begin
                next_state = UPDATE;
            end

            UPDATE: begin
                next_state = WAIT_UPDATE;
            end

            WAIT_UPDATE: begin
                if (update_done) next_state = COMPLETE;
            end

            COMPLETE: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule