
`timescale 1ns/10ps

module MFE(clk,reset,busy,ready,iaddr,idata,data_rd,data_wr,addr,wen);
	input				clk;
	input				reset;
	output				busy;	
	input				ready;	
	output	[13:0]		iaddr;
	input	[7:0]		idata;	
	input	[7:0]		data_rd;
	output	[7:0]		data_wr;
	output	[13:0]		addr;
	output				wen;
	
	reg busy;
	reg wen;
	reg first;
	reg [1:0] hold_cnt;

	reg [7:0] mask [8:0];
	reg [7:0] mask_next [8:0];
	reg [7:0] offset_x, offset_y;
	reg [1:0] mask_x, mask_y;

	wire [3:0] mask_cnt;
	assign mask_cnt = mask_x + (mask_y << 1) + mask_y;//x+3y

	/*wire [7:0] mask0,mask1,mask2,mask3,mask4,mask5,mask6,mask7,mask8;
	assign mask0 = mask[0];
	assign mask1 = mask[1];
	assign mask2 = mask[2];
	assign mask3 = mask[3];
	assign mask4 = mask[4];
	assign mask5 = mask[5];
	assign mask6 = mask[6];
	assign mask7 = mask[7];
	assign mask8 = mask[8];*/

	//assign iaddr = (offset_x - 1 + mask_x) + ((offset_y + mask_y - 1) << 7);//x+y*128
	//assign iaddr = ( (offset_x - 1) + ( (offset_y << 7) - 128) + mask_x ) + ( mask_y << 7 );
	assign iaddr = addr - 128 + mask_x + ( mask_y << 7 );
	assign addr = (offset_x - 1) + (offset_y << 7);
	assign data_wr = mask[4];
	integer i;

	//sort
	reg [3:0] idx1,idx2;
	reg [2:0] state;

	parameter INI = 0;
	//parameter READ_INI = 1;
	parameter SORT_READ = 1;
	parameter STORE = 2;
	parameter MOVE = 3;
	parameter OUT = 4;

	always@(posedge clk or posedge reset)begin
		if(reset) begin
			for(i = 0 ; i < 9 ; i = i + 1)begin
				mask[i] <= 0;
			end
			for(i = 0 ; i < 9 ; i = i + 1)begin
				mask_next[i] <= 0;
			end
			offset_x <= 0;
			offset_y <= 0;
			mask_x <= 0;
			mask_y <= 0;
			idx1 <= 0;
			idx2 <= 7;
			hold_cnt <= 1;
		end
		else begin
			case(state)
				INI : ;

				SORT_READ : begin
					if(mask[idx1 + 1] > mask[idx1])begin
						mask[idx1 + 1] <= mask[idx1];
						mask[idx1] <= mask[idx1 + 1];
					end
					if(idx1 == idx2) begin
						idx1 <= 0;
						idx2 <= idx2 - 1;
					end
					else begin
						idx1 <= idx1 + 1;
						idx2 <= idx2;
					end

					//read from img to next mask
					if(hold_cnt == 0)begin
						if( ((offset_x == 0) && (mask_x == 0)) || ((offset_x == 127) && (mask_x == 2)) ) begin
							mask_next[mask_cnt] <= 0;
						end
						else if( ((offset_y == 0) && (mask_y == 0)) || ((offset_y == 127) && (mask_y == 2)) ) begin
							mask_next[mask_cnt] <= 0;
						end
						else mask_next[mask_cnt] <= idata;
						
						//mask_x,mask_y
						if(mask_x == 2)begin
							if(mask_y < 2)begin
								mask_x <= 0;
								mask_y <= mask_y + 1;
							end
							else begin
								mask_x <= mask_x;
								mask_y <= mask_y;
							end 
						end
						else begin
							mask_x <= mask_x + 1;
							mask_y <= mask_y;
						end
						hold_cnt <= 1;
					end
					else if(hold_cnt == 1) hold_cnt <= 2;
					else hold_cnt <= 0;
				end

				STORE : begin
					idx1 <= 0;
					idx2 <= 7;

					mask_x <= 0;
					mask_y <= 0;
					hold_cnt <= 1;
				end
				//put next column into mask
				//offset operation
				MOVE : begin					
					for(i = 0 ; i < 9 ; i = i + 1)begin
						mask[i] <= mask_next[i];
					end

					if(offset_x == 127)begin//next data in next row
						offset_x <= 0;
						offset_y <= offset_y + 1;
					end
					else begin
						offset_x <= offset_x + 1;
						offset_y <= offset_y;
					end
				end
				OUT : ;
			endcase
		end
	end
	//state
	always@(posedge clk or posedge reset)begin
		if(reset) state <= INI;
		else begin
			case(state)
				INI : begin
					if(ready) state <= SORT_READ;
					else state <= INI;
				end
				SORT_READ : begin
					if(idx2 == 2) state <= STORE;
					else state <= SORT_READ;
				end
				STORE : state <= MOVE;
				MOVE : begin
					if((offset_x == 0) && (offset_y == 128)) state <= OUT;
					else state <= SORT_READ;
				end
				OUT : state <= OUT;
				default : state <= INI;
			endcase
		end
	end

	always @(posedge clk or posedge reset) begin
		if(reset)begin
			busy <= 0;
			wen <= 0;
			first <= 1;
		end
		else begin
			case(state)
				INI : begin
					busy <= 1;
					wen <= 0;
				end
				SORT_READ : begin 
					wen <= 0;
				end
				STORE : begin 
					if(first) begin
						first <= 0;
						wen <= 0;
					end
					else begin 
						first <= 0;
						wen <= 1;
					end
				end
				MOVE : wen <= 0;
				OUT : busy <= 0;
				default : begin
					busy <= 1;
					wen <= 0;
					first <= 0;
				end
			endcase
		end
	end

endmodule