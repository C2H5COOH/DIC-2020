module FIR (
    input clk, rst,
    input data_valid,
    input signed [15:0] data,

    //output reg fir_valid,
    output [15:0] fir_d 
);

    reg signed [15:0] x [31:0];
    integer i;

    parameter signed [19:0] FIR_C00 = 20'hFFF9E ;     //The FIR_coefficient value 0: -1.495361e-003
    parameter signed [19:0] FIR_C01 = 20'hFFF86 ;     //The FIR_coefficient value 1: -1.861572e-003
    parameter signed [19:0] FIR_C02 = 20'hFFFA7 ;     //The FIR_coefficient value 2: -1.358032e-003
    parameter signed [19:0] FIR_C03 = 20'h0003B ;    //The FIR_coefficient value 3: 9.002686e-004
    parameter signed [19:0] FIR_C04 = 20'h0014B ;    //The FIR_coefficient value 4: 5.050659e-003
    parameter signed [19:0] FIR_C05 = 20'h0024A ;    //The FIR_coefficient value 5: 8.941650e-003
    parameter signed [19:0] FIR_C06 = 20'h00222 ;    //The FIR_coefficient value 6: 8.331299e-003
    parameter signed [19:0] FIR_C07 = 20'hFFFE4 ;     //The FIR_coefficient value 7: -4.272461e-004
    parameter signed [19:0] FIR_C08 = 20'hFFBC5 ;     //The FIR_coefficient value 8: -1.652527e-002
    parameter signed [19:0] FIR_C09 = 20'hFF7CA ;     //The FIR_coefficient value 9: -3.207397e-002
    parameter signed [19:0] FIR_C10 = 20'hFF74E ;     //The FIR_coefficient value 10: -3.396606e-002
    parameter signed [19:0] FIR_C11 = 20'hFFD74 ;     //The FIR_coefficient value 11: -9.948730e-003
    parameter signed [19:0] FIR_C12 = 20'h00B1A ;    //The FIR_coefficient value 12: 4.336548e-002
    parameter signed [19:0] FIR_C13 = 20'h01DAC ;    //The FIR_coefficient value 13: 1.159058e-001
    parameter signed [19:0] FIR_C14 = 20'h02F9E ;    //The FIR_coefficient value 14: 1.860046e-001
    parameter signed [19:0] FIR_C15 = 20'h03AA9 ;    //The FIR_coefficient value 15: 2.291412e-001
    parameter signed [19:0] FIR_C16 = 20'h03AA9 ;    //The FIR_coefficient value 16: 2.291412e-001
    parameter signed [19:0] FIR_C17 = 20'h02F9E ;    //The FIR_coefficient value 17: 1.860046e-001
    parameter signed [19:0] FIR_C18 = 20'h01DAC ;    //The FIR_coefficient value 18: 1.159058e-001
    parameter signed [19:0] FIR_C19 = 20'h00B1A ;    //The FIR_coefficient value 19: 4.336548e-002
    parameter signed [19:0] FIR_C20 = 20'hFFD74 ;     //The FIR_coefficient value 20: -9.948730e-003
    parameter signed [19:0] FIR_C21 = 20'hFF74E ;     //The FIR_coefficient value 21: -3.396606e-002
    parameter signed [19:0] FIR_C22 = 20'hFF7CA ;     //The FIR_coefficient value 22: -3.207397e-002
    parameter signed [19:0] FIR_C23 = 20'hFFBC5 ;     //The FIR_coefficient value 23: -1.652527e-002
    parameter signed [19:0] FIR_C24 = 20'hFFFE4 ;     //The FIR_coefficient value 24: -4.272461e-004
    parameter signed [19:0] FIR_C25 = 20'h00222 ;    //The FIR_coefficient value 25: 8.331299e-003
    parameter signed [19:0] FIR_C26 = 20'h0024A ;    //The FIR_coefficient value 26: 8.941650e-003
    parameter signed [19:0] FIR_C27 = 20'h0014B ;    //The FIR_coefficient value 27: 5.050659e-003
    parameter signed [19:0] FIR_C28 = 20'h0003B ;    //The FIR_coefficient value 28: 9.002686e-004
    parameter signed [19:0] FIR_C29 = 20'hFFFA7 ;     //The FIR_coefficient value 29: -1.358032e-003
    parameter signed [19:0] FIR_C30 = 20'hFFF86 ;     //The FIR_coefficient value 30: -1.861572e-003
    parameter signed [19:0] FIR_C31 = 20'hFFF9E ;     //The FIR_coefficient value 31: -1.495361e-003

    wire signed [35:0] fir_d_36;

    assign fir_d_36 =   x[0] * FIR_C00 +  x[1] * FIR_C01 +  x[2] * FIR_C02 +  x[3] * FIR_C03 +
                        x[4] * FIR_C04 +  x[5] * FIR_C05 +  x[6] * FIR_C06 +  x[7] * FIR_C07 +
                        x[8] * FIR_C08 +  x[9] * FIR_C09 +  x[10] * FIR_C10 +  x[11] * FIR_C11 +
                        x[12] * FIR_C12 +  x[13] * FIR_C13 +  x[14] * FIR_C14 +  x[15] * FIR_C15 +
                        x[16] * FIR_C16 +  x[17] * FIR_C17 +  x[18] * FIR_C18 +  x[19] * FIR_C19 +
                        x[20] * FIR_C20 +  x[21] * FIR_C21 +  x[22] * FIR_C22 +  x[23] * FIR_C23 +
                        x[24] * FIR_C24 +  x[25] * FIR_C25 +  x[26] * FIR_C26 +  x[27] * FIR_C27 +
                        x[28] * FIR_C28 +  x[29] * FIR_C29 +  x[30] * FIR_C30 +  x[31] * FIR_C31 ;

    //assign fir_d = { fir_d_36[35],fir_d_36[31:24],fir_d_36[23:16] };
    assign fir_d = (fir_d_36[35] == 0) ? { fir_d_36[31:24],fir_d_36[23:16] } : { fir_d_36[31:24],fir_d_36[23:16] } + 1;

    always@(posedge clk or posedge rst)begin
        if(rst)begin
            for(i = 0 ; i < 32 ; i = i + 1)begin
                x[i] <= 0;
            end

        end
        else begin
            if(data_valid) begin
                x[0] <= data;
                for(i = 1 ; i < 32 ; i = i + 1)begin
                    x[i] <= x[i-1];
                end
            end
        end
    end

    
endmodule