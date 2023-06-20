module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
					// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because your device under test will be instantiated as a module inside your testbench

logic CLK = 0;

// Outputs
logic S;
logic C0;
logic C1;

logic A0;
logic A1;
logic A2;
logic A3;

logic B0;
logic B1;
logic B2;
logic B3;

logic F;
logic A_STAR;
logic B_STAR;

// Inputs
logic E;
logic LOADA;
logic LOADB;

logic D0;
logic D1;
logic D2;
logic D3;

logic F0;
logic F1;
logic F2;

logic R0;
logic R1;

// Instantiating the DUT
// Make sure the module and signal names match with those in your design
lab1 dut0(.S(S), .C0(C0), .C1(C1), .F(F), .A_STAR(A_STAR), .B_STAR(B_STAR), 
			 .A0(A0), .A1(A1), .A2(A2), .A3(A3), .B0(B0), .B1(B1), .B2(B2), .B3(B3), .E(E), .LOADA(LOADA), .LOADB(LOADB),
			 .D0(D0), .D1(D1), .D2(D2), .D3(D3), .F0(F0), .F1(F1), .F2(F2), .R0(R0), .R1(R1), .CLK(CLK));

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 CLK = ~CLK;
end

initial begin: CLOCK_INITIALIZATION
    CLK = 0;
end 


initial begin: TEST_VECTORS
//Put your test vectors here

// initial values for units
F0 = 1'b0;
F1 = 1'b0;
F2 = 1'b0;

R1 = 1'b0;
R0 = 1'b0;

LOADA = 1'b0;
LOADB = 1'b0;
E = 1'b0;

// loading values
D0 = 1'b1;
D1 = 1'b0;
D2 = 1'b1;
D3 = 1'b1;

#6 LOADA = 1'b1;
#6 LOADA = 1'b0;

D0 = 1'b1;
D1 = 1'b0;
D2 = 1'b1;
D3 = 1'b0;

#6 LOADB = 1'b1;
#6 LOADB = 1'b0;

#6 E = 1'b1;
F0 = 1'b0;
F1 = 1'b0;
F2 = 1'b1;

R0 = 1'b1;
R1 = 1'b0;

#6 E = 1'b0;
#6 E = 1'b1;

F0 = 1'b1;
F1 = 1'b0;
F2 = 1'b1;

R0 = 1'b0;
R1 = 1'b1;

#6 E = 1'b0;
F0 = 1'b0;
F1 = 1'b1;
F2 = 1'b0;

R0 = 1'b1;
R1 = 1'b0;

#6 E = 1'b1;


#2 E = 1'b0;

// #5 E = 1'b0;



//CLRN = 1'b0;
//#5 CLRN = 1'b1;

end


endmodule
	