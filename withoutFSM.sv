extern module MULT_FSM (
    input logic SYS_CLOCK,
    input logic FSM_ARESET,
    input logic GO,
    input logic [2: 0] A,
    input logic [2: 0] B,
    input logic R2_LT_B_1,
    output logic MUX_IN1_CONT, MUX_IN2_CONT,
    output logic [1:0] ALU_CONT,
    output logic LOAD_A_REG, LOAD_B_REG, LOAD_R1_REG, LOAD_R2_REG, LOAD_F_REG,
    output logic START
);

module MULT_FSM (.*);	 
    logic [1 : 0] P_STATE, N_STATE;	

    always_comb begin : NEXT_STATE_LOGIC	
        N_STATE = 2'b00;
        case (P_STATE)
            2'b00: if (GO) N_STATE = (A==0 || B==0) ? 2'b11 : 2'b01;
                   else N_STATE = 2'b00;
            2'b01: N_STATE = 2'b10;
            2'b10: N_STATE = R2_LT_B_1 ? 2'b01 : 2'b11;
            2'b11: N_STATE = 2'b00;
            default: N_STATE = 2'b00;
        endcase
    end

    always_comb begin: OUTPUT_LOGIC
        {LOAD_R1_REG, LOAD_R2_REG, ALU_CONT, LOAD_A_REG, LOAD_B_REG, MUX_IN1_CONT, MUX_IN2_CONT, LOAD_F_REG, START} = '0;
        case (P_STATE)
            2'b00: begin
                START = 1;
                if(GO) begin
                    LOAD_A_REG=1; LOAD_B_REG=1; ALU_CONT=2; LOAD_R2_REG=1; LOAD_R1_REG=1;
                end
            end
            2'b01: begin
                ALU_CONT = 0; LOAD_R1_REG=1; MUX_IN1_CONT=0; MUX_IN2_CONT=0;
            end 
            2'b10: begin
                MUX_IN2_CONT=1; ALU_CONT=1; LOAD_R2_REG=1;
            end
            2'b11: LOAD_F_REG = 1;
        endcase	   
    end

    always_ff @ (posedge SYS_CLOCK, posedge FSM_ARESET) begin
        if (FSM_ARESET) P_STATE <= 2'b00;
        else P_STATE <= N_STATE;
    end
endmodule