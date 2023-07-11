module marmux (
	input  logic [15:0] IR, PC, SR1_OUT,
    input  logic [1:0] ADDR2MUX,
    input  logic ADDR1MUX, // MARMUX, NOTE: Don't need MARMUX in SLC-3
    output logic new_MAR
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
    case (ADDR2MUX): // NOTE: We are SEXTing
        2'b01: begin
            if (IR[5]) addr2_out = {10'b1, IR[5:0]};
            else addr2_out = {10'b0, IR[5:0]};
        end
        2'b10: begin
            if (IR[8]) addr2_out = {7'b1, IR[8:0]};
            else addr2_out = {7'b0, IR[8:0]};
        end
        2'b11: begin
            if (IR[10]) addr2_out = {5'b1, IR[10:0]};
            else addr2_out = {5'b0, IR[10:0]};
        end
        default: addr2_out = 16'b0;
    endcase

    new_MAR = addr1_out + addr2_out;
end
	 
endmodule
