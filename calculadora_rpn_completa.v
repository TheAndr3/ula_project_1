// Módulo principal da calculadora RPN com sistema de clock real
// Implementação puramente estrutural

module calculadora_rpn_completa (
    // Entradas físicas da placa
    input  wire [9:0] SW,           // Chaves da placa
    input  wire [1:0] KEY,          // Botões da placa
    input  wire CLOCK_50,           // Clock da placa (50MHz)
    
    // Saídas físicas da placa
    output wire [6:0] HEX0,         // Display unidade
    output wire [6:0] HEX1,         // Display dezena
    output wire [6:0] HEX2,         // Display centena
    output wire [6:0] HEX3,         // Display milhar
    output wire [6:0] HEX4,         // Display operação
    output wire [6:0] HEX5,         // Display base
    output wire [9:0] LEDR          // LEDs indicadores
);

    // Mapeamento de entradas
    wire [7:0] entrada_numero = SW[7:0];        // Entrada de número de 8 bits
    wire [2:0] operacao = {KEY[1], KEY[0], SW[8]}; // Código da operação
    wire [1:0] base_exibicao = {SW[9], 1'b0};    // Base de exibição (00=dec, 01=hex, 10=oct)
    wire entrada_num = KEY[0];                   // Botão para entrada de número
    wire entrada_op = KEY[1];                    // Botão para entrada de operação
    wire executar = SW[9];                       // Chave para executar operação

    // Fios intermediários
    wire [7:0] resultado_pilha;
    wire [7:0] display_a, display_b;
    wire [7:0] valor_exibicao;
    wire [7:0] resultado_ula;
    
    // Flags
    wire pilha_vazia, pilha_cheia;
    wire overflow, zero, carry_out, erro;
    
    // Clock e controle
    wire clk_sync, clk_numero, clk_operacao, clk_execucao;
    wire rst;
    
    // Constantes
    wire gnd, vcc;
    wire [7:0] gnd_bus;
    
    // Gerar constantes
    and U_GND (gnd, entrada_numero[0], entrada_numero[0]);
    not U_VCC_NOT (vcc, gnd);
    
    // Atribuir GND ao barramento
    buf U_GND_BUF0 (gnd_bus[0], gnd);
    buf U_GND_BUF1 (gnd_bus[1], gnd);
    buf U_GND_BUF2 (gnd_bus[2], gnd);
    buf U_GND_BUF3 (gnd_bus[3], gnd);
    buf U_GND_BUF4 (gnd_bus[4], gnd);
    buf U_GND_BUF5 (gnd_bus[5], gnd);
    buf U_GND_BUF6 (gnd_bus[6], gnd);
    buf U_GND_BUF7 (gnd_bus[7], gnd);

    // Reset (ativo baixo)
    not U_RST (rst, gnd);

    // Controle de clock
    controle_clock U_CONTROLE_CLK (
        .clk_in(CLOCK_50),
        .rst(rst),
        .entrada_numero(entrada_num),
        .entrada_operacao(entrada_op),
        .executar(executar),
        .clk_out(clk_sync),
        .clk_numero(clk_numero),
        .clk_operacao(clk_operacao),
        .clk_execucao(clk_execucao)
    );

    // Sistema de pilha RPN
    pilha_rpn U_PILHA (
        .entrada(entrada_numero),
        .operacao(operacao),
        .entrada_numero(entrada_num),
        .entrada_operacao(entrada_op),
        .executar(executar),
        .clk(clk_sync),
        .rst(rst),
        .resultado(resultado_pilha),
        .display_a(display_a),
        .display_b(display_b),
        .pilha_vazia(pilha_vazia),
        .pilha_cheia(pilha_cheia),
        .resultado_ula(resultado_ula)
    );

    // Seleção do valor para exibição
    mux_2_para_1_8bits U_MUX_EXIBICAO (
        .D0(display_a),         // Mostrar registrador A
        .D1(resultado_ula),     // Mostrar resultado da ULA
        .S(executar),           // Selecionar baseado na execução
        .Y(valor_exibicao)
    );

    // Conversor de bases
    conversor_bases U_CONVERSOR (
        .valor_binario(valor_exibicao),
        .base_selecionada(base_exibicao),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3)
    );

    // Display da operação
    operacao_7seg U_OP_DISPLAY (
        .seletor(operacao),
        .HEX5(HEX4)
    );

    // Display da base
    base_7seg U_BASE_DISPLAY (
        .seletor(base_exibicao),
        .HEX5(HEX5)
    );

    // LEDs indicadores
    buf U_LED0 (LEDR[0], zero);
    buf U_LED1 (LEDR[1], overflow);
    buf U_LED2 (LEDR[2], carry_out);
    buf U_LED3 (LEDR[3], erro);
    buf U_LED4 (LEDR[4], pilha_vazia);
    buf U_LED5 (LEDR[5], pilha_cheia);
    buf U_LED6 (LEDR[6], gnd);
    buf U_LED7 (LEDR[7], gnd);
    buf U_LED8 (LEDR[8], gnd);
    buf U_LED9 (LEDR[9], gnd);

endmodule
