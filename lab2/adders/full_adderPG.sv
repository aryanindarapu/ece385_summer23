module full_adderPG(input x, y, cin, output s, p, g);


	//x and y are the added bits, c_in is the carry-in, s is lowest sum bit, and P(propogating), and G(generating)
	//**NOTE THAT C(carry-out) IS OMITTED SINCE WE ARE MAKING A CLA
	assign s = x^y^cin;
	assign p = x^y;
	assign g = x&y;
	
endmodule 

//full adder for CLA and CSA(Has P and G logic capabilites)