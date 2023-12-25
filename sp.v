
module SP(write,imm,clk,sp,reset);
        input [31:0] imm;
        input clk,write,reset;
        reg [31:0] SP;
        output [31:0] sp;
        always @(posedge clk)begin
            if(write==1) SP<=imm;
            if(reset) SP<=30;
        end
        assign sp=SP;
endmodule