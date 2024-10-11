`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2022 12:47:55 PM
// Design Name: 
// Module Name: OR_T_4
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

module OR_T_4(out, in1, in2, in3, in4);

input in1, in2, in3, in4;
output out;

or		#`D		or1 (out, in1, in2, in3, in4);


endmodule
