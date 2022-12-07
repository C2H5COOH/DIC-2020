module FFT_butterfly_minus (
    input [31:0] X,Y,
    output [31:0] fft_b
);
    parameter signed W_real = 32'h00010000;
    parameter signed W_img = 32'h00000000;

    wire signed [15:0] X_real,Y_real,X_img,Y_img;
    assign X_real = X[31:16];
    assign Y_real = Y[31:16];
    assign X_img = X[15:0];
    assign Y_img = Y[15:0];

    wire signed [47:0] fft_b_real,fft_b_img;
    assign fft_b_real = (X_real - Y_real) * W_real + (Y_img - X_img) * W_img;
    assign fft_b_img = (X_real - Y_real) * W_img + (X_img - Y_img) * W_real;
    
    assign fft_b[31:16] = {fft_b_real[31:24], fft_b_real[23:16]};
    assign fft_b[15:0] = {fft_b_img[31:24], fft_b_img[23:16]};

endmodule