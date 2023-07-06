module datapath (
	 input  logic Clk,
    input  logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED,
    input  logic GatePC, GateMDR, GateALU, GateMARMUX,
    input  logic SR2MUX, ADDR1MUX, MARMUX,
    input  logic BEN, MIO_EN, DRMUX, SR1MUX,
    input  logic [1:0] PCMUX, ADDR2MUX, ALUK,
    input  logic [15:0] MDR_In,
//	 output logic [3:0] hex_4[3:0],
    output logic [15:0] MAR, MDR, IR
);

logic [15:0] PC, BUS, new_PC;

pcmux PM(.PCMUX(PCMUX), .PC(PC), .BUS(BUS), .Clk(Clk), .new_PC(new_PC));

always_comb begin
	 PC = new_PC;

    // Gate Muxes
    if (GatePC) BUS = PC;
    else if (GateMDR) BUS = MDR;
    // else if (GateALU) BUS = ALU;
    // else if (GateMARMUX) BUS = MARMUX;
    else BUS = 16'b0; // TODO: pretty sus not sure if right

    // Output Muxes
    if (LD_MAR == 1'b1) begin
        MAR = BUS;
    end else begin
        MAR = MAR;
    end

    if (LD_MDR == 1'b1) begin
        if (MIO_EN == 1'b1) begin
            MDR = MDR_In; // data to cpu from memory
        end else begin
            MDR = BUS;
        end
    end else begin
        MDR = MDR;
    end

    if (LD_IR == 1'b1) begin
        IR = BUS;
    end else begin
        IR = IR;
    end
end

endmodule
