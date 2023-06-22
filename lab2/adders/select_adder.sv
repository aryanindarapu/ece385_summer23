module select_adder (
	input  [15:0] A, B,
	input         cin,
	output [15:0] S,
	output        cout
);
    logic [15:0] S_0, S_1;
    logic [3:0] tempS;
    logic C4;

    // Hardwired logic to get possibilities if cin = 0 or 1
    select_adder_4 SA0(.A(A[3:0]), .B(B[3:0]), .cin(cin), .S(tempS[3:0]), .cout(C4));
    assign S_0[3:0] = tempS[3:0];
    assign S_1[3:0] = tempS[3:0];

    logic C8, C8_0, C8_1;
    select_adder_4 SA1(.A(A[7:4]), .B(B[7:4]), .cin(1'b0), .S(S_0[7:4]), .cout(C8_0));
    select_adder_4 SA2(.A(A[7:4]), .B(B[7:4]), .cin(1'b1), .S(S_1[7:4]), .cout(C8_1));
    assign C8 = C8_0 | (C4 & C8_1);

    logic C12, C12_0, C12_1;
    select_adder_4 SA3(.A(A[11:8]), .B(B[11:8]), .cin(1'b0), .S(S_0[11:8]), .cout(C12_0));
    select_adder_4 SA4(.A(A[11:8]), .B(B[11:8]), .cin(1'b1), .S(S_1[11:8]), .cout(C12_1));
    assign C12 = C12_0 | (C8 & C12_1);

    logic C16_0, C16_1;
    select_adder_4 SA5(.A(A[15:12]), .B(B[15:12]), .cin(1'b0), .S(S_0[15:12]), .cout(C16_0));
    select_adder_4 SA6(.A(A[15:12]), .B(B[15:12]), .cin(1'b1), .S(S_1[15:12]), .cout(C16_1));

    // TODO: Check that this logic works
    always_comb
		if (cin == 1'b0) begin
			 S = S_0;
			 cout = C16_0 | (C12 & C16_1);
		end else begin
			 S = S_1;
			 cout = C16_0 | (C12 & C16_1);
		end

    /* TODO
     *
     * Insert code here to implement a CSA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */

endmodule
