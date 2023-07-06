module mdrmux(
	input  logic [15:0] MIO_EN, MDR_In, BUS,
	input  logic Clk,
	output logic [15:0] new_MDR
);

always_ff @ (posedge Clk) begin
    if (MIO_EN == 1'b1) begin
        new_MDR = MDR_In; // data to cpu from memory
    end else begin
        new_MDR = BUS;
    end
end
	 
endmodule
