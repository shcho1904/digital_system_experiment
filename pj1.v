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

module six_bit_fa(M,C0,S,C_out, A,B);

output [5:0] S;
output C_out;
wire [6:1] Ci;
input C0, M;
input [5:0] A,B;
wire [5:0] B_N;

xor(B_N[0], B[0], M);
xor(B_N[1], B[1], M);
xor(B_N[2], B[2], M);
xor(B_N[3], B[3], M);
xor(B_N[4], B[4], M);
xor(B_N[5], B[5], M);

full_adder f0(Ci[1], S[0], A[0], B_N[0], C0);
full_adder f1(Ci[2], S[1], A[1], B_N[1], Ci[1]);
full_adder f2(Ci[3], S[2], A[2], B_N[2], Ci[2]);
full_adder f3(Ci[4], S[3], A[3], B_N[3], Ci[3]);
full_adder f4(Ci[5], S[4], A[4], B_N[4], Ci[4]);
full_adder f5(Ci[6], S[5], A[5], B_N[5], Ci[5]);

assign C_out = Ci[6];
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

module ten_bit_fa(M,C0,S,C_out,A,B);	//A,B added number, C0: carry-in(usually 0)
	output [9:0] S;						//M: adder or subtracter
	output C_out;						//S: result, C_out: overflowed bit
	wire [10:1] Ci;
	input C0, M;
	input [9:0] A,B;
	wire [9:0] B_N;
	
	xor(B_N[0], B[0], M);
	xor(B_N[1], B[1], M);
	xor(B_N[2], B[2], M);
	xor(B_N[3], B[3], M);
	xor(B_N[4], B[4], M);
	xor(B_N[5], B[5], M);
	xor(B_N[6], B[6], M);
	xor(B_N[7], B[7], M);
	xor(B_N[8], B[8], M);
	xor(B_N[9], B[9], M);
	
	full_adder f0(Ci[1], S[0], A[0], B_N[0], C0);
	full_adder f1(Ci[2], S[1], A[1], B_N[1], Ci[1]);
	full_adder f2(Ci[3], S[2], A[2], B_N[2], Ci[2]);
	full_adder f3(Ci[4], S[3], A[3], B_N[3], Ci[3]);
	full_adder f4(Ci[5], S[4], A[4], B_N[4], Ci[4]);
	full_adder f5(Ci[6], S[5], A[5], B_N[5], Ci[5]);
	full_adder f6(Ci[7], S[6], A[6], B_N[6], Ci[6]);
	full_adder f7(Ci[8], S[7], A[7], B_N[7], Ci[7]);
	full_adder f8(Ci[9], S[8], A[8], B_N[8], Ci[8]);
	full_adder f9(Ci[10], S[9], A[9], B_N[9], Ci[9]);
	assign C_out = Ci[10];
endmodule

module sixteen_bit_fa(M,C0,S,C_out,A,B);	//A,B added number, C0: carry-in(usually 0)
	output [15:0] S;						//M: adder or subtracter
	output C_out;						//S: result, C_out: overflowed bit
	wire [16:1] Ci;
	input C0, M;
	input [15:0] A,B;
	wire [15:0] B_N;
	
	xor(B_N[0], B[0], M);
	xor(B_N[1], B[1], M);
	xor(B_N[2], B[2], M);
	xor(B_N[3], B[3], M);
	xor(B_N[4], B[4], M);
	xor(B_N[5], B[5], M);
	xor(B_N[6], B[6], M);
	xor(B_N[7], B[7], M);
	xor(B_N[8], B[8], M);
	xor(B_N[9], B[9], M);
	xor(B_N[10], B[10], M);
	xor(B_N[11], B[11], M);
	xor(B_N[12], B[12], M);
	xor(B_N[13], B[13], M);
	xor(B_N[14], B[14], M);
	xor(B_N[15], B[15], M);
	
	
	full_adder f0(Ci[1], S[0], A[0], B_N[0], C0);
	full_adder f1(Ci[2], S[1], A[1], B_N[1], Ci[1]);
	full_adder f2(Ci[3], S[2], A[2], B_N[2], Ci[2]);
	full_adder f3(Ci[4], S[3], A[3], B_N[3], Ci[3]);
	full_adder f4(Ci[5], S[4], A[4], B_N[4], Ci[4]);
	full_adder f5(Ci[6], S[5], A[5], B_N[5], Ci[5]);
	full_adder f6(Ci[7], S[6], A[6], B_N[6], Ci[6]);
	full_adder f7(Ci[8], S[7], A[7], B_N[7], Ci[7]);
	full_adder f8(Ci[9], S[8], A[8], B_N[8], Ci[8]);
	full_adder f9(Ci[10], S[9], A[9], B_N[9], Ci[9]);
	full_adder f10(Ci[11], S[10], A[10], B_N[10], Ci[10]);
	full_adder f11(Ci[12], S[11], A[11], B_N[11], Ci[11]);
	full_adder f12(Ci[13], S[12], A[12], B_N[12], Ci[12]);
	full_adder f13(Ci[14], S[13], A[13], B_N[13], Ci[13]);
	full_adder f14(Ci[15], S[14], A[14], B_N[14], Ci[14]);
	full_adder f15(Ci[16], S[15], A[15], B_N[15], Ci[15]);
	
	assign C_out = Ci[16];
endmodule

module mul8bit(a, b, result);

    input  [7:0] a,b;
    output [15:0] result;
    wire [15:0] result;

wire [7:0] temp1;
wire [7:0] temp2;
wire [7:0] temp3;
wire [9:0] temp4;
wire [9:0] temp5;
wire [7:0] temp6;
wire [7:0] temp7;

vedic4x4 M1(a[3:0], b[3:0], temp1);
assign result[3:0] = temp1[3:0];

vedic4x4 M2(a[7:4], b[3:0], temp2);
vedic4x4 M3(a[3:0], b[7:4], temp3);

adder10 A1({2'b00, temp2}, {2'b00,temp3}, temp4);
adder10 A2(temp4, {6'b000000, temp1[7:4]}, temp5);
assign result[7:4] = temp5[3:0];

vedic4x4 M4(a[7:4], b[7:4], temp6);
adder8 A3(temp6, {2'b00,temp5[9:4]}, temp7);

assign result[15:8] = temp7;

endmodule

module vedic4x4(a, b, result);

    input  [3:0] a,b;
    output [7:0] result;
    wire [7:0] result;

wire [3:0] temp1;
wire [3:0] temp2;
wire [3:0] temp3;
wire [5:0] temp4;
wire [5:0] temp5;
wire [3:0] temp6;
wire [3:0] temp7;
wire [5:0] w1;

vedic_2x2 V1(a[1:0], b[1:0], temp1);
assign result[1:0] = temp1[1:0];

vedic_2x2 V2(a[3:2], b[1:0], temp2);
vedic_2x2 V3(a[1:0], b[3:2], temp3);

assign w1 = {4'b0000, temp1[3:2]};

adder6 A1({2'b00, temp3}, {2'b00, temp2}, temp4);
adder6 A2(temp4, w1, temp5);

assign result[3:2] = temp5[1:0];

vedic_2x2 V4(a[3:2], b[3:2], temp6);

adder4 A3(temp6, temp5[5:2], temp7);
assign result[7:4] = temp7;


endmodule

module vedic_2x2 (a, b, result);
    input [1:0] a,b;
    output [3:0] result;

    wire [3:0] w;
    
    
    assign result[0]= a[0]&b[0];
    assign w[0]     = a[1]&b[0];
    assign w[1]     = a[0]&b[1];
    assign w[2]     = a[1]&b[1];

    halfAdder H0(w[0], w[1], result[1], w[3]);
    halfAdder H1(w[2], w[3], result[2], result[3]);    
    
endmodule

module halfAdder(a,b,sum,carry);
    input a,b;
    output sum, carry;

xor x0(sum, a, b);
and a0(carry, a,b);

endmodule

module adder4(a,b,sum);

input [3:0] a,b;
output [3:0] sum;
wire [3:0] sum;

assign sum = a + b;

endmodule

module adder6(a,b,sum);

input [5:0] a,b;
output [5:0] sum;
wire [5:0] sum;

assign sum = a + b;

endmodule

module adder8(a,b,sum);

input [7:0] a,b;
output [7:0] sum;
wire [7:0] sum;

assign sum = a + b;

endmodule

module adder10(a,b,sum);

input [9:0] a,b;
output [9:0] sum;
wire [9:0] sum;

assign sum = a + b;

endmodule


module mul_signed(M, Q, R, overflow);
	input [7:0] M,Q;
	output [7:0] R;
	output overflow;
	
	wire [7:0] new_M, new_Q,neg_M,neg_Q;
	wire M_m, Q_m, neg,trash0,trash1;
	assign M_m = M[7];
	assign Q_m = Q[7];	//check whether M and Q is negative
	xor x0(neg, M_m, Q_m);
	//module eight_bit_fa(M,C0,S,C_out,A,B);
	wire [7:0] zero;
	wire or_temp0,or_temp1,or_temp2,or_temp3,or_temp4,or_temp5,or_temp6,sign_diff,over_sub;
	wire [15:0] sub_result,full_result,trash2;
	assign zero = 8'd0;
	eight_bit_fa f0(1'b1, 1'b1, neg_M, trash0, zero, M); 
	eight_bit_fa f1(1'b1, 1'b1, neg_Q, trash0, zero, Q);
	//module eight_bit_2to1mux(I0,I1,S,R);
	eight_bit_2to1mux m0(M, neg_M, M_m, new_M);
	eight_bit_2to1mux m1(Q, neg_Q, Q_m, new_Q);
	mul8bit mul(new_M, new_Q, sub_result);
	
	sixteen_bit_fa f2(neg, neg, full_result, trash1, 16'd0, sub_result);
	or(or_temp0, sub_result[14], sub_result[15]);
	or(or_temp1, or_temp0, sub_result[13]);
	or(or_temp2, or_temp1, sub_result[12]);
	or(or_temp3, or_temp2, sub_result[11]);
	or(or_temp4, or_temp3, sub_result[10]);
	or(or_temp5, or_temp4, sub_result[9]);
	or(or_temp6, or_temp5, sub_result[8]);
	xor(sign_diff, M_m, Q_m);
	xor(over_sub, sign_diff, full_result[7]);
	or(overflow, over_sub, or_temp6);
	
	assign R[0] = full_result[0];
	assign R[1] = full_result[1];
	assign R[2] = full_result[2];
	assign R[3] = full_result[3];
	assign R[4] = full_result[4];
	assign R[5] = full_result[5];
	assign R[6] = full_result[6];
	assign R[7] = full_result[7];
	
endmodule

//8x8 bit multiplier ref: https://github.com/Saadia-Hassan/8x8Multiplier-Using-Vedic-Mathematics/blob/master/vedic8x8.v

module testbench();
	reg signed[7:0] A, B;
	wire signed [7:0] M;
	wire C;
	//module mul_signed(M, Q, R, overflow);
	mul_signed m0(A,B,M,overflow);
	initial begin
		$monitor ("Time=%d, A=%d, B=%d, S=%d, overflow=%d",
			$time,A,B,M,overflow);
		#10; A = 1; B = 2;
		#10; A = 7; B = 5;
		#10; A = 11; B = 8;
		#10; A = 12; B = 14;
		#10; A = 15; B = 15;
		#10; A = -2; B = 15;
		#10; A = -15; B = 15;
		#10; A = -5; B = -8;
	end
endmodule
