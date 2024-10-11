`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2024 04:35:58 PM
// Design Name: 
// Module Name: Verification_4bit
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


module Verification_4bit(c_out, sum, A,B ,c_in
    );
    
input[3:0] A,B;
input c_in;
output[3:0] sum;
output c_out;

assign {c_out, sum} = A + B + c_in;


endmodule
