module ULA_TOP (
    // Entradas físicas da placa
    input  wire [9:0] SW,
    // Saídas físicas da placa
    output wire [6:0] HEX0,
    output wire [6:0] HEX1
);

    // --- Mapeamento de Entradas ---
    wire [3:0] a = SW[3:0];
    // NOTA: Para B ter 4 bits, teríamos que usar SW[7:4].
    // Mantendo a lógica anterior com SW[7] como carry-in:
    wire [3:0] b = {1'b0, SW[6:4]}; // B usa 3 chaves, o bit mais alto é 0.
    wire carry_in_switch = SW[7];   // SW[7] é a nossa Carry-in.
    wire [1:0] seletor = SW[9:8];
    
    // --- Fios Intermediários ---
    wire [3:0] resultado_soma_sub, resultado_and, resultado_or;
    wire cout, ov;
    wire [3:0] resultado_ula;
    wire [3:0] digito_dezena;
    wire [3:0] digito_unidade;
    
    // Fios de controle para o somador
    wire modo_sub;
    wire carry_inicial;

    // Fios para constantes e lógica de controle
    wire not_seletor_1;
    wire vcc; // Fio para constante '1'
    wire not_a0; // Fio auxiliar para gerar vcc

    // --- Lógica Estrutural de Controle (Substituindo 'assign') ---

    // 1. Gerar constantes VCC (1) e GND (0) de forma estrutural se necessário.
    //    Para VCC = a[0] OR (NOT a[0]), o que sempre resulta em 1.
    not U_VCC_NOT (not_a0, a[0]);
    or  U_VCC_OR  (vcc, a[0], not_a0);

    // 2. Lógica para gerar 'modo_sub'
    //    modo_sub = (seletor == 2'b01) -> modo_sub = (NOT seletor[1]) AND seletor[0]
    not U_NOT_SEL1 (not_seletor_1, seletor[1]);
    and U_AND_SUB  (modo_sub, not_seletor_1, seletor[0]);

    // 3. Lógica para gerar 'carry_inicial' com um MUX 2-para-1 implícito
    //    carry_inicial = modo_sub ? 1'b1 : carry_in_switch;
    wire term_mux_0, term_mux_1;
    wire not_modo_sub;
    not U_NOT_MSUB (not_modo_sub, modo_sub);
    and U_MUX_T0   (term_mux_0, not_modo_sub, carry_in_switch);
    and U_MUX_T1   (term_mux_1, modo_sub, vcc);
    or  U_MUX_OR   (carry_inicial, term_mux_0, term_mux_1);

    // --- Instanciação dos Módulos ---

    // 1. Instanciar as unidades de operação
    somador_subtrator_4bits U_SomaSub (
        .a(a), 
        .b(b), 
        .modo_sub(modo_sub), 
        .cin_inicial(carry_inicial), // Passamos o carry correto
        .s(resultado_soma_sub), 
        .cout(cout), 
        .ov(ov)
    );
    
    unidade_and_4bits U_AND (.A(a), .B(b), .S(resultado_and));
    unidade_or_4bits  U_OR  (.A(a), .B(b), .S(resultado_or));
    
    // 2. MUX principal para selecionar o resultado
    mux_4_para_1_4bits U_MUX (
        .D0(resultado_soma_sub), // Seletor 00 (Soma)
        .D1(resultado_soma_sub), // Seletor 01 (Subtração)
        .D2(resultado_and),      // Seletor 10 (AND)
        .D3(resultado_or),       // Seletor 11 (OR)
        .S(seletor),
        .Y(resultado_ula)
    );
    
    // 3. Conversão e exibição nos displays
    // (Usando o nome do módulo que criamos a partir da tabela verdade)
    bcd U_BCD (
        .B(resultado_ula), 
        .dezena_out(digito_dezena), 
        .unidade_out(digito_unidade)
    );
    
    decodificador_7seg U_Display_Unidade (.D(digito_unidade), .SEG(HEX0));
    decodificador_7seg U_Display_Dezena  (.D(digito_dezena),  .SEG(HEX1));

endmodule
