module SLA(x,y);
    input [31:0] x;
    output [31:0] y;
    assign y[31:1]=x[30:0];
    assign y[0]=1'b0;
endmodule