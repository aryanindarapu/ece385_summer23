module datapath (
	 input  logic Clk, Reset,
    input  logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED,
    input  logic GatePC, GateMDR, GateALU, GateMARMUX,
    input  logic SR2MUX, ADDR1MUX, MARMUX,
    input  logic BEN, MIO_EN, DRMUX, SR1MUX,
    input  logic [1:0] PCMUX, ADDR2MUX, ALUK,
    input  logic [15:0] MDR_In,
//	 output logic [3:0] hex_4[3:0],
    output logic [15:0] MAR, MDR, IR
);

logic [3:0] gates;
assign gates = {GatePC, GateMDR, GateALU, GateMARMUX};
logic [15:0] PC, BUS	;
logic [15:0] new_PC, new_MDR;

reg_16 mar_reg (.Clk(Clk), .Reset(Reset), .Load(LD_MAR), .D(BUS), .Data_Out(MAR));
reg_16 mdr_reg (.Clk(Clk), .Reset(Reset), .Load(LD_MDR), .D(new_MDR), .Data_Out(MDR));
reg_16 ir_reg (.Clk(Clk), .Reset(Reset), .Load(LD_IR), .D(BUS), .Data_Out(IR));
reg_16 pc_reg (.Clk(Clk), .Reset(Reset), .Load(LD_PC), .D(new_PC), .Data_Out(PC)); 

mdrmux mdrm (.MIO_EN(MIO_EN), .MDR_In(MDR_In), .BUS(BUS), .Clk(Clk), .new_MDR(new_MDR));
pcmux pcm (.PCMUX(PCMUX), .PC(PC), .BUS(BUS), .Clk(Clk), .new_PC(new_PC));

always_comb begin
//    // Gate Muxes
//    if (GatePC && GateMDR == 1'b0) begin 
//		BUS = PC;
//	 end
//    else if (GateMDR && GatePC == 1'b0) begin
//		BUS = MDR;
//	 end
//	 
//    // else if (GateALU) BUS = ALU;
//    // else if (GateMARMUX) BUS = MARMUX;
//	 else begin
//		BUS = 16'bxxxxxxxxxxxxxxxx;
//	 end
	 if (gates == 4'b1000) 
		BUS = PC; //GatePC
	 else if (gates == 4'b0100)
		BUS = MDR; //GateMDR
	 else if (gates == 4'b0010)
		BUS = 16'h0; //WHATEVER THE ALU OUPUT WOULD BE
	 else if (gates == 4'b0001)
		BUS = 16'h0; //WHATEVER MARMUX DOES
	 else 
		BUS = 16'bxxxxxxxxxxxxxxxx;
end

endmodule
