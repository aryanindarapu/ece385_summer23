module pcmux(
	input  logic [15:0] PC, BUS, ADDER_OUT,
	input  logic [1:0] PCMUX,
	output logic [15:0] new_PC
);

always_comb begin
    case (PCMUX)
        2'b01: new_PC = BUS;
        2'b10: new_PC = ADDER_OUT;
        default: new_PC = PC + 1'b1;
    endcase
end
//I feel like this can be always_comb and it maybe should be	 
endmodule
