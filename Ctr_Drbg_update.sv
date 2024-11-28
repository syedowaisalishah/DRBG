module CTR_DRBG_Update #( 
    parameter BLOCKLEN = 128,  // Block length in bits (e.g., 128 for AES)
    parameter KEYLEN = 128,    // Key length in bits (e.g., 128 for AES)
    parameter SEEDLEN = 256    // Seed length in bits (must be a multiple of BLOCKLEN)
) (
    input  logic [SEEDLEN-1:0] provided_data,
    input  logic [KEYLEN-1:0]  Key_in,
    input  logic [BLOCKLEN-1:0] V_in,
    output logic [KEYLEN-1:0]  Key_out,
    output logic [BLOCKLEN-1:0] V_out
);

    logic [SEEDLEN-1:0] temp;
    logic [BLOCKLEN-1:0] V_temp;
    logic [KEYLEN-1:0] Key_temp;

    // Temporary register for output blocks
    logic [BLOCKLEN-1:0] output_block;
    
    // Block encryption function (stub for now, replace with AES encryption)
    function [BLOCKLEN-1:0] Block_Encrypt (
        input logic [KEYLEN-1:0] Key,
        input logic [BLOCKLEN-1:0] V
    );
        // Placeholder for encryption operation
        Block_Encrypt = V ^ Key;  // Simplified for example
    endfunction

    initial begin
        temp = 0;
        V_temp = V_in;

        // Generate seedlen bits
        while ($bits(temp) < SEEDLEN) begin
            // Increment V
            V_temp = V_temp + 1; // Simplified, assumes no ctr_len logic here
            output_block = Block_Encrypt(Key_in, V_temp);

            // Truncate the concatenation to SEEDLEN bits
            temp = {temp, output_block};  
            temp = temp[SEEDLEN-1:0];  // Ensure temp is only SEEDLEN bits
        end

        // XOR temp with provided_data
        temp = temp ^ provided_data;

        // Update Key and V
        Key_temp = temp[SEEDLEN-1:SEEDLEN-KEYLEN];  // Extract keylen bits for Key
        V_temp   = temp[KEYLEN-1:0];                // Extract blocklen bits for V

        Key_out = Key_temp;
        V_out   = V_temp;
    end
endmodule
