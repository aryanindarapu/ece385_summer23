module control(
	input logic Reset, Clk, Run, ClearA_LoadB, M, X,
	output logic Clr_Ld, Shift, Add, Sub
);

logic [2:0] counter; //if counter = 3b'111 we need to check if M is 1 because this means we need to subtract






endmodule 