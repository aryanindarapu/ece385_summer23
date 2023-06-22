module lookahead_adder_pg (
    input [3:0] A, B,
    output [3:0] P, G,
    output Pg, Gg
);
    assign P[0] = A[0]^B[0];
    assign P[1] = A[1]^B[1];
    assign P[2] = A[2]^B[2];
    assign P[3] = A[3]^B[3];

    assign G[0] = A[0]&B[0];
    assign G[1] = A[1]&B[1];
    assign G[2] = A[2]&B[2];
    assign G[3] = A[3]&B[3];

    assign Pg = P[0]&P[1]&P[2]&P[3];
    assign Gg = G[3] | (G[2]&P[3]) | (G[1]&P[3]&P[2]) | (G[0]&P[3]&P[2]&P[1]);

endmodule 