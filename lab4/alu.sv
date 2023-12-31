module alu (
    input logic [15:0] SR1_OUT, SR2_OUT,
    input logic [4:0] IR,
    input logic [1:0] ALUK,
    input logic SR2MUX, 
    output logic [15:0] new_ALU
);

logic [15:0] A, B;

always_comb begin
    A = SR1_OUT;

    if (~SR2MUX) begin //IR_5 = 1 for sexted IR[4:0]
        B = SR2_OUT;
    end else begin
        B = {{11{IR[4]}}, IR[4:0]};

    end

    case (ALUK) // idk is this is correct
        2'b00: new_ALU = A + B;
        2'b01: new_ALU = A & B;
        2'b10: new_ALU = ~A; // TODO: how to do not?
        2'b11: new_ALU = A;
    endcase
end


endmodule