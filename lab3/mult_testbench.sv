module mult_testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
					// This is the amount of time represented by #1 
timeprecision 1ns;

//INPUTS FOR MULTIPLIER
logic [7:0] SW;
logic Reset_Load_Clear, Run, Clk;
logic [6:0] HEX0, HEX1, HEX2, HEX3;
//OUTPUTS FROM MULTIPLIER
logic [7:0] Aval, Bval;
logic Xval;

multiplier guy(.SW(SW), .Reset_Load_Clear(Reset_Load_Clear), .Run(Run), .Clk(Clk), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .Aval(Aval),  .Bval(Bval), .Xval(Xval));

//initialize the operation of the clock
always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 
/////////////////////////////////////////


initial begin
//flicker for normal activity
Reset_Load_Clear = 1'b1;
Run = 1'b1;


//Load a posistive one to B
SW = 8'b00000001;
#2 Reset_Load_Clear = 1'b0;
#2 Reset_Load_Clear = 1'b1;

//Set S = -1 and multiply by negative one 3 times
#2 SW = 8'b11111111;
#2 Run = 1'b0;
#2 Run = 1'b1;
//RESULT SHOULD BE FFFF = -1
#50 Run = 1'b0;
#2 Run = 1'b1;
//RESULT SHOULD BE 0001 = 1
#50 Run = 1'b0;
#2 Run = 1'b1;
//RESULT SHOULD BE FFFF = -1
#50 Reset_Load_Clear = 1'b0;
#2 Reset_Load_Clear = 1'b1;
//ALL REGISTERS SHOULD BE RESET
end
	
endmodule 