module lookahead_adder (
	input  [15:0] A, B,
	input         cin,
	output [15:0] S,
	output        cout
);
/*
	input [3:0] A, B,
	input cin,
	output [3:0] S,
	output Pg, Gg, cout
*/
logic Pg0, Pg4, Pg8,  Pg12, Gg0, Gg4, Gg8,  Gg12;
logic C4, C8, C12, C16;

lookahead_adder_4 LA0(.A(A[3:0]), .B(B[3:0]), .cin(cin), .S(S[3:0]), .Pg(Pg0), .Gg(Gg0));
lookahead_adder_4 LA0(.A(A[7:4]), .B(B[7:4]), .cin(C4), .S(S[7:4]), .Pg(Pg4), .Gg(Gg4));
lookahead_adder_4 LA0(.A(A[11:8]), .B(B[11:8]), .cin(C8), .S(S[11:8]), .Pg(Pg8), .Gg(Gg8));
lookahead_adder_4 LA0(.A(A[15:12]), .B(B[15:12]), .cin(C12), .S(S[15:12]), .Pg(Pg12), .Gg(Gg12));

assign Pg0 = A[0]^B[0];
assign Pg1 = A[1]^B[1];
assign Pg2 = A[2]^B[2];
assign Pg3 = A[3]^B[3];

assign Gg0 = A[0]&B[0];
assign Gg1 = A[1]&B[1];
assign Gg2 = A[2]&B[2];
assign Gg3 = A[3]&B[3];

assign C4 = (cin&P0) | G0;
assign C8 = (C1&P1) | G1;
assign C12 = (C2&P2) | G2;
assign C16 = (C3&P3) | G3;

    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */

endmodule
