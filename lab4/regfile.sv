module regfile (
    input  logic Clk, Reset, DRMUX, SR1MUX, LD_REG,
    input  logic [15:0] IR, BUS,
    output logic [15:0] SR1_OUT, SR2_OUT
);

logic [15:0] regs [8];

always_ff @ (posedge Clk) begin
    if (Reset) begin // notice, this is a sycnrhonous reset, which is recommended on the FPGA
        for (int i = 0; i < 8; i++)
            regfile[i] <= 16'b0;
    end else if (LD_REG) begin
        regs[DR] <= BUS;
    end
end

logic [2:0] DR, SR1, SR2;

always_comb begin
    if (~DRMUX) // 0 based on lc-3 control manual
        DR = IR[11:9]; // instruction destination register specification bits
    else // 1
        DR = 3'b111; // otherwise destination register is R7

    if (~SR1MUX) // 0
        SR1 = IR[11:9];
    else // 1
        SR1 = IR[8:6];

    SR1_OUT = regs[SR1];
    SR2_OUT = regs[IR[2:0]];
end

endmodule
