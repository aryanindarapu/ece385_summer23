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
logic [15:0] full_output;
logic notRun, notReset_Load_Clear;
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
logic [2:0] curr_state;

control ctrl(.Reset_Load_Clear(notReset_Load_Clear), .Clk(Clk), .Run(notRun), .M(M), .out_state(curr_state));
// .Clr_Ld(Clr_Ld), .Shift(Shift), .Add(Add), .Sub(Sub));
adder_9 add(.XA(XA), .SW(SW), .new_XA(new_XA_add));
subtracter_9 sub(.XA(XA), .SW(SW), .new_XA(new_XA_sub));

always_comb begin //These are active low, not high, TODO
	notRun = ~Run;
	notReset_Load_Clear = ~Reset_Load_Clear;
end

always_ff @ (posedge Clk) begin
	//add a default values for all the values I'm chaing in the always_comb
	case (curr_state)
		3'b000 : begin
			XA <= 9'b000000000;
			B <= SW;
		end
		3'b001 :;
		3'b010 :  begin XA <= new_XA_add; end
		
		3'b011 : begin XA <= new_XA_sub; end

		3'b100 : begin
			full_output[15:8] <= XA[7:0]; //set to save the part of A
			full_output[7:0] <= B;
//			XA <= 9'b000000000;
			end
		3'b101 : begin
			B[0] <= B[1];
			B[1] <= B[2];
			B[2] <= B[3];
			B[3] <= B[4];
			B[4] <= B[5];
			B[5] <= B[6];
			B[6] <= B[7]; 
			B[7] <= XA[0];
			XA[0] <= XA[1];
			XA[1] <= XA[2];
			XA[2] <= XA[3];
			XA[3] <= XA[4];
			XA[4] <= XA[5];
			XA[5] <= XA[6];
			XA[6] <= XA[7];
			XA[7] <= XA[8];
			end
		default:;
	endcase
end

assign Aval = XA[7:0];
assign Bval = B;
assign Xval = XA[8];

HexDriver AHex0 (
	.In0(Bval[3:0]),
	.Out0(HEX0)
);
								
HexDriver AHex1 (
	.In0(Bval[7:4]),
	.Out0(HEX1) 
);
						
HexDriver BHex0 (
	.In0(full_output[11:8]),
	.Out0(HEX2)
);
						
HexDriver BHex1 (
	.In0(full_output[15:12]),
	.Out0(HEX3)
);

endmodule 