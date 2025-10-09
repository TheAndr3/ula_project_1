// Arquivo de teste para verificar se os módulos compilam corretamente
// Este arquivo não será usado no projeto final

module teste_modulos;

    // Teste do módulo unidade_not_8bits
    wire [7:0] a_not, s_not;
    unidade_not_8bits U_TESTE_NOT (
        .a(a_not),
        .s(s_not)
    );

    // Teste do módulo mux_2_para_1
    wire d0, d1, s, y;
    mux_2_para_1 U_TESTE_MUX2 (
        .D0(d0), .D1(d1), .S(s), .Y(y)
    );

    // Teste do módulo mux_4_para_1
    wire d0_4, d1_4, d2_4, d3_4;
    wire [1:0] s_4;
    wire y_4;
    mux_4_para_1 U_TESTE_MUX4 (
        .D0(d0_4), .D1(d1_4), .D2(d2_4), .D3(d3_4),
        .S(s_4), .Y(y_4)
    );

    // Teste do módulo mux_2_para_1_8bits
    wire [7:0] d0_8, d1_8, y_8;
    wire s_8;
    mux_2_para_1_8bits U_TESTE_MUX2_8 (
        .D0(d0_8), .D1(d1_8), .S(s_8), .Y(y_8)
    );

    // Teste do módulo mux_4_para_1_4bits
    wire [3:0] d0_4_4, d1_4_4, d2_4_4, d3_4_4;
    wire [1:0] s_4_4;
    wire [3:0] y_4_4;
    mux_4_para_1_4bits U_TESTE_MUX4_4 (
        .D0(d0_4_4), .D1(d1_4_4), .D2(d2_4_4), .D3(d3_4_4),
        .S(s_4_4), .Y(y_4_4)
    );

    // Teste do módulo mux_4_para_1_7bits
    wire [6:0] d0_7, d1_7, d2_7, d3_7;
    wire [1:0] s_7;
    wire [6:0] y_7;
    mux_4_para_1_7bits U_TESTE_MUX4_7 (
        .D0(d0_7), .D1(d1_7), .D2(d2_7), .D3(d3_7),
        .S(s_7), .Y(y_7)
    );

    // Teste do módulo unidade_and_8bits
    wire [7:0] a_and, b_and, s_and;
    unidade_and_8bits U_TESTE_AND (
        .a(a_and), .b(b_and), .s(s_and)
    );

    // Teste do módulo unidade_or_8bits
    wire [7:0] a_or, b_or, s_or;
    unidade_or_8bits U_TESTE_OR (
        .a(a_or), .b(b_or), .s(s_or)
    );

    // Teste do módulo unidade_xor_8bits
    wire [7:0] a_xor, b_xor, s_xor;
    unidade_xor_8bits U_TESTE_XOR (
        .a(a_xor), .b(b_xor), .s(s_xor)
    );

    // Teste do módulo somador_8bits
    wire [7:0] a_soma, b_soma, s_soma;
    wire cin_soma, cout_soma, ov_soma;
    somador_8bits U_TESTE_SOMA (
        .a(a_soma), .b(b_soma), .cin(cin_soma),
        .s(s_soma), .cout(cout_soma), .ov(ov_soma)
    );

    // Teste do módulo subtrator_8bits
    wire [7:0] a_sub, b_sub, s_sub;
    wire cout_sub, ov_sub, neg_sub;
    subtrator_8bits U_TESTE_SUB (
        .a(a_sub), .b(b_sub), .s(s_sub),
        .cout(cout_sub), .ov(ov_sub), .neg(neg_sub)
    );

    // Teste do módulo multiplicador_8bits
    wire [7:0] a_mult, b_mult, p_mult;
    wire ov_mult;
    multiplicador_8bits U_TESTE_MULT (
        .a(a_mult), .b(b_mult), .p(p_mult), .ov(ov_mult)
    );

    // Teste do módulo divisor_8bits
    wire [7:0] a_div, b_div, q_div, r_div;
    wire div_zero_div, ov_div;
    divisor_8bits U_TESTE_DIV (
        .a(a_div), .b(b_div), .q(q_div), .r(r_div),
        .div_zero(div_zero_div), .ov(ov_div)
    );

    // Teste do módulo ula_8bits
    wire [7:0] a_ula, b_ula, resultado_ula;
    wire [2:0] operacao_ula;
    wire overflow_ula, zero_ula, carry_out_ula, erro_ula;
    ula_8bits U_TESTE_ULA (
        .a(a_ula), .b(b_ula), .operacao(operacao_ula),
        .resultado(resultado_ula), .overflow(overflow_ula),
        .zero(zero_ula), .carry_out(carry_out_ula), .erro(erro_ula)
    );

    // Teste do módulo conversor_bases
    wire [7:0] valor_binario;
    wire [1:0] base_selecionada;
    wire [6:0] HEX0_conv, HEX1_conv, HEX2_conv, HEX3_conv;
    conversor_bases U_TESTE_CONV (
        .valor_binario(valor_binario), .base_selecionada(base_selecionada),
        .HEX0(HEX0_conv), .HEX1(HEX1_conv), .HEX2(HEX2_conv), .HEX3(HEX3_conv)
    );

    // Teste do módulo base_7seg
    wire [1:0] seletor_base;
    wire [6:0] HEX5_base;
    base_7seg U_TESTE_BASE (
        .seletor(seletor_base), .HEX5(HEX5_base)
    );

    // Teste do módulo sistema_rpn
    wire [7:0] entrada_rpn;
    wire [2:0] operacao_rpn;
    wire entrada_numero_rpn, entrada_operacao_rpn, executar_rpn;
    wire [7:0] resultado_rpn, display_a_rpn, display_b_rpn;
    wire pilha_vazia_rpn, pilha_cheia_rpn;
    sistema_rpn U_TESTE_RPN (
        .entrada(entrada_rpn), .operacao(operacao_rpn),
        .entrada_numero(entrada_numero_rpn), .entrada_operacao(entrada_operacao_rpn),
        .executar(executar_rpn), .resultado(resultado_rpn),
        .display_a(display_a_rpn), .display_b(display_b_rpn),
        .pilha_vazia(pilha_vazia_rpn), .pilha_cheia(pilha_cheia_rpn)
    );

    // Teste do módulo calculadora_rpn
    wire [9:0] SW_calc;
    wire [1:0] KEY_calc;
    wire CLOCK_50_calc;
    wire [6:0] HEX0_calc, HEX1_calc, HEX2_calc, HEX3_calc, HEX4_calc, HEX5_calc;
    wire [9:0] LEDR_calc;
    calculadora_rpn U_TESTE_CALC (
        .SW(SW_calc), .KEY(KEY_calc), .CLOCK_50(CLOCK_50_calc),
        .HEX0(HEX0_calc), .HEX1(HEX1_calc), .HEX2(HEX2_calc), .HEX3(HEX3_calc),
        .HEX4(HEX4_calc), .HEX5(HEX5_calc), .LEDR(LEDR_calc)
    );

endmodule
