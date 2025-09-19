module mutiplicacao_5x4 (
	input wire [4:0] a,
	input wire [3:0] b,
	output wire [7:0] s
);
	
	wire gnd = 1'b0;
	wire cout01, cout02, cout03, cout04, cout05, cout11, cout12, cout13, cout14, cout15, cout21, cout22, cout23, cout24, cout25;
	wire soma_02, soma_03, soma_12, soma_04, soma_13, soma_05, soma_14, soma_15;

    // --- Produtos Parciais (gerados implicitamente nos somadores) ---

	//s0
	and U_s0 (s[0], a[0], b[0]);
	
	//s1
	wire b0a1_and, a0b1_and;
	and f0s1 (b0a1_and, a[1], b[0]);
	and f1s1 (a0b1_and, a[0], b[1]);
	full_adder soma01 ( .a(b0a1_and), .b(a0b1_and), .cin(gnd), .s(s[1]), .cout(cout01) );
	
	//s2
	wire a2b0_and, a1b1_and, a0b2_and;
	and f0s2 (a2b0_and, a[2], b[0]);
	and f1s2 (a1b1_and, a[1], b[1]);
	full_adder soma02 ( .a(a2b0_and), .b(a1b1_and), .cin(cout01), .s(soma_02), .cout(cout02) );
	and f2s2 (a0b2_and, a[0], b[2]);
	full_adder soma11 ( .a(a0b2_and), .b(soma_02), .cin(gnd), .s(s[2]), .cout(cout11) );

	// --- CORREÇÃO 1: Somar os carries da coluna s2 ---
	wire c2_s, c2_c;
	full_adder FA_CARRY_S2 ( .a(cout02), .b(cout11), .cin(gnd), .s(c2_s), .cout(c2_c) );

	//s3
	wire a3b0_and, a2b1_and, a1b2_and, a0b3_and;
	and f0s3 (a3b0_and, a[3], b[0]);
	and f1s3 (a2b1_and, a[2], b[1]);
	full_adder soma03 ( .a(a3b0_and), .b(a2b1_and), .cin(c2_s), .s(soma_03), .cout(cout03) ); // Usa o carry somado
	and f2s3 (a1b2_and, a[1], b[2]);
	full_adder soma12 ( .a(a1b2_and), .b(soma_03), .cin(c2_c), .s(soma_12), .cout(cout12) ); // Usa o carry do carry
	and f3s3 (a0b3_and, a[0], b[3]);
	full_adder soma21 ( .a(a0b3_and), .b(soma_12), .cin(gnd), .s(s[3]), .cout(cout21) );

	// --- CORREÇÃO 2: Somar os carries da coluna s3 ---
	wire c3_s1, c3_c1, c3_s2, c3_c2;
	full_adder FA_CARRY_S3_1 ( .a(cout03), .b(cout12), .cin(gnd), .s(c3_s1), .cout(c3_c1) );
	full_adder FA_CARRY_S3_2 ( .a(c3_s1), .b(cout21), .cin(gnd), .s(c3_s2), .cout(c3_c2) );

	//s4
	wire a4b0_and, a3b1_and, a2b2_and, a1b3_and;
	and f0s4 (a4b0_and, a[4], b[0]);
	and f1s4 (a3b1_and, a[3], b[1]);
	full_adder soma04 ( .a(a4b0_and), .b(a3b1_and), .cin(c3_s2), .s(soma_04), .cout(cout04) );
	and f2s4 (a2b2_and, a[2], b[2]);
	full_adder soma13 ( .a(a2b2_and), .b(soma_04), .cin(c3_c1), .s(soma_13), .cout(cout13) );
	and f3s4 (a1b3_and, a[1], b[3]);
	full_adder soma22 ( .a(a1b3_and), .b(soma_13), .cin(c3_c2), .s(s[4]), .cout(cout22) );
	
	// --- CORREÇÃO 3: Somar os carries da coluna s4 ---
	wire c4_s1, c4_c1, c4_s2, c4_c2;
	full_adder FA_CARRY_S4_1 ( .a(cout04), .b(cout13), .cin(gnd), .s(c4_s1), .cout(c4_c1) );
	full_adder FA_CARRY_S4_2 ( .a(c4_s1), .b(cout22), .cin(gnd), .s(c4_s2), .cout(c4_c2) );

	//s5
	wire a4b1_and, a3b2_and, a2b3_and;
	and f0s5 (a4b1_and, a[4], b[1]);
	full_adder soma05 ( .a(a4b1_and), .b(c4_s2), .cin(gnd), .s(soma_05), .cout(cout05) ); // Modificado para somar o carry
	and f1s5 (a3b2_and, a[3], b[2]);
	full_adder soma14 ( .a(a3b2_and), .b(soma_05), .cin(c4_c1), .s(soma_14), .cout(cout14) );
	and f2s5 (a2b3_and, a[2], b[3]);
	full_adder soma23 ( .a(a2b3_and), .b(soma_14), .cin(c4_c2), .s(s[5]), .cout(cout23) );
	
	// --- CORREÇÃO 4: Somar os carries da coluna s5 ---
	wire c5_s1, c5_c1, c5_s2, c5_c2;
	full_adder FA_CARRY_S5_1 ( .a(cout05), .b(cout14), .cin(gnd), .s(c5_s1), .cout(c5_c1) );
	full_adder FA_CARRY_S5_2 ( .a(c5_s1), .b(cout23), .cin(gnd), .s(c5_s2), .cout(c5_c2) );

	//s6
	wire a4b2_and, a3b3_and;
	and f0s6 (a4b2_and, a[4], b[2]);
	full_adder soma15 ( .a(a4b2_and), .b(c5_s2), .cin(c5_c1), .s(soma_15), .cout(cout15) );
	and f1s6 (a3b3_and, a[3], b[3]);
	full_adder soma24 ( .a(a3b3_and), .b(soma_15), .cin(c5_c2), .s(s[6]), .cout(cout24) );
	
	//s7
	wire a4b3_and;
	and f0s7 (a4b3_and, a[4], b[3]);
	full_adder soma25 ( .a(a4b3_and), .b(cout15), .cin(cout24), .s(s[7]), .cout(cout25) );

endmodule
