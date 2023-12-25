
module Program_Counter(write,imm,clk,pc,reset);
        input [31:0] imm;
        input clk,write,reset;
        reg [31:0] PC;
        output [31:0] pc;
        always @(posedge clk)begin
            if(write==1) PC<=imm;
            if(reset) PC<=0;
        end
        assign pc=PC;
endmodule