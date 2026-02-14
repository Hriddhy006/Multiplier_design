extern module UNS_3X3_MULT (
    input logic SYS_CLOCK,
    input logic FSM_ARESET,
    input logic GO,
    input logic [2: 0] A,
    input logic [2: 0] B,
    output var logic [5 : 0] F_REG,
    output var logic R2_LT_B_1 
);

module UNS_3X3_MULT (.*);
    logic MUX_IN1_CONT, MUX_IN2_CONT;
    logic [1:0] ALU_CONT;
    logic LOAD_A_REG, LOAD_B_REG, LOAD_R1_REG, LOAD_R2_REG, LOAD_F_REG;
    logic START;

    // These instances use .* which requires identical signal names in all 3 modules
    MULT_FSM FSM (.*);
    MULT_DATAPATH DP (.*);
endmodule