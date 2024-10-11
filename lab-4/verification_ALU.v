`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2024 12:02:32 AM
// Design Name: 
// Module Name: verification_ALU
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

/*
    R0: Register Output 
    R1: ALU Output
    R2: ALU input
    R3: ALU input 
    ALUOP: Operation
*/

module verification_ALU #(
  parameter n = 32
)(
  input signed [n-1:0] R2,
  input signed [n-1:0] R3,
  input [2:0] ALUOp,

  output reg [n-1:0] R1
);

always @(*)begin
  case(ALUOp)
    3'b000: R1 = R2;
    3'b001: R1 = ~R2;
    3'b010: R1 = R2 + R3;
    3'b011: R1 = R2 - R3;
    3'b100: R1 = R2 | R3;
    3'b101: R1 = R2 & R3;
    3'b110: R1 = R2 < R3;
  endcase
end

endmodule