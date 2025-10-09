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

    // Lógica de controle
    // Load inicial dos registradores
    and U_LOAD_MULTIPLICANDO (multiplicando_load, start, rst);
    and U_LOAD_MULTIPLICADOR (multiplicador_load, start, rst);
    
    // Enable do shift register
    and U_SHIFT_ENABLE (shift_enable, start, contador_out[0], contador_out[1], contador_out[2]);
    
    // Enable do somador
    and U_SOMADOR_ENABLE (somador_enable, start, bit_atual);
    
    // Load do acumulador
    or U_ACUMULADOR_LOAD (acumulador_load, start, somador_enable);
    
    // Entradas do somador
    mux_2_para_1_8bits U_MUX_SOMADOR_A (
        .D0(gnd_bus),           // Inicialização
        .D1(acumulador_out),    // Acumulador atual
        .S(start),
        .Y(somador_a)
    );
    
    mux_2_para_1_8bits U_MUX_SOMADOR_B (
        .D0(gnd_bus),           // Inicialização
        .D1(multiplicando_reg), // Multiplicando
        .S(somador_enable),
        .Y(somador_b)
    );
    
    // Entrada do acumulador
    mux_2_para_1_8bits U_MUX_ACUMULADOR (
        .D0(gnd_bus),           // Inicialização
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
