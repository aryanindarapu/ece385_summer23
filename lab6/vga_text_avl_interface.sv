/************************************************************************
Avalon-MM Interface VGA Text mode display

Register Map:
0x000-0x0257 : VRAM, 80x30 (2400 byte, 600 word) raster order (first column then row)
0x258        : control register

VRAM Format:
X->
[ 31  30-24][ 23  22-16][ 15  14-8 ][ 7    6-0 ]
[IV3][CODE3][IV2][CODE2][IV1][CODE1][IV0][CODE0]

IVn = Draw inverse glyph
CODEn = Glyph code from IBM codepage 437

Control Register Format:
[[31-25][24-21][20-17][16-13][ 12-9][ 8-5 ][ 4-1 ][   0    ] 
[[RSVD ][FGD_R][FGD_G][FGD_B][BKG_R][BKG_G][BKG_B][RESERVED]

VSYNC signal = bit which flips on every Vsync (time for new frame), used to synchronize software
BKG_R/G/B = Background color, flipped with foreground when IVn bit is set
FGD_R/G/B = Foreground color, flipped with background when Inv bit is set

************************************************************************/
`define NUM_REGS 601 //80*30 characters / 4 characters per register
`define CTRL_REG 600 //index of control register

module vga_text_avl_interface (
	// Avalon Clock Input, note this clock is also used for VGA, so this must be 50Mhz
	// We can put a clock divider here in the future to make this IP more generalizable
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,					// Avalon-MM Chip Select
	input  logic [3:0] AVL_BYTE_EN,			// Avalon-MM Byte Enable
	input  logic [9:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,		// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,		// Avalon-MM Read Data
	
	// Exported Conduit (mapped to VGA port - make sure you export in Platform Designer)
	output logic [3:0]  red, green, blue,	// VGA color channels (mapped to output pins in top-level)
	output logic hs, vs						// VGA HS/VS
);

logic [31:0] LOCAL_REG       [`NUM_REGS]; // Registers -- literally the VRAM
//put other local variables here
logic pixel_clk, blank, sync;
logic [9:0] drawxsig, drawysig;
logic [7:0] pixel_data;
logic [10:0] char_index; //character address determined from drawx,y positions
logic [10:0] word_addr; //word address determined from character address
logic [10:0] row; //current glyph map row bitwise
logic [10:0] col; //current glyph map col bitwise
logic [10:0] glyph_row; //pixel row for the current glyph
logic [10:0] glyph_col; //pixel col for the current glyph
logic [10:0] cur_byte; //which byte in the word
logic [10:0] glyph_addr; //glyph address to input to font_rom
logic [10:0] mod_four;
logic [10:0] mod_eight;
logic [10:0] mod_sixteen;
logic inv_en; //inverse enable for the particular glyph
logic bof; //is this pixel background or foreground (B OR F)
logic [10:0] curr_byte;

logic [3:0] fgd_r, fgd_g, fgd_b, bkg_r, bkg_g, bkg_b;
assign fgd_r = LOCAL_REG[`CTRL_REG][24:21];
assign fgd_g = LOCAL_REG[`CTRL_REG][20:17];
assign fgd_b = LOCAL_REG[`CTRL_REG][16:13];
assign bkg_r = LOCAL_REG[`CTRL_REG][12:9];
assign bkg_g = LOCAL_REG[`CTRL_REG][8:5];
assign bkg_b = LOCAL_REG[`CTRL_REG][4:1];

assign mod_four = 11'b00000000011; //for % 4
assign mod_eight = 11'b00000000111; //for % 8
assign mod_sixteen = 11'b00000001111; //for % 16


logic [10:0] addr_code;
logic [7:0] temp_output;
   
// Read and write from AVL interface to register block, note that READ waitstate = 1, so this should be in always_ff
always_ff @(posedge CLK) begin
	/*=====================================================================================================*/
	/*---------------READING AND WRITING PORTION OF THE ALWAYS_FF------------------------------------------*/
	/*=====================================================================================================*/
	if (RESET) begin // notice, this is a sycnrhonous reset, which is recommended on the FPGA
        for (int i = 0; i < `NUM_REGS; i++)
            LOCAL_REG[i] <= 32'b0;
    end else if (AVL_CS) begin
        if (AVL_READ) 
			AVL_READDATA <= LOCAL_REG[AVL_ADDR];
		else if (AVL_WRITE) begin
			case (AVL_BYTE_EN)
				4'b1111: // write all bytes
					LOCAL_REG[AVL_ADDR] <= AVL_WRITEDATA;
				4'b1100: // write upper two bytes
					LOCAL_REG[AVL_ADDR][31:16] <= AVL_WRITEDATA[31:16];
				4'b0011: // write lower two bytes
					LOCAL_REG[AVL_ADDR][15:0] <= AVL_WRITEDATA[15:0];
				4'b1000: // write upper byte
					LOCAL_REG[AVL_ADDR][31:24] <= AVL_WRITEDATA[31:24];
				4'b0100: // write middle upper byte
					LOCAL_REG[AVL_ADDR][23:16] <= AVL_WRITEDATA[23:16];
				4'b0010: // write middle lower byte
					LOCAL_REG[AVL_ADDR][15:8] <= AVL_WRITEDATA[15:8];
				4'b0001: // write lower byte
					LOCAL_REG[AVL_ADDR][7:0] <= AVL_WRITEDATA[7:0];
				default: ; // write no bytes - DO NOTHING

			endcase
		end
	end
end

always_comb begin
	/*=====================================================================================================*/
	/*-----------------------PIXEL DRAWING AND MATH LOGIC SECTION(IN RASTOR ORDER CONTROL)-----------------*/
	/*=====================================================================================================*/
	// drawx and drawy tell us which pixel positon we are trying to draw, and with math what glyph we are drawing
	row = drawysig[9:4]; //divide by 16 (height of a glyph)
	col = drawxsig[9:3]; //divide by 8 (width of a glyph)
	glyph_row = drawysig & mod_sixteen;
	glyph_col = 11'b00000000111 - (drawxsig & mod_eight);
	
	// 80x30 = 2400 glyphs | row*80 + col will give our glyph/char address
	char_index <= (row*80) + col;
	// (char_addr / 4) = word_addr/register
	word_addr <= char_index[10:2];
	// byte in the word -> char_addr % 4 
	curr_byte <= char_index & mod_four;

	// now we know the word address and byte we are drawing in, so we can access what character we are drawing
	case (curr_byte) 
		11'b00000000001: begin // 1st byte of the word
			glyph_addr[10:4] = LOCAL_REG[word_addr][22:16];
			glyph_addr[3:0] = glyph_row[3:0];
			inv_en = LOCAL_REG[word_addr][23];
		end
		11'b00000000011: begin // 3rd byte of the word
			glyph_addr[10:4] = LOCAL_REG[word_addr][14:8];
			glyph_addr[3:0] = glyph_row[3:0];
			inv_en = LOCAL_REG[word_addr][15];
		end
		11'b00000000010: begin // 2nd byte of the word
			glyph_addr[10:4] = LOCAL_REG[word_addr][30:24];
			glyph_addr[3:0] = glyph_row[3:0];
			inv_en = LOCAL_REG[word_addr][31];
		end
		default: begin // 0th byte of the word
			glyph_addr[10:4] = LOCAL_REG[word_addr][6:0];
			glyph_addr[3:0] = glyph_row[3:0];
			inv_en = LOCAL_REG[word_addr][7];
		end
	endcase
	
	// now pixel_data is the correct 8 bit data
	bof <= pixel_data[glyph_col];
end

always_ff @(posedge pixel_clk) begin
	if (~blank) begin
		red <= 4'b0000;
		green <= 4'b0000;
		blue <= 4'b0000;
	end else begin
		/*=====================================================================================================*/
		/*----------------------------------------ELECTRON GUN SETTING-----------------------------------------*/
		/*=====================================================================================================*/
		if (inv_en == 1'b0) begin // no inverse
			if(bof == 1'b1) begin //foreground
				red = fgd_r;
				green = fgd_g;
				blue = fgd_b;
			end
			else begin // background
				red = bkg_r;
				green = bkg_g;
				blue = bkg_b;
			end
		end
		else begin
			if (bof == 1'b1) begin // background
				red = bkg_r;
				green = bkg_g;
				blue = bkg_b;
			end
			else begin // foreground
				red = fgd_r;
				green = fgd_g;
				blue = fgd_b;
			end
		end
	end
end

//handle drawing (may either be combinational or sequential - or both).
font_rom f0(.addr(glyph_addr), .data(pixel_data)); 
vga_controller v0(.Clk(CLK), .Reset(RESET), .hs(hs), .vs(vs), .pixel_clk(pixel_clk), .blank(blank), .sync(sync), .DrawX(drawxsig), .DrawY(drawysig));

endmodule
