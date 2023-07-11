module mdrmux(
	input  logic [15:0] MDR_In, BUS,
	input  logic MIO_EN,
	output logic [15:0] new_MDR
);

always_comb begin
    if (MIO_EN == 1'b1) begin
        new_MDR = MDR_In; // data to cpu from memory
    end else begin
        new_MDR = BUS;
    end
end
//I feel like this can be always_comb and it maybe should be
	 
endmodule
