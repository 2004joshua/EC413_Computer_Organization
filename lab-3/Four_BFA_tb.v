`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2024 04:44:36 PM
// Design Name: 
// Module Name: Four_BFA_tb
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


module Four_BFA_tb();

reg [3:0]a;
reg [3:0]b;
reg c_in;

reg clk;

wire c_out;
wire [3:0]sum;
wire c_out_verify;
wire sum_verify;
wire error_flag;

Four_BFA FBFA (
    .c_out(c_out),
    .sum(sum),
    .A(a),
    .B(b),
    .c_in(c_in)
);

Verification_4bit Verification (
    .c_out(c_out_verify), 
	.sum(sum_verify), 
	.A(a), 
    .B(b), 
    .c_in(c_in)
);

assign error_flag = (c_out != c_out_verify || sum != sum_verify);

// Verification logic
	always@(posedge clk)
		begin
		if(error_flag)
			// Use $display here instead of $monitor
			// $monitor will display the message whenever there's a change of a, b, c_in
			// $display will only display once when it's been executed
			$display("Error occurs when a = %d, b = %d, c_in = %d\n", a, b, c_in);
		end
		
// Derfine clk signal for Verfication purpose
	always #5 clk = ~clk;
	
    initial begin
    //init clock
    clk = 0;
    
    a = 0;
    b = 0;
    c_in = 1;
    
    end
    
always #27  {a,b,c_in} ={a,b,c_in}+1;

endmodule
