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
logic X, M;
logic [7:0] A, B;
logic [8:0] XA, S;
assign M = B[0];

//assign XA as a X concatenated with A
assign XA[8] = X;
assign XA[7:0] = A

//assign S as a sign extended SW
assign S[8] = SW[7]; 
assign S[7:0] = SW;

//logics I'm not sure if ill need to use
logic Clr_Ld, Shift, Add, Sub;


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
control ctrl(.Reset(Reset_Load_Clear), .Clk(Clk), .Run(Run), .ClearA_LoadB(Reset_Load_Clear), .M(M), .X(X), .Clr_Ld(Clr_Ld), .Shift(Shift), .Add(Add), .Sub(Sub));
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
adder_9 add_sub(.XA(XA), .S(S), .OUT(A));
///////////////////////////////NOTE THAT OUTPUT FROM THE 9-BIT ADDER(WHICH IS THE LEAST SIGNIFICANT 8-BITS) GOES INTO A//////////////////////////////////////////////////

always_comb begin
	if (Shift == 1'b1) begin
		logic temp = B[0];
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
		XA[8] = temp;
	end else if (Add == 1'b1) begin
		
	end

end

endmodule 