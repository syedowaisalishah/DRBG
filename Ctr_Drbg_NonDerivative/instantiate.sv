`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2025 03:14:20 AM
// Design Name: 
// Module Name: instantiate
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

module instantiate (
    input wire clk,
    input wire rst,
    input wire start,
    input wire [383:0] entropy_input,
    input wire [383:0] personalization_string,
    output reg [255:0] initial_key,
    output reg [127:0] initial_v,
    output reg [31:0] reseed_counter,
    output reg done
);

    // State machine states
    localparam IDLE = 3'd0;
    localparam PREPARE_SEED = 3'd1;
    localparam UPDATE_PROCESS = 3'd2;
    localparam WAIT_UPDATE = 3'd3;
    localparam COMPLETE = 3'd4;

    reg [2:0] current_state, next_state;

    // Internal signals
    reg [383:0] seed_material;
    reg update_start;
    wire update_done;
    wire [255:0] updated_key;
    wire [127:0] updated_v;

    // Instantiate update module
    update u_update (
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
            initial_key <= 256'd0;
            initial_v <= 128'd0;
            reseed_counter <= 32'd0;
            done <= 1'b0;
            update_start <= 1'b0;
            seed_material <= 384'd0;
        end else begin
            current_state <= next_state;

            case (current_state)
                IDLE: begin
                    if (start) begin
                        done <= 1'b0;
                        update_start <= 1'b0;
                    end
                end

                PREPARE_SEED: begin
                    // seed_material = entropy_input ⊕ personalization_string
                    seed_material <= entropy_input ^ personalization_string;
                    update_start <= 1'b1;
                end

                UPDATE_PROCESS: begin
                    update_start <= 1'b0;
                end

                WAIT_UPDATE: begin
                    if (update_done) begin
                        initial_key <= updated_key;
                        initial_v <= updated_v;
                        reseed_counter <= 32'd1;
                    end
                end

                COMPLETE: begin
                    done <= 1'b1;
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
                if (start) begin
                    next_state = PREPARE_SEED;
                end
            end

            PREPARE_SEED: begin
                next_state = UPDATE_PROCESS;
            end

            UPDATE_PROCESS: begin
                next_state = WAIT_UPDATE;
            end

            WAIT_UPDATE: begin
                if (update_done) begin
                    next_state = COMPLETE;
                end
            end

            COMPLETE: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule