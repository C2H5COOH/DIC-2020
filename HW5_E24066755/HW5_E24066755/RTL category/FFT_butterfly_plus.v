module FFT_butterfly_plus(
    input [31:0] X,Y,
    output [31:0] fft_a
);
    wire signed [15:0] X_real,Y_real,X_img,Y_img;
    assign X_real = X[31:16];
    assign Y_real = Y[31:16];
    assign X_img = X[15:0];
    assign Y_img = Y[15:0];

    
    wire signed [15:0] fft_a_real,fft_a_img;
    assign fft_a_real =  X_real + Y_real;
    assign fft_a_img =  X_img + Y_img;

    assign fft_a = {fft_a_real,fft_a_img};

endmodule