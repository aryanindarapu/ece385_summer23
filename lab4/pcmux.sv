module pcmux(
	input  logic [15:0] PC, BUS,
	input logic [1:0] PCMUX,
	input  logic Clk,
	output logic [15:0] new_PC
);

always_comb begin
    case (PCMUX)
        2'b00: new_PC = PC + 1;
        2'b01: new_PC = BUS;
        default: new_PC = PC;
    endcase
end
//I feel like this can be always_comb and it maybe should be	 
endmodule
