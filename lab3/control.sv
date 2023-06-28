module control(
	input logic Reset_Load_Clear, Clk, Run, M,
	output logic [2:0] out_state
);

	enum logic [3:0] { START, A, B, C, D, E, F, G, H, RESET, LOAD, ADD, SUB, SHIFT }  prev_next_state, curr_state, next_state, temp; //if counter = 3b'111 we need to check if M is 1 because this means we need to subtract
	//updates flip flop, current state is the only one
    always_ff @ (posedge Clk)  
    begin
        if (Reset_Load_Clear) begin
            curr_state <= LOAD;
				prev_next_state <= A;
		end else begin
			curr_state <= next_state;
			prev_next_state <= temp;
		end
    end

    // Assign outputs based on state
	always_comb
    begin
        
		next_state = curr_state; // these will be equal values until further logic
		temp = prev_next_state;
//		prev_next_state = prev_next_state; //if we don't go to add or subtract we need to remember what our last count value was
//		out_state = out_state;
        unique case (curr_state) 
			START: begin
				if (Run) begin
				next_state = A;
				end
				else begin
				next_state = START;
				end
			end
			A : begin
				if (M == 1'b1) begin
					next_state = ADD;
					temp = B;
				end else begin
					next_state = SHIFT;
					temp = B;
				end
			end
         B : begin  
				if (M == 1'b1) begin
					next_state = ADD;
					temp = C;
				end else begin
					next_state = SHIFT;
					temp = C;
				end
			end
         C : begin
				if (M == 1'b1) begin
					next_state = ADD;
					temp = D;
				end else begin
					next_state = SHIFT;
					temp = D;
				end
			end
         D : begin   
				if (M == 1'b1) begin
					next_state = ADD;
					temp = E;
				end else begin
					next_state = SHIFT;
					temp = E;
				end
			end
         E : begin   
				if (M == 1'b1) begin
					next_state = ADD;
					temp = F;
				end else begin
					next_state = SHIFT;
					temp = F;
				end
			end
			F : begin
				if (M == 1'b1) begin
					next_state = ADD;
					temp = G;
				end else begin
					next_state = SHIFT;
					temp = G;
				end
			end
         G : begin   
				if (M == 1'b1) begin
					next_state = ADD;
					temp = H;
				end else begin
					next_state = SHIFT;
					temp = H;
				end
			end
         H : begin    
				if (M == 1'b1) begin
					next_state = SUB;
					temp = RESET; // LAST;
				end else begin
					next_state = SHIFT; // LAST;
					temp = RESET;
				end
			end
			// LAST: 
			// 	if (~Run) next_state = RESET;
			RESET: begin
				if (~Run) begin //Reset is the halting state as well
					next_state = START;
				end
			end
			LOAD: begin
				next_state = START;
			end
			ADD: begin
				next_state = SHIFT;
			end
			SUB: begin
				next_state = SHIFT;
			end
			SHIFT: begin
				next_state = prev_next_state;
			end
							  
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
			START:
				out_state = 3'b001; //halt in start
			SHIFT:
				out_state = 3'b101; //actually do a shift
	   	default:
		    	out_state = 3'b001; // hold a count
        endcase
    end

endmodule 