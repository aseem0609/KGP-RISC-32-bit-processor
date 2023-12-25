
module ALU(func,res,a,b);
    input [5:0] func;
    input [31:0] a,b;
    output [31:0] res;
    wire [31:0] sum,diff,and1,or1,xor1,not2,sla,sra,srl,comp,not1;
    adder A(a,b,sum,1'b0);
    NOT B(b,not1);
    adder C(32'd1,not1,comp,1'b0);
    adder D(a,comp,diff,1'b0);
    AND E(a,b,and1);
    OR F(a,b,or1);
    XOR G(a,b,xor1);
    NOT H(a,not2);
    SLA I(a,sla);
    SRL J(a,srl);
    SRA K(a,sra);
    assign res=(func==0)?sum:(func==1)?diff:(func==2)?and1:(func==3)?or1:(func==4)?xor1:(func==5)?not2:(func==6)?((b[0]==1)?sla:a):(func==7)?((b[0]==1)?sra:a):((b[0]==1)?srl:a);
endmodule
