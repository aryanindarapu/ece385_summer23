module conditioncode (
	input  logic [15:0] IR, BUS,
    input  logic LD_CC, Reset, Clk, LD_BEN,
    output logic BEN
);

always_ff @ (posedge Clk) begin
    if (Reset)
        BEN <= 1'b0;

    if (LD_BEN)
        BEN <= temp_BEN;
end

// register for cc
logic [2:0] CC;
reg_cc CC (.Clk(Clk), .Reset(Reset), .Load(LD_CC), .BUS(BUS), .Data_Out(CC));

logic temp_BEN;

always_comb begin
    // Set new_BEN based on LD_BEN and BEN
    temp_BEN = CC[2] & IR[11] + CC[1] & IR[10] + CC[0] & IR[9];
end
	 
endmodule
