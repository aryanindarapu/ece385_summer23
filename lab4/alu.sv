module alu (
    input logic [15:0] SR1_OUT, SR2_OUT,
    input logic [4:0] IR,
    input logic [1:0] ALUK,
    input logic SR2MUX, 
    output logic new_ALU
);

logic [15:0] A, B;

always_comb begin
    A = SR1_OUT;

    if (SR2MUX) begin
        B = SR2_OUT;
    end else begin
        if (IR[4] == 1'b0) begin
            B = {11'b0, IR[4:0]};
        end else begin
            B = {11'b1, IR[4:0]};
        end
    end

    case (ALUK): // idk is this is correct
        2'b00: new_ALU = SR1_OUT + SR2_OUT;
        2'b01: new_ALU = SR1_OUT & SR2_OUT;
        2'b10: new_ALU = SR1_OUT ^ SR2_OUT; // TODO: how to do not?
        2'b11: new_ALU = SR1_OUT;
    endcase
end


endmodule