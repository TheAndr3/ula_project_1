module unidade_xor_5x4 (
	input wire [4:0] a,
	input wire [3:0] b,
	output s
);

	xor u_xr (s, a[4], a[3], a[2], a[1], a[0], b[3], b[2], b[1], b[0]);

endmodule