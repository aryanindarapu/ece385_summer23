module conditioncode (
    input  logic Clk, Reset, LD_CC, LD_BEN,
	input  logic [15:0] IR, BUS,
    output logic BEN
);

logic temp_BEN;
logic [2:0] CC; // register for cc

always_ff @ (posedge Clk) begin
    if (Reset)
        BEN <= 1'b0;

    if (LD_BEN)
        BEN <= temp_BEN;
end

reg_cc r_CC (.Clk(Clk), .Reset(Reset), .LD_CC(LD_CC), .BUS(BUS), .Data_Out(CC));


always_comb begin
    // Set new_BEN based on LD_BEN and BEN
    temp_BEN = (CC[2] & IR[11]) | (CC[1] & IR[10]) | (CC[0] & IR[9]); //+ is arithmetic add we need to do OR
end
	 
endmodule
