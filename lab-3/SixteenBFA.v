`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2024 12:51:37 PM
// Design Name: 
// Module Name: SixteenBFA
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


module SixteenBFA(c_out, sum, A, B, c_in);

    input [15:0] A;
    input [15:0] B;
    output [15:0] sum;
    input c_in;
    output c_out;
   
    wire c0,c1,c2,c3;
    
    Four_BFA fbfa1(c0, sum[3:0], A[3:0], B[3:0], c_in);
    Four_BFA fbfa2(c1, sum[7:4], A[7:4], B[7:4], c0);
    Four_BFA fbfa3(c2, sum[11:8], A[11:8], B[11:8], c1);
    Four_BFA fbfa4(c_out, sum[15:12], A[15:12], B[15:12], c2);
    
    
endmodule
