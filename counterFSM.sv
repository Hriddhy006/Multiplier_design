// counterFSM.sv
extern module MULT_FSM (
    input logic SYS_CLOCK, FSM_ARESET, GO,
    input logic [2:0] A, B,
    input logic R2_LT_B,
    output logic MUX_IN1_CONT, ALU_CONT, SCLR, INC,
    output logic LOAD_A_REG, LOAD_B_REG, LOAD_R1_REG, LOAD_F_REG,
    output logic START
);

module MULT_FSM (.*);	 
    logic [1 : 0] P_STATE, N_STATE;	

    always_comb begin : NEXT_STATE_LOGIC	
        case (P_STATE)
            2'b00: N_STATE = (GO) ? ((A==0 || B==0) ? 2'b10 : 2'b01) : 2'b00;
            2'b01: N_STATE = (R2_LT_B) ? 2'b01 : 2'b10;
            2'b10: N_STATE = 2'b00;
            default: N_STATE = 2'b00;
        endcase
    end

    always_comb begin: OUTPUT_LOGIC
        {LOAD_R1_REG, ALU_CONT, LOAD_A_REG, LOAD_B_REG, MUX_IN1_CONT, LOAD_F_REG, SCLR, INC, START} = '0;
        case (P_STATE)
            2'b00: begin
                START = 1;
                if (GO) begin
                    {LOAD_A_REG, LOAD_B_REG, SCLR, ALU_CONT, LOAD_R1_REG} = 5'b11111;
                end
            end
            2'b01: begin
                {ALU_CONT, LOAD_R1_REG, MUX_IN1_CONT, INC} = 4'b0101;
            end 
            2'b10: LOAD_F_REG = 1;
        endcase	   
    end

    always_ff @ (posedge SYS_CLOCK, posedge FSM_ARESET) begin
        if (FSM_ARESET) P_STATE <= 2'b00;
        else P_STATE <= N_STATE;
    end
endmodule