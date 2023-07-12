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

//NOTE THAT TEST 1, 2, selfmodifying, and XOR test all work and WE DONT NEED THE AUTO COUNTER TEST IT WAS OMMITTED THIS YEAR
//SPECIFY WHICH OPERATION TYPE WE ARE DOING
#10 SW = 10'b0000110001; //first IO operation(should withhold the switch value)
///////////////////////////////////////////


////////////////////////////////UNCOMMENT FOR TEST 2 and 3///////////////////////////////////////////////
//#5 Run = 1'b0;
//#5 Run = 1'b1;
//
//#100 SW = 10'b0000001010;
//
//#200 Continue = 1'b0;
//#5 Continue = 1'b1;
//
//#200 SW = 10'b0000000101;
//
//#5 Continue = 1'b0;
//#5 Continue = 1'b1;
//
//#200 SW = 10'b0000000001;
//
//#5 Continue = 1'b0;
//#5 Continue = 1'b1;
//
//#200 SW = 10'b0000011111;
//
//#5 Continue = 1'b0;
//#5 Continue = 1'b1;
//
//#200 SW = 10'b0011111111;
//
//#5 Continue = 1'b0;
//#5 Continue = 1'b1;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////UNCOMMENT FOR MULT AND XOR TEST////////////////////////////////////////////////
#5 Run = 1'b0;
#5 Run = 1'b1;

#200 SW = 10'b00000001111;

#200 Continue = 1'b0;
#5 Continue = 1'b1;

#200 SW = 10'b00000001010;
 //XOR = 00000000101
 //MULT = 15 * 10 = x0F * x0A = 150 = x96
#5 Continue = 1'b0;
#5 Continue = 1'b1;
/////////////////////////////////////////////////////////////////////////////////////////////////////////
end

endmodule
