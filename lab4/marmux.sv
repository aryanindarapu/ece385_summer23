module marmux (
	input  logic [15:0] IR, PC, SR1_OUT,
    input  logic [1:0] ADDR2MUX,
    input  logic ADDR1MUX, Clk, // MARMUX, NOTE: Don't need MARMUX in SLC-3
    output logic new_MAR
);

logic [15:0] addr1_out, addr2_out;

always_ff @ (posedge Clk) begin
    new_MAR <= addr1_out + addr2_out;
end

always_comb begin
    // ADDR1 Code
    if (ADDR1MUX == 1'b1) begin
        addr1_out = PC; // data to cpu from memory
    end else begin
        addr1_out = SR1_OUT;
    end

    // ADDR2 Code
    case (ADDR2MUX):
        2'b01: addr2_out = {10'b1, IR[5:0]};
        2'b10: addr2_out = {8'b1, IR[8:0]};
        2'b11: addr2_out = {5'b1, IR[10:0]};
        default: addr2_out = 16'b0;
    endcase
end
	 
endmodule
