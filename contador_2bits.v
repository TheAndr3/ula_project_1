// Módulo contador de 2 bits com reset automático em 11
// Implementação puramente estrutural

module contador_2bits (
    input  wire clk,           // Clock de entrada
    input  wire rst,           // Reset (ativo baixo)
    input  wire enable,        // Enable para incrementar
    output wire [1:0] count    // Saída do contador
);

    // Fios intermediários
    wire [1:0] count_next;     // Próximo valor do contador
    wire [1:0] count_reg;      // Valor atual do contador
    wire enable_count;         // Enable efetivo
    wire reset_condition;      // Condição de reset (quando count = 11)
    
    // Constantes
    wire gnd, vcc;
    wire [1:0] gnd_bus;
    
    // Gerar constantes
    and U_GND (gnd, clk, clk);
    not U_VCC_NOT (vcc, gnd);
    
    // Atribuir GND ao barramento
    buf U_GND_BUF0 (gnd_bus[0], gnd);
    buf U_GND_BUF1 (gnd_bus[1], gnd);

    // Detecta quando count = 11 (3 em decimal)
    and U_RESET_COND (reset_condition, count_reg[1], count_reg[0]);

    // Enable efetivo: enable AND NOT reset_condition
    wire not_reset_condition;
    not U_NOT_RESET (not_reset_condition, reset_condition);
    and U_ENABLE_EFF (enable_count, enable, not_reset_condition);

    // Lógica do contador:
    // count_next[0] = count[0] XOR enable_count
    // count_next[1] = count[1] XOR (count[0] AND enable_count)
    
    // count_next[0]
    wire count0_and_enable;
    and U_COUNT0_AND_ENABLE (count0_and_enable, count_reg[0], enable_count);
    xor U_COUNT0_XOR (count_next[0], count_reg[0], enable_count);
    
    // count_next[1]
    xor U_COUNT1_XOR (count_next[1], count_reg[1], count0_and_enable);

    // Reset: quando rst = 0 OU reset_condition = 1
    wire reset_final;
    or U_RESET_FINAL (reset_final, rst, reset_condition);
    
    // Registradores D para cada bit
    flip_flop_d U_REG_COUNT0 (
        .D(count_next[0]),
        .clk(clk),
        .rst(reset_final),
        .Q(count_reg[0])
    );
    
    flip_flop_d U_REG_COUNT1 (
        .D(count_next[1]),
        .clk(clk),
        .rst(reset_final),
        .Q(count_reg[1])
    );

    // Saída
    buf U_OUT0 (count[0], count_reg[0]);
    buf U_OUT1 (count[1], count_reg[1]);

endmodule
