module lookahead_adder_4(
	input [3:0] A, B,
	input cin,
	output [3:0] S
);

logic [3:0] P, G;
logic C1, C2, C3;
logic Pg, Gg; // NEVER USED(only exists for lookahead_adder to send cin's here)

lookahead_adder_pg LPG(.A(A), .B(B), .P(P), .G(G), .Pg(Pg), .Gg(Gg));

assign C1 = (cin&P[0]) | G[0];
assign C2 = (C1&P[1]) | G[1];
assign C3 = (C2&P[2]) | G[2];

assign S[0] = A[0]^B[0]^cin;
assign S[1] = A[1]^B[1]^C1;
assign S[2] = A[2]^B[2]^C2;
assign S[3] = A[3]^B[3]^C3;
 
endmodule 