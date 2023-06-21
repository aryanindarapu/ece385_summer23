module lookahead_adder_pg (
    input [3:0] A, B,
    output [3:0] P, G
    output Pg, Gg
);
    logic P0, P1, P2, P3, G0, G1, G2, G3;
    assign P[0] = A[0]^B[0];
    assign P[1] = A[1]^B[1];
    assign P[2] = A[2]^B[2];
    assign P[3] = A[3]^B[3];

    assign G[0] = A[0]&B[0];
    assign G[1] = A[1]&B[1];
    assign G[2] = A[2]&B[2];
    assign G[3] = A[3]&B[3];

    logic Pg, Gg;
    assign Pg = P0&P1&P2&P3;
    assign Gg = G3 | (G2&P3) | (G1&P3&P2) | (G0&P3&P2&P1);

    // assign S[0] = A[0]^B[0]^cin;
    // assign S[1] = A[1]^B[1]^cin;
    // assign S[2] = A[2]^B[2]^cin;
    // assign S[3] = A[3]^B[3]^cin;

endmodule