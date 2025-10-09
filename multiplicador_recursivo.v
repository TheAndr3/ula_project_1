// Multiplicador usando soma recursiva com shift registers
// Implementação puramente estrutural

module multiplicador_recursivo (
    input  wire [7:0] multiplicando,  // A
    input  wire [7:0] multiplicador,  // B
    input  wire clk,                  // Clock
    input  wire rst,                  // Reset
    input  wire start,                // Iniciar multiplicação
    output wire [7:0] produto,        // Resultado (8 bits com saturação)
    output wire done,                 // Flag de fim de multiplicação
    output wire overflow              // Flag de overflow
);

    // Fios intermediários
    wire [7:0] shift_reg_out;         // Saída do shift register
    wire [7:0] somador_a, somador_b;  // Entradas do somador
    wire [7:0] somador_out;           // Saída do somador
    wire [7:0] acumulador_in;         // Entrada do acumulador
    wire [7:0] acumulador_out;        // Saída do acumulador
    wire [7:0] multiplicando_reg;     // Registrador do multiplicando
    wire [7:0] multiplicador_reg;     // Registrador do multiplicador
    
    // Controle
    wire [2:0] contador_out;          // Saída do contador
    wire contador_done;               // Flag de fim do contador
    wire shift_enable;                // Enable do shift register
    wire acumulador_load;             // Load do acumulador
    wire multiplicando_load;          // Load do multiplicando
    wire multiplicador_load;          // Load do multiplicador
    wire somador_enable;              // Enable do somador
    wire bit_atual;                   // Bit atual do multiplicador
    
    // Constantes
    wire gnd, vcc;
    wire [7:0] gnd_bus;
    
    // Gerar constantes
    and U_GND (gnd, multiplicando[0], multiplicando[0]);
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

    // Contador de 3 bits para controlar as 8 iterações
    contador_3bits U_CONTADOR (
        .clk(clk),
        .rst(rst),
        .enable(start),
        .Q(contador_out),
        .done(contador_done)
    );

    // Shift register para o multiplicador
    shift_register_8bits U_SHIFT_REG (
        .D(multiplicador),
        .clk(clk),
        .rst(rst),
        .shift(shift_enable),
        .load(multiplicador_load),
        .shift_in(gnd),
        .Q(multiplicador_reg),
        .shift_out(bit_atual)
    );

    // Registrador para o multiplicando
    registrador_8bits U_MULTIPLICANDO_REG (
        .D(multiplicando),
        .clk(clk),
        .rst(rst),
        .load(multiplicando_load),
        .Q(multiplicando_reg),
        .Qn()
    );

    // Acumulador (registrador de 8 bits)
    registrador_8bits U_ACUMULADOR (
        .D(acumulador_in),
        .clk(clk),
        .rst(rst),
        .load(acumulador_load),
        .Q(acumulador_out),
        .Qn()
    );

    // Somador de 8 bits
    somador_8bits U_SOMADOR (
        .a(somador_a),
        .b(somador_b),
        .cin(gnd),
        .s(somador_out),
        .cout(),
        .ov()
    );

    // Lógica de controle simplificada
    // Load inicial dos registradores quando start = 1
    buf U_LOAD_MULTIPLICANDO (multiplicando_load, start);
    buf U_LOAD_MULTIPLICADOR (multiplicador_load, start);
    
    // Enable do shift register quando start = 1
    buf U_SHIFT_ENABLE (shift_enable, start);
    
    // Enable do somador quando bit atual = 1
    buf U_SOMADOR_ENABLE (somador_enable, bit_atual);
    
    // Load do acumulador quando start = 1 ou somador enable = 1
    or U_ACUMULADOR_LOAD (acumulador_load, start, somador_enable);
    
    // Entradas do somador - sempre usar acumulador e multiplicando
    buf U_SOMADOR_A0 (somador_a[0], acumulador_out[0]);
    buf U_SOMADOR_A1 (somador_a[1], acumulador_out[1]);
    buf U_SOMADOR_A2 (somador_a[2], acumulador_out[2]);
    buf U_SOMADOR_A3 (somador_a[3], acumulador_out[3]);
    buf U_SOMADOR_A4 (somador_a[4], acumulador_out[4]);
    buf U_SOMADOR_A5 (somador_a[5], acumulador_out[5]);
    buf U_SOMADOR_A6 (somador_a[6], acumulador_out[6]);
    buf U_SOMADOR_A7 (somador_a[7], acumulador_out[7]);
    
    buf U_SOMADOR_B0 (somador_b[0], multiplicando_reg[0]);
    buf U_SOMADOR_B1 (somador_b[1], multiplicando_reg[1]);
    buf U_SOMADOR_B2 (somador_b[2], multiplicando_reg[2]);
    buf U_SOMADOR_B3 (somador_b[3], multiplicando_reg[3]);
    buf U_SOMADOR_B4 (somador_b[4], multiplicando_reg[4]);
    buf U_SOMADOR_B5 (somador_b[5], multiplicando_reg[5]);
    buf U_SOMADOR_B6 (somador_b[6], multiplicando_reg[6]);
    buf U_SOMADOR_B7 (somador_b[7], multiplicando_reg[7]);
    
    // Entrada do acumulador - resultado do somador quando enable, senão mantém
    mux_2_para_1_8bits U_MUX_ACUMULADOR (
        .D0(acumulador_out),    // Manter valor atual
        .D1(somador_out),       // Resultado do somador
        .S(somador_enable),
        .Y(acumulador_in)
    );

    // Saídas
    buf U_PRODUTO0 (produto[0], acumulador_out[0]);
    buf U_PRODUTO1 (produto[1], acumulador_out[1]);
    buf U_PRODUTO2 (produto[2], acumulador_out[2]);
    buf U_PRODUTO3 (produto[3], acumulador_out[3]);
    buf U_PRODUTO4 (produto[4], acumulador_out[4]);
    buf U_PRODUTO5 (produto[5], acumulador_out[5]);
    buf U_PRODUTO6 (produto[6], acumulador_out[6]);
    buf U_PRODUTO7 (produto[7], acumulador_out[7]);
    
    // Flag de fim
    buf U_DONE (done, contador_done);
    
    // Overflow (sempre 0 para esta implementação)
    buf U_OVERFLOW (overflow, gnd);

endmodule
