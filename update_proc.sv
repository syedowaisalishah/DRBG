module update_proc (
    input logic clk,
    input logic rst,
    input logic start,                          // Start signal to trigger the process
    input logic [383:0] provided_data,          // 384-bit input data
    input logic [255:0] key_in,                 // 256-bit current Key
    input logic [127:0] v_in,                   // 128-bit current V
    output logic [255:0] key_out,               // 256-bit updated Key
    output logic [127:0] v_out,                 // 128-bit updated V
    output logic done                           // Done signal to indicate process completion
);

    // Internal variables
    logic [127:0] temp [0:2];                   // Temporary storage for seedlen (384 bits)
    logic [127:0] v_reg;                        // Register to hold the value of V
    logic [383:0] temp_concat;                  // Concatenated temp values
    logic [383:0] temp_xor;                     // XOR result of temp and provided_data

    // State machine variables
    typedef enum logic [1:0] {
        IDLE,                                   // Waiting for start signal
        PROCESS,                                // Processing CTR_DRBG_Update
        FINISH                                  // Finish and output the result
    } state_t;

    state_t current_state, next_state;

    // Initialization
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= IDLE;
            v_reg <= 128'b0;
            temp[0] <= 128'b0;
            temp[1] <= 128'b0;
            temp[2] <= 128'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // State Machine Transitions
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (start) begin
                    v_reg = v_in;               // Initialize V
                    temp[0] = 128'b0;
                    temp[1] = 128'b0;
                    temp[2] = 128'b0;
                    next_state = PROCESS;
                end
            end

            PROCESS: begin
                // Increment V (CTR logic)
                v_reg = v_reg + 1;

                // Static AES encryption function (replace later with actual AES module)
                temp[0] = aes_encrypt(key_in, v_reg);
                v_reg = v_reg + 1;
                temp[1] = aes_encrypt(key_in, v_reg);
                v_reg = v_reg + 1;
                temp[2] = aes_encrypt(key_in, v_reg);

                // Concatenate temp values and XOR with provided_data
                temp_concat = {temp[0], temp[1], temp[2]};
                temp_xor = temp_concat ^ provided_data;

                next_state = FINISH;
            end

            FINISH: begin
                // Update Key and V based on XOR result
                key_out = temp_xor[383:128];    // Leftmost 256 bits for Key
                v_out = temp_xor[127:0];        // Rightmost 128 bits for V
                next_state = IDLE;              // Return to IDLE state
            end
        endcase
    end

    // Done signal to indicate completion
    assign done = (current_state == FINISH);

    // Dummy AES Encryption Function (Replace with actual AES)
    function logic [127:0] aes_encrypt(input logic [255:0] key, input logic [127:0] v);
        begin
            // This is a placeholder function that returns a static value
            aes_encrypt = 128'hDEADBEEFCAFEBABEDEADBEEFCAFEBABE;
        end
    endfunction

endmodule
