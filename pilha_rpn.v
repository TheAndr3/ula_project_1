// Sistema de pilha RPN usando registradores reais
// Implementação puramente estrutural

module pilha_rpn (
    input  wire [7:0] entrada,           // Entrada de 8 bits
    input  wire [2:0] operacao,          // Código da operação
    input  wire entrada_numero,          // Sinal para entrada de número
    input  wire entrada_operacao,        // Sinal para entrada de operação
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
    output wire erro                     // Flag de erro da ULa
);

    // Registradores da pilha (4 registradores de 8 bits)
    wire [7:0] reg0, reg1, reg2, reg3;
    wire [7:0] reg0_next, reg1_next, reg2_next, reg3_next;
    
    // Controle da pilha
    wire [1:0] estado_pilha;
    wire [3:0] reg_select;
    wire [3:0] reg_load;
    
    // Flags de controle
    wire reg0_empty, reg1_empty, reg2_empty, reg3_empty;
    wire reg0_full, reg1_full, reg2_full, reg3_full;
    
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

    // Contador de estado da pilha
    contador_2bits U_CONTADOR (
        .clk(clk),
        .rst(rst),
        .inc(entrada_numero),
        .dec(executar),
        .Q(estado_pilha),
        .empty(pilha_vazia),
        .full(pilha_cheia)
    );

    // Decodificador para seleção de registradores
    decodificador_2_4 U_DECOD (
        .A(estado_pilha),
        .Y(reg_select)
    );

    // Lógica de carga dos registradores
    // Carregar quando entrada_numero = 1 OU executar = 1
    wire load_trigger;
    or U_LOAD_TRIGGER (load_trigger, entrada_numero, executar);
    
    buf U_LOAD0 (reg_load[0], load_trigger);
    buf U_LOAD1 (reg_load[1], load_trigger);
    buf U_LOAD2 (reg_load[2], load_trigger);
    buf U_LOAD3 (reg_load[3], load_trigger);

    // Lógica de deslocamento da pilha
    // Quando entrada_numero = 1: reg3 <- reg2, reg2 <- reg1, reg1 <- reg0, reg0 <- entrada
    // Quando executar = 1: reg0 <- resultado_ula, reg1 <- reg2, reg2 <- reg3, reg3 <- 0
    wire [7:0] reg0_shift, reg1_shift, reg2_shift, reg3_shift;
    wire [7:0] reg0_input;
    
    // reg0: Selecionar entre entrada (push número) e resultado_ula (push resultado)
    mux_2_para_1_8bits U_MUX_REG0_INPUT (
        .D0(entrada),           // Entrada de número
        .D1(resultado_ula),     // Resultado da ULA
        .S(executar),           // Quando executar=1, usar resultado
        .Y(reg0_input)
    );
    
    // Deslocamento reg0
    buf U_SHIFT0_0 (reg0_shift[0], reg0_input[0]);
    buf U_SHIFT0_1 (reg0_shift[1], reg0_input[1]);
    buf U_SHIFT0_2 (reg0_shift[2], reg0_input[2]);
    buf U_SHIFT0_3 (reg0_shift[3], reg0_input[3]);
    buf U_SHIFT0_4 (reg0_shift[4], reg0_input[4]);
    buf U_SHIFT0_5 (reg0_shift[5], reg0_input[5]);
    buf U_SHIFT0_6 (reg0_shift[6], reg0_input[6]);
    buf U_SHIFT0_7 (reg0_shift[7], reg0_input[7]);
    
    // reg1: Quando entrada_numero, recebe reg0; quando executar, recebe reg2 (pop)
    wire [7:0] reg1_input;
    mux_2_para_1_8bits U_MUX_REG1_INPUT (
        .D0(reg0),              // Push número: recebe reg0
        .D1(reg2),              // Executar: recebe reg2 (pop)
        .S(executar),
        .Y(reg1_input)
    );
    
    buf U_SHIFT1_0 (reg1_shift[0], reg1_input[0]);
    buf U_SHIFT1_1 (reg1_shift[1], reg1_input[1]);
    buf U_SHIFT1_2 (reg1_shift[2], reg1_input[2]);
    buf U_SHIFT1_3 (reg1_shift[3], reg1_input[3]);
    buf U_SHIFT1_4 (reg1_shift[4], reg1_input[4]);
    buf U_SHIFT1_5 (reg1_shift[5], reg1_input[5]);
    buf U_SHIFT1_6 (reg1_shift[6], reg1_input[6]);
    buf U_SHIFT1_7 (reg1_shift[7], reg1_input[7]);
    
    // reg2: Quando entrada_numero, recebe reg1; quando executar, recebe reg3 (pop)
    wire [7:0] reg2_input;
    mux_2_para_1_8bits U_MUX_REG2_INPUT (
        .D0(reg1),              // Push número: recebe reg1
        .D1(reg3),              // Executar: recebe reg3 (pop)
        .S(executar),
        .Y(reg2_input)
    );
    
    buf U_SHIFT2_0 (reg2_shift[0], reg2_input[0]);
    buf U_SHIFT2_1 (reg2_shift[1], reg2_input[1]);
    buf U_SHIFT2_2 (reg2_shift[2], reg2_input[2]);
    buf U_SHIFT2_3 (reg2_shift[3], reg2_input[3]);
    buf U_SHIFT2_4 (reg2_shift[4], reg2_input[4]);
    buf U_SHIFT2_5 (reg2_shift[5], reg2_input[5]);
    buf U_SHIFT2_6 (reg2_shift[6], reg2_input[6]);
    buf U_SHIFT2_7 (reg2_shift[7], reg2_input[7]);
    
    // reg3: Quando entrada_numero, recebe reg2; quando executar, recebe 0 (limpa)
    wire [7:0] reg3_input;
    mux_2_para_1_8bits U_MUX_REG3_INPUT (
        .D0(reg2),              // Push número: recebe reg2
        .D1(gnd_bus),           // Executar: recebe 0 (limpa)
        .S(executar),
        .Y(reg3_input)
    );
    
    buf U_SHIFT3_0 (reg3_shift[0], reg3_input[0]);
    buf U_SHIFT3_1 (reg3_shift[1], reg3_input[1]);
    buf U_SHIFT3_2 (reg3_shift[2], reg3_input[2]);
    buf U_SHIFT3_3 (reg3_shift[3], reg3_input[3]);
    buf U_SHIFT3_4 (reg3_shift[4], reg3_input[4]);
    buf U_SHIFT3_5 (reg3_shift[5], reg3_input[5]);
    buf U_SHIFT3_6 (reg3_shift[6], reg3_input[6]);
    buf U_SHIFT3_7 (reg3_shift[7], reg3_input[7]);

    // Registradores
    registrador_8bits U_REG0 (
        .D(reg0_shift),
        .clk(clk),
        .rst(rst),
        .load(reg_load[0]),
        .Q(reg0),
        .Qn()
    );
    
    registrador_8bits U_REG1 (
        .D(reg1_shift),
        .clk(clk),
        .rst(rst),
        .load(reg_load[1]),
        .Q(reg1),
        .Qn()
    );
    
    registrador_8bits U_REG2 (
        .D(reg2_shift),
        .clk(clk),
        .rst(rst),
        .load(reg_load[2]),
        .Q(reg2),
        .Qn()
    );
    
    registrador_8bits U_REG3 (
        .D(reg3_shift),
        .clk(clk),
        .rst(rst),
        .load(reg_load[3]),
        .Q(reg3),
        .Qn()
    );

    // Seleção dos operandos para a ULA
    // A = reg0 (topo da pilha)
    // B = reg1 (segundo da pilha)
    buf U_DISP_A0 (display_a[0], reg0[0]);
    buf U_DISP_A1 (display_a[1], reg0[1]);
    buf U_DISP_A2 (display_a[2], reg0[2]);
    buf U_DISP_A3 (display_a[3], reg0[3]);
    buf U_DISP_A4 (display_a[4], reg0[4]);
    buf U_DISP_A5 (display_a[5], reg0[5]);
    buf U_DISP_A6 (display_a[6], reg0[6]);
    buf U_DISP_A7 (display_a[7], reg0[7]);
    
    buf U_DISP_B0 (display_b[0], reg1[0]);
    buf U_DISP_B1 (display_b[1], reg1[1]);
    buf U_DISP_B2 (display_b[2], reg1[2]);
    buf U_DISP_B3 (display_b[3], reg1[3]);
    buf U_DISP_B4 (display_b[4], reg1[4]);
    buf U_DISP_B5 (display_b[5], reg1[5]);
    buf U_DISP_B6 (display_b[6], reg1[6]);
    buf U_DISP_B7 (display_b[7], reg1[7]);

    // ULA de 8 bits
    ula_8bits U_ULA (
        .a(reg0),
        .b(reg1),
        .operacao(operacao),
        .clk(clk),
        .rst(rst),
        .resultado(resultado_ula),
        .overflow(overflow),
        .zero(zero),
        .carry_out(carry_out),
        .erro(erro)
    );

    // Resultado final
    buf U_RESULT0 (resultado[0], resultado_ula[0]);
    buf U_RESULT1 (resultado[1], resultado_ula[1]);
    buf U_RESULT2 (resultado[2], resultado_ula[2]);
    buf U_RESULT3 (resultado[3], resultado_ula[3]);
    buf U_RESULT4 (resultado[4], resultado_ula[4]);
    buf U_RESULT5 (resultado[5], resultado_ula[5]);
    buf U_RESULT6 (resultado[6], resultado_ula[6]);
    buf U_RESULT7 (resultado[7], resultado_ula[7]);

endmodule
