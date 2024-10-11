`timescale 1ns / 1ps


module ALU_1bit
(R1, R2, R3, c_in, ALUop, c_out, clk);

    output reg R1; 
    input R2;
    input R3;
    
    input c_in; 
    output reg c_out;
    
    input [2:0] ALUop;
    
    input clk;  
     
    wire 
        _mov,
        _sum, 
        _sub,   
        _not, 
        _and; 
        
    wire 
        _cout_sum, 
        _cout_sub; 
        
    nbit_reg mov_reg (.in0(R2), .out0(_mov), .clk(clk));     
    
    nbit_not not_1b (.out(_not), .in(R2)); 
    
    nbit_adder #(.n(1)) adder_1b
    (.a(R2), .b(R3), .c_in(c_in), .sum(_sum), .c_out(_cout_sum));
    
    nbit_sub #(.n(1)) sub_1b 
    (.a(R2), .b(R3), .c_in(c_in), .sum(_sub), .c_out(_cout_sub));
    
    nbit_and #(.n(1)) and_1b
    (.in1_val(R2), .in2_val(R3), .out_val(_and)); 
    
    nbit_or #(.n(1)) or_1b
    (.in1_val(R2), .in2_val(R3), .out_val(_or)); 

    always @(*) begin
        case(ALUop)
            // move
            3'b000: begin
                R1 = _mov; 
                c_out = 0; 
            end
            
            // not
            3'b001: begin
                R1 = _not; 
                c_out = 0; 
            end
            
            // add 
            3'b010: begin
                R1 = _sum; 
                c_out = _cout_sum; 
            end
            
            // sub
            3'b011: begin
                R1 = _sub; 
                c_out = _cout_sub;
            end
            
            // or
            3'b100: begin
                R1 = _or; 
                c_out = 0; 
            end
            
            // and
            3'b101: begin
                R1 = _and; 
                c_out = 0; 
            end
        endcase
    end    
    
endmodule
