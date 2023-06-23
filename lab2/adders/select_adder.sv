module select_adder (
	input  logic [15:0] A, B,
	input  logic cin,
	output logic [15:0] S,
	output logic cout
);  
    
    logic C4;
    select_adder_4 SA0(.A(A[3:0]), .B(B[3:0]), .cin(cin), .S(S[3:0]), .cout(C4));

    logic C8, C8_0, C8_1;
    logic [3:0] S_8_0, S_8_1;
    select_adder_4 SA1(.A(A[7:4]), .B(B[7:4]), .cin(1'b0), .S(S_8_0), .cout(C8_0));
    select_adder_4 SA2(.A(A[7:4]), .B(B[7:4]), .cin(1'b1), .S(S_8_1), .cout(C8_1));
    assign C8 = C8_0 | (C4 & C8_1);

    logic C12, C12_0, C12_1;
    logic [3:0] S_12_0, S_12_1;
    select_adder_4 SA3(.A(A[11:8]), .B(B[11:8]), .cin(1'b0), .S(S_12_0), .cout(C12_0));
    select_adder_4 SA4(.A(A[11:8]), .B(B[11:8]), .cin(1'b1), .S(S_12_1), .cout(C12_1));
    assign C12 = C12_0 | (C8 & C12_1);

    logic C16_0, C16_1;
    logic [3:0] S_16_0, S_16_1;
    select_adder_4 SA5(.A(A[15:12]), .B(B[15:12]), .cin(1'b0), .S(S_16_0), .cout(C16_0));
    select_adder_4 SA6(.A(A[15:12]), .B(B[15:12]), .cin(1'b1), .S(S_16_1), .cout(C16_1));
    assign cout = C16_0 | (C12 & C16_1);

    always_comb 
	 begin : PATH_SELECTION
    if (C4 == 1'b0) begin
        S[7:4] = S_8_0;
    end else begin
        S[7:4] = S_8_1;
	 end
    if (C8 == 1'b0) begin
        S[11:8] = S_12_0;
    end else begin
        S[11:8] = S_12_1;
    end
    if (C12 == 1'b0) begin
        S[15:12] = S_16_0;
    end else begin
        S[15:12] = S_16_1;
	 end
	 end

    

    /*
    logic [15:0] S_0, S_1;
    logic [3:0] tempS;
    logic C4;
	
	
	 
//    // Hardwired logic to get possibilities if cin = 0 or 1
//    select_adder_4 SA0(.A(A[3:0]), .B(B[3:0]), .cin(cin), .S(tempS), .cout(C4));
//    assign S_0[3:0] = tempS;
//    assign S_1[3:0] = tempS;
//
//    logic C8, C8_0, C8_1;
//    select_adder_4 SA1(.A(A[7:4]), .B(B[7:4]), .cin(1'b0), .S(S_0[7:4]), .cout(C8_0));
//    select_adder_4 SA2(.A(A[7:4]), .B(B[7:4]), .cin(1'b1), .S(S_1[7:4]), .cout(C8_1));
//    assign C8 = C8_0 | (C4 & C8_1);
//
//    logic C12, C12_0, C12_1;
//    select_adder_4 SA3(.A(A[11:8]), .B(B[11:8]), .cin(1'b0), .S(S_0[11:8]), .cout(C12_0));
//    select_adder_4 SA4(.A(A[11:8]), .B(B[11:8]), .cin(1'b1), .S(S_1[11:8]), .cout(C12_1));
//    assign C12 = C12_0 | (C8 & C12_1);
//
//    logic C16_0, C16_1;
//    select_adder_4 SA5(.A(A[15:12]), .B(B[15:12]), .cin(1'b0), .S(S_0[15:12]), .cout(C16_0));
//    select_adder_4 SA6(.A(A[15:12]), .B(B[15:12]), .cin(1'b1), .S(S_1[15:12]), .cout(C16_1));
//
//    // TODO: Check that this logic works
//    always_comb
//    begin
//            if (cin == 1'b0) begin
//                S = S_0;
//                cout = C16_0 | (C12 & C16_1);
//            end else begin
//                S = S_1;
//                cout = C16_0 | (C12 & C16_1);
//				end
//    end
	 
	 //Last 3x4 logics completing based on the ussumption that either cin is 1 or 0
	 logic C8, C8_0, C8_1;
	 logic C12, C12_0, C12_1;
	 logic C16_0, C16_1;
	 
    select_adder_4 SA1(.A(A[7:4]), .B(B[7:4]), .cin(1'b0), .S(S_0[7:4]), .cout(C8_0));
    select_adder_4 SA2(.A(A[7:4]), .B(B[7:4]), .cin(1'b1), .S(S_1[7:4]), .cout(C8_1));
    select_adder_4 SA3(.A(A[11:8]), .B(B[11:8]), .cin(1'b0), .S(S_0[11:8]), .cout(C12_0));
    select_adder_4 SA4(.A(A[11:8]), .B(B[11:8]), .cin(1'b1), .S(S_1[11:8]), .cout(C12_1));
    select_adder_4 SA5(.A(A[15:12]), .B(B[15:12]), .cin(1'b0), .S(S_0[15:12]), .cout(C16_0));
    select_adder_4 SA6(.A(A[15:12]), .B(B[15:12]), .cin(1'b1), .S(S_1[15:12]), .cout(C16_1));
	 //Now we have 6 units that repesent the outputs of either theoretical cin(0 or 1)
	 
	 assign 
	 
    select_adder_4 SA0(.A(A[3:0]), .B(B[3:0]), .cin(cin), .S(tempS), .cout(C4));
    assign S_0[3:0] = tempS;
    assign S_1[3:0] = tempS;

    

    // TODO: Check that this logic works
    always_comb
    begin
            if (cin == 1'b0) begin
                
            end else begin
                S = S_1;
                cout = C16_0 | (C12 & C16_1);
			end
    end */

//					 S = S_0;
//                cout = C16_0 | (C12 & C16_1);
//					 S = S_1;
//                cout = C16_0 | (C12 & C16_1);
    /* TODO
     *
     * Insert code here to implement a CSA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */

endmodule
