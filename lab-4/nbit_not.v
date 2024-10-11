`timescale 1ns / 1ps

module nbit_not (out, in); 
    parameter n=32;
    input[n-1:0] in;
    output [n-1:0] out;
    
    genvar i;
    generate 
    
    for(i=0;i<n;i=i+1) begin
        not(out[i],in[i]);
    end 
    
    endgenerate 
endmodule