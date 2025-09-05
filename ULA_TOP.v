module ULA_TOP (
    // Entradas físicas da placa
    input  wire [9:0] SW,      // 10 chaves
    // Saídas físicas da placa
    output wire [9:0] LEDR,    // 10 LEDs vermelhos
    output wire [6:0] HEX0     // Display de 7 segmentos 0
);

    // --- Mapeamento de Entradas ---
    wire [3:0] a = SW[3:0];
    wire [3:0] b = SW[7:4];
    wire [1:0] seletor = SW[9:8]; // Seletor de 2 bits para 4 operações

    // --- Fios Intermediários ---
    wire [3:0] resultado_soma_sub, resultado_and, resultado_or;
    wire cout, ov;
    wire [3:0] resultado_ula;
    wire flag_zero;

    // --- Instanciação dos Módulos ---

    // 1. Instanciar as unidades de operação
    // Seletor: 00=Soma, 01=Sub, 10=AND, 11=OR
    wire modo_sub = (seletor == 2'b01); // modo_sub é 1 apenas quando seletor é 01
    somador_subtrator_4bits U_SomaSub (.a(a), .b(b), .modo_sub(modo_sub), .s(resultado_soma_sub), .cout(cout), .ov(ov));
    unidade_and_4bits       U_AND     (.A(a), .B(b), .S(resultado_and));
    unidade_or_4bits        U_OR      (.A(a), .B(b), .S(resultado_or));
    
    // 2. Instanciar o MUX principal para selecionar o resultado
    mux_4_para_1_4bits U_MUX (
        .D0(resultado_soma_sub), // Seletor 00
        .D1(resultado_soma_sub), // Seletor 01
        .D2(resultado_and),      // Seletor 10
        .D3(resultado_or),       // Seletor 11
        .S(seletor),
        .Y(resultado_ula)
    );

    // 3. Instanciar o decodificador para o display
    decodificador_7seg U_Display (.D(resultado_ula), .SEG(HEX0));

endmodule
