`timescale 1ns / 1ps

module nbit_ALU #(parameter n = 32) 
(R0, R1, R2, R3, ALUop, c_in, c_out, clk);

    output wire [n-1:0]R0; 
    output reg [n-1:0]R1;
    input signed [n-1:0]R2;
    input signed [n-1:0]R3;
    
    input [2:0] ALUop; 
    
    output reg c_out; 
    input c_in; 
    
    input clk; 
    
    // Ill collect whatever I get from the loop into here
    wire [n-1:0] R1_temp; 
    wire [n:0] carries; 
    
    assign carries[0] = c_in; 
    
    nbit_reg #(.n(n)) reg_add
    (.in0(R1[n-1:0]), .out0(R0[n-1:0]), .clk(clk)); 
    
    genvar i; 
    generate   
        for(i = 0; i < n; i = i + 1) begin
            ALU_1bit ALU_slice (
                .R1(R1_temp[i]), 
                .R2(R2[i]), 
                .R3(R3[i]), 
                .c_in(carries[i]), 
                .ALUop(ALUop), 
                .c_out(carries[i+1]), 
                .clk(clk)
            ); 
        end
    endgenerate
    
    always @(*) begin
        R1 = R1_temp;
        c_out = carries[n]; 
    end
    
endmodule
