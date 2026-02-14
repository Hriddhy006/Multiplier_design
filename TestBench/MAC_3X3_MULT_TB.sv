//-----------------------------------------------------------------------------
//
// Title       : MAC_3X3_MULT_tb
// Design      : VL_2001
// Author      : SMR
// Company     : AIUB
//
//-----------------------------------------------------------------------------
//
// File        : MAC_3X3_MULT_TB.v
// Generated   : Sat Nov 23 09:58:24 2024
// From        : c:\My_Designs\Lab_5\VL_2001\src\TestBench\MAC_3X3_MULT_TB_settings.txt
// By          : tb_verilog.pl ver. ver 1.2s
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------

timeunit 1ns;
timeprecision 1ps;

import MAC_PACKAGE::*; 

module MAC_3X3_MULT_tb;


//Internal signals declarations:
logic SYS_CLOCK;
logic SCLR;
logic LOAD;
logic [WIDTH-1:0]A;
logic [WIDTH-1:0]B;
logic [(2*WIDTH)-1:0]MAC_OUT;



// Unit Under Test port map
//	MAC_3X3_MULT UUT (
//		.SYS_CLOCK(SYS_CLOCK),
//		.SCLR(SCLR),
//		.LOAD(LOAD),
//		.A(A),
//		.B(B),
//		.MAC_OUT(MAC_OUT));	
MAC_3X3_MULT UUT (.*);


//Stimulus
//Clock Generator
initial
begin
SYS_CLOCK = 0;	

	forever
	begin  
	#50ns;  //clock toggles every 50 ns, clock period = 100 ns, clock f = 10 MHz
	SYS_CLOCK = ~SYS_CLOCK;	
	end
end	

//Stimulus for Control Inputs (SCLR, LOAD)
initial
begin
SCLR = 1; LOAD = 0;
#100ns;
SCLR = 0; LOAD = 1;
#7000ns;
SCLR = 1;

end

//Stimulus for Data Inputs (A, B)
initial
begin
A = 3'd2; B = 3'd3;	

fork
	forever
	begin
	#100ns;
	A = A + 1;
	end	  
	
	forever
	begin
	#800ns;
	B = B + 1;
	end	

join

end	 

//Simulator Control
time RUN_TIME = 7100;

initial
begin
#RUN_TIME;
$finish;
end

endmodule
