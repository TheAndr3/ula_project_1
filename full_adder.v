module full_adder (
	input wire a,
	input wire b,
	input wire cin,
	output wire s,
	output wire cout
);

	// Somador
	assign s = (~a & ~b & cin) | (~a & b & ~cin) | (a & ~b & ~cin) | (a & b & cin);
		
	//Cout 
	assign cout = (b & cin) | (a & cin) | (a & b);

endmodule
