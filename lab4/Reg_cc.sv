module reg_cc (input  logic Clk, Reset, Load,
               input  logic [15:0] BUS,
               output logic [2:0]  Data_Out);

logic [2:0]  D;
always_ff @ (posedge Clk)
    begin
        if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
            Data_Out <= 3'b0;
        else if (Load) begin
            Data_Out <= D;
        end
    end

always_comb begin
    if (BUS == 16'b0) 
        D = 3'b010;
    else if (BUS[15] == 1'b1)
        D = 3'b100;
    else 
        D = 3'b001;
end

endmodule
