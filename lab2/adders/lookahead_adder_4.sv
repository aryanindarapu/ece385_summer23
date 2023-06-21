module lookahead_adder_4(
	input [3:0] A, B,
	input cin,
	output [3:0] S,
);

logic P0, P1, P2, P3, G0, G1, G2, G3;
logic C1, C2, C3;
logic Pg, Gg; // NEVER USED

lookahead_adder_pg LPG(.A(A), .B(B), .P({P3, P2, P1, P0}), .G({G3, G2, G1, G0}), .Pg(Pg), .Gg(Gg));

assign C1 = (cin&P0) | G0;
assign C2 = (C1&P1) | G1;
assign C3 = (C2&P2) | G2;

S[0] = A[0]^B[0]^cin;
S[1] = A[1]^B[1]^C1;
S[2] = A[2]^B[2]^C2;
S[3] = A[3]^B[3]^C3;
 
endmodule 