module FFT_layer2 (
    input [31:0] x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,

    output [31:0] y0,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15
);

    FFT_butterfly_plus b0 (
        .X(x4),
        .Y(x0),
        .fft_a(y0)
    );

    FFT_butterfly_plus b1 (
        .X(x5),
        .Y(x1),
        .fft_a(y1)
    );

    FFT_butterfly_plus b2 (
        .X(x6),
        .Y(x2),
        .fft_a(y2)
    );

    FFT_butterfly_plus b3 (
        .X(x7),
        .Y(x3),
        .fft_a(y3)
    );

    FFT_butterfly_minus #(
        .W_real(32'h00010000),
        .W_img(32'h00000000)
    )
    b4 (
        .X(x0),
        .Y(x4),
        .fft_b(y4)
    );

    FFT_butterfly_minus #(
        .W_real(32'h0000B504),
        .W_img(32'hFFFF4AFC)
    )
    b5 (
        .X(x1),
        .Y(x5),
        .fft_b(y5)
    );

    FFT_butterfly_minus #(
        .W_real(32'h00000000),
        .W_img(32'hFFFF0000)
    )
    b6 (
        .X(x2),
        .Y(x6),
        .fft_b(y6)
    );

    FFT_butterfly_minus #(
        .W_real(32'hFFFF4AFC),
        .W_img(32'hFFFF4AFC)
    )
    b7 (
        .X(x3),
        .Y(x7),
        .fft_b(y7)
    );

    /*Left side*/

    FFT_butterfly_plus b8 (
        .X(x12),
        .Y(x8),
        .fft_a(y8)
    );

    FFT_butterfly_plus b9 (
        .X(x13),
        .Y(x9),
        .fft_a(y9)
    );

    FFT_butterfly_plus b10 (
        .X(x14),
        .Y(x10),
        .fft_a(y10)
    );

    FFT_butterfly_plus b11 (
        .X(x15),
        .Y(x11),
        .fft_a(y11)
    );

    FFT_butterfly_minus #(
        .W_real(32'h00010000),
        .W_img(32'h00000000)
    )
    b12 (
        .X(x8),
        .Y(x12),
        .fft_b(y12)
    );

    FFT_butterfly_minus #(
        .W_real(32'h0000B504),
        .W_img(32'hFFFF4AFC)
    )
    b13 (
        .X(x9),
        .Y(x13),
        .fft_b(y13)
    );

    FFT_butterfly_minus #(
        .W_real(32'h00000000),
        .W_img(32'hFFFF0000)
    )
    b14 (
        .X(x10),
        .Y(x14),
        .fft_b(y14)
    );

    FFT_butterfly_minus #(
        .W_real(32'hFFFF4AFC),
        .W_img(32'hFFFF4AFC)
    )
    b15 (
        .X(x11),
        .Y(x15),
        .fft_b(y15)
    );

endmodule