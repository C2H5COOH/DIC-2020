module booth(out, in1, in2);

parameter width = 6;

input  [width-1:0]   in1;   //multiplicand
input  [width-1:0]   in2;   //multiplier
output [2*width-1:0] out; //product

reg signed [2*width : 0] P;
reg [width-1:0] left;
integer index;

/*write your code here*/
always@(in1 or in2)begin
    P = { { width{1'b0} }, in2 , 1'b0 }; 
    for(index = 0; index < width; index = index + 1) begin
        case(P[1:0])
            2'b01 : begin
                //P = { { (P[2*width:width+1] + in1) }, { P[width:0] } };
                //P[2*width:width+1] = P[2*width:width+1] + in1;
                left = in1;
            end
            2'b10 : begin
                //P = { { (P[2*width:width+1] - in1) }, { P[width:0] } };
                //P[2*width:width+1] = P[2*width:width+1] - in1;
                left = -in1;
            end
            default: left = { width{1'b0} };
        endcase
        P[2*width:width+1] = P[2*width:width+1] + left;
        P = P >>> 1;
    end
end
assign out = P[2*width : 1];

endmodule
