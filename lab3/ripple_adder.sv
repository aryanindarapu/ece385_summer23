module ripple_adder
(
	input  [15:0] A, B,
	input         cin,
	output [15:0] S,
	output        cout
);

	logic c1; //the output carry bit to the next 2-bit adder
	logic c2;
	logic c3;
	logic c4;
	logic c5;
	logic c6;
	logic c7;
	logic c8;
	logic c9;
	logic c10;
	logic c11;
	logic c12;
	logic c13;
	logic c14;
	logic c15;
	
	//16 full adders that pass cout->cin serially
	full_adder FA0(.x(A[0]), .y(B[0]), .cin(cin), .s(S[0]), .cout(c1));
	full_adder FA1(.x(A[1]), .y(B[1]), .cin(c1), .s(S[1]), .cout(c2));
	full_adder FA2(.x(A[2]), .y(B[2]), .cin(c2), .s(S[2]), .cout(c3));
	full_adder FA3(.x(A[3]), .y(B[3]), .cin(c3), .s(S[3]), .cout(c4));
	full_adder FA4(.x(A[4]), .y(B[4]), .cin(c4), .s(S[4]), .cout(c5));
	full_adder FA5(.x(A[5]), .y(B[5]), .cin(c5), .s(S[5]), .cout(c6));
	full_adder FA6(.x(A[6]), .y(B[6]), .cin(c6), .s(S[6]), .cout(c7));
	full_adder FA7(.x(A[7]), .y(B[7]), .cin(c7), .s(S[7]), .cout(c8));
	full_adder FA8(.x(A[8]), .y(B[8]), .cin(c8), .s(S[8]), .cout(c9));
	full_adder FA9(.x(A[9]), .y(B[9]), .cin(c9), .s(S[9]), .cout(c10));
	full_adder FA10(.x(A[10]), .y(B[10]), .cin(c10), .s(S[10]), .cout(c11));
	full_adder FA11(.x(A[11]), .y(B[11]), .cin(c11), .s(S[11]), .cout(c12));
	full_adder FA12(.x(A[12]), .y(B[12]), .cin(c12), .s(S[12]), .cout(c13));
	full_adder FA13(.x(A[13]), .y(B[13]), .cin(c13), .s(S[13]), .cout(c14));
	full_adder FA14(.x(A[14]), .y(B[14]), .cin(c14), .s(S[14]), .cout(c15));
	full_adder FA15(.x(A[15]), .y(B[15]), .cin(c15), .s(S[15]), .cout(cout));
	
	 /* TODO
     *
     * Insert code here to implement a ripple adder.
     * your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */

     
endmodule
