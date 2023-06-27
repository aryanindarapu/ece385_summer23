module multiplier (
    input logic [7:0] SW,
    input logic Clk, Reset_Load_Clear, Run,
    output logic [6:0] HEX0, HEX1, HEX2, HEX3,
    output logic [7:0] Aval, Bval,
    output logic Xval 
)
// If Reset_Load_Clear is 1, then load switches (SW) into register B and clear registers X and A


endmodule