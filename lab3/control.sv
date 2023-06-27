module control(
	input logic Reset, Clk, Run, ClearA_LoadB, M, X,
	output logic Clr_Ld, Shift, Add, Sub
);

logic [2:0] count; //if counter = 3b'111 we need to check if M is 1 because this means we need to subtract
logic d_able;
assign d_able = Add | Sub | Reset

counter counting(.Clk(Clk), .enable(~d_able), .out(count)); //~Reset controls the counter since we shift after an add or subtract anyway



endmodule 