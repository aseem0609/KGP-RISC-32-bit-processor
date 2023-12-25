module test(clk,a,booth,gcd,reset,mem_reset,pc_reset,sp_reset,en,res);
    input clk,a,booth,gcd,reset,mem_reset,pc_reset,sp_reset,en;
    output [15:0] res;
    wire [31:0] write_data2,wd3,write_data;
    datapath DP(reset,clk,mem_reset,write_data,pc_reset,sp_reset,gcd,write_data2,booth,en);
    assign res=(a==1)?write_data2[31:16]:write_data2[15:0];
endmodule