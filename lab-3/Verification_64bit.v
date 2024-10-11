`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2024 01:04:29 PM
// Design Name: 
// Module Name: Verification_64bit
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


module Verification_64bit(
    output c_out,
    output [63:0] sum,
    input [63:0] A,
    input [63:0] B,
    input c_in
    );
    
assign {c_out, sum} = A + B + c_in;
endmodule
