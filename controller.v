
module controller(
    input wire [5:0] opcode,
    input [31:0] IF,
    input wire [5:0] func,
    input wire clk,
    output reg immediate,
    output reg memory,
    output reg write,
    output reg pc_in,
    output reg read_pc1,
    output reg read_pc2,
    output reg read_sp1,
    output reg read_sp2,
    output reg branch,
    output reg sp_in,
    output reg store,
    output reg [1:0] imm_type,
    output reg [5:0] alu_code,
    output reg [1:0] branch_op,
    output reg intr,
    input en
);
    
    reg [5:0] state,opcode1;
  
    always@(negedge clk)begin
        if(en) begin
            if(intr)opcode1<=IF[31:26];
        end
        else opcode1<=6'b110000;
     
        case(opcode1)
            
            6'b000010,6'b000011,6'b100000,6'b000100,6'b000000,6'b010000,6'b010001,6'b010010,6'b010011,6'b010100,6'b010101,6'b010110,6'b010111,6'b011000,6'b011001,6'b011010,6'b011011,6'b011100,6'b000001:
            begin
             state<=opcode1;
             opcode1<=6'b110001;

            end
            6'b100011:
            begin
                state<=6'b000001;
                 
                opcode1<=6'b100100;
            end
            6'b100100:
            begin
                state<=6'b100011;
            end
            6'b100010:
            begin
                state<=6'b110001;
            
                opcode1<=6'b100101;
            end
            6'b100101:
            begin 
                state<=6'b100010;
                
                opcode1<=6'b011001;

            end
            6'b110001:begin
                 state<=6'b110001;
                 opcode1<=6'b110000;
            end
            6'b110000: state<=6'b110000;
            default: state<=6'b110000;
        endcase
    end
    always@(state)begin
        case(state)
            
            6'b110000:
            begin
                read_pc1<=0;
                branch_op<=0;
                read_sp1<=0;
                read_pc2<=0;
                read_sp2<=0;
                immediate<=0;
                imm_type<=0;
                store<=0;
                write<=0;
                pc_in<=0;
                sp_in<=0;
                alu_code<=0;
                memory<=0;
                branch<=0;
                intr<=1;
            end
            6'b110001:
            begin
                branch<=0;
                read_pc1<=1;
                read_sp1<=0;
                branch_op<=0;
                read_pc2<=0;
                read_sp2<=0;
                immediate<=1;
                imm_type<=1;
                store<=0;
                write<=0;
                pc_in<=1;
                sp_in<=0;
                alu_code<=0;
                memory<=0;
                intr<=0;
            end
            6'b100010:
            begin
                branch<=0;
                branch_op<=0;
                read_pc1<=1;
                read_sp1<=0;
                read_pc2<=0;
                read_sp2<=0;
                immediate<=1;
                imm_type<=1;
                store<=0;
                write<=0;
                pc_in<=1;
                sp_in<=0;
                alu_code<=1;
                memory<=0;
                intr<=0;
            end
            6'b100011:
            begin
                branch<=0;
                read_pc1<=0;
                branch_op<=0;
                read_sp1<=1;
                read_pc2<=0;
                read_sp2<=0;
                immediate<=1;
                imm_type<=1;
                store<=0;
                write<=0;
                pc_in<=0;
                sp_in<=1;
                alu_code<=0;
                memory<=0;
                intr<=0;
            end
            6'b000000:
            begin
                store<=0;
                immediate<=0;
                imm_type<=0;
                if(IF[15:11]<=5'b01111) write<=1;
                else write<=0;
                branch_op<=0;
                memory<=0;
                branch<=0;
                alu_code<=func;
                if(IF[25:21]==6'b010000) read_pc1<=1;
                else read_pc1<=0;
                if(IF[25:21]==6'b010001) read_sp1<=1;
                else read_sp1<=0;
                if(IF[20:16]==6'b010000) read_pc2<=1;
                else read_pc2<=0;
                if(IF[20:16]==6'b010001) read_sp2<=1;
                else read_sp2<=0;
                if(IF[15:11]==6'b010000) pc_in<=1;
                else pc_in<=0;
                if(IF[15:11]==5'b10001) sp_in<=1;
                else sp_in<=0;
                intr<=0;
            end
            6'b010000,6'b010001,6'b010010,6'b010011,6'b010100,6'b010101,6'b010110,6'b010111,6'b011000:
                
            begin
                if(IF[20:16]<=5'b01111) write<=1;
                else write<=0;
                memory<=0;
                branch<=0;
                branch_op<=0;
                store<=0;
                alu_code<={{6-2{1'b0}},state[3:0]};
                if(IF[25:21]==6'b010000) read_pc1<=1;
                else read_pc1<=0;
                if(IF[25:21]==6'b010001) read_sp1<=1;
                else read_sp1<=0;
                if(IF[20:16]==6'b010000) pc_in<=1;
                else pc_in<=0;
                if(IF[20:16]==6'b010001) sp_in<=1;
                else sp_in<=0;
                read_pc2<=0;
                read_sp2<=0;
                immediate<=1;
                imm_type<=2;
                intr<=0;
            end
            6'b011001,6'b011010,6'b011011,6'b011100:
                
            begin
                immediate<=1;
                alu_code<=0;
                branch<=1;
                branch_op<=state[1:0];
                pc_in<=1;
                store<=0;
                memory<=0;
                write<=0;
                sp_in<=0;
                read_pc1<=1;
                read_pc2<=0;
                read_sp1<=0;
                read_sp2<=0;
                imm_type<=2;
                intr<=0;
            end
            6'b000001:
                
            begin
                if(IF[20:16]<=5'b01111) write<=1;
                else write<=0;
                memory<=1;
                branch<=0;
                store<=0;
                branch_op<=0;
                alu_code<=6'b000000;
                if(IF[25:21]==6'b010000) read_pc1<=1;
                else read_pc1<=0;
                if(IF[25:21]==6'b010001) read_sp1<=1;
                else read_sp1<=0;
                if(IF[20:16]==6'b010000) pc_in<=1;
                else pc_in<=0;
                if(IF[20:16]==6'b010001) sp_in<=1;
                else sp_in<=0;
                read_pc2<=0;
                read_sp2<=0;
                immediate<=1;
                imm_type<=2;
                intr<=0;
            end
            6'b000010:
                
            begin
                write<=0;
                memory<=0;
                branch<=0;
                branch_op<=0;
                store<=1;
                alu_code<=6'b000000;
                if(IF[25:21]==6'b010000) read_pc1<=1;
                else read_pc1<=0;
                if(IF[25:21]==6'b010001) read_sp1<=1;
                else read_sp1<=0;
                if(IF[20:16]==6'b010000) read_pc2<=1;
                else read_pc2<=0;
                if(IF[20:16]==5'b10001) read_sp2<=1;
                else read_sp2<=0;
                pc_in<=0;
                sp_in<=0;
                immediate<=1;
                imm_type<=2;
                intr<=0;
            end
            6'b000011:
                
            begin
                write<=0;
                memory<=1;
                branch<=0;
                branch_op<=0;
                store<=0;
                alu_code<=6'b000000;
                if(IF[25:21]==6'b010000) read_pc1<=1;
                else read_pc1<=0;
                if(IF[25:21]==6'b010001) read_sp1<=1;
                else read_sp1<=0;
                read_sp2<=0;
                read_pc2<=0;
                pc_in<=0;
                sp_in<=1;
                immediate<=1;
                imm_type<=2;
                intr<=0;
            end
            6'b000100:
            begin
                write<=0;
                memory<=0;
                branch<=0;
                store<=1;
                branch_op<=0;
                alu_code<=6'b000000;
                if(IF[25:21]==6'b010000) read_pc1<=1;
                else read_pc1<=0;
                if(IF[25:21]==6'b010001) read_sp1<=1;
                else read_sp1<=0;
                read_sp2<=1;
                read_pc2<=0;
                pc_in<=0;
                sp_in<=0;
                immediate<=1;
                imm_type<=2;
                intr<=0;
            end
            6'b100000:
            begin
                write<=0;
                memory<=0;
                branch<=0;
                branch_op<=0;
                
                store<=1;
                alu_code<=6'b000001;
                read_pc2<=0;
                read_sp2<=0;
                read_sp1<=1;
                read_pc1<=0;
                pc_in<=0;
                sp_in<=1;
                immediate<=1;
                imm_type<=1;
                intr<=0;
            end
            6'b100001:
            begin
                write<=1;
                memory<=1;
                branch<=0;
                store<=0;
                branch_op<=0;
                alu_code<=6'b000000;
                read_pc2<=0;
                read_sp2<=0;
                read_sp1<=1;
                read_pc1<=0;
                pc_in<=0;
                sp_in<=0;
                immediate<=1;
                imm_type<=1;
                intr<=0;
            end
            default:
            begin
                branch_op<=0;
                read_pc1<=0;
                read_sp1<=0;
                read_pc2<=0;
                read_sp2<=0;
                immediate<=0;
                imm_type<=0;
                store<=0;
                write<=0;
                pc_in<=0;
                sp_in<=0;
                alu_code<=0;
                memory<=0;
                branch<=0;
                intr<=0;
            end
        endcase
    end

endmodule