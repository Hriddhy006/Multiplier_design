`timescale 1ns/1ps

package MULT_PKG;
    parameter MULTIPLICAND_WIDTH = 3;
    parameter MULTIPLIER_WIDTH = 3;
    localparam PRODUCT_WIDTH = MULTIPLICAND_WIDTH + MULTIPLIER_WIDTH;  
	
    parameter NO_OF_STATE = 4; // Adjusted to match your FSM logic (00, 01, 10, 11)
    localparam STATE_REG_WIDTH = $clog2(NO_OF_STATE); 
endpackage : MULT_PKG