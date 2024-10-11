`timescale 1ns / 1ps

/*
    R0: Register Output 
    R1: ALU Output
    R2: ALU input
    R3: ALU input 
    ALUOP: Operation
*/

module ALU #(parameter n = 32)
(R0, R1, R2, R3, ALUop, clk, c_in, carry_output);

    input clk; 
    input c_in; 
    
    output wire [n-1:0] R0; // Change this to wire
    output reg [n-1:0] R1; 
    
    input signed [n-1:0] R2; 
    input signed [n-1:0] R3;

    input [2:0] ALUop; 
     
    wire [n-1:0] _mv; 
    wire [n-1:0] _not;
    wire [n-1:0] _add;
    wire [n-1:0] _or;
    wire [n-1:0] _sub;
    wire [n-1:0] _nand;
    wire [n-1:0] _and;
    
    wire [n-1:0] _transfer; 
    
    wire carry_add, carry_sub; 
    
    output reg carry_output; 
    
    // Declarations
    assign _mv [n-1:0] = R2 [n-1:0];
    
    nbit_not #(.n(n)) alu_not 
    (.out(_not[n-1:0]), .in(R2[n-1:0])); 
    
    nbit_adder #(.N(n)) alu_adder 
    (.a(R2[n-1:0]), .b(R3[n-1:0]), .c_in(c_in), .sum(_add[n-1:0]), .c_out(carry_add)); 
    
    nbit_or #(.N(n)) alu_or 
    (.in1_val(R2[n-1:0]), .in2_val(R3[n-1:0]), .out_val(_or[n-1:0])); 
    
    // For R3 im just going to get 2's complement and add
    nbit_sub #(.N(n)) alu_sub
    (.a(R2[n-1:0]), .b(R3[n-1:0]), .c_in(0), .sum(_sub[n-1:0]), .c_out(carry_sub));
    
    nbit_and #(.N(n)) alu_and
    (.in1_val(R2[n-1:0]), .in2_val(R3[n-1:0]), .out_val(_and[n-1:0]));
    
    // Make R0 a wire connected to the register module output
    nbit_reg #(.n(n)) reg_add
    (.in0(R1[n-1:0]), .out0(R0[n-1:0]), .clk(clk));    
    
    always @(*) begin 
        case(ALUop)
            // move
            3'b000: begin
                R1[n-1:0] = _mv[n-1:0]; 
                carry_output = 0; 
            end 
            
            // Not
            3'b001: begin
                R1[n-1:0] = _not[n-1:0]; 
                carry_output = 0; 
            end
            
            // Add
            3'b010: begin
                 R1[n-1:0] = _add[n-1:0]; 
                 carry_output = carry_add; 
            end
            
            // Sub
            3'b011: begin
                R1[n-1:0] = _sub[n-1:0]; 
                carry_output = carry_sub; 
            end 
            
            // Or
            3'b100: begin
                 R1[n-1:0] = _or[n-1:0]; 
                 carry_output = 0; 
            end
            
            // And
            3'b101: begin
                R1[n-1:0] = _and[n-1:0]; 
                carry_output = 0; 
            end
            
          /*Extra Credit             
            3'b111: begin
                R1 = (R2 < R3) ? 1 : 0; 
            end
          */
          
            default: begin  // Default case to handle unexpected values
                R1 = 32'b0;
                carry_output = 0;
            end
        endcase
    end
endmodule