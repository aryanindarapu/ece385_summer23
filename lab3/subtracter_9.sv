module subtracter_9(
	input  logic [8:0] XA,
	input  logic [7:0] SW,
	output logic [8:0] new_XA
);

logic [7:0] tempSwitches;
assign tempSwitches = ~SW;

logic [8:0] notSwitches;
adder_9 SA0(.XA(9'b000000001), .SW(tempSwitches), .new_XA(notSwitches));

adder_9 SA1(.XA(XA), .SW(notSwitches[7:0]), .new_XA(new_XA));

endmodule 