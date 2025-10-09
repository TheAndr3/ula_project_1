// Controle de memória para armazenamento automático do último resultado
// Implementação puramente estrutural

module controle_memoria (
    input  wire [2:0] operacao,           // Código da operação
    input  wire [7:0] resultado_ula,      // Resultado da ULA
    input  wire executar,                 // Sinal de execução
    input  wire clk,                      // Clock
    input  wire rst,                      // Reset (ativo baixo)
    output wire carregar_memoria,         // Sinal para carregar na memória
    output wire [7:0] valor_memoria,      // Valor atual da memória
    output wire [7:0] resultado_final     // Resultado final para exibição
);

    // Fios intermediários
    wire [7:0] memoria_saida;
    wire [7:0] resultado_saida;
    
    // Constantes
    wire gnd, vcc;
    wire [7:0] gnd_bus;
    
    // Gerar constantes
    and U_GND (gnd, operacao[0], operacao[0]);
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

    // Lógica para determinar quando carregar na memória
    // Carrega quando: executar = 1 E operação é válida (não é 000 = soma vazia)
    wire operacao_valida;
    wire [2:0] operacao_inv;
    not U_NOT_OP0 (operacao_inv[0], operacao[0]);
    not U_NOT_OP1 (operacao_inv[1], operacao[1]);
    not U_NOT_OP2 (operacao_inv[2], operacao[2]);
    
    // Operação válida: não é 000 (soma vazia)
    or U_OP_VALIDA (operacao_valida, operacao[0], operacao[1], operacao[2]);
    
    // Carregar memória: executar AND operação válida
    and U_CARREGAR (carregar_memoria, executar, operacao_valida);

    // Registrador de memória
    registrador_memoria U_REG_MEM (
        .resultado_entrada(resultado_ula),
        .clk(clk),
        .rst(rst),
        .carregar(carregar_memoria),
        .valor_memoria(memoria_saida),
        .memoria_saida(memoria_saida),
        .resultado_saida(resultado_saida)
    );

    // Saídas
    buf U_VALOR_MEM0 (valor_memoria[0], memoria_saida[0]);
    buf U_VALOR_MEM1 (valor_memoria[1], memoria_saida[1]);
    buf U_VALOR_MEM2 (valor_memoria[2], memoria_saida[2]);
    buf U_VALOR_MEM3 (valor_memoria[3], memoria_saida[3]);
    buf U_VALOR_MEM4 (valor_memoria[4], memoria_saida[4]);
    buf U_VALOR_MEM5 (valor_memoria[5], memoria_saida[5]);
    buf U_VALOR_MEM6 (valor_memoria[6], memoria_saida[6]);
    buf U_VALOR_MEM7 (valor_memoria[7], memoria_saida[7]);

    buf U_RESULTADO_FINAL0 (resultado_final[0], resultado_saida[0]);
    buf U_RESULTADO_FINAL1 (resultado_final[1], resultado_saida[1]);
    buf U_RESULTADO_FINAL2 (resultado_final[2], resultado_saida[2]);
    buf U_RESULTADO_FINAL3 (resultado_final[3], resultado_saida[3]);
    buf U_RESULTADO_FINAL4 (resultado_final[4], resultado_saida[4]);
    buf U_RESULTADO_FINAL5 (resultado_final[5], resultado_saida[5]);
    buf U_RESULTADO_FINAL6 (resultado_final[6], resultado_saida[6]);
    buf U_RESULTADO_FINAL7 (resultado_final[7], resultado_saida[7]);

endmodule
