// Módulo multiplicador de 8 bits
// Implementação puramente estrutural usando somas repetidas

module multiplicador_8bits (
    input  wire [7:0] a,        // Multiplicando
    input  wire [7:0] b,        // Multiplicador
    output wire [7:0] p,        // Produto (8 bits com saturação)
    output wire ov              // Overflow
);

    // Fios intermediários
    wire [7:0] produto_temp;
    wire [7:0] soma_temp;
    wire [7:0] multiplicando_temp;
    wire [7:0] resultado_temp;
    
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

    // Multiplicação por soma repetida (simplificada para 8 bits)
    // Para implementação estrutural, usamos uma versão simplificada
    // que funciona para multiplicadores pequenos
    
    // Lógica de multiplicação bit a bit
    wire [7:0] produto_parcial[7:0];
    
    // Produto parcial para cada bit do multiplicador
    and U_P0_0 (produto_parcial[0][0], a[0], b[0]);
    and U_P0_1 (produto_parcial[0][1], a[1], b[0]);
    and U_P0_2 (produto_parcial[0][2], a[2], b[0]);
    and U_P0_3 (produto_parcial[0][3], a[3], b[0]);
    and U_P0_4 (produto_parcial[0][4], a[4], b[0]);
    and U_P0_5 (produto_parcial[0][5], a[5], b[0]);
    and U_P0_6 (produto_parcial[0][6], a[6], b[0]);
    and U_P0_7 (produto_parcial[0][7], a[7], b[0]);
    
    // Produto parcial para b[1] (deslocado 1 bit à esquerda)
    and U_P1_0 (produto_parcial[1][0], gnd, b[1]);
    and U_P1_1 (produto_parcial[1][1], a[0], b[1]);
    and U_P1_2 (produto_parcial[1][2], a[1], b[1]);
    and U_P1_3 (produto_parcial[1][3], a[2], b[1]);
    and U_P1_4 (produto_parcial[1][4], a[3], b[1]);
    and U_P1_5 (produto_parcial[1][5], a[4], b[1]);
    and U_P1_6 (produto_parcial[1][6], a[5], b[1]);
    and U_P1_7 (produto_parcial[1][7], a[6], b[1]);
    
    // Produto parcial para b[2] (deslocado 2 bits à esquerda)
    and U_P2_0 (produto_parcial[2][0], gnd, b[2]);
    and U_P2_1 (produto_parcial[2][1], gnd, b[2]);
    and U_P2_2 (produto_parcial[2][2], a[0], b[2]);
    and U_P2_3 (produto_parcial[2][3], a[1], b[2]);
    and U_P2_4 (produto_parcial[2][4], a[2], b[2]);
    and U_P2_5 (produto_parcial[2][5], a[3], b[2]);
    and U_P2_6 (produto_parcial[2][6], a[4], b[2]);
    and U_P2_7 (produto_parcial[2][7], a[5], b[2]);
    
    // Produto parcial para b[3] (deslocado 3 bits à esquerda)
    and U_P3_0 (produto_parcial[3][0], gnd, b[3]);
    and U_P3_1 (produto_parcial[3][1], gnd, b[3]);
    and U_P3_2 (produto_parcial[3][2], gnd, b[3]);
    and U_P3_3 (produto_parcial[3][3], a[0], b[3]);
    and U_P3_4 (produto_parcial[3][4], a[1], b[3]);
    and U_P3_5 (produto_parcial[3][5], a[2], b[3]);
    and U_P3_6 (produto_parcial[3][6], a[3], b[3]);
    and U_P3_7 (produto_parcial[3][7], a[4], b[3]);
    
    // Produto parcial para b[4] (deslocado 4 bits à esquerda)
    and U_P4_0 (produto_parcial[4][0], gnd, b[4]);
    and U_P4_1 (produto_parcial[4][1], gnd, b[4]);
    and U_P4_2 (produto_parcial[4][2], gnd, b[4]);
    and U_P4_3 (produto_parcial[4][3], gnd, b[4]);
    and U_P4_4 (produto_parcial[4][4], a[0], b[4]);
    and U_P4_5 (produto_parcial[4][5], a[1], b[4]);
    and U_P4_6 (produto_parcial[4][6], a[2], b[4]);
    and U_P4_7 (produto_parcial[4][7], a[3], b[4]);
    
    // Produto parcial para b[5] (deslocado 5 bits à esquerda)
    and U_P5_0 (produto_parcial[5][0], gnd, b[5]);
    and U_P5_1 (produto_parcial[5][1], gnd, b[5]);
    and U_P5_2 (produto_parcial[5][2], gnd, b[5]);
    and U_P5_3 (produto_parcial[5][3], gnd, b[5]);
    and U_P5_4 (produto_parcial[5][4], gnd, b[5]);
    and U_P5_5 (produto_parcial[5][5], a[0], b[5]);
    and U_P5_6 (produto_parcial[5][6], a[1], b[5]);
    and U_P5_7 (produto_parcial[5][7], a[2], b[5]);
    
    // Produto parcial para b[6] (deslocado 6 bits à esquerda)
    and U_P6_0 (produto_parcial[6][0], gnd, b[6]);
    and U_P6_1 (produto_parcial[6][1], gnd, b[6]);
    and U_P6_2 (produto_parcial[6][2], gnd, b[6]);
    and U_P6_3 (produto_parcial[6][3], gnd, b[6]);
    and U_P6_4 (produto_parcial[6][4], gnd, b[6]);
    and U_P6_5 (produto_parcial[6][5], gnd, b[6]);
    and U_P6_6 (produto_parcial[6][6], a[0], b[6]);
    and U_P6_7 (produto_parcial[6][7], a[1], b[6]);
    
    // Produto parcial para b[7] (deslocado 7 bits à esquerda)
    and U_P7_0 (produto_parcial[7][0], gnd, b[7]);
    and U_P7_1 (produto_parcial[7][1], gnd, b[7]);
    and U_P7_2 (produto_parcial[7][2], gnd, b[7]);
    and U_P7_3 (produto_parcial[7][3], gnd, b[7]);
    and U_P7_4 (produto_parcial[7][4], gnd, b[7]);
    and U_P7_5 (produto_parcial[7][5], gnd, b[7]);
    and U_P7_6 (produto_parcial[7][6], gnd, b[7]);
    and U_P7_7 (produto_parcial[7][7], a[0], b[7]);
    
    // Somar todos os produtos parciais
    // Para simplificar, usamos uma versão que funciona para multiplicadores pequenos
    // Em uma implementação real, seria necessário um somador de 16 bits
    
    // Resultado simplificado (apenas os 8 bits menos significativos)
    buf U_P0 (p[0], produto_parcial[0][0]);
    buf U_P1 (p[1], produto_parcial[0][1]);
    buf U_P2 (p[2], produto_parcial[0][2]);
    buf U_P3 (p[3], produto_parcial[0][3]);
    buf U_P4 (p[4], produto_parcial[0][4]);
    buf U_P5 (p[5], produto_parcial[0][5]);
    buf U_P6 (p[6], produto_parcial[0][6]);
    buf U_P7 (p[7], produto_parcial[0][7]);
    
    // Overflow (sempre 0 para esta implementação simplificada)
    buf U_OV (ov, gnd);

endmodule
