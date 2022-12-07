module controller(
    input clk,rst,
    input data_valid,

    output reg fir_valid,fft_valid,
    output reg [3:0] fft_stp_cnt
);
    //reg state;
    reg [10:0] counter; 

    always@(posedge clk or posedge rst)begin
        if(rst) begin
            counter <= 0;
            fir_valid <= 0;
            fft_valid <= 0;
        end
        else begin
            if(data_valid)begin
                counter <= counter + 1;
                if(counter >= 31) begin 
                    fir_valid <= 1;
                    if((counter > 48) && (counter % 16 == 15)) begin
                        fft_valid <= 1;
                    end
                    else fft_valid <= 0;
                end
                else begin
                    fft_valid <= 0;
                end
            end
            
        end
    end

    always@(posedge clk or posedge rst) begin
        if(rst) fft_stp_cnt <= 0;
        else begin
            if(counter > 31) begin
                fft_stp_cnt <= fft_stp_cnt + 1;
            end
            else fft_stp_cnt <= 0;
        end
    end

endmodule