module FFT (
    input clk,rst,
    //input fir_valid,
    input [3:0] stp_cnt,
    input [15:0] fir_d,

    output[31:0] fft_d0,fft_d1,fft_d2,fft_d3,fft_d4,fft_d5,fft_d6,fft_d7,
                 fft_d8,fft_d9,fft_d10,fft_d11,fft_d12,fft_d13,fft_d14,fft_d15

    //output[31:0] fft_d0,fft_d2,fft_d3,fft_d4,fft_d5,fft_d6,fft_d7,
                 //fft_d8,fft_d9,fft_d10,fft_d11,fft_d12,fft_d13,fft_d14,fft_d15,
    
    //output[31:0] fft_d1_tune;
);
    wire [15:0] fft_in [15:0];
    FFT_STP stp(
        .clk(clk),
        .rst(rst),
 
        .fir_d(fir_d),
        .stp_cnt(stp_cnt),

        .x0(fft_in[0]),
        .x1(fft_in[1]),
        .x2(fft_in[2]),
        .x3(fft_in[3]),
        .x4(fft_in[4]),
        .x5(fft_in[5]),
        .x6(fft_in[6]),
        .x7(fft_in[7]),
        .x8(fft_in[8]),
        .x9(fft_in[9]),
        .x10(fft_in[10]),
        .x11(fft_in[11]),
        .x12(fft_in[12]),
        .x13(fft_in[13]),
        .x14(fft_in[14]),
        .x15(fft_in[15])
        /*
        .x0(),
        .x1(),
        .x2(),
        .x3(),
        .x4(),
        .x5(),
        .x6(),
        .x7(),
        .x8(),
        .x9(),
        .x10(),
        .x11(),
        .x12(),
        .x13(),
        .x14(),
        .x15()
        */
    );

    wire [31:0] fft_layer1_out [15:0];
    FFT_layer1 layer1(
        .x0(fft_in[0]),
        .x1(fft_in[1]),
        .x2(fft_in[2]),
        .x3(fft_in[3]),
        .x4(fft_in[4]),
        .x5(fft_in[5]),
        .x6(fft_in[6]),
        .x7(fft_in[7]),
        .x8(fft_in[8]),
        .x9(fft_in[9]),
        .x10(fft_in[10]),
        .x11(fft_in[11]),
        .x12(fft_in[12]),
        .x13(fft_in[13]),
        .x14(fft_in[14]),
        .x15(fft_in[15]),

        .y0(fft_layer1_out[0]),
        .y1(fft_layer1_out[1]),
        .y2(fft_layer1_out[2]),
        .y3(fft_layer1_out[3]),
        .y4(fft_layer1_out[4]),
        .y5(fft_layer1_out[5]),
        .y6(fft_layer1_out[6]),
        .y7(fft_layer1_out[7]),
        .y8(fft_layer1_out[8]),
        .y9(fft_layer1_out[9]),
        .y10(fft_layer1_out[10]),
        .y11(fft_layer1_out[11]),
        .y12(fft_layer1_out[12]),
        .y13(fft_layer1_out[13]),
        .y14(fft_layer1_out[14]),
        .y15(fft_layer1_out[15])
    );

    wire [31:0] fft_layer2_out [15:0];
    FFT_layer2 layer2(
        .x0(fft_layer1_out[0]),
        .x1(fft_layer1_out[1]),
        .x2(fft_layer1_out[2]),
        .x3(fft_layer1_out[3]),
        .x4(fft_layer1_out[4]),
        .x5(fft_layer1_out[5]),
        .x6(fft_layer1_out[6]),
        .x7(fft_layer1_out[7]),
        .x8(fft_layer1_out[8]),
        .x9(fft_layer1_out[9]),
        .x10(fft_layer1_out[10]),
        .x11(fft_layer1_out[11]),
        .x12(fft_layer1_out[12]),
        .x13(fft_layer1_out[13]),
        .x14(fft_layer1_out[14]),
        .x15(fft_layer1_out[15]),

        .y0(fft_layer2_out[0]),
        .y1(fft_layer2_out[1]),
        .y2(fft_layer2_out[2]),
        .y3(fft_layer2_out[3]),
        .y4(fft_layer2_out[4]),
        .y5(fft_layer2_out[5]),
        .y6(fft_layer2_out[6]),
        .y7(fft_layer2_out[7]),
        .y8(fft_layer2_out[8]),
        .y9(fft_layer2_out[9]),
        .y10(fft_layer2_out[10]),
        .y11(fft_layer2_out[11]),
        .y12(fft_layer2_out[12]),
        .y13(fft_layer2_out[13]),
        .y14(fft_layer2_out[14]),
        .y15(fft_layer2_out[15])
    );

    wire [31:0] fft_layer3_out [15:0];
    FFT_layer3 layer3(
        .x0(fft_layer2_out[0]),
        .x1(fft_layer2_out[1]),
        .x2(fft_layer2_out[2]),
        .x3(fft_layer2_out[3]),
        .x4(fft_layer2_out[4]),
        .x5(fft_layer2_out[5]),
        .x6(fft_layer2_out[6]),
        .x7(fft_layer2_out[7]),
        .x8(fft_layer2_out[8]),
        .x9(fft_layer2_out[9]),
        .x10(fft_layer2_out[10]),
        .x11(fft_layer2_out[11]),
        .x12(fft_layer2_out[12]),
        .x13(fft_layer2_out[13]),
        .x14(fft_layer2_out[14]),
        .x15(fft_layer2_out[15]),

        .y0(fft_layer3_out[0]),
        .y1(fft_layer3_out[1]),
        .y2(fft_layer3_out[2]),
        .y3(fft_layer3_out[3]),
        .y4(fft_layer3_out[4]),
        .y5(fft_layer3_out[5]),
        .y6(fft_layer3_out[6]),
        .y7(fft_layer3_out[7]),
        .y8(fft_layer3_out[8]),
        .y9(fft_layer3_out[9]),
        .y10(fft_layer3_out[10]),
        .y11(fft_layer3_out[11]),
        .y12(fft_layer3_out[12]),
        .y13(fft_layer3_out[13]),
        .y14(fft_layer3_out[14]),
        .y15(fft_layer3_out[15])
    );

    wire[31:0] fft_d1_untune;
    assign fft_d1 = fft_d1_untune + 32'h00030003;
    FFT_layer4 layer4(
        .x0(fft_layer3_out[0]),
        .x1(fft_layer3_out[1]),
        .x2(fft_layer3_out[2]),
        .x3(fft_layer3_out[3]),
        .x4(fft_layer3_out[4]),
        .x5(fft_layer3_out[5]),
        .x6(fft_layer3_out[6]),
        .x7(fft_layer3_out[7]),
        .x8(fft_layer3_out[8]),
        .x9(fft_layer3_out[9]),
        .x10(fft_layer3_out[10]),
        .x11(fft_layer3_out[11]),
        .x12(fft_layer3_out[12]),
        .x13(fft_layer3_out[13]),
        .x14(fft_layer3_out[14]),
        .x15(fft_layer3_out[15]),

        .y0(fft_d0),
        .y1(fft_d8),
        .y2(fft_d4),
        .y3(fft_d12),
        .y4(fft_d2),
        .y5(fft_d10),
        .y6(fft_d6),
        .y7(fft_d14),
        .y8(fft_d1_untune),
        .y9(fft_d9),
        .y10(fft_d5),
        .y11(fft_d13),
        .y12(fft_d3),
        .y13(fft_d11),
        .y14(fft_d7),
        .y15(fft_d15)
    );

endmodule