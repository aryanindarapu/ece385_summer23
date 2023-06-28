module control(
	input logic Reset, Clk, Run, ClearA_LoadB, M,
	output logic [1:0] out_state
);

	enum logic [4:0] { RESET, A, B, C, D, E, F, G, H, LAST, ADD, SUB }  prev_next_state, curr_state, next_state; //if counter = 3b'111 we need to check if M is 1 because this means we need to subtract

	//updates flip flop, current state is the only one
    always_ff @ (posedge Clk)  
    begin
        if (Reset)
            curr_state <= RESET;
		else 
			curr_state <= next_state;
    end

    // Assign outputs based on state
	always_comb
    begin
        
		next_state = curr_state; // these will be equal values until further logic
        unique case (curr_state) 
            RESET :  if (Run) next_state = A;
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
					prev_next_state = LAST;
				end else begin
					next_state = LAST;
				end
			LAST: if (~Execute) 
                       next_state = A;
			ADD:
				// do add operation
				next_state = prev_next_state;

			SUB:
				// do sub operation
				next_state = prev_next_state;
							  
        endcase
   
		  // Assign outputs based on ‘state’
        case (curr_state) 
	   	   RESET: 
				begin
					Clr_Ld = 1'b1;
					Shift = 1'b0;
					Add = 1'b0;
					Sub = 1'b0;
				end
	   	   LAST: 
				begin
					Clr_Ld = 1'b0;
					Shift = 1'b0;
					Add = 1'b0;
					Sub = 1'b0;
				end
			ADD:
				begin
					Clr_Ld = 1'b0;
					Shift = 1'b0;
					Add = 1'b1;
					Sub = 1'b0;
				end
			SUB:
				begin
					Clr_Ld = 1'b0;
					Shift = 1'b0;
					Add = 1'b0;
					Sub = 1'b1;
				end
	   	   default:  //default case, can also have default assignments for Ld_A and Ld_B before case
		      begin 
                Clr_Ld = 1'b0;
				Shift = 1'b1;
				Add = 1'b0;
				Sub = 1'b0;
		      end
        endcase
    end

endmodule 