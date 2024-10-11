`timescale 1ns / 1ps

module nbit_adder(a,b,c_in,sum,c_out);

    parameter n = 32; 
    input [n-1:0] a; 
    input [n-1:0] b;
    input c_in;
    output [n-1:0] sum;
    output c_out;

    wire [n:0]carry; 
    assign carry[0] = c_in; 
    assign c_out = carry[n];
    
    genvar i;
    generate 
    for(i=0; i<n; i=i+1) begin 
        FA_str Adder1bit (carry[i+1], sum[i],a[i],b[i],carry[i]);
    end 

    endgenerate 
endmodule
