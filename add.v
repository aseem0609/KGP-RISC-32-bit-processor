module ADD(x,y,z,cin,cout);
    input cin;
    input [7:0] x,y;
    output  [7:0] z;
    output cout;
    wire [31:0] p,g,a,b,c,d,e,h,i,j,C,f;
    NOT S({{32-8{1'b0}},y},a);
    NOT T({{32-8{1'b0}},x},b);
    AND U({{32-8{1'b0}},x},a,c);
    AND V({{32-8{1'b0}},y},b,d);
    OR W(c,d,p);
    AND K({{32-8{1'b0}},x},{{32-8{1'b0}},y},g);
    assign C[0]=cin;
    assign C[1]=g[0]||(p[0]&&C[0]);
    assign C[2]=g[1]||(p[1]&&g[0])||(p[1]&&p[0]&&C[0]);
    assign C[3]=g[2]||(p[2]&&g[1])||(p[2]&&p[1]&&g[0])||(p[2]&&p[1]&&p[0]&&C[0]);
    assign C[4]=g[3]||(p[3]&&g[2])||(p[3]&&p[2]&&g[1])||(p[3]&&p[2]&&p[1]&&g[0])||(p[3]&&p[2]&&p[1]&&p[0]&&C[0]);
    assign C[5]=g[4]||(p[4]&&g[3])||(p[4]&&p[3]&&g[2])||(p[4]&&p[3]&&p[2]&&g[1])||(p[4]&&p[3]&&p[2]&&p[1]&&g[0])||(p[4]&&p[3]&&p[2]&&p[1]&&p[0]&&C[0]);
    assign C[6]=g[5]||(p[5]&&g[4])||(p[5]&&p[4]&&g[3])||(p[5]&&p[4]&&p[3]&&g[2])||(p[5]&&p[4]&&p[3]&&p[2]&&g[1])||(p[5]&&p[4]&&p[3]&&p[2]&&p[1]&&g[0])||(p[5]&&p[4]&&p[3]&&p[2]&&p[1]&&p[0]&&C[0]);
    assign C[7]=g[6]||(p[6]&&g[5])||(p[6]&&p[5]&&g[4])||(p[6]&&p[5]&&p[4]&&g[3])||(p[6]&&p[5]&&p[4]&&p[3]&&g[2])||(p[6]&&p[5]&&p[4]&&p[3]&&p[2]&&g[1])||(p[6]&&p[5]&&p[4]&&p[3]&&p[2]&&p[1]&&g[0])||(p[6]&&p[5]&&p[4]&&p[3]&&p[2]&&p[1]&&p[0]&&C[0]);
    assign cout=g[7]||(p[7]&&g[6])||(p[7]&&p[6]&&g[5])||(p[7]&&p[6]&&p[5]&&g[4])||(p[7]&&p[6]&&p[5]&&p[4]&&g[3])||(p[7]&&p[6]&&p[5]&&p[4]&&p[3]&&g[2])||(p[7]&&p[6]&&p[5]&&p[4]&&p[3]&&p[2]&&g[1])||(p[7]&&p[6]&&p[5]&&p[4]&&p[3]&&p[2]&&p[1]&&g[0])||(p[7]&&p[6]&&p[5]&&p[4]&&p[3]&&p[2]&&p[1]&&p[0]&&C[0]);
    NOT M(C,e);
    NOT N(p,h);
    AND O(p,e,i);
    AND P(C,h,j);
    OR Q(i,j,f);
    assign z=f[7:0];
endmodule