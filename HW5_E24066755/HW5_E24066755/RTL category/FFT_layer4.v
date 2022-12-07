module FFT_layer4 (
    input [31:0] x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,

    output [31:0] y0,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15
);
    //0,1
    FFT_butterfly_plus b0 (
        .X(x1),
        .Y(x0),
        .fft_a(y0)
    );

    FFT_butterfly_minus #(
        .W_real(32'h00010000),
        .W_img(32'h00000000)
    )
    b1 (
        .X(x0),
        .Y(x1),
        .fft_b(y1)
    );

    //2,3
    FFT_butterfly_plus b2 (
        .X(x3),
        .Y(x2),
        .fft_a(y2)
    );

    FFT_butterfly_minus #(
        .W_real(32'h00010000),
        .W_img(32'h00000000)
    )
    b3 (
        .X(x2),
        .Y(x3),
        .fft_b(y3)
    );

    //4,5
    FFT_butterfly_plus b4 (
        .X(x5),
        .Y(x4),
        .fft_a(y4)
    );

    FFT_butterfly_minus #(
        .W_real(32'h00010000),
        .W_img(32'h00000000)
    )
    b5 (
        .X(x4),
        .Y(x5),
        .fft_b(y5)
    );

    //6,7
    FFT_butterfly_plus b6 (
        .X(x7),
        .Y(x6),
        .fft_a(y6)
    );

    FFT_butterfly_minus #(
        .W_real(32'h00010000),
        .W_img(32'h00000000)
    )
    b7 (
        .X(x6),
        .Y(x7),
        .fft_b(y7)
    );

    //8,9
    FFT_butterfly_plus b8 (
        .X(x9),
        .Y(x8),
        .fft_a(y8)
    );

    FFT_butterfly_minus #(
        .W_real(32'h00010000),
        .W_img(32'h00000000)
    )
    b9 (
        .X(x8),
        .Y(x9),
        .fft_b(y9)
    );

    //10,11
    FFT_butterfly_plus b10 (
        .X(x11),
        .Y(x10),
        .fft_a(y10)
    );

    FFT_butterfly_minus #(
        .W_real(32'h00010000),
        .W_img(32'h00000000)
    )
    b11 (
        .X(x10),
        .Y(x11),
        .fft_b(y11)
    );

    //12,13
    FFT_butterfly_plus b12 (
        .X(x13),
        .Y(x12),
        .fft_a(y12)
    );

    FFT_butterfly_minus #(
        .W_real(32'h00010000),
        .W_img(32'h00000000)
    )
    b13 (
        .X(x12),
        .Y(x13),
        .fft_b(y13)
    );

    //14,15
    FFT_butterfly_plus b14 (
        .X(x15),
        .Y(x14),
        .fft_a(y14)
    );

    FFT_butterfly_minus #(
        .W_real(32'h00010000),
        .W_img(32'h00000000)
    )
    b15 (
        .X(x14),
        .Y(x15),
        .fft_b(y15)
    );

endmodule
