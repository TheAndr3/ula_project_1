// Divisor real de 8 bits usando subtrações repetidas
// Implementação puramente estrutural

module divisor_real (
    input  wire [7:0] dividendo,    // Dividendo
    input  wire [7:0] divisor,      // Divisor
    input  wire clk,                // Clock
    input  wire rst,                // Reset
    input  wire start,              // Iniciar divisão
    output wire [7:0] quociente,    // Quociente
    output wire [7:0] resto,        // Resto
    output wire done,               // Flag de fim de divisão
    output wire div_zero,           // Flag de divisão por zero
    output wire overflow            // Flag de overflow
);

    // Fios intermediários
    wire [7:0] resto_atual, resto_next;
    wire [7:0] quociente_atual, quociente_next;
    wire [7:0] divisor_atual;
    wire [7:0] subtracao_result;
    wire [7:0] subtracao_cout;
    wire [7:0] subtracao_ov;
    
    // Controle
    wire [2:0] contador_out;
    wire contador_done;
    wire subtracao_possivel;
    wire load_resto, load_quociente;
    wire shift_quociente;
    
    // Constantes
    wire gnd, vcc;
    wire [7:0] gnd_bus;
    
    // Gerar constantes
    and U_GND (gnd, dividendo[0], dividendo[0]);
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
    comparador_8bits U_COMP_ZERO (
        .a(divisor),
        .b(gnd_bus),
        .a_gt_b(),
        .a_eq_b(div_zero),
        .a_lt_b()
    );
    
    // Contador de 3 bits para controlar as 8 iterações
    contador_3bits U_CONTADOR (
        .clk(clk),
        .rst(rst),
        .enable(start),
        .Q(contador_out),
        .done(contador_done)
    );

    // Registrador para o divisor
    registrador_8bits U_DIVISOR_REG (
        .D(divisor),
        .clk(clk),
        .rst(rst),
        .load(start),
        .Q(divisor_atual),
        .Qn()
    );

    // Registrador para o resto
    registrador_8bits U_RESTO_REG (
        .D(resto_next),
        .clk(clk),
        .rst(rst),
        .load(load_resto),
        .Q(resto_atual),
        .Qn()
    );

    // Registrador para o quociente
    registrador_8bits U_QUOCIENTE_REG (
        .D(quociente_next),
        .clk(clk),
        .rst(rst),
        .load(load_quociente),
        .Q(quociente_atual),
        .Qn()
    );

    // Comparador para verificar se resto >= divisor
    comparador_8bits U_COMP_MAIOR (
        .a(resto_atual),
        .b(divisor_atual),
        .a_gt_b(subtracao_possivel),
        .a_eq_b(),
        .a_lt_b()
    );

    // Subtrator para resto - divisor
    subtrator_8bits U_SUBTRATOR (
        .a(resto_atual),
        .b(divisor_atual),
        .s(subtracao_result),
        .cout(subtracao_cout),
        .ov(subtracao_ov),
        .neg()
    );

    // Lógica de controle simplificada
    // Load inicial do resto (dividendo) quando start = 1
    buf U_LOAD_RESTO_INIT (load_resto, start);
    
    // Load do resto durante a divisão quando subtração é possível
    buf U_LOAD_RESTO_DIV (load_resto_div, subtracao_possivel);
    
    // Load do quociente quando start = 1 ou shift = 1
    or U_LOAD_QUOCIENTE (load_quociente, start, shift_quociente);
    
    // Shift do quociente quando subtração é possível
    buf U_SHIFT_QUOCIENTE (shift_quociente, subtracao_possivel);
    
    // Entrada do resto - dividendo inicial ou resultado da subtração
    mux_2_para_1_8bits U_MUX_RESTO (
        .D0(dividendo),           // Inicialização
        .D1(subtracao_result),    // Resultado da subtração
        .S(load_resto_div),
        .Y(resto_next)
    );
    
    // Entrada do quociente - shift à esquerda quando necessário
    wire [7:0] quociente_shift;
    // Shift à esquerda do quociente
    buf U_Q_SHIFT0 (quociente_shift[0], gnd);
    buf U_Q_SHIFT1 (quociente_shift[1], quociente_atual[0]);
    buf U_Q_SHIFT2 (quociente_shift[2], quociente_atual[1]);
    buf U_Q_SHIFT3 (quociente_shift[3], quociente_atual[2]);
    buf U_Q_SHIFT4 (quociente_shift[4], quociente_atual[3]);
    buf U_Q_SHIFT5 (quociente_shift[5], quociente_atual[4]);
    buf U_Q_SHIFT6 (quociente_shift[6], quociente_atual[5]);
    buf U_Q_SHIFT7 (quociente_shift[7], quociente_atual[6]);
    
    mux_2_para_1_8bits U_MUX_QUOCIENTE (
        .D0(gnd_bus),             // Inicialização
        .D1(quociente_shift),     // Shift do quociente
        .S(shift_quociente),
        .Y(quociente_next)
    );

    // Saídas
    buf U_QUOCIENTE0 (quociente[0], quociente_atual[0]);
    buf U_QUOCIENTE1 (quociente[1], quociente_atual[1]);
    buf U_QUOCIENTE2 (quociente[2], quociente_atual[2]);
    buf U_QUOCIENTE3 (quociente[3], quociente_atual[3]);
    buf U_QUOCIENTE4 (quociente[4], quociente_atual[4]);
    buf U_QUOCIENTE5 (quociente[5], quociente_atual[5]);
    buf U_QUOCIENTE6 (quociente[6], quociente_atual[6]);
    buf U_QUOCIENTE7 (quociente[7], quociente_atual[7]);
    
    buf U_RESTO0 (resto[0], resto_atual[0]);
    buf U_RESTO1 (resto[1], resto_atual[1]);
    buf U_RESTO2 (resto[2], resto_atual[2]);
    buf U_RESTO3 (resto[3], resto_atual[3]);
    buf U_RESTO4 (resto[4], resto_atual[4]);
    buf U_RESTO5 (resto[5], resto_atual[5]);
    buf U_RESTO6 (resto[6], resto_atual[6]);
    buf U_RESTO7 (resto[7], resto_atual[7]);
    
    // Flags
    buf U_DONE (done, contador_done);
    buf U_OVERFLOW (overflow, gnd);

endmodule
