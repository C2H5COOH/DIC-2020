module Analysis (
    input clk,rst,
    input fft_valid,
    input [31:0] fft_d0,fft_d1,fft_d2,fft_d3,fft_d4,fft_d5,fft_d6,fft_d7,fft_d8,fft_d9,fft_d10,fft_d11,fft_d12,fft_d13,fft_d14,fft_d15,
    output reg [3:0] freq,
    output reg done

);
    parameter INI = 0;
    parameter SQU = 1;
    parameter OUT = 2;
    parameter FINISH = 3;

    reg [1:0] state;
    reg [3:0] count;
    reg [31:0] max;

    wire [31:0] fft_d [15:0];
    assign fft_d[0] = fft_d0;
    assign fft_d[1] = fft_d1;
    assign fft_d[2] = fft_d2;
    assign fft_d[3] = fft_d3;
    assign fft_d[4] = fft_d4;
    assign fft_d[5] = fft_d5;
    assign fft_d[6] = fft_d6;
    assign fft_d[7] = fft_d7;
    assign fft_d[8] = fft_d8;
    assign fft_d[9] = fft_d9;
    assign fft_d[10] = fft_d10;
    assign fft_d[11] = fft_d11;
    assign fft_d[12] = fft_d12;
    assign fft_d[13] = fft_d13;
    assign fft_d[14] = fft_d14;
    assign fft_d[15] = fft_d15;

    wire [31:0] fft_d_cur;
    assign fft_d_cur = fft_d[count];

    wire signed [15:0] fft_d_real,fft_d_img;
    assign fft_d_real = fft_d_cur[31:16];
    assign fft_d_img = fft_d_cur[15:0];

    wire [31:0] fft_d_squ; 
    assign fft_d_squ = fft_d_real * fft_d_real + fft_d_img * fft_d_img;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            count <= 0;
            max <= 0;
            freq <= 0;
            state <= INI;
        end
        else begin
            case(state)
                INI : begin
                    if(fft_valid) state <= SQU;
                end
                SQU : begin
                    count <= count + 1;
                    if(fft_d_squ > max) begin 
                        max <= fft_d_squ;
                        freq <= count;
                    end
                    else;
                    
                    if(count == 15) state <= OUT;
                end

                OUT : begin
                    done <= 1;
                    state <= FINISH;
                end

                FINISH : begin
                    done <= 0;
                    state <= FINISH;
                end
            endcase
        end    
    end
    
endmodule