// complete this module
// you SHOULD use the structural coding, 
// which directly describes the hardware 
// components and connections.
// 	Tip: {A,B} is the concatenation of A and B
// 	if A is 3 bit and B is 2 bit, {A,B} is 5 bit.
// 	Example:
// 	for	reg [3:0] A, B;
//	{A[2:0],B[3:2]} is equal to A[2]A[1]A[0]B[3]B[2] (5bit)
module mul4b(M,A,B);
	input [3:0] A, B;
	output [7:0] M;
	wire [3:0] z1,z2,z3,z4,z5,z6,z7,z8,z9,w1,w2,w3;
	wire[2:0] carry;
	
	assign M[0] = A[0]&B[0];
	assign z1[0] = A[0]&B[1];
	assign z1[1] = A[0]&B[2];
	assign z1[2] = A[0]&B[3];
	assign z1[3] = 0;
	
	and(z2[0],A[1],B[0]);
	and(z2[1],A[1],B[1]);
	and(z2[2],A[1],B[2]);
	and(z2[3],A[1],B[3]);
	
	four_bit_fa f0(1'b0,1'b0,z3,carry[0],z1,z2);
	
	assign M[1] = z3[0];
	
	and(z4[0],A[2],B[0]);
	and(z4[1],A[2],B[1]);
	and(z4[2],A[2],B[2]);
	and(z4[3],A[2],B[3]);
	assign w1 = {1'b0, z3[3],z3[2],z3[1]};
	assign z5 = {carry[0], w1[2], w1[1], w1[0]};
	//module four_bit_fa(M,C0,S,C_out, A,B);
	four_bit_fa f1(1'b0,1'b0,z6,carry[1],z5,z4);
	assign M[2] = z6[0];
	
	and(z7[0],A[3],B[0]);
	and(z7[1],A[3],B[1]);
	and(z7[2],A[3],B[2]);
	and(z7[3],A[3],B[3]);
	
	assign w2 = {1'b0,z6[3], z6[2], z6[1], z6[0]}; 
	assign z8 = {carry[1], w2[3], w2[2], w2[1]};
	four_bit_fa f2(1'b0,1'b0,z9,carry[2],z8,z7);
	
	assign M[3] = z9[0];
	assign M[4] = z9[1];
	assign M[5] = z9[2];
	assign M[6] = z9[3];
	assign M[7] = carry[2];
	
endmodule
	// put your code here

module half_adder(C,S,A,B);

output C,S;
input A,B;

xor x0(S,A,B);
and a0(C,A,B);

endmodule

module full_adder(C_out, S, A, B, C_in);

output C_out, S;
input A,B,C_in;
wire C0, C1;
wire S0;

half_adder h0(C0, S0, A, B);
half_adder h1(C1, S, S0, C_in);
or o0(C_out, C1, C0);
endmodule

module four_bit_fa(M,C0,S,C_out, A,B);

output [3:0] S;
output C_out;
wire [4:1] Ci;
input C0, M;
input [3:0] A,B;
wire [3:0] B_N;

xor(B_N[0], B[0], M);
xor(B_N[1], B[1], M);
xor(B_N[2], B[2], M);
xor(B_N[3], B[3], M);

full_adder f0(Ci[1], S[0], A[0], B_N[0], C0);
full_adder f1(Ci[2], S[1], A[1], B_N[1], Ci[1]);
full_adder f2(Ci[3], S[2], A[2], B_N[2], Ci[2]);
full_adder f3(Ci[4], S[3], A[3], B_N[3], Ci[3]);

assign C_out = Ci[4];
endmodule

module testbench();
	reg [3:0] A, B;
	wire [7:0] M;
	wire C;
	mul4b mul0(M,A,B);
	initial begin
		$monitor ("Time=%d, A=%d, B=%d, S=%d",
			$time,A,B,M);
		#10; A = 1; B = 2;
		#10; A = 7; B = 5;
		#10; A = 11; B = 8;
		#10; A = 12; B = 14;
		#10; A = 15; B = 15;
	end
endmodule


