module unidade_and_4bits (
    input  wire [4:0] AC,    
    input  wire [3:0] B,    
    output wire [4:0] S    
);
	
	wire gnd = 1'b0;
	
	and and0 (S[0], AC[0], B[0]);
	and and1 (S[1], AC[1], B[1]);
	and and2 (S[2], AC[2], B[2]);
	and and3 (S[3], AC[3], B[3]);
	and and4 (S[4], AC[4], gnd);

endmodule