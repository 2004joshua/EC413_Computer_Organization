`timescale 1ns / 1ps

module nbit_sub #(parameter n = 32)(
	input [n-1:0] a,
	input [n-1:0] b,
	input c_in,             	// Initial carry-in (for 2's complement, this should be 1)
	output c_out,           	// Carry-out (borrow flag)
	output [n-1:0] sum      	// Subtraction result
);

	genvar i;
    
	wire [n-1:0] inv_b;     	// Inverted 'b' (for two's complement)
	wire [n:0] carry;       	// Carry chain, one extra bit for final carry out
    
	// Set initial carry-in
	assign carry[0] = c_in; 	// Initial carry-in should be 1 for subtraction

	// Invert 'b' to create the two's complement representation (~b + 1)
	nbit_not #(.n(n)) inverting (
    	.out(inv_b),
    	.in(b)
	);
    
	// Generate n full adders to perform 'a - b = a + (~b + 1)'
	generate
    	for(i = 0; i < n; i = i + 1) begin : adder_slice
        	FA_str fa (
            	.c_out(carry[i+1]),  // Carry-out to the next stage
            	.a(a[i]),        	// Bit of input 'a'
            	.b(inv_b[i]),    	// Inverted bit of 'b'
            	.c_in(carry[i]), 	// Carry-in from previous stage
            	.sum(sum[i])     	// Sum output (result bit)
        	);
    	end
	endgenerate
    
	// Final carry-out (borrow)
	assign c_out = carry[n]; 	// Carry-out from the final adder stage
    
endmodule

