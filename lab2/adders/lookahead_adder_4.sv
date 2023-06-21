module lookahead_adder_4(
	input [3:0] A, B,
	input cin,
	output [3:0] S,
	output Pg, Gg
);

logic P0, P1, P2, P3, G0, G1, G2, G3;
logic C1, C2, C3;

assign P0 = A[0]^B[0];
assign P1 = A[1]^B[1];
assign P2 = A[2]^B[2];
assign P3 = A[3]^B[3];

assign G0 = A[0]&B[0];
assign G1 = A[1]&B[1];
assign G2 = A[2]&B[2];
assign G3 = A[3]&B[3];

assign C1 = (cin&P0) | G0;
assign C2 = (C1&P1) | G1;
assign C3 = (C2&P2) | G2;

full_adderPG FA0(.x(A[0]), .y(B[0]), .cin(cin), .s(S[0]), .p(P0), .g(G0));

full_adderPG FA1(.x(A[1]), .y(B[1]), .cin(C1), .s(S[1]), .p(P1), .g(G1));

full_adderPG FA2(.x(A[2]), .y(B[2]), .cin(C2), .s(S[2]), .p(P2), .g(G2));

full_adderPG FA3(.x(A[3]), .y(B[3]), .cin(C3), .s(S[3]), .p(P3), .g(G3));

assign Pg = P0&P1&P2&P3;
assign Gg = G3 | (G2&P3) | (G1&P3&P2) | (G0&P3&P2&P1);
 
endmodule 