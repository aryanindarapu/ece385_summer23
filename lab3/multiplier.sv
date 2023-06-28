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

/* Current Multiplier State Outputs 
 *
 * Clr_Ld = 3'b000;
 * Shift = 3'b001;
 * Add = 3'b010;
 * Sub = 3'b011;
 * Reset = 3'b100;
*/

logic [8:0] new_XA_add, new_XA_sub;
logic [1:0] curr_state;

control ctrl(.Reset_Load_Clear(Reset_Load_Clear), .Clk(Clk), .Run(Run), .M(M), .out_state(curr_state));
// .Clr_Ld(Clr_Ld), .Shift(Shift), .Add(Add), .Sub(Sub));
adder_9 add(.XA(XA), .S(SW), .OUT(new_XA_add));
subtracter_9 sub(.XA(XA), .S(SW), .OUT(new_XA_sub));

logic [16:0] full_output;
always_comb begin
	unique case (curr_state)
		3'b000 : 
			XA = 9'b000000000;
			B = SW;

		3'b001 : 
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

		3'b010 : XA = new_XA_add;
		
		3'b011 : XA = new_XA_sub;

		3'b100 : 
			full_output = { XA[7:0], B }; // display to hex drivers
			XA = 9'b000000000;
	endcase

end

endmodule 