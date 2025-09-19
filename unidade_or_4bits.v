module unidade_or_4bits (
    input  wire [4:0] AC,    
    input  wire [3:0] B,    
    output wire [4:0] S     
);

    wire gnd = 1'b0;
	 
	 or or0 (S[0], AC[0], B[0]);
	 or or1 (S[1], AC[1], B[1]);
	 or or2 (S[2], AC[2], B[2]);
	 or or3 (S[3], AC[3], B[3]);
	 or or4 (S[4], AC[4], gnd);

endmodule