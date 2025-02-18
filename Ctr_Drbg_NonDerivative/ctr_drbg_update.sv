`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2025 04:40:16 PM
// Design Name: 
// Module Name: ctr_drbg_update
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Updated with XOR-based state update logic
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ctr_drbg_update (
    input logic clk,
    input logic rst,
    input logic [383:0] provided_data,  // Updated to 384 bits
    input logic [255:0] key,            // 256 bits for AES-256
    input logic [127:0] V,              // Initialization vector
    output logic [255:0] new_key,       // Updated to 256 bits
    output logic [127:0] new_V
);

    // Block Encryption function
    function [255:0] block_encrypt (input [255:0] key, input [127:0] data);
        block_encrypt = {data, data} ^ key;  // Simplified encryption for illustration purposes
    endfunction

    // Sequential logic for updating new_key and new_V
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            new_key <= 256'h0;  // Reset new_key to all zeros
            new_V <= 128'h0;    // Reset new_V to all zeros
        end else begin
            // XOR-based logic to update key and V
            new_key <= key ^ provided_data[255:0];   // XOR key with lower 256 bits of provided data
            new_V <= V ^ provided_data[127:0];       // XOR V with lower 128 bits of provided data
        end
    end
endmodule
