
module IF(clk,pc,opcode,instruction_format,func,src_reg1,src_reg2,dest_reg,shamt,imm,dri,imm2);
input clk;
input [31:0] pc;
input [31:0] instruction_format;
output [5:0] opcode;
output [4:0] src_reg1;
output [4:0] src_reg2;
output [4:0] dest_reg;
output [5:0] func;
output [4:0] shamt;
output [31:0] imm;
output [31:0] imm2;
output [4:0] dri;
assign src_reg1 = instruction_format[25:21];
assign src_reg2 = instruction_format[20:16];
assign dest_reg = instruction_format[15:11];
assign shamt = instruction_format[10:6];
assign imm = (instruction_format[15]==1'b1)?{{32-16{1'b1}},instruction_format[15:0]}:{{32-16{1'b0}},instruction_format[15:0]};
assign dri = instruction_format[20:16];
assign imm2 = (instruction_format[25]==1'b1)?{{32-26{1'b1}},instruction_format[25:0]}:{{32-26{1'b0}},instruction_format[25:0]};
assign func=instruction_format[5:0];
assign opcode = instruction_format[31:26];
endmodule