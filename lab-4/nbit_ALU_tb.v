`timescale 1ns / 1ps

module nbit_ALU_tb();

	// Parameter for ALU width (32-bit in this case)
	parameter n = 32;

	// Inputs to the ALU
	reg signed [n-1:0] R2;
	reg signed [n-1:0] R3;
	reg [2:0] ALUop;
	reg c_in;
	reg clk;

	// Outputs from the ALU
	wire [n-1:0] R0;    	// Register output (stored result)
	wire [n-1:0] R1;    	// ALU output
	wire c_out;         	// Carry out signal from ALU

	// Expected outputs from verification module
	wire [n-1:0] R1_verify;
	wire error_flag;    	// Error flag for mismatch between outputs

	// Instantiate the n-bit ALU (Unit Under Test - UUT)
	nbit_ALU #(.n(n)) uut (
    	.R0(R0),
    	.R1(R1),
    	.R2(R2),
    	.R3(R3),
    	.ALUop(ALUop),
    	.c_in(c_in),
    	.c_out(c_out),
    	.clk(clk)
	);

	// Instantiate the verification ALU
	verification_ALU #(.n(n)) verification (
    	.R2(R2),
    	.R3(R3),
    	.ALUOp(ALUop),
    	.R1(R1_verify)
	);

	// Error flag that checks for mismatch between actual ALU and verification ALU
	assign error_flag = (R1 != R1_verify);

	// Clock generation (toggle every 5 ns for a 100MHz clock)
	always #5 clk = ~clk;

	// Testbench logic
	initial begin
    	// Initialize inputs
    	clk = 0;
    	c_in = 0;
    	R2 = 0;
    	R3 = 0;
    	ALUop = 0;

    	// Wait 10 ns for global reset
    	#10;

    	// Test MOV (pass-through operation)
    	ALUop = 3'b000; // MOV operation
    	R2 = 32'hAAAAAAAA;  // Test with a value
    	R3 = 32'h00000000;  // R3 is not used in MOV
    	#10;
    	$display("MOV Test: R1 = %h, Expected = %h, Error = %b", R1, R1_verify, error_flag);

    	// Test NOT
    	ALUop = 3'b001; // NOT operation
    	R2 = 32'hAAAAAAAA;
    	#10;
    	$display("NOT Test: R1 = %h, Expected = %h, Error = %b", R1, R1_verify, error_flag);

    	// ----------- Test ADD (No Overflow) ----------- //
    	ALUop = 3'b010; // ADD operation
    	R2 = 32'h00000001;  // Small numbers (no overflow)
    	R3 = 32'h00000002;
    	#10;
    	$display("ADD Test (No Overflow): R1 = %h, Expected = %h, Error = %b", R1, R1_verify, error_flag);

    	// ----------- Test ADD (Positive Overflow) ----------- //
    	ALUop = 3'b010; // ADD operation
    	R2 = 32'h7FFFFFFF;  // Max positive number
    	R3 = 32'h00000001;  // Adding 1 causes overflow
    	#10;
    	$display("ADD Test (Positive Overflow): R1 = %h, Expected = %h, Error = %b", R1, R1_verify, error_flag);

    	// ----------- Test ADD (Negative Overflow) ----------- //
    	ALUop = 3'b010; // ADD operation
    	R2 = 32'h80000000;  // Max negative number
    	R3 = 32'hFFFFFFFF;  // Adding -1 causes overflow
    	#10;
    	$display("ADD Test (Negative Overflow): R1 = %h, Expected = %h, Error = %b", R1, R1_verify, error_flag);

    	// ----------- Test SUB (No Overflow) ----------- //
    	ALUop = 3'b011; // SUB operation
    	c_in = 1;  // Set carry-in to 1 for two's complement subtraction
    	R2 = 32'h00000005;
    	R3 = 32'h00000003;
    	#10;
    	$display("SUB Test (No Overflow): R1 = %h, Expected = %h, Error = %b", R1, R1_verify, error_flag);

    	// ----------- Test SUB (Subtract by 0) ----------- //
    	ALUop = 3'b011; // SUB operation
    	c_in = 1;  // Set carry-in to 1 for two's complement subtraction
    	R2 = 32'h00000005;
    	R3 = 32'h00000000;  // Subtracting by 0
    	#10;
    	$display("SUB Test (Subtract by 0): R1 = %h, Expected = %h, Error = %b", R1, R1_verify, error_flag);

    	// ----------- Test SUB (Number minus itself) ----------- //
    	ALUop = 3'b011; // SUB operation
    	c_in = 1;  // Set carry-in to 1 for two's complement subtraction
    	R2 = 32'h12345678;
    	R3 = 32'h12345678;  // Subtracting a number by itself
    	#10;
    	$display("SUB Test (Number minus itself): R1 = %h, Expected = %h, Error = %b", R1, R1_verify, error_flag);

    	// ----------- Test SUB (Positive Overflow) ----------- //
    	ALUop = 3'b011; // SUB operation
    	c_in = 1;  // Set carry-in to 1 for two's complement subtraction
    	R2 = 32'h7FFFFFFF;  // Max positive number
    	R3 = 32'hFFFFFFFF;  // Subtracting -1 causes overflow
    	#10;
    	$display("SUB Test (Positive Overflow): R1 = %h, Expected = %h, Error = %b", R1, R1_verify, error_flag);

    	// ----------- Test SUB (Negative Overflow) ----------- //
    	ALUop = 3'b011; // SUB operation
    	c_in = 1;  // Set carry-in to 1 for two's complement subtraction
    	R2 = 32'h80000000;  // Max negative number
    	R3 = 32'h00000001;  // Subtracting 1 causes overflow
    	#10;
    	$display("SUB Test (Negative Overflow): R1 = %h, Expected = %h, Error = %b", R1, R1_verify, error_flag);

    	// Test AND
    	ALUop = 3'b101; // AND operation
    	c_in = 0;  // Reset carry-in
    	R2 = 32'hAAAAAAAA;
    	R3 = 32'h55555555;
    	#10;
    	$display("AND Test: R1 = %h, Expected = %h, Error = %b", R1, R1_verify, error_flag);

    	// Test SLT (Set less than)
    	ALUop = 3'b110; // SLT operation
    	c_in = 0;  // Reset carry-in
    	R2 = 32'h00000005;
    	R3 = 32'h00000003;
    	#10;
    	$display("SLT Test: R1 = %h, Expected = %h, Error = %b", R1, R1_verify, error_flag);

    	// Final test for default case (unsupported ALUop)
    	ALUop = 3'b111; // Unsupported operation
    	R2 = 32'hAAAAAAAA;
    	R3 = 32'h55555555;
    	#10;
    	$display("Default Test: R1 = %h, Expected = %h, Error = %b", R1, R1_verify, error_flag);

    	// End the simulation
    	$finish;
	end

endmodule
