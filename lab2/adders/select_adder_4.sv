module select_adder_4 (
    input [3:0] A, B,
    input cin,
    output [3:0] S,
    output cout
);
    logic cout0, cout1, cout2;

    // Just a 4-bit CRA
    full_adder FA0(.x(A[0]), .y(B[0]), .cin(cin), .s(S[0]), .cout(cout0));
    full_adder FA1(.x(A[1]), .y(B[1]), .cin(cout0), .s(S[1]), .cout(cout1));
    full_adder FA2(.x(A[2]), .y(B[2]), .cin(cout1), .s(S[2]), .cout(cout2));
    full_adder FA3(.x(A[3]), .y(B[3]), .cin(cout2), .s(S[3]), .cout(cout));

endmodule
