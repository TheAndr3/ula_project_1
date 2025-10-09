// Sistema de pilha RPN simplificado - APENAS 2 NÍVEIS
// Implementação puramente estrutural
// Otimizado para operações simples: A op B

module pilha_rpn (
    input  wire [7:0] entrada,           // Entrada de 8 bits
    input  wire [2:0] operacao,          // Código da operação
    input  wire entrada_numero,          // Sinal para entrada de número
    input  wire entrada_operacao,        // Sinal para entrada de operação (não usado)
    input  wire executar,                // Sinal para executar operação
    input  wire clk,                     // Clock
    input  wire rst,                     // Reset
    output wire [7:0] resultado,         // Resultado da operação
    output wire [7:0] display_a,         // Valor do registrador A para display
    output wire [7:0] display_b,         // Valor do registrador B para display
    output wire pilha_vazia,             // Flag indicando pilha vazia
    output wire pilha_cheia,             // Flag indicando pilha cheia
    output wire [7:0] resultado_ula,     // Resultado da ULA
    output wire overflow,                // Flag de overflow da ULA
    output wire zero,                    // Flag de zero da ULA
    output wire carry_out,               // Flag de carry out da ULA
    output wire erro                     // Flag de erro da ULA
);

    // ========================================
    // PILHA SIMPLIFICADA: APENAS 2 REGISTRADORES
    // ========================================
    // reg0 = Topo da pilha (operando A)
    // reg1 = Segundo nível (operando B)
    
    wire [7:0] reg0, reg1;               // 2 registradores de 8 bits
    wire [7:0] reg0_next, reg1_next;     // Próximos valores
    
    // Controle da pilha
    wire estado_pilha;                   // 1 bit: 0=vazio/1elem, 1=2elem
    wire load_reg0, load_reg1;           // Sinais de carga
    
    // Constantes
    wire gnd, vcc;
    wire [7:0] gnd_bus;
    
    // Gerar constantes
    and U_GND (gnd, entrada[0], entrada[0]);
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

    // ========================================
    // CONTADOR DE 1 BIT: Controla 0, 1 ou 2 elementos
    // ========================================
    contador_1bit U_CONTADOR (
        .clk(clk),
        .rst(rst),
        .inc(entrada_numero),      // Incrementa ao empilhar
        .dec(executar),            // Decrementa ao executar
        .Q(estado_pilha),          // 0 ou 1
        .empty(pilha_vazia),       // 1 quando vazio
        .full(pilha_cheia)         // 1 quando tem 2 elementos
    );

    // ========================================
    // LÓGICA DE CONTROLE DOS REGISTRADORES
    // ========================================
    
    // Load reg0: sempre que empilhar OU executar
    or U_LOAD_REG0 (load_reg0, entrada_numero, executar);
    
    // Load reg1: apenas quando empilhar E pilha já tem 1 elemento
    and U_LOAD_REG1 (load_reg1, entrada_numero, estado_pilha);

    // ========================================
    // LÓGICA DE DESLOCAMENTO SIMPLIFICADA
    // ========================================
    
    // reg0_next (topo):
    // - Se executar: recebe resultado_ula
    // - Se empilhar: recebe entrada
    mux_2_para_1_8bits U_MUX_REG0 (
        .D0(entrada),           // Empilhar número
        .D1(resultado_ula),     // Resultado da operação
        .S(executar),
        .Y(reg0_next)
    );
    
    // reg1_next (segundo nível):
    // - Se empilhar: recebe reg0 antigo (deslocamento)
    // - Se executar: recebe 0 (limpa)
    mux_2_para_1_8bits U_MUX_REG1 (
        .D0(reg0),              // Deslocamento ao empilhar
        .D1(gnd_bus),           // Limpar ao executar
        .S(executar),
        .Y(reg1_next)
    );

    // ========================================
    // REGISTRADORES DE 8 BITS
    // ========================================
    
    registrador_8bits U_REG0 (
        .D(reg0_next),
        .clk(clk),
        .rst(rst),
        .load(load_reg0),
        .Q(reg0),
        .Qn()
    );
    
    registrador_8bits U_REG1 (
        .D(reg1_next),
        .clk(clk),
        .rst(rst),
        .load(load_reg1),
        .Q(reg1),
        .Qn()
    );

    // ========================================
    // SAÍDAS PARA DISPLAY (Operandos A e B)
    // ========================================
    
    // A = reg0 (topo da pilha)
    buf U_DISP_A0 (display_a[0], reg0[0]);
    buf U_DISP_A1 (display_a[1], reg0[1]);
    buf U_DISP_A2 (display_a[2], reg0[2]);
    buf U_DISP_A3 (display_a[3], reg0[3]);
    buf U_DISP_A4 (display_a[4], reg0[4]);
    buf U_DISP_A5 (display_a[5], reg0[5]);
    buf U_DISP_A6 (display_a[6], reg0[6]);
    buf U_DISP_A7 (display_a[7], reg0[7]);
    
    // B = reg1 (segundo da pilha)
    buf U_DISP_B0 (display_b[0], reg1[0]);
    buf U_DISP_B1 (display_b[1], reg1[1]);
    buf U_DISP_B2 (display_b[2], reg1[2]);
    buf U_DISP_B3 (display_b[3], reg1[3]);
    buf U_DISP_B4 (display_b[4], reg1[4]);
    buf U_DISP_B5 (display_b[5], reg1[5]);
    buf U_DISP_B6 (display_b[6], reg1[6]);
    buf U_DISP_B7 (display_b[7], reg1[7]);

    // ========================================
    // ULA DE 8 BITS
    // ========================================
    
    ula_8bits U_ULA (
        .a(reg0),              // Operando A (topo)
        .b(reg1),              // Operando B (segundo)
        .operacao(operacao),
        .clk(clk),
        .rst(rst),
        .resultado(resultado_ula),
        .overflow(overflow),
        .zero(zero),
        .carry_out(carry_out),
        .erro(erro)
    );

    // ========================================
    // RESULTADO FINAL
    // ========================================
    
    buf U_RESULT0 (resultado[0], resultado_ula[0]);
    buf U_RESULT1 (resultado[1], resultado_ula[1]);
    buf U_RESULT2 (resultado[2], resultado_ula[2]);
    buf U_RESULT3 (resultado[3], resultado_ula[3]);
    buf U_RESULT4 (resultado[4], resultado_ula[4]);
    buf U_RESULT5 (resultado[5], resultado_ula[5]);
    buf U_RESULT6 (resultado[6], resultado_ula[6]);
    buf U_RESULT7 (resultado[7], resultado_ula[7]);

endmodule
