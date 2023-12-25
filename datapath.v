module datapath(
    input wire reset,
    input wire clk,
    input wire mem_reset,
    
    output wire [31:0] write_data,
    input wire pc_reset,
    input wire sp_reset,
    input wire gcd,
    output wire [31:0] write_data2,
    input wire booth,
    input wire en
);
wire [31:0] instruction_format;
wire [31:0] alu_src1,x,sp,brnch_out,mem_data;
wire [31:0] alu_src2,mem_out;
wire [31:0] alu_result,val,val1,val3;
wire [31:0] val2,pc;
wire [4:0] dest_reg,src_reg1,src_reg2,Destreg,shamt,dri;
wire [5:0] alu_code,opcode,func;
wire [31:0] imm;
wire [31:0] imm2;
wire immediate,memory,write,pc_in,read_pc1,read_pc2,read_sp1,read_sp2,branch,sp_in,store,instr;
wire [1:0] branch_op,imm_ty;
wire [31:0] imm_data;
Memory M(alu_result,store,mem_data,mem_out,mem_reset,pc,instruction_format,clk,gcd,instr,booth);
IF Inst_F (clk,pc,opcode,instruction_format,func,src_reg1,src_reg2,dest_reg,shamt,imm,dri,imm2);
controller C(opcode,instruction_format,func,clk,immediate,memory,write,pc_in,read_pc1,read_pc2,read_sp1,read_sp2,branch,sp_in,store,imm_ty,alu_code,branch_op,instr,en);
assign Destreg=(opcode==6'b0)?dest_reg:dri;
RegisterBank RB(src_reg1, src_reg2, Destreg,write_data,write,clk, reset,val3,val2);
ALU A(alu_code,alu_result,alu_src1,alu_src2);
branch_type BT(branch,branch_op,mem_data,imm_data,clk,brnch_out);
Program_Counter P(pc_in,write_data,clk,pc,pc_reset);
SP SP(sp_in,write_data,clk,sp,sp_reset);
assign alu_src1=(read_pc1)?pc:(read_sp1)?sp:val3;

assign mem_data=(read_pc2)?pc:(read_sp2)?sp:val2;
assign imm_data=(imm_ty==0)?0:(imm_ty==1)?32:imm;

assign alu_src2=(branch)?brnch_out:(immediate)?imm_data:mem_data;

assign write_data=(memory)?mem_out:alu_result;
assign write_data2=alu_src1;

endmodule    