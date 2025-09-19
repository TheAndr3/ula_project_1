module operacao_7seg (
	input [2:0] seletor,
	output [6:0] HEX5
);

	//GND
	wire gnd = 1'b0;

	//Negando entradas
	wire nS0, nS1, nS2;
	not ns0 (nS0, seletor[0]);
	not ns1 (nS1, seletor[1]);
	not ns2 (nS2, seletor[2]);
	
	//HEX5[0] = S2' S0 + S2 S0';
	wire ns2s0_and, s2ns0_and;
	and a0 (ns2s0_and, nS2, seletor[0]);
	and a1 (s2ns0_and, seletor[2], nS0);
	or h50 (HEX5[0], ns2s0_and, s2ns0_and);
	
	//HEX5[1] = S2' S1'  + S2' S0 + S1' S0;
	wire ns2ns1_and, ns1s0_and;
	and a2 (ns2ns1_and, nS2, nS1);
	and a3 (ns1s0_and, nS1, seletor[0]);
	or h51 (HEX5[1], ns2ns1_and, ns2s0_and, ns1s0_and);

	//HEX5[2] = S2' S1' S0;
	and h52 (HEX5[2], nS2, nS1, seletor[0]);
	
	//HEX5[3] = S2' S1' S0 + S2' S1 S0' + S2 S1' S0';
	wire ns2ns1s0_and, ns2s1ns0_and, s2ns1ns0_and;
	and a4 (ns2ns1s0_and, nS2, nS1, seletor[0]);
	and a5 (ns2s1ns0_and, nS2, seletor[1], nS0);
	and a6 (s2ns1ns0_and, seletor[2], nS1, nS0);
	or h53 (HEX5[3], ns2ns1s0_and, ns2s1ns0_and, s2ns1ns0_and);
	
	//HEX5[4] = S2' S1' ;
	and h54 (HEX5[4], nS2, nS1);
	
	//HEX5[5] = S1' S0 + S2 S1 S0';
	wire s2s1ns0_and;
	and a8 (s2s1ns0_and, seletor[2], seletor[1], nS0);
	or h55 (HEX5[5], ns1s0_and, s2s1ns0_and);
	
	//HEX5[6] = 0;
	wire aux;
	not d0 (aux, gnd);
	not h56 (HEX5[6], aux);
	
endmodule
