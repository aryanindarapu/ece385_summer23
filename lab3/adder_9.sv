module adder_9 (
	input logic [8:0] XA,
	input logic [7:0] SW,
	output logic [8:0] new_XA
);

logic c1; // the output carry bit to the next 2-bit adder
logic c2;
logic c3;
logic c4;
logic c5;
logic c6;
logic c7;
logic c8;
logic c9;
	
// 16 full adders that pass cout->cin serially
full_adder FA0(.x(XA[0]), .y(SW[0]), .cin(1'b0), .s(new_XA[0]), .cout(c1));
full_adder FA1(.x(XA[1]), .y(SW[1]), .cin(c1), .s(new_XA[1]), .cout(c2));
full_adder FA2(.x(XA[2]), .y(SW[2]), .cin(c2), .s(new_XA[2]), .cout(c3));
full_adder FA3(.x(XA[3]), .y(SW[3]), .cin(c3), .s(new_XA[3]), .cout(c4));
full_adder FA4(.x(XA[4]), .y(SW[4]), .cin(c4), .s(new_XA[4]), .cout(c5));
full_adder FA5(.x(XA[5]), .y(SW[5]), .cin(c5), .s(new_XA[5]), .cout(c6));
full_adder FA6(.x(XA[6]), .y(SW[6]), .cin(c6), .s(new_XA[6]), .cout(c7));
full_adder FA7(.x(XA[7]), .y(SW[7]), .cin(c7), .s(new_XA[7]), .cout(c8));
full_adder FA8(.x(XA[8]), .y(SW[7]), .cin(c8), .s(new_XA[8]), .cout(c9));

endmodule 