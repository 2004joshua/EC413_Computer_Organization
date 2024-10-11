`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2024 03:37:43 PM
// Design Name: 
// Module Name: Four_BFA
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
module Four_BFA( c_out, sum, A, B, c_in);
    
input[3:0] A,B;
input c_in;
output[3:0] sum;
output c_out;

wire    c0, c1,c2,c3;   

FA_str      fa1 (c0,sum[0], A[0], B[0], c_in);
FA_str      fa2 (c1,sum[1], A[1], B[1], c0);
FA_str      fa3 (c2,sum[2], A[2], B[2], c1);
FA_str      fa4 (c_out,sum[3], A[3], B[3], c2);

endmodule