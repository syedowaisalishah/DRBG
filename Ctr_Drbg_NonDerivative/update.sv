timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2025 07:32:32 AM
// Design Name: 
// Module Name: update
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

module update (
    input logic clk,
    input logic rst,
    input logic start,
    input logic [383:0] provided_data,
    output logic [255:0] key,
    output logic [127:0] v,
    output logic done
);
    
    logic [383:0] temp;
    logic [255:0] static_key = 256'h0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef;
    logic [127:0] static_v = 128'h0123456789abcdef0123456789abcdef;
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            key <= 256'b0;
            v <= 128'b0;
            done <= 0;
        end else if (start) begin
            key <= provided_data[383:128]; // Extract Key from provided_data
            v <= provided_data[127:0];     // Extract v from provided_data
            done <= 1;
        end else begin
            done <= 0;
        end
    end



endmodule

