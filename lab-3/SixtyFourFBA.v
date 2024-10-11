`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2024 12:58:16 PM
// Design Name: 
// Module Name: SixtyFourFBA
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


module SixtyFourFBA(
    input [63:0] A,
    input [63:0] B,
    output [63:0] sum,
    input c_in,
    output c_out
    );
    
wire c0,c1,c2;

SixteenBFA sbfa1(c0, sum[15:0], A[15:0], B[15:0], c_in);
SixteenBFA sbfa2(c1, sum[31:16], A[31:16], B[31:16], c0);
SixteenBFA sbfa3(c2, sum[47:32], A[47:32], B[47:32], c1);
SixteenBFA sbfa4(c_out, sum[63:48], A[63:48], B[63:48], c2);

endmodule
