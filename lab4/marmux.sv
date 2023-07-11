module marmux (
	input  logic [15:0] IR, PC, SR1_OUT,
    input  logic [1:0] ADDR2MUX,
    input  logic ADDR1MUX, // MARMUX, NOTE: Don't need MARMUX in SLC-3
    output logic [15:0] new_MAR
);

logic [15:0] addr1_out, addr2_out;

always_comb begin
    // ADDR1 Code
    if (ADDR1MUX) begin
        addr1_out = SR1_OUT; // data to cpu from memory
    end else begin
        addr1_out = PC;
    end

    // ADDR2 Code
    case (ADDR2MUX) // NOTE: We are SEXTing
        2'b01: addr2_out = {{10{IR[5]}}, IR[5:0]};
        2'b10: addr2_out = {{7{IR[8]}}, IR[8:0]};
        2'b11: addr2_out = {{5{IR[10]}}, IR[10:0]};
        default: addr2_out = 16'b0;
    endcase

    new_MAR = addr1_out + addr2_out;
end
	 
endmodule
