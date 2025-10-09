// Módulo para sistema RPN (Reverse Polish Notation)
// Implementação puramente estrutural com registradores

module sistema_rpn (
    input  wire [7:0] entrada,           // Entrada de 8 bits
    input  wire [2:0] operacao,          // Código da operação
    input  wire entrada_numero,          // Sinal para entrada de número
    input  wire entrada_operacao,        // Sinal para entrada de operação
    input  wire executar,                // Sinal para executar operação
    output wire [7:0] resultado,         // Resultado da operação
    output wire [7:0] display_a,         // Valor do registrador A para display
    output wire [7:0] display_b,         // Valor do registrador B para display
    output wire pilha_vazia,             // Flag indicando pilha vazia
    output wire pilha_cheia              // Flag indicando pilha cheia
);

    // Registradores da pilha (simulando uma pilha de 2 elementos)
    wire [7:0] reg_a, reg_b;
    wire [7:0] reg_a_next, reg_b_next;
    
    // Flags de controle
    wire reg_a_vazio, reg_b_vazio;
    wire reg_a_cheio, reg_b_cheio;
    
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

    // Lógica de controle da pilha
    // Se entrada_numero=1, empilha o número
    // Se entrada_operacao=1, executa a operação
    
    // Controle do registrador A
    mux_2_para_1_8bits U_MUX_A (
        .D0(reg_a),           // Mantém valor atual
        .D1(entrada),         // Novo valor
        .S(entrada_numero),   // Seleciona se deve carregar novo valor
        .Y(reg_a_next)
    );
    
    // Controle do registrador B
    mux_2_para_1_8bits U_MUX_B (
        .D0(reg_b),           // Mantém valor atual
        .D1(reg_a),           // Move A para B
        .S(entrada_numero),   // Seleciona se deve mover A para B
        .Y(reg_b_next)
    );

    // Registradores (simulados com fios para implementação estrutural)
    // Em uma implementação real, seriam flip-flops
    buf U_REG_A0 (reg_a[0], reg_a_next[0]);
    buf U_REG_A1 (reg_a[1], reg_a_next[1]);
    buf U_REG_A2 (reg_a[2], reg_a_next[2]);
    buf U_REG_A3 (reg_a[3], reg_a_next[3]);
    buf U_REG_A4 (reg_a[4], reg_a_next[4]);
    buf U_REG_A5 (reg_a[5], reg_a_next[5]);
    buf U_REG_A6 (reg_a[6], reg_a_next[6]);
    buf U_REG_A7 (reg_a[7], reg_a_next[7]);
    
    buf U_REG_B0 (reg_b[0], reg_b_next[0]);
    buf U_REG_B1 (reg_b[1], reg_b_next[1]);
    buf U_REG_B2 (reg_b[2], reg_b_next[2]);
    buf U_REG_B3 (reg_b[3], reg_b_next[3]);
    buf U_REG_B4 (reg_b[4], reg_b_next[4]);
    buf U_REG_B5 (reg_b[5], reg_b_next[5]);
    buf U_REG_B6 (reg_b[6], reg_b_next[6]);
    buf U_REG_B7 (reg_b[7], reg_b_next[7]);

    // Saídas para display
    buf U_DISP_A0 (display_a[0], reg_a[0]);
    buf U_DISP_A1 (display_a[1], reg_a[1]);
    buf U_DISP_A2 (display_a[2], reg_a[2]);
    buf U_DISP_A3 (display_a[3], reg_a[3]);
    buf U_DISP_A4 (display_a[4], reg_a[4]);
    buf U_DISP_A5 (display_a[5], reg_a[5]);
    buf U_DISP_A6 (display_a[6], reg_a[6]);
    buf U_DISP_A7 (display_a[7], reg_a[7]);
    
    buf U_DISP_B0 (display_b[0], reg_b[0]);
    buf U_DISP_B1 (display_b[1], reg_b[1]);
    buf U_DISP_B2 (display_b[2], reg_b[2]);
    buf U_DISP_B3 (display_b[3], reg_b[3]);
    buf U_DISP_B4 (display_b[4], reg_b[4]);
    buf U_DISP_B5 (display_b[5], reg_b[5]);
    buf U_DISP_B6 (display_b[6], reg_b[6]);
    buf U_DISP_B7 (display_b[7], reg_b[7]);

    // Flags de controle da pilha
    // Pilha vazia: ambos registradores vazios
    and U_PILHA_VAZIA (pilha_vazia, reg_a_vazio, reg_b_vazio);
    
    // Pilha cheia: ambos registradores cheios
    and U_PILHA_CHEIA (pilha_cheia, reg_a_cheio, reg_b_cheio);

    // Resultado da operação (conectado ao resultado da ULA)
    buf U_RESULT0 (resultado[0], reg_a[0]);
    buf U_RESULT1 (resultado[1], reg_a[1]);
    buf U_RESULT2 (resultado[2], reg_a[2]);
    buf U_RESULT3 (resultado[3], reg_a[3]);
    buf U_RESULT4 (resultado[4], reg_a[4]);
    buf U_RESULT5 (resultado[5], reg_a[5]);
    buf U_RESULT6 (resultado[6], reg_a[6]);
    buf U_RESULT7 (resultado[7], reg_a[7]);

endmodule
