`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2024 10:12:46 PM
// Design Name: 
// Module Name: mux
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


module mux #(parameter N = 32)(in1, in2, select, out_val);

	input signed [N-1:0] in1;   // First input (for NOT operation)
    input signed [N-1:0] in2;   // Second input (for ADD operation)
    input select;               // 1-bit selection signal
    output reg [N-1:0] out_val; // Output of the MUX

    // Always block to choose between adder and NOT operation
    always @(*) begin
        case(select)
            1'b0: out_val = in2;   // Select adder result
            1'b1: out_val = in1;   // Select NOT result
        endcase
    end
	
endmodule