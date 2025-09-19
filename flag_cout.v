module flag_cout (
	input cout_soma,
	input [2:0] seletor,
	output ledr7
);

	//Seletor negado
	wire nSE0, nSE1, nSE2;
	not se0 (nSE0, seletor[0]);
	not se1 (nSE1, seletor[1]);
	not se2 (nSE2, seletor[2]);
	
	and fc (ledr7, cout_soma, nSE0, nSE1, nSE2);

endmodule