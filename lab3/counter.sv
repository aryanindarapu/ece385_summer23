module counter(
	input logic Clk, enable
	output logic [2:0] out
);

always_ff(@ posedge Clk) begin

if(enable)
begin
	if(out[0] == 1) begin//increment
		out[0] <= 1b'0; //since we are carrying to the next bit
		if(out[1] == 1) begin
			out[1] <= 1b'0 //since we are carrying to the next bit
			if(out[2] == 1) begin
				//we go back to 000
				out[2] = 1b'0;
				out[1] = 1b'0;
				out[0] = 1b'0;
			end
			else begin
				out[2] <= 1b'1;
			end
		end
		else begin
			out[1] = 1b'1;
		end
	end
	else begin
		out[0] <= 1b'1;
	end
end
end //end of always_ff

endmodule 