`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2025 04:48:48 PM
// Design Name: 
// Module Name: ctr_drbg_instantiate
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




module ctr_drbg_instantiate (
    input logic clk,
    input logic rst,
    input logic [383:0] entropy_input,           // Full-entropy input
    input logic [383:0] personalization_string,  // Personalization string
    output logic [255:0] new_key,                // Initialized Key
    output logic [127:0] new_V,                  // Initialized V
    output logic [31:0] reseed_counter           // Reseed counter
);

    logic [383:0] seed_material;
    logic [255:0] key;
    logic [127:0] V;

    // Instantiate the CTR DRBG Update function
    ctr_drbg_update update_inst (
        .clk(clk),
        .rst(rst),
        .provided_data(seed_material),
        .key(key),
        .V(V),
        .new_key(new_key),
        .new_V(new_V)
    );

    // Always block with reset logic
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            reseed_counter <= 32'd0;
            key <= 256'h0;
            V <= 128'h0;
        end else begin
            // Step 3: seed_material = entropy_input ⊕ personalization_string
            seed_material <= entropy_input ^ personalization_string;

            // Step 6: Update key and V after calling ctr_drbg_update
            key <= new_key;
            V <= new_V;

            // Step 7: Set reseed_counter to 1 after instantiation
            reseed_counter <= 32'd1;
        end
    end
endmodule


