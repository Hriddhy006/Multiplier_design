extern module MULT_DATAPATH(
    input logic SYS_CLOCK,
    input logic [2:0] A, B,
    input logic MUX_IN1_CONT, MUX_IN2_CONT,
    input logic [1:0] ALU_CONT, // Changed to 2-bit to match FSM
    input logic LOAD_A_REG, LOAD_B_REG,
    input logic LOAD_R1_REG, LOAD_R2_REG,
    input logic LOAD_F_REG,
    output logic [5:0] F_REG,
    output logic R2_LT_B_1 // Name must match Top-Level and FSM
);

module MULT_DATAPATH (.*);
    logic [2:0] A_REG, B_REG, B_1;
    logic [5:0] R1_REG, R2_REG;
    logic [5:0] ALU_INP1, ALU_INP2, ALU_OUT;

    always_ff @ (posedge SYS_CLOCK) begin: INP_REGS
        if (LOAD_A_REG) A_REG <= A;
        if (LOAD_B_REG) B_REG <= B;
    end

    always_ff @(posedge SYS_CLOCK) begin: ACCUM_REGS
        if (LOAD_R1_REG) R1_REG <= ALU_OUT;
        if (LOAD_R2_REG) R2_REG <= ALU_OUT;
    end

    always_ff @(posedge SYS_CLOCK) begin: OUT_REGS
        if (LOAD_F_REG) F_REG <= R1_REG;
    end

    always_comb begin: MUXES
        case (MUX_IN1_CONT)
            1'b0: ALU_INP1 = R1_REG;
            1'b1: ALU_INP1 = {3'b000, A_REG}; // Zero-extend A_REG to 6 bits
            default: ALU_INP1 = '0;
        endcase 

        case (MUX_IN2_CONT)
            1'b0: ALU_INP2 = {3'b000, A_REG};
            1'b1: ALU_INP2 = R2_REG;	 
            default: ALU_INP2 = '0;
        endcase
    end

    always_comb begin: ALU
        case (ALU_CONT)	 
            2'b00: ALU_OUT = ALU_INP1 + ALU_INP2; // Repeated addition
            2'b01: ALU_OUT = ALU_INP2 + 1;        // Internal counting using ALU
            2'b10: ALU_OUT = '0;                  // Clear/Reset ALU
            default: ALU_OUT = '0;
        endcase
    end

    always_comb begin: SUBSTRACTOR
        B_1 = B_REG - 1;
    end

    always_comb begin: COMPARATOR
        if (R2_REG < {3'b000, B_1}) R2_LT_B_1 = 1'b1;
        else R2_LT_B_1 = 1'b0;
    end
endmodule