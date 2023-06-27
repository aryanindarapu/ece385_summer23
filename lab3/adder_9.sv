module adder_9(
	input logic [8:0] XA,
	input logic [7:0] SW,
	output logic [7:0] S
);

logic [8:0] ext_SW;
assign ext_SW[8] = 
logic c1; //the output carry bit to the next 2-bit adder
logic c2;
logic c3;
logic c4;
logic c5;
logic c6;
logic c7;
logic c8;
logic c9;
	
	//16 full adders that pass cout->cin serially
full_adder FA0(.x(A[0]), .y(B[0]), .cin(1'b0), .s(S[0]), .cout(c1));
full_adder FA1(.x(A[1]), .y(B[1]), .cin(c1), .s(S[1]), .cout(c2));
full_adder FA2(.x(A[2]), .y(B[2]), .cin(c2), .s(S[2]), .cout(c3));
full_adder FA3(.x(A[3]), .y(B[3]), .cin(c3), .s(S[3]), .cout(c4));
full_adder FA4(.x(A[4]), .y(B[4]), .cin(c4), .s(S[4]), .cout(c5));
full_adder FA5(.x(A[5]), .y(B[5]), .cin(c5), .s(S[5]), .cout(c6));
full_adder FA6(.x(A[6]), .y(B[6]), .cin(c6), .s(S[6]), .cout(c7));
full_adder FA7(.x(A[7]), .y(B[7]), .cin(c7), .s(S[7]), .cout(c8));
full_adder FA8(.x(A[8]), .y(B[8]), .cin(c8), .s(S[8]), .cout(c9));


endmodule 