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

logic [15:0] PC, BUS, new_BUS;
logic [15:0] new_PC, new_MDR;

reg_16 mar_reg (.Clk(Clk), .Reset(Reset), .Load(LD_MAR), .D(BUS), .Data_Out(MAR));
reg_16 mdr_reg (.Clk(Clk), .Reset(Reset), .Load(LD_MDR), .D(new_MDR), .Data_Out(MDR));
reg_16 ir_reg (.Clk(Clk), .Reset(Reset), .Load(LD_IR), .D(BUS), .Data_Out(IR));
reg_16 pc_reg (.Clk(Clk), .Reset(Reset), .Load(LD_PC), .D(new_PC), .Data_Out(PC)); 

mdrmux mdrm (.MIO_EN(MIO_EN), .MDR_In(MDR_In), .BUS(BUS), .Clk(Clk), .new_MDR(new_MDR));
pcmux pcm (.PCMUX(PCMUX), .PC(PC), .BUS(BUS), .Clk(Clk), .new_PC(new_PC));

always_comb begin
	 new_BUS = BUS;
    // Gate Muxes
    if (GatePC) begin 
		new_BUS = PC;
	 end
    else if (GateMDR) begin
		new_BUS = MDR;
	 end
    // else if (GateALU) BUS = ALU;
    // else if (GateMARMUX) BUS = MARMUX;
//	 else begin
//		new_BUS = 16'h0;
//	 end
end

always_ff @ (posedge Clk) begin //This did something but didn't quite work
    if (Reset) begin
        BUS = 16'h0; 
    end else begin
        BUS = new_BUS;
    end
end

endmodule
