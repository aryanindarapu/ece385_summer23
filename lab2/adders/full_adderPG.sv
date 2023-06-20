module full_adderPG(input x, y, c_in, output s, p, g);


	//x and y are the added bits, c_in is the carry-in, s is lowest sum bit, and P(propogating), and G(generating)
	//**NOTE THAT C(carry-out) IS OMITTED SINCE WE ARE MAKING A CLA
	assign s = x^y^c_in;
	assign g = x&y;
	assign p = x^y;
	
endmodule 

//full adder for CLA and CSA(Has P and G logic capabilites)