`timescale 1ns / 1ps 

module UNS_3X3_MULT_tb;
    reg SYS_CLOCK, GO, FSM_ARESET;
    wire R2_LT_B;
    wire [5:0] F_REG;
    logic [2:0] A, B;

    // Probes for Waveform (These will appear in the Structure tab)
    logic SCLR, LOAD, INC;
    logic [1:0] P_STATE;
    logic [5:0] ALU_OUT;

    assign SCLR = UUT.SCLR;
    assign INC  = UUT.INC;
    assign LOAD = GO;
    assign P_STATE = UUT.FSM.P_STATE;
    assign ALU_OUT = UUT.DP.ALU_OUT;

    UNS_3X3_MULT UUT (.*);

    initial begin : CLOCK_GEN
        SYS_CLOCK = 0;
        forever #50ns SYS_CLOCK = ~SYS_CLOCK;
    end

    initial begin : STIMULUS
        A = 3'd7; B = 3'd3;
        FSM_ARESET = 1; GO = 0;
        #120ns FSM_ARESET = 0;
        #100ns GO = 1;
        #100ns GO = 0;
        #5000ns $finish;
    end
endmodule