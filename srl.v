module SRL(x,y);
    input [31:0] x;
    output [31:0] y;
    assign y[31]=1'b0;
    assign y[30:0]=x[31:1];
endmodule