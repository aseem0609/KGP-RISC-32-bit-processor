module branch_type (branch,branch_op,reg1,imm,clk,out);
    
    input [31:0] imm;
    input [31:0] reg1;
    input clk,branch;
    output [31:0] out;
  
    input [1:0] branch_op;
    assign out=(branch==1'b1)?(branch_op==2'b01)?imm:(branch_op==2'b10)?(((reg1[31]==1'b1)&&(reg1[30:0]!=0))?imm:0):(branch_op==2'b11)?(((reg1[31]==0)&&(reg1[30:0]!=0))?imm:0):(((reg1[30:0]==0))?imm:0):0;
endmodule