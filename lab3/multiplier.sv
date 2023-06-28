module multiplier(
	input logic [7:0] SW,
	input logic Reset_Load_Clear, Run, Clk,
	output logic [6:0] HEX0, 
                       HEX1, 
                       HEX2, 
                       HEX3,
	output logic [7:0] Aval, Bval,
	output logic Xval
);

//define logics which are also our registers
logic M;
logic [7:0] B;
logic [8:0] XA;

initial begin
	XA = 9'b000000000;
	B = 8'b00000000;
end

assign M = B[0];

//logics I'm not sure if ill need to use
logic Clr_Ld, Shift, Add, Sub;
enum logic [1:0] { Clr_Ld, Shift, Add, Sub } curr_state;
logic [8:0] new_XA_add, new_XA_sub;

control ctrl(.Reset(Reset_Load_Clear), .Clk(Clk), .Run(Run), .ClearA_LoadB(Reset_Load_Clear), .M(M), .out_state(curr_state));
// .Clr_Ld(Clr_Ld), .Shift(Shift), .Add(Add), .Sub(Sub));
adder_9 add(.XA(XA), .S(SW), .OUT(new_XA_add));
subtracter_9 sub(.XA(XA), .S(SW), .OUT(new_XA_sub));



always_comb begin
	unique case (curr_state)
		Clr_Ld : 
			XA = 9'b000000000;
			B = SW;

		Shift : 
			B[0] = B[1];
			B[1] = B[2];
			B[2] = B[3];
			B[3] = B[4];
			B[4] = B[5];
			B[5] = B[6];
			B[6] = B[7]; 
			B[7] = XA[0];
			XA[0] = XA[1];
			XA[1] = XA[2];
			XA[2] = XA[3];
			XA[3] = XA[4];
			XA[4] = XA[5];
			XA[5] = XA[6];
			XA[6] = XA[7];
			XA[7] = XA[8];

		Add : XA = new_XA_add;
		
		Sub : XA = new_XA_sub;
	endcase

end

endmodule 