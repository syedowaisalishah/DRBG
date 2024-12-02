`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2024 08:38:56 PM
// Design Name: 
// Module Name: instantiate_proc
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

module instantiation_proc (
    input logic [255:0] entropy,                
    input logic [383:0] persnolstring,           
    input logic clk,                             
    input logic rst,                            
    output logic [255:0] key,                    
    output logic [127:0] value,                  
    output logic [31:0] reseedcounter,           
    output logic [383:0] padded_persnolstring,  
    output logic [255:0] seedmaterial           

    logic [383:0] zero_padding;


    always_comb begin
        zero_padding = 384'b0;  
        padded_persnolstring = persnolstring | zero_padding; 
    end


    assign seedmaterial = entropy ^ padded_persnolstring[255:0]; 

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            key <= 256'b0;
            value <= 128'b0;
            reseedcounter <= 32'b1;
        end else begin
         
            key <= 256'b0;  
            value <= 128'b0; 
            reseedcounter <= reseedcounter;  
        end
    end

endmodule