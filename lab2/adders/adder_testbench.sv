module adder_testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
					// This is the amount of time represented by #1 
timeprecision 1ns;

/* ADDER2 MODULE CONSTRUCTOR
	input Clk, Reset_Clear, Run_Accumulate, 
					input [9:0] SW,
				output logic [9:0] LED,
				output logic [6:0] HEX0, 
										 HEX1, 
										 HEX2, 
										 HEX3, 
										 HEX4,
										 HEX5
*/

//initialize module logics to manipulate in testbench
logic clk, Reset_Clear, Run_Accumulate;
logic [9:0] SW;
logic [9:0] LED;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
assign CO = LED[9]; //indicates cout--> which infers overflow

//instantiate an instance of adder2 which is the controller for FPGA and calls on one of the adders
adder2 dut0(.Clk(clk), .Reset_Clear(Reset_Clear), .Run_Accumulate(Run_Accumulate), .SW(SW), .LED(LED), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5));

//initialize the operation of the clock
always begin : CLOCK_GENERATION
#1 clk = ~clk;
end

initial begin: CLOCK_INITIALIZATION
    clk = 0;
end 
/////////////////////////////////////////


//Start actually manipulating inputs to test the different adder forms
initial begin: ADDER_TEST
//run Reset_Clear for a moment
Reset_Clear = 1'b1;
#2 Reset_Clear = 1'b0;
//testing loading a number into A
#2 SW[0] = 1'b1;
SW[1] = 1'b0;
SW[2] = 1'b0;
SW[3] = 1'b1;
SW[4] = 1'b0;
SW[5] = 1'b1;
SW[6] = 1'b1;
SW[7] = 1'b0;
SW[8] = 1'b0;
SW[9] = 1'b0;
// A = 0001101001 = 0x69 (THE FIRST TO HEX VALUES SHOULD REFLECT THIS NUMBER)

/*Add A into B 6 times 
	B = x69
	B = xD2
	B = x13B
	B = x1A4
	B = x20D
	B = x276
*/
//They are buttons so we toggle them
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0;
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0;
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0;
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0;
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0;
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0;
/////////////////////////////////////

//Test Reset
#2 Reset_Clear = 1'b1;
#2 Reset_Clear = 1'b0;

//We also need to confirm that we can make over flow happen and turn on LED[9] = CO
#2 SW[0] = 1'b0;
SW[1] = 1'b0;
SW[2] = 1'b0;
SW[3] = 1'b0;
SW[4] = 1'b0;
SW[5] = 1'b0;
SW[6] = 1'b0;
SW[7] = 1'b0;
SW[8] = 1'b1;
SW[9] = 1'b1;
// A = 1111111111 = 0x300 (Unfortunately our largest binary representation limited to 10 switches, so I'm not even going to use the least significant bits for simplicity)
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x300
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x600
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x900
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xC00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xF00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x1200
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x1500
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x1800
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x1B00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x1E00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x2100
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x2400
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x2700
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x2A00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x2D00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x3000
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x3300
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x3600
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x3900
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x3C00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x3F00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x4200
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x4500
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x4800
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x4B00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x4E00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x5100
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x5400
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x5700
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x5A00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x5D00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x6000
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x6300
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x6600
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x6900
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x6C00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x6F00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x7200
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x7500
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x7800
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x7B00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x7E00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x8100
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x8400
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x8700
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x8A00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x8D00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x9000
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x9300
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x9600
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x9900
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x9C00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //x9F00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xA200
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xA500
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xA800
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xAB00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xAE00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xB100
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xB400
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xB700
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xBA00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xBD00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xC000
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xC300
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xC600
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xC900
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xCC00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xCF00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xD200
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xD500
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xD800
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xDB00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xDE00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xE100
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xE400
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xE700
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xEA00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xED00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xF000
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xF300
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xF600
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xF900
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xFC00
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //xFF00
//NOW IF WE ADD ONE MORE SHOULD SHOULD HAVE OVERFLOW BIT TURN ON
#2 Run_Accumulate = 1'b1;
#2 Run_Accumulate = 1'b0; //OVERFLOW!!!

//CLear on more time for the hell of it
#8 Reset_Clear = 1'b1;
Reset_Clear = 1'b0;

end


endmodule 