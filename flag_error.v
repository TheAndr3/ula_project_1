module flag_error (
	input wire [3:0] b,
	input wire [2:0] seletor,
	output ledr9
);	
	//Seletor negado
	wire nSE0, nSE1, nSE2;
	not se0 (nSE0, seletor[0]);
	not se1 (nSE1, seletor[1]);
	not se2 (nSE2, seletor[2]);
	
	//B negado
	wire nB0, nB1, nB2, nB3;
	not nb0 (nB0, b[0]);
	not nb1 (nB1, b[1]);
	not nb2 (nB2, b[2]);
	not nb3 (nB3, b[3]);
	
	//ledr9
	wire div_erro, op_erro, saida;
	and fe0 (div_erro, nSE0, seletor[1], seletor[2], nB0, nB1, nB2, nB3);
	and fe1 (op_erro, seletor[0], seletor[1], seletor[2]);
	xor fe2 (ledr9, div_erro, op_erro);


endmodule