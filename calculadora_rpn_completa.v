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
    wire [7:0] entrada_numero = SW[7:0];        // Entrada de número de 8 bits (compartilhada)
    wire [7:0] operacao = SW[7:0];              // Código da operação de 8 bits (compartilhada)
    wire [1:0] base_exibicao = {SW[9], SW[8]};  // Base de exibição (00=dec, 01=hex, 10=oct)
    wire entrada_botao = KEY[0];                 // Botão para entrada (A, B ou operação)
    wire reset_global = KEY[1];                  // Reset global
    
    // Contador de controle de entrada
    wire [1:0] contador_entrada;                 // Contador: 00=A, 01=B, 10=op, 11=reset
    wire enable_contador;                        // Enable do contador
    
    // Sinais de controle de entrada
    wire entrada_numero_a, entrada_numero_b, entrada_operacao, executar_operacao;
    
    // Código interno da operação (3 bits)
    wire [2:0] codigo_operacao_interno;

    // Fios intermediários
    wire [7:0] resultado_pilha;
    wire [7:0] display_a, display_b;
    wire [7:0] valor_exibicao;
    wire [7:0] resultado_ula;
    wire [7:0] resultado_memoria;
    wire [7:0] valor_memoria;
    
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
    
    // Enable do contador: entrada_botao pressionado
    buf U_ENABLE_CONTADOR (enable_contador, entrada_botao);

    // Contador de controle de entrada
    contador_2bits U_CONTADOR_ENTRADA (
        .clk(CLOCK_50),
        .rst(reset_global),
        .enable(enable_contador),
        .count(contador_entrada)
    );

    // Decodificador de operações
    decodificador_operacoes U_DECOD_OPERACOES (
        .operacao_8bits(operacao),
        .codigo_operacao(codigo_operacao_interno)
    );

    // Controle de entrada baseado no contador
    controle_entrada U_CONTROLE_ENTRADA (
        .entrada_numero(entrada_numero),
        .operacao(codigo_operacao_interno),
        .contador_entrada(contador_entrada),
        .entrada_botao(entrada_botao),
        .entrada_numero_a(entrada_numero_a),
        .entrada_numero_b(entrada_numero_b),
        .entrada_operacao(entrada_operacao),
        .executar_operacao(executar_operacao)
    );

    // Controle de clock
    controle_clock U_CONTROLE_CLK (
        .clk_in(CLOCK_50),
        .rst(rst),
        .entrada_numero(entrada_botao),
        .entrada_operacao(entrada_botao),
        .executar(gnd),
        .clk_out(clk_sync),
        .clk_numero(clk_numero),
        .clk_operacao(clk_operacao),
        .clk_execucao(clk_execucao)
    );

    // Sistema de pilha RPN
    pilha_rpn U_PILHA (
        .entrada(entrada_numero),
        .operacao(codigo_operacao_interno),
        .entrada_numero(entrada_numero_a),
        .entrada_operacao(entrada_operacao),
        .executar(executar_operacao),
        .clk(clk_sync),
        .rst(rst),
        .resultado(resultado_pilha),
        .display_a(display_a),
        .display_b(display_b),
        .pilha_vazia(pilha_vazia),
        .pilha_cheia(pilha_cheia),
        .resultado_ula(resultado_ula),
        .overflow(overflow),
        .zero(zero),
        .carry_out(carry_out),
        .erro(erro)
    );

    // Sistema de controle de memória
    controle_memoria U_CONTROLE_MEM (
        .operacao(codigo_operacao_interno),
        .resultado_ula(resultado_ula),
        .executar(executar_operacao),
        .clk(clk_sync),
        .rst(rst),
        .carregar_memoria(),
        .valor_memoria(valor_memoria),
        .resultado_final(resultado_memoria)
    );

    // Seleção do valor para exibição - sempre mostrar resultado da ULA
    buf U_VALOR_EXIBICAO0 (valor_exibicao[0], resultado_ula[0]);
    buf U_VALOR_EXIBICAO1 (valor_exibicao[1], resultado_ula[1]);
    buf U_VALOR_EXIBICAO2 (valor_exibicao[2], resultado_ula[2]);
    buf U_VALOR_EXIBICAO3 (valor_exibicao[3], resultado_ula[3]);
    buf U_VALOR_EXIBICAO4 (valor_exibicao[4], resultado_ula[4]);
    buf U_VALOR_EXIBICAO5 (valor_exibicao[5], resultado_ula[5]);
    buf U_VALOR_EXIBICAO6 (valor_exibicao[6], resultado_ula[6]);
    buf U_VALOR_EXIBICAO7 (valor_exibicao[7], resultado_ula[7]);

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
        .seletor(codigo_operacao_interno),
        .HEX5(HEX4)
    );

    // Display da base
    base_7seg U_BASE_DISPLAY (
        .seletor(base_exibicao),
        .HEX5(HEX5)
    );

    // LEDs indicadores
    buf U_LED0 (LEDR[0], contador_entrada[0]);  // Bit menos significativo do contador
    buf U_LED1 (LEDR[1], contador_entrada[1]);  // Bit mais significativo do contador
    buf U_LED2 (LEDR[2], zero);
    buf U_LED3 (LEDR[3], overflow);
    buf U_LED4 (LEDR[4], carry_out);
    buf U_LED5 (LEDR[5], erro);
    buf U_LED6 (LEDR[6], pilha_vazia);
    buf U_LED7 (LEDR[7], pilha_cheia);
    buf U_LED8 (LEDR[8], entrada_numero_a);     // Indica entrada do número A
    buf U_LED9 (LEDR[9], entrada_operacao);     // Indica entrada da operação

endmodule
