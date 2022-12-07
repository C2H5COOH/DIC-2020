module FFT_STP(
    input clk,rst,
    //input fir_valid,
    input [15:0] fir_d,

    input [3:0] stp_cnt,

    output [15:0] x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15
);
    integer i;
    reg [15:0] x_cur [15:0];
    reg [15:0] x_new [15:0];

    assign x0 = x_cur[0];
    assign x1 = x_cur[1];
    assign x2 = x_cur[2];
    assign x3 = x_cur[3];
    assign x4 = x_cur[4];
    assign x5 = x_cur[5];
    assign x6 = x_cur[6];
    assign x7 = x_cur[7];
    assign x8 = x_cur[8];
    assign x9 = x_cur[9];
    assign x10 = x_cur[10];
    assign x11 = x_cur[11];
    assign x12 = x_cur[12];
    assign x13 = x_cur[13];
    assign x14 = x_cur[14];
    assign x15 = x_cur[15];

    always@(posedge clk or posedge rst) begin
        if(rst) begin
            for(i = 0 ; i < 16 ; i = i + 1)begin
                x_new[i] <= 0;
                x_cur[i] <= 0;
            end
        end
        else begin
            x_new[stp_cnt] <= fir_d;
            
            if(stp_cnt == 0) begin
                for(i = 0 ; i < 16 ; i = i + 1)begin
                    x_cur[i] <= x_new[i];
                end
            end
        end
    end
endmodule
