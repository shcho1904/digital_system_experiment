module _2to1mux(A0, A1, S, R);
	input A0, A1,S;
	output R;
	wire nS,I0,I1;
	not n0(nS, S);
	and a0(I0, A0, nS), a1(I1, A1, S);
	or o0(R, I0, I1);
endmodule

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

module eight_bit_2to1mux(I0,I1,S,R);
	input [7:0] I0,I1;
	input S;
	output [7:0] R;
	_2to1mux m1(I0[0],I1[0],S,R[0]);
	_2to1mux m2(I0[1],I1[1],S,R[1]);
	_2to1mux m3(I0[2],I1[2],S,R[2]);
	_2to1mux m4(I0[3],I1[3],S,R[3]);
	_2to1mux m5(I0[4],I1[4],S,R[4]);
	_2to1mux m6(I0[5],I1[5],S,R[5]);
	_2to1mux m7(I0[6],I1[6],S,R[6]);
	_2to1mux m8(I0[7],I1[7],S,R[7]);
endmodule

module three_bit_fa(M,C0,S,C_out, A,B);

output [2:0] S;
output C_out;
wire [3:1] Ci;
input C0, M;
input [2:0] A,B;
wire [2:0] B_N;

xor(B_N[0], B[0], M);
xor(B_N[1], B[1], M);
xor(B_N[2], B[2], M);

full_adder f0(Ci[1], S[0], A[0], B_N[0], C0);
full_adder f1(Ci[2], S[1], A[1], B_N[1], Ci[1]);
full_adder f2(Ci[3], S[2], A[2], B_N[2], Ci[2]);

assign C_out = Ci[3];
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

module eight_bit_fa(M,C0,S,C_out,A,B);	//A,B added number, C0: carry-in(usually 0)
	output [7:0] S;						//M: adder or subtracter
	output C_out;						//S: result, C_out: overflowed bit
	wire [8:1] Ci;
	input C0, M;
	input [7:0] A,B;
	wire [7:0] B_N;
	
	xor(B_N[0], B[0], M);
	xor(B_N[1], B[1], M);
	xor(B_N[2], B[2], M);
	xor(B_N[3], B[3], M);
	xor(B_N[4], B[4], M);
	xor(B_N[5], B[5], M);
	xor(B_N[6], B[6], M);
	xor(B_N[7], B[7], M);
	
	full_adder f0(Ci[1], S[0], A[0], B_N[0], C0);
	full_adder f1(Ci[2], S[1], A[1], B_N[1], Ci[1]);
	full_adder f2(Ci[3], S[2], A[2], B_N[2], Ci[2]);
	full_adder f3(Ci[4], S[3], A[3], B_N[3], Ci[3]);
	full_adder f4(Ci[5], S[4], A[4], B_N[4], Ci[4]);
	full_adder f5(Ci[6], S[5], A[5], B_N[5], Ci[5]);
	full_adder f6(Ci[7], S[6], A[6], B_N[6], Ci[6]);
	full_adder f7(Ci[8], S[7], A[7], B_N[7], Ci[7]);
	assign C_out = Ci[8];
endmodule

module single_cycle_divisor(A,M,Q, result_A, result_Q);
	input [7:0] A,M,Q;
	output [7:0] result_A, result_Q;
	
	wire [7:0] shifted_A, shifted_Q, A_M, AM_Q, AP_Q;
	wire C_out;
	
	assign shifted_A = {A[6], A[5],A[4],A[3],A[2],A[1],A[0],Q[7]};
	assign shifted_Q = {Q[6], Q[5],Q[4],Q[3],Q[2],Q[1],Q[0],1'b0};
	//module eight_bit_fa(M,C0,S,C_out,A,B);
	eight_bit_fa fa0(1'b1, 1'b1, A_M, C_out, shifted_A, M);	//A-M
	//module eight_bit_2to1mux(I0,I1,S,R);
	assign AM_Q = {shifted_Q[7], shifted_Q[6], shifted_Q[5], shifted_Q[4], shifted_Q[3], shifted_Q[2], shifted_Q[1], 1'b0};	//when A_M is nagative, A<M
	assign AP_Q = {shifted_Q[7], shifted_Q[6], shifted_Q[5], shifted_Q[4], shifted_Q[3], shifted_Q[2], shifted_Q[1], 1'b1};	//when A_M is positive, A>=M
	eight_bit_2to1mux mux0(AP_Q, AM_Q, A_M[7], result_Q);
	eight_bit_2to1mux mux1(A_M, shifted_A, A_M[7], result_A);
endmodule

module binary_divisor(Q,M,Quotient, remainder);
//M:divisor, Q: Dividend
	input [7:0] M,Q;
	output [7:0] Quotient, remainder;
	wire [7:0] A_1, A_2, A_3, A_4, A_5, A_6, A_7;
	wire [7:0] Q_1, Q_2, Q_3, Q_4, Q_5, Q_6, Q_7;
	
	single_cycle_divisor div0(8'd0, M, Q, A_1, Q_1);
	single_cycle_divisor div1(A_1, M, Q_1, A_2, Q_2);
	single_cycle_divisor div2(A_2, M, Q_2, A_3, Q_3);
	single_cycle_divisor div3(A_3, M, Q_3, A_4, Q_4);
	single_cycle_divisor div4(A_4, M, Q_4, A_5, Q_5);
	single_cycle_divisor div5(A_5, M, Q_5, A_6, Q_6);
	single_cycle_divisor div6(A_6, M, Q_6, A_7, Q_7);
	single_cycle_divisor div7(A_7, M, Q_7, remainder, Quotient);

endmodule


module testbench();
	reg [7:0] A, B;
	wire [7:0] Quotient, remainder;
	binary_divisor div0(A,B, Quotient, remainder);
	initial begin
		$monitor ("Time=%d, A=%d, B=%d, Quotient=%d, remainder=%d",
			$time,A,B,Quotient,remainder);
		#10; A = 7; B = 3;
		#10; A = 7; B = 5;
		#10; A = 11; B = 8;
		#10; A = 16; B = 6;
		#10; A = 18; B = 9;
	end
endmodule

