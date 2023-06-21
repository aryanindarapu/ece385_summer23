module lookahead_adder (
	input  [15:0] A, B,
	input         cin,
	output [15:0] S,
	output        cout
);

logic Pg0, Pg4, Pg8, Pg12, Gg0, Gg4, Gg8, Gg12;
logic [3:0] Pgs, Ggs; // NEVER USED(only exists to be used as outputs in lookahead_adder_pg)
logic C4, C8, C12;

// all done in parallel
lookahead_adder_pg PG0(.A(A[3:0]), .B(B[3:0]), .P(Pgs), .G(Ggs), .Pg(Pg0), .Gg(Gg0));
lookahead_adder_pg PG1(.A(A[7:4]), .B(B[7:4]), .P(Pgs), .G(Ggs), .Pg(Pg4), .Gg(Gg4));
lookahead_adder_pg PG2(.A(A[11:8]), .B(B[11:8]), .P(Pgs), .G(Ggs), .Pg(Pg8), .Gg(Gg8));
lookahead_adder_pg PG3(.A(A[15:12]), .B(B[15:12]), .P(Pgs), .G(Ggs), .Pg(Pg12), .Gg(Gg12));


// lookahead_adder_pg PG0(.A(A[3:0]), .B(B[3:0]), .Pg(Pg0), .Gg(Gg0));
// lookahead_adder_pg PG1(.A(A[7:4]), .B(B[7:4]), .Pg(Pg4), .Gg(Gg4));
// lookahead_adder_pg PG2(.A(A[11:8]), .B(B[11:8]), .Pg(Pg8), .Gg(Gg8));
// lookahead_adder_pg PG3(.A(A[15:12]), .B(B[15:12]), .Pg(Pg12), .Gg(Gg12));

assign C4   = (cin&Pg0)  | Gg0;
assign C8   = (C4&Pg4)   | Gg4;
assign C12  = (C8&Pg8)   | Gg8;
assign cout = (C12&Pg12) | Gg12;

lookahead_adder_4 LA0(.A(A[3:0]), .B(B[3:0]), .cin(cin), .S(S[3:0]));
lookahead_adder_4 LA1(.A(A[7:4]), .B(B[7:4]), .cin(C4), .S(S[7:4]));
lookahead_adder_4 LA2(.A(A[11:8]), .B(B[11:8]), .cin(C8), .S(S[11:8]));
lookahead_adder_4 LA3(.A(A[15:12]), .B(B[15:12]), .cin(C12), .S(S[15:12]));
//////////////////////////////////////////////


    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */

endmodule
