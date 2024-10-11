`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2024 01:08:05 PM
// Design Name: 
// Module Name: SixtyFourFBA_tb
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


module SixtyFourFBA_tb;

//Inputs

reg [63:0]a;
reg [63:0]b;
reg c_in;

reg clk;

//Outputs
wire c_out;
wire [63:0]sum;
wire c_out_verify;
wire [63:0]sum_verify;
wire error_flag;

SixtyFourFBA SBFA (
    .c_out(c_out),
    .sum(sum),
    .A(a),
    .B(b),
    .c_in(c_in)
    );
 
Verification_64bit Verification(
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
	always #1 clk = ~clk;
	
    initial begin
    //init clock
    clk = 0;
    
    a = 0;
    b = 0;
    c_in = 1;
    
    #20
    a=64'b101010100110011001;
    b=64'b000011101011101010;
    
    //Force an overall carry out
    #20
    a=64'b10000000000000000000000000000000000000000000000000000000000000000;
    b=64'b10000000000000000000000000000000000000000000000000000000000000000;
    
    //Random large A&B input (w/ and w/o carry)
    #20
    // w/ carry
    a= {$random , $random};
    b= {$random , $random};
    a[63]=1'b1;
    b[63]=1'b1;
    
    #20
    // w/0 carry
    a= {$random , $random};
    b= {$random , $random};
    a[63]=1'b0;
    b[63]=1'b0;
    
    //Random small A&B input (w/ and w/o carry)
    #20 //w/ carry
    a= {32'b0, $random};
    b= {32'b0, $random};
    a[31]=1'b0;
    b[32]=1'b0;
    
    #20 //w/o carry
    a= {32'b0, $random};
    b= {32'b0, $random};
    a[31]=1'b1;
    b[32]=1'b1;
    
    //Random combinations
    #20
    a= {$random , $random};
    b= {$random , $random};
    
    #20
    a= {$random , $random};
    b= {$random , $random};
    end
    
always #1000  {a,b,c_in} ={a,b,c_in}+1;
endmodule
