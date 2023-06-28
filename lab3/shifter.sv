module shifter (
	input  logic [7:0] XA, B,
	output logic [8:0] new_XA, 
	output logic [7:0] new_B
);

always_comb begin
	new_B[0] = B[1];
	new_B[1] = B[2];
	new_B[2] = B[3];
	new_B[3] = B[4];
	new_B[4] = B[5];
	new_B[5] = B[6];
	new_B[6] = B[7]; 
	new_B[7] = XA[0];
	
	new_XA[0] = XA[1];
	new_XA[1] = XA[2];
	new_XA[2] = XA[3];
	new_XA[3] = XA[4];
	new_XA[4] = XA[5];
	new_XA[5] = XA[6];
	new_XA[6] = XA[7];
	new_XA[7] = XA[8];
	new_XA[8] = XA[8]; // previous X is also new X
end

endmodule 