module unidade_xor_5x4 (
	input wire [4:0] a,
	input wire [3:0] b,
	output [4:0] s
);
	wire gnd = 1'b0;
	
	xor or0 (s[0], a[0], b[0]);
	xor or1 (s[1], a[1], b[1]);
	xor or2 (s[2], a[2], b[2]);
	xor or3 (s[3], a[3], b[3]);
	xor or4 (s[4], a[4], gnd);


endmodule