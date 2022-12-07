module PSE ( clk,reset,Xin,Yin,point_num,valid,Xout,Yout);
input clk;
input reset;
input [9:0] Xin;
input [9:0] Yin;
input [2:0] point_num;
output valid;
output [9:0] Xout;
output [9:0] Yout;

reg [9:0] point_x [5:0];
reg [9:0] point_y [5:0];
reg [9:0] Xout;
reg [9:0] Yout;
reg [2:0] point_cnt;
reg valid;
reg[2:0] state;

reg[2:0] index_ref,index_comp;
reg need_swap;

parameter Input1 = 3'd1;
parameter cal = 3'd2;
parameter cal_comp = 3'd3;
parameter swap = 3'd4;
parameter Out = 3'd5;
parameter Last_out = 3'd6;

wire signed [24:0] product;
assign product =    ((point_x[index_ref] - point_x[0]) * (point_y[index_comp] - point_y[0])) - 
                    ((point_x[index_comp] - point_x[0]) * (point_y[index_ref] - point_y[0]));


always@(posedge clk or posedge reset)begin
    if(reset)begin
        Xout <= 10'd0;
        Yout <= 10'd0;
        valid <= 0;
        point_cnt <= 0;
        index_comp <= 2;
        index_ref <= 1;
    end
    else begin
        case(state)
            Input1: begin
                valid <= 0;
                point_x[point_cnt] <= Xin;
                point_y[point_cnt] <= Yin;
                point_cnt <= point_cnt + 1;
                index_comp <= 2;
                index_ref <= 1;
            end

            cal :;

            cal_comp:begin
                if(product > 0) need_swap <= 1'b1;
                else need_swap <= 1'b0;
            end

            swap: begin
                if(need_swap) begin
                    point_x[index_ref] <= point_x[index_comp];
                    point_y[index_ref] <= point_y[index_comp];
                    point_x[index_comp] <= point_x[index_ref];
                    point_y[index_comp] <= point_y[index_ref];
                end
                if(index_comp == point_num - 1) begin
                    index_ref <= index_ref + 1;
                    index_comp <= index_ref + 2;
                end
                else index_comp <= index_comp + 1;
            end

            Out: begin
                valid <= 1;
                Xout <= point_x[point_num - point_cnt];
                Yout <= point_y[point_num - point_cnt];
                point_cnt <= point_cnt - 1;
            end
            Last_out: begin
                valid <= 0;
            end
            default begin
                valid <= 0;
                Xout <= 0;
                Yout <= 0;
            end
        endcase
    end
end


always@(posedge clk)begin
    if(reset) state <= Input1;
    else begin
        case(state)
            Input1:begin
                if((point_cnt == point_num - 1) && (point_num != 0)) state <= cal;
                else state <= state;
            end 

            cal : state <= cal_comp;
            cal_comp: state <= swap;
            swap: begin
                if((index_comp == point_num - 1) && (index_ref == index_comp - 1))begin//all sort
                    state <= Out;
                end
                else state <= cal;
            end

            Out: begin
                if(point_cnt == 1) state <= Last_out;
                else state <= state;
            end
            Last_out: begin
                state <= Input1;
            end
            default: state <= Input1;
        endcase
    end
end

endmodule

