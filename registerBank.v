
module RegisterBank(sr1, sr2, dr, write_data, write, clk, reset,rdData1,rdData2);
    input clk, write, reset;
    input [31:0] write_data;
    input [4:0] sr1, sr2, dr;
    reg write1;
    output [31:0] rdData1, rdData2/*,res*/;
    reg [31:0] regfile[15:0];
    always @(posedge clk)begin
        regfile[0]<=0;
        if(reset)begin
            regfile[0]<=0;
            regfile[1]<=0;
            regfile[2]<=0;
            regfile[3]<=0;
            regfile[4]<=0;
            regfile[5]<=0;
            regfile[6]<=0;
            regfile[7]<=0;
            regfile[8]<=0;
            regfile[9]<=0;
            regfile[10]<=0;
            regfile[11]<=0;
            regfile[12]<=0;
            regfile[13]<=0;
            regfile[14]<=0;
            regfile[15]<=0;
        end
        if (write==1'b1)begin
            regfile[dr] <= write_data;
        end
    end
    assign rdData1 = regfile[sr1];
    assign rdData2 = regfile[sr2];
    
endmodule