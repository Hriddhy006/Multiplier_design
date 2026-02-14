extern module UNS_3X3_MULT (
	input logic SYS_CLOCK,
    input logic FSM_ARESET,
    input logic GO,
    input logic [2: 0] A,
    input logic [2: 0] B,
    output logic [5 : 0] F_REG,
    output logic R2_LT_B
);

module UNS_3X3_MULT (.*);
    
    logic MUX_IN1_CONT;
    logic ALU_CONT;
    logic LOAD_A_REG, LOAD_B_REG, LOAD_R1_REG,SCLR,INC, LOAD_F_REG;
    logic START;
    
    MULT_FSM FSM (.*);
    MULT_DATAPATH DP (.*);
endmodule : UNS_3X3_MULT
