
module testbench;

  reg gcd,clk,booth,en;
  reg reset,mem,pc,sp;
  wire [31:0] alu_out,w2,w3;
  datapath dp (
    reset,clk,mem,alu_out,pc,sp,gcd,w2,
    booth,en,w3
  );

  // Clock generation
  always begin
    #1 clk = ~clk; 
  end
  always @(w2 or w3)
    $monitor("%b,%b",w2,w3);
  initial begin
    clk = 1;
//    en=0;
//    pc=1;sp=1;reset=1;gcd=0;mem=1;booth=0;   //comment lines from 20 to 26 for gcd
//    #2 mem=0;reset=0;pc=0;sp=0;
//    booth=1;
//    #2 booth=0;                             //Booth's algorithm
//    en=1;
//    #3000
    en=0;pc=1;sp=1;reset=1;gcd=0;mem=1;booth=0;  //comment lines from 27 to 32 for booth's multipication
    #2 mem=0;reset=0;pc=0;sp=0;
    gcd=1;
    #2 gcd=0;                               //gcd
    en=1;
    #1000
    $finish; // End the simulation
  end

endmodule
