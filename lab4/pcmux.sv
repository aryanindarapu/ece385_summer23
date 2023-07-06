module pcmux(
	input  logic [15:0] PCMUX, PC, BUS,
	input  logic Clk,
	output logic [15:0] new_PC
);

always_ff @ (posedge Clk) begin
    case (PCMUX)
        2'b00: new_PC = PC + 1;
        2'b01: new_PC = BUS;
        default: new_PC = PC;
    endcase
end
	 
endmodule
