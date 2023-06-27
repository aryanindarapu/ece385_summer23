module full_adder(input x, y, cin, output s, cout);

	assign s = x^y^cin;
	assign cout = (x&y)|(y&cin)|(x&cin);
	
endmodule 

//full adder for CRA(ripple so no P and G logic capabilities)