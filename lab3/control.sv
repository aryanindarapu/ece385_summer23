module control(
	input logic Reset_Load_Clear, Clk, Run, M,
	output logic [2:0] out_state
);

	enum logic [3:0] { START, A, B, C, D, E, F, G, H, RESET, LOAD, ADD, SUB }  prev_next_state, curr_state, next_state; //if counter = 3b'111 we need to check if M is 1 because this means we need to subtract

	//updates flip flop, current state is the only one
    always_ff @ (posedge Clk)  
    begin
        if (Reset_Load_Clear)
            curr_state <= LOAD;
		else 
			curr_state <= next_state;
    end

    // Assign outputs based on state
	always_comb
    begin
        
		next_state = curr_state; // these will be equal values until further logic
        unique case (curr_state) 
			START:
				if (Run) next_state = A;
			A :
				if (M == 1'b1) begin
					next_state = ADD;
					prev_next_state = B;
				end else begin
					next_state = B;
				end
            B :    
				if (M == 1'b1) begin
					next_state = ADD;
					prev_next_state = C;
				end else begin
					next_state = C;
				end
            C :    
				if (M == 1'b1) begin
					next_state = ADD;
					prev_next_state = D;
				end else begin
					next_state = D;
				end
            D :    
				if (M == 1'b1) begin
					next_state = ADD;
					prev_next_state = E;
				end else begin
					next_state = E;
				end
            E :    
				if (M == 1'b1) begin
					next_state = ADD;
					prev_next_state = F;
				end else begin
					next_state = F;
				end
			F :    
				if (M == 1'b1) begin
					next_state = ADD;
					prev_next_state = G;
				end else begin
					next_state = G;
				end
            G :    
				if (M == 1'b1) begin
					next_state = ADD;
					prev_next_state = H;
				end else begin
					next_state = H;
				end
            H :    
				if (M == 1'b1) begin
					next_state = SUB;
					prev_next_state = RESET; // LAST;
				end else begin
					next_state = RESET; // LAST;
				end
			// LAST: 
			// 	if (~Run) next_state = RESET;
			RESET:
				next_state = START;
			LOAD:
				next_state = START;
			ADD:
				next_state = prev_next_state;
			SUB:
				next_state = prev_next_state;
							  
        endcase
   
        case (curr_state) 
			LOAD: 
				out_state = 3'b000;
			RESET: 
				out_state = 3'b100; // only reset XA
			ADD:
				out_state = 3'b010;
			SUB:
				out_state = 3'b011;
	   	   default:
		    	out_state = 3'b001; // shift by default
        endcase
    end

endmodule 