`timescale 1ns / 1ps 

module UNS_3X3_MULT_tb;
    // Clock and Physical Control Inputs
    reg SYS_CLOCK;
    reg GO;          
    reg FSM_ARESET;  

    // Signals for Waveform
    logic SCLR;      // Synchronous Clear
    logic LOAD;      // Pulse signal to start multiplication

    // Top-Level Outputs
    wire [5:0] F_REG;
    wire R2_LT_B_1;

    // Logic to drive Waveform Labels
    assign LOAD = GO; 
    // SCLR is active when the FSM is in the IDLE state (2'b00) 
    assign SCLR = (UUT.FSM.P_STATE == 2'b00); 

    // Instantiate the Unit Under Test (UUT)
    UNS_3X3_MULT UUT (
        .SYS_CLOCK(SYS_CLOCK),
        .FSM_ARESET(FSM_ARESET),
        .GO(GO),
        .A(A),
        .B(B),
        .F_REG(F_REG),
        .R2_LT_B_1(R2_LT_B_1)
    );

    // Ports and stimulus logic...
    logic [2:0] A, B;

    // 10 MHz Clock Generator
    initial begin
        SYS_CLOCK = 0;
        forever #50ns SYS_CLOCK = ~SYS_CLOCK;
    end

    initial begin: STIMULUS
        A = 3'd7; B = 3'd3;
        FSM_ARESET = 1; GO = 0;
        #120ns;
        FSM_ARESET = 0; // Release Reset
        #100ns;
        GO = 1;         // Drive LOAD high
        #100ns;
        GO = 0;         // Release LOAD
    end

    initial begin
        #5000ns; 
        $finish;
    end
endmodule