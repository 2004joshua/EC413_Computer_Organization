`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2024 10:35:41 AM
// Design Name: 
// Module Name: top_level
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


module top_level(a, b, clk, c_in, select, out0, c_out);
    
    parameter n = 32;
    
    input [n-1:0] a, b;  // Inputs for the adder and NOT operations
    input clk, c_in, select;  // Clock, carry-in for adder, and select for MUX
    output [n-1:0] out0;  // Output from the register (final output)
    output c_out;  // Carry-out from the adder
    
    wire [n-1:0] sum;     // Wire for the sum output from the adder
    wire [n-1:0] not_out; // Wire for the bitwise NOT output
    wire [n-1:0] mux_out; // Wire for the MUX output
    
    // Instantiate the n-bit adder
    nbit_adder #(.n(n)) adder_inst (
        .a(a),
        .b(b),
        .c_in(c_in),
        .sum(sum),
        .c_out(c_out)
    );
    
    // Instantiate the n-bit NOT
    nbit_not #(.n(n)) not_inst (
        .in(a),          // Apply NOT to input 'a'
        .out(not_out)
    );
    
    // Instantiate the MUX to select between the adder and NOT outputs
    mux #(.N(n)) mux_inst (
        .in1(not_out),   // First input (bitwise NOT result)
        .in2(sum),       // Second input (adder result)
        .select(select), // Selection signal (0 for adder, 1 for NOT)
        .out_val(mux_out) // MUX output
    );
    
    // Instantiate the n-bit register
    nbit_reg #(.n(n)) reg_inst (
        .in0(mux_out),   // Connect MUX output to the register input
        .out0(out0),     // Register output
        .clk(clk)        // Clock input
    );

endmodule

