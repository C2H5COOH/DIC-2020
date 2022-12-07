module FFT_layer1(
    input [15:0] x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,

    output [31:0] y0,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15
);

    FFT_butterfly_plus b0 (
        .X({x8,16'd0}),
        .Y({x0,16'd0}),
        .fft_a(y0)
    );

    FFT_butterfly_plus b1 (
        .X({x9,16'd0}),
        .Y({x1,16'd0}),
        .fft_a(y1)
    );

    FFT_butterfly_plus b2 (
        .X({x10,16'd0}),
        .Y({x2,16'd0}),
        .fft_a(y2)
    );

    FFT_butterfly_plus b3 (
        .X({x11,16'd0}),
        .Y({x3,16'd0}),
        .fft_a(y3)
    );

    FFT_butterfly_plus b4 (
        .X({x12,16'd0}),
        .Y({x4,16'd0}),
        .fft_a(y4)
    );

    FFT_butterfly_plus b5 (
        .X({x13,16'd0}),
        .Y({x5,16'd0}),
        .fft_a(y5)
    );

    FFT_butterfly_plus b6 (
        .X({x14,16'd0}),
        .Y({x6,16'd0}),
        .fft_a(y6)
    );

    FFT_butterfly_plus b7 (
        .X({x15,16'd0}),
        .Y({x7,16'd0}),
        .fft_a(y7)
    );

    //left
    FFT_butterfly_minus #(
        .W_real(32'h00010000),
        .W_img(32'h00000000)
    )
    b8 (
        .X({x0,16'd0}),
        .Y({x8,16'd0}),
        .fft_b(y8)
    );

    FFT_butterfly_minus #(
        .W_real(32'h0000EC83),
        .W_img(32'hFFFF9E09)
    )
    b9 (
        .X({x1,16'd0}),
        .Y({x9,16'd0}),
        .fft_b(y9)
    );

    FFT_butterfly_minus #(
        .W_real(32'h0000B504),
        .W_img(32'hFFFF4AFC)
    )
    b10 (
        .X({x2,16'd0}),
        .Y({x10,16'd0}),
        .fft_b(y10)
    );

    FFT_butterfly_minus #(
        .W_real(32'h000061F7),
        .W_img(32'hFFFF137D)
    )
    b11 (
        .X({x3,16'd0}),
        .Y({x11,16'd0}),
        .fft_b(y11)
    );

    FFT_butterfly_minus #(
        .W_real(32'h00000000),
        .W_img(32'hFFFF0000)
    )
    b12 (
        .X({x4,16'd0}),
        .Y({x12,16'd0}),
        .fft_b(y12)
    );

    FFT_butterfly_minus #(
        .W_real(32'hFFFF9E09),
        .W_img(32'hFFFF137D)
    )
    b13 (
        .X({x5,16'd0}),
        .Y({x13,16'd0}),
        .fft_b(y13)
    );

    FFT_butterfly_minus #(
        .W_real(32'hFFFF4AFC),
        .W_img(32'hFFFF4AFC)
    )
    b14 (
        .X({x6,16'd0}),
        .Y({x14,16'd0}),
        .fft_b(y14)
    );

    FFT_butterfly_minus #(
        .W_real(32'hFFFF137D),
        .W_img(32'hFFFF9E09)
    )
    b15 (
        .X({x7,16'd0}),
        .Y({x15,16'd0}),
        .fft_b(y15)
    );

endmodule