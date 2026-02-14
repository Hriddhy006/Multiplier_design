// counter dpath.sv
extern module MULT_DATAPATH(
    input logic SYS_CLOCK,
    input logic [2:0] A, B,
    input logic MUX_IN1_CONT, ALU_CONT, SCLR, INC,
    input logic LOAD_A_REG, LOAD_B_REG, LOAD_R1_REG, LOAD_F_REG,
    output logic [5:0] F_REG,
    output logic R2_LT_B
);

module MULT_DATAPATH (.*);
    logic [2:0] A_REG, B_REG, Q1;
    logic [5:0] R1_REG, ALU_INP1, ALU_INP2, ALU_OUT;

    always_ff @ (posedge SYS_CLOCK) begin: INP_REGS
        if (LOAD_A_REG) A_REG <= A;
        if (LOAD_B_REG) B_REG <= B;
    end

    always_ff @(posedge SYS_CLOCK) begin: ACCUM_REGS
        if (LOAD_R1_REG) R1_REG <= ALU_OUT;
    end

    always_ff @(posedge SYS_CLOCK) begin: COUNTER_LOGIC
        if (SCLR) Q1 <= 3'b001;
        else if (INC) Q1 <= Q1 + 1;
    end

    always_comb begin: MUXES
        ALU_INP1 = (MUX_IN1_CONT) ? {3'b000, A_REG} : R1_REG;
    end

    always_comb begin: ALU 
        ALU_INP2 = {3'b000, A_REG};
        ALU_OUT = (ALU_CONT) ? 6'b0 : (ALU_INP1 + ALU_INP2);
    end

    always_comb begin: COMPARATOR  
        R2_LT_B = (Q1 < B_REG); // Returns 1 if another addition is needed
    end

    always_ff @(posedge SYS_CLOCK) begin: OUT_REGS
        if (LOAD_F_REG) F_REG <= R1_REG;
    end
endmodule