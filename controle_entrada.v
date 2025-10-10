// Módulo de controle de entrada baseado no contador
// Implementação puramente estrutural

module controle_entrada (
    input  wire [7:0] entrada_numero,    // Entrada de número de 8 bits
    input  wire [2:0] operacao,          // Código da operação
    input  wire [1:0] contador_entrada,  // Contador: 00=A, 01=B, 10=op, 11=reset
    input  wire entrada_botao,           // Botão de entrada
    output wire entrada_numero_a,        // Enable para entrada do número A
    output wire entrada_numero_b,        // Enable para entrada do número B
    output wire entrada_operacao,        // Enable para entrada da operação
    output wire executar_operacao        // Enable para executar operação
);

    // Constantes
    wire gnd, vcc;
    
    // Gerar constantes
    and U_GND (gnd, entrada_numero[0], entrada_numero[0]);
    not U_VCC_NOT (vcc, gnd);

    // Detectar estados do contador
    wire contador_00, contador_01, contador_10, contador_11;
    
    // contador_00: contador[1] = 0 AND contador[0] = 0
    wire not_contador1, not_contador0;
    not U_NOT_CONT1 (not_contador1, contador_entrada[1]);
    not U_NOT_CONT0 (not_contador0, contador_entrada[0]);
    and U_CONT_00 (contador_00, not_contador1, not_contador0);
    
    // contador_01: contador[1] = 0 AND contador[0] = 1
    and U_CONT_01 (contador_01, not_contador1, contador_entrada[0]);
    
    // contador_10: contador[1] = 1 AND contador[0] = 0
    and U_CONT_10 (contador_10, contador_entrada[1], not_contador0);
    
    // contador_11: contador[1] = 1 AND contador[0] = 1
    and U_CONT_11 (contador_11, contador_entrada[1], contador_entrada[0]);

    // Controle de entrada
    // entrada_numero_a: contador_00 AND entrada_botao
    and U_ENTRADA_A (entrada_numero_a, contador_00, entrada_botao);
    
    // entrada_numero_b: contador_01 AND entrada_botao
    and U_ENTRADA_B (entrada_numero_b, contador_01, entrada_botao);
    
    // entrada_operacao: contador_10 AND entrada_botao
    and U_ENTRADA_OP (entrada_operacao, contador_10, entrada_botao);
    
    // executar_operacao: contador_11 AND entrada_botao
    and U_EXECUTAR_OP (executar_operacao, contador_11, entrada_botao);

endmodule
