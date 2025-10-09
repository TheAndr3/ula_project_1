// Arquivo de teste completo para verificar se todos os módulos compilam
// Este arquivo não será usado no projeto final

module teste_completo;

    // Teste do flip-flop D
    wire d_ff, clk_ff, rst_ff, q_ff, qn_ff;
    flip_flop_d U_TESTE_FF (
        .D(d_ff), .clk(clk_ff), .rst(rst_ff), .Q(q_ff), .Qn(qn_ff)
    );

    // Teste do registrador de 8 bits
    wire [7:0] d_reg, q_reg, qn_reg;
    wire clk_reg, rst_reg, load_reg;
    registrador_8bits U_TESTE_REG (
        .D(d_reg), .clk(clk_reg), .rst(rst_reg), .load(load_reg),
        .Q(q_reg), .Qn(qn_reg)
    );

    // Teste do contador de 2 bits
    wire clk_cnt, rst_cnt, inc_cnt, dec_cnt;
    wire [1:0] q_cnt;
    wire empty_cnt, full_cnt;
    contador_2bits U_TESTE_CNT (
        .clk(clk_cnt), .rst(rst_cnt), .inc(inc_cnt), .dec(dec_cnt),
        .Q(q_cnt), .empty(empty_cnt), .full(full_cnt)
    );

    // Teste do decodificador 2:4
    wire [1:0] a_dec;
    wire [3:0] y_dec;
    decodificador_2_4 U_TESTE_DEC (
        .A(a_dec), .Y(y_dec)
    );

    // Teste do controle de clock
    wire clk_in_ctrl, rst_ctrl, entrada_numero_ctrl, entrada_operacao_ctrl, executar_ctrl;
    wire clk_out_ctrl, clk_numero_ctrl, clk_operacao_ctrl, clk_execucao_ctrl;
    controle_clock U_TESTE_CTRL (
        .clk_in(clk_in_ctrl), .rst(rst_ctrl), .entrada_numero(entrada_numero_ctrl),
        .entrada_operacao(entrada_operacao_ctrl), .executar(executar_ctrl),
        .clk_out(clk_out_ctrl), .clk_numero(clk_numero_ctrl),
        .clk_operacao(clk_operacao_ctrl), .clk_execucao(clk_execucao_ctrl)
    );

    // Teste da pilha RPN
    wire [7:0] entrada_pilha;
    wire [2:0] operacao_pilha;
    wire entrada_numero_pilha, entrada_operacao_pilha, executar_pilha;
    wire clk_pilha, rst_pilha;
    wire [7:0] resultado_pilha, display_a_pilha, display_b_pilha;
    wire pilha_vazia_pilha, pilha_cheia_pilha, resultado_ula_pilha;
    pilha_rpn U_TESTE_PILHA (
        .entrada(entrada_pilha), .operacao(operacao_pilha),
        .entrada_numero(entrada_numero_pilha), .entrada_operacao(entrada_operacao_pilha),
        .executar(executar_pilha), .clk(clk_pilha), .rst(rst_pilha),
        .resultado(resultado_pilha), .display_a(display_a_pilha), .display_b(display_b_pilha),
        .pilha_vazia(pilha_vazia_pilha), .pilha_cheia(pilha_cheia_pilha),
        .resultado_ula(resultado_ula_pilha)
    );

    // Teste da calculadora RPN completa
    wire [9:0] SW_calc;
    wire [1:0] KEY_calc;
    wire CLOCK_50_calc;
    wire [6:0] HEX0_calc, HEX1_calc, HEX2_calc, HEX3_calc, HEX4_calc, HEX5_calc;
    wire [9:0] LEDR_calc;
    calculadora_rpn_completa U_TESTE_CALC_COMPLETA (
        .SW(SW_calc), .KEY(KEY_calc), .CLOCK_50(CLOCK_50_calc),
        .HEX0(HEX0_calc), .HEX1(HEX1_calc), .HEX2(HEX2_calc), .HEX3(HEX3_calc),
        .HEX4(HEX4_calc), .HEX5(HEX5_calc), .LEDR(LEDR_calc)
    );

endmodule
