`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2022 12:48:59 PM
// Design Name: 
// Module Name: OR_T_3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define	D		0	// definition of the delay

// Delayed OR gate

module OR_T_3(out, in1, in2, in3);

input in1, in2, in3;
output out;

or		#`D		or1 (out, in1, in2, in3);


endmodule
