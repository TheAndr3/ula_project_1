module soma_cin_a (
	input wire [3:0] a,
	input c_in,
	output wire [4:0] AC
);

	wire gnd = 1'b0;
	wire cout1, cout2, cout3;
	
	full_adder U_s1 ( a[0], c_in, gnd,
    AC[0], cout1);

full_adder U_s2 (
    a[1],
    cout1,
    gnd,
    AC[1],
    cout2
);

full_adder U_s3 ( a[2], cout2, gnd,
    AC[2], cout3
);

full_adder U_s4 ( a[3], cout3, gnd,
    AC[3], AC[4]
);

endmodule