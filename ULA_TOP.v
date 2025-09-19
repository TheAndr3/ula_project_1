module ULA_TOP (
    // Entradas físicas da placa
    input  wire [9:0] SW,
    input  wire [1:0] KEY,
    // Saídas físicas da placa
    output wire [6:0] HEX0,
    output wire [6:0] HEX1,
	 output LEDR9,
	 output LEDR8
);

	// Invertendo butoes
	wire nKEY1, nKEY0;
	not nk1 (nKEY1, KEY[1]);
	not nk0 (nKEY0, KEY[0]);

    // --- Mapeamento de Entradas ---
    wire [3:0] a = SW[3:0];
    wire [3:0] b = SW[7:4];
    wire carry_in_switch = SW[8];
    wire [2:0] seletor = {nKEY1, nKEY0, SW[9]}; // Seletor de 3 bits

    // --- Fios Intermediários ---
	 wire [4:0] ac;
    wire [4:0] resultado_soma, resultado_sub, resultado_div;
	 wire resultado_and, resultado_or, resultado_xor;
    wire cout_soma, ov_soma, cout_sub, ov_sub;
    wire [7:0] resultado_ula, resultado_mult;
    wire [3:0] digito_dezena;
    wire [3:0] digito_unidade;
    
    // Fios para constantes
    wire vcc, gnd, not_a0;
    wire [3:0] gnd_bus; // Barramento de 4 bits para o GND

    // --- Lógica Estrutural de Controle e Constantes ---

    // 1. Gerar constantes VCC (1) e GND (0)
    not U_VCC_NOT (not_a0, a[0]);
    or  U_VCC_OR  (vcc, a[0], not_a0);
    and U_GND_AND (gnd, a[0], not_a0);
    
    // Atribui o GND a todos os bits do barramento gnd_bus
    buf U_GND_BUF0 (gnd_bus[0], gnd);
    buf U_GND_BUF1 (gnd_bus[1], gnd);
    buf U_GND_BUF2 (gnd_bus[2], gnd);
    buf U_GND_BUF3 (gnd_bus[3], gnd);

    // --- Instanciação dos Módulos ---

	 soma_cin_a U_somaCin (
	 .a(a), .c_in(carry_in_switch),
	 .AC(ac)
	 );
	 
	 
    // 1. Unidades de operação
    // Soma (modo_sub=0, cin=carry_in_switch)
    somador_subtrator_4bits U_Soma (
        .a(a), .b(b), .modo_sub(gnd), .cin_inicial(carry_in_switch),
        .s(resultado_soma), .cout(cout_soma), .ov(ov_soma)
    );

    // Subtração (modo_sub=1, cin=1)
    somador_subtrator_4bits U_Sub (
        .a(a), .b(b), .modo_sub(vcc), .cin_inicial(vcc),
        .s(resultado_sub), .cout(cout_sub), .ov(ov_sub)
    );
    
	 // And
    unidade_and_4bits U_AND (.AC(ac), .B(b), .S(resultado_and));
	 
	 // Or
    unidade_or_4bits  U_OR  (.AC(ac), .B(b), .S(resultado_or));
	 
	 // Mutiplicação
	 mutiplicacao_5x4 U_Mult (
	 .a(ac), .b(b),
	 .s(resultado_mult)
	 );
	 
	 //XOR
	 unidade_xor_5x4 U_xor (
		.a(ac), .b(b),
		.s(resultado_xor)
	 );
	 
	 //Divisao
	 divisao_5por4 U_div (
		.a(ac), .b(b),
		.s(resultado_div)
	 );
    
    // 2. MUX principal de 8 para 1
    mux_8_para_1_8bits U_MUX (
        .D0(resultado_soma),    // Seletor 000: Soma
        .D1(resultado_sub),     // Seletor 001: Subtração
        .D2(resultado_and),     // Seletor 010: AND
        .D3(resultado_or),      // Seletor 011: OR
        .D4(resultado_mult),    // Seletor 100: Multiplicação
        .D5(resultado_xor),     // Seletor 101: XOR
        .D6(resultado_div),     // Seletor 110: Divisao
        .D7(gnd_bus),           // Seletor 111: Não usado (saída 0)
        .S(seletor),            // Conecta o seletor de 3 bits
        .Y(resultado_ula)
    );

    // 3. Conversão e exibição
    bcd U_BCD (
        .B(resultado_ula), 
        .dezena_out(digito_dezena), 
        .unidade_out(digito_unidade)
    );
    
    decodificador_7seg ( .D(digito_unidade) , .SEG(HEX0));
    decodificador_7seg ( .D(digito_dezena) ,  .SEG(HEX1));
	 
	 flag_zero (.HEX0(HEX0), .HEX1(HEX1), .ledr8(LEDR8));
	 
	 flag_error (.b(b), .seletor(seletor), .sub_neg(resultado_sub[3]), .ledr9(LEDR9));

endmodule