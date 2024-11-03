module DRBG_Instantiate (
    input logic clk,
    input logic rst_n,
    input logic [7:0] requested_instantiation_security_strength,
    input logic prediction_resistance_flag,
    input logic prediction_resistance_supported,
    input logic [127:0] personalization_string,
    input logic [7:0] max_personalization_string_length,
    output logic success,
    output logic error_flag,
    output logic catastrophic_error_flag,
    output logic [7:0] security_strength,
    output logic [127:0] state_handle
);

    // Parameters and constants with updated width
    parameter logic [7:0] highest_supported_security_strength = 8'd254;
    parameter logic [7:0] supported_security_strengths [3:0] = '{8'd112, 8'd128, 8'd192, 8'd255};
    parameter int min_entropy_length = 32;
    parameter int max_entropy_length = 64;
    
    // Internal signals and registers
    logic [127:0] entropy_input;
    logic [127:0] nonce;
    logic [127:0] initial_working_state;
    logic [3:0]  state; // FSM state
    logic [127:0] working_state;

    // States for FSM
    typedef enum logic [3:0] {
        IDLE = 4'b0000,
        CHECK_SECURITY = 4'b0001,
        CHECK_PRED_RESISTANCE = 4'b0010,
        CHECK_PERSONALIZATION_LENGTH = 4'b0011,
        SET_SECURITY_STRENGTH = 4'b0100,
        GET_ENTROPY = 4'b0101,
        CHECK_ENTROPY_STATUS = 4'b0110,
        GET_NONCE = 4'b0111,
        INSTANTIATE_WORKING_STATE = 4'b1000,
        SET_INTERNAL_STATE = 4'b1001,
        COMPLETE = 4'b1010,
        ERROR = 4'b1011
    } fsm_states;

    // FSM to execute the algorithm step-by-step
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            success <= 0;
            error_flag <= 0;
            catastrophic_error_flag <= 0;
            security_strength <= 0;
            state_handle <= 0;
        end else begin
            case (state)
                IDLE: begin
                    // Go to check security strength
                    state <= CHECK_SECURITY;
                end

                CHECK_SECURITY: begin
                    if (requested_instantiation_security_strength > highest_supported_security_strength) begin
                        error_flag <= 1;
                        state <= ERROR;
                    end else begin
                        state <= CHECK_PRED_RESISTANCE;
                    end
                end

                CHECK_PRED_RESISTANCE: begin
                    if (prediction_resistance_flag && !prediction_resistance_supported) begin
                        error_flag <= 1;
                        state <= ERROR;
                    end else begin
                        state <= CHECK_PERSONALIZATION_LENGTH;
                    end
                end

                CHECK_PERSONALIZATION_LENGTH: begin
                    if ($bits(personalization_string) > max_personalization_string_length) begin
                        error_flag <= 1;
                        state <= ERROR;
                    end else begin
                        state <= SET_SECURITY_STRENGTH;
                    end
                end

                SET_SECURITY_STRENGTH: begin
                    // Set security_strength to nearest supported level
                    foreach (supported_security_strengths[i]) begin
                        if (supported_security_strengths[i] >= requested_instantiation_security_strength) begin
                            security_strength <= supported_security_strengths[i];
                            state <= GET_ENTROPY;
                            break;
                        end
                    end
                end

                GET_ENTROPY: begin
                    // Simulate entropy gathering (here, simply setting a default value)
                    entropy_input <= 128'hCAFEBABE123456789ABCDEF012345678;
                    state <= CHECK_ENTROPY_STATUS;
                end

                CHECK_ENTROPY_STATUS: begin
                    if (entropy_input == 0) begin
                        error_flag <= 1;
                        state <= ERROR;
                    end else begin
                        state <= GET_NONCE;
                    end
                end

                GET_NONCE: begin
                    // Simulate nonce generation
                    nonce <= 128'hDEADBEEFDEADBEEFDEADBEEFDEADBEEF;
                    state <= INSTANTIATE_WORKING_STATE;
                end

                INSTANTIATE_WORKING_STATE: begin
                    // Simulate working state instantiation
                    initial_working_state <= entropy_input ^ nonce ^ personalization_string;
                    state <= SET_INTERNAL_STATE;
                end

                SET_INTERNAL_STATE: begin
                    // Set internal state
                    working_state <= initial_working_state;
                    state_handle <= 128'h0BADCAFEBADCAFE0BADCAFEBADCAFE;
                    state <= COMPLETE;
                end

                COMPLETE: begin
                    success <= 1;
                    state <= IDLE; // Reset to idle after completion
                end

                ERROR: begin
                    success <= 0;
                    state <= IDLE; // Reset to idle on error
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
