module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
					// This is the amount of time represented by #1 
timeprecision 1ns;

//INPUTS FOR SLC3 CPU
logic [9:0] SW;
logic	Clk, Run, Continue;
logic [9:0] LED;
logic [6:0] HEX0, HEX1, HEX2, HEX3;

slc3_testtop guy(.SW(SW), .Clk(Clk), .Run(Run), .Continue(Continue), .LED(LED), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3));

//initialize the operation of the clock
always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 
/////////////////////////////////////////


initial begin
SW = 10'b0000000000;
Run = 1'b1;
Continue = 1'b1;
#5 Run = 1'b0;
Continue = 1'b0;
#5 Run = 1'b1;
Continue = 1'b1;

#5 Run = 1'b0;
#5 Run = 1'b1;

#50 Continue = 1'b0;
#5 Continue = 1'b1;

#50 Continue = 1'b0;
#5 Continue = 1'b1;

#50 Continue = 1'b0;
#5 Continue = 1'b1;

end

endmodule
