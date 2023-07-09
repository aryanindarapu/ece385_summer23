module datapath (
	input  logic Clk, Reset,
    input  logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED,
    input  logic GatePC, GateMDR, GateALU, GateMARMUX,
    input  logic SR2MUX, ADDR1MUX, MARMUX,
    input  logic MIO_EN, DRMUX, SR1MUX,
    input  logic [1:0] PCMUX, ADDR2MUX, ALUK,
    input  logic [15:0] MDR_In,
    output logic [15:0] MAR, MDR, IR
	output logic BEN
);

logic [3:0] gates;
assign gates = {GatePC, GateMDR, GateALU, GateMARMUX};
logic [15:0] PC, BUS, ALU, SR1_OUT, SR2_OUT;
logic [15:0] new_PC, new_MDR, new_ALU, new_MAR;

reg_16 mar_reg (.Clk(Clk), .Reset(Reset), .Load(LD_MAR), .D(BUS), .Data_Out(MAR));
reg_16 mdr_reg (.Clk(Clk), .Reset(Reset), .Load(LD_MDR), .D(new_MDR), .Data_Out(MDR));
reg_16 ir_reg (.Clk(Clk), .Reset(Reset), .Load(LD_IR), .D(BUS), .Data_Out(IR));
reg_16 pc_reg (.Clk(Clk), .Reset(Reset), .Load(LD_PC), .D(new_PC), .Data_Out(PC));

mdrmux mdrm (.MIO_EN(MIO_EN), .MDR_In(MDR_In), .BUS(BUS), .Clk(Clk), .new_MDR(new_MDR));
marmux marm (.IR(IR), .PC(PC), .SR1_OUT(SR1_OUT), .ADDR2MUX(ADDR2MUX), .ADDR1MUX(ADDR1MUX), .Clk(Clk), .new_MAR(new_MAR));
pcmux pcm (.PCMUX(PCMUX), .PC(PC), .BUS(BUS), .Clk(Clk), .new_PC(new_PC));
regfile reg (.DRMUX(DRMUX), .SR1MUX(SR1MUX), .LD_REG(LD_REG), .IR(IR), .BUS(BUS), .SR1_OUT(SR1_OUT), .SR2_OUT(SR2_OUT));
conditioncode cc (.IR(IR), .BUS(BUS), .LD_CC(LD_CC), .Reset(Reset), .Clk(Clk), .BEN(BEN));

alu al (.SR1_OUT(SR1_OUT), .SR2_OUT(SR2_OUT), .IR(IR[4:0]), .ALUK(ALUK), .GateALU(GateALU), .new_ALU(new_ALU)); // TODO: Need to properly work out

always_comb begin
	if (gates == 4'b1000) // GatePC
		BUS = PC; 
	else if (gates == 4'b0100) // GateMDR
		BUS = MDR; 
	else if (gates == 4'b0010) // GateALU
		BUS = new_ALU; //WHATEVER THE ALU OUPUT WOULD BE
	else if (gates == 4'b0001) // GateMARMUX
		BUS = new_MAR; //WHATEVER MARMUX DOES
	else 
		BUS = 16'bxxxxxxxxxxxxxxxx;
end

endmodule
