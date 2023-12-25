module adder(x,y,z,cin);
    input [31:0] x,y;
    output [31:0] z;
    input cin;
    wire [3:0] cout;
    ADD A(x[7:0],y[7:0],z[7:0],cin,cout[0]);
    ADD B(x[15:8],y[15:8],z[15:8],cout[0],cout[1]);
    ADD C(x[23:16],y[23:16],z[23:16],cout[1],cout[2]);
    ADD D(x[31:24],y[31:24],z[31:24],cout[2],cout[3]);
endmodule