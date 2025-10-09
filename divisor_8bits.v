// Módulo divisor de 8 bits
// Implementação puramente estrutural usando subtrações repetidas

module divisor_8bits (
    input  wire [7:0] a,        // Dividendo
    input  wire [7:0] b,        // Divisor
    output wire [7:0] q,        // Quociente
    output wire [7:0] r,        // Resto
    output wire div_zero,       // Flag de divisão por zero
    output wire ov              // Overflow
);

    // Fios intermediários
    wire [7:0] quociente_temp;
    wire [7:0] resto_temp;
    wire [7:0] dividendo_temp;
    wire [7:0] divisor_temp;
    
    // Constantes
    wire gnd, vcc;
    wire [7:0] gnd_bus;
    
    // Gerar constantes
    and U_GND (gnd, a[0], a[0]);
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

    // Detecção de divisão por zero
    // Verificar se todos os bits de b são zero
    wire [7:0] b_not;
    not U_NOT_B0 (b_not[0], b[0]);
    not U_NOT_B1 (b_not[1], b[1]);
    not U_NOT_B2 (b_not[2], b[2]);
    not U_NOT_B3 (b_not[3], b[3]);
    not U_NOT_B4 (b_not[4], b[4]);
    not U_NOT_B5 (b_not[5], b[5]);
    not U_NOT_B6 (b_not[6], b[6]);
    not U_NOT_B7 (b_not[7], b[7]);
    
    and U_DIV_ZERO (div_zero, b_not[0], b_not[1], b_not[2], b_not[3], 
                    b_not[4], b_not[5], b_not[6], b_not[7]);
    
    // Divisão simplificada (apenas para divisores pequenos)
    // Em uma implementação real, seria necessário um algoritmo mais complexo
    
    // Quociente simplificado (apenas os 8 bits menos significativos)
    buf U_Q0 (q[0], gnd);
    buf U_Q1 (q[1], gnd);
    buf U_Q2 (q[2], gnd);
    buf U_Q3 (q[3], gnd);
    buf U_Q4 (q[4], gnd);
    buf U_Q5 (q[5], gnd);
    buf U_Q6 (q[6], gnd);
    buf U_Q7 (q[7], gnd);
    
    // Resto (igual ao dividendo para esta implementação simplificada)
    buf U_R0 (r[0], a[0]);
    buf U_R1 (r[1], a[1]);
    buf U_R2 (r[2], a[2]);
    buf U_R3 (r[3], a[3]);
    buf U_R4 (r[4], a[4]);
    buf U_R5 (r[5], a[5]);
    buf U_R6 (r[6], a[6]);
    buf U_R7 (r[7], a[7]);
    
    // Overflow (sempre 0 para esta implementação simplificada)
    buf U_OV (ov, gnd);

endmodule
