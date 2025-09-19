// Módulo de flag de erro atualizado para incluir erro de subtração negativa
module flag_error (
	input wire [3:0] b,
	input wire [2:0] seletor,
	input wire       sub_neg,   // Nova entrada: 1 se o resultado da subtração for negativo
	output wire      ledr9      // Saída para o LED de erro
);	
	// --- Fios e Inversores ---
	wire nSE0, nSE1, nSE2;
	not se0 (nSE0, seletor[0]);
	not se1 (nSE1, seletor[1]);
	not se2 (nSE2, seletor[2]);
	
	wire nB0, nB1, nB2, nB3;
	not nb0 (nB0, b[0]);
	not nb1 (nB1, b[1]);
	not nb2 (nB2, b[2]);
	not nb3 (nB3, b[3]);
	
	// --- Lógica de Detecção de Erros ---
	
	// Condição 1: Divisão por zero (b == 0000 e seletor == 110)
	wire div_erro;
	and fe0 (div_erro, nSE0, seletor[1], seletor[2], nB0, nB1, nB2, nB3);
	
	// Condição 2: Operação não utilizada (seletor == 111)
	wire op_erro;
	and fe1 (op_erro, seletor[0], seletor[1], seletor[2]);
	
	// Condição 3 (NOVA): Resultado da subtração é negativo
	// Ativa se (seletor == 001) E (sub_neg == 1)
	wire sub_neg_erro, nsub_neg;
	not nab0 (nsub_neg, sub_neg);
	and fe_sub_neg (sub_neg_erro, seletor[0], nSE1, nSE2, nsub_neg);

	// --- Saída Final ---
	// O LED de erro acende se QUALQUER uma das condições for verdadeira
	or  U_FINAL_ERROR (ledr9, div_erro, op_erro, sub_neg_erro);

endmodule