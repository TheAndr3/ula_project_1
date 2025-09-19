// Módulo dedicado para a subtração de dois números de 4 bits.
// Implementa a lógica A - B através do complemento de dois: A + (~B) + 1.
module subtrator_4bits (
    input  wire [3:0] a,          // Operando A (minuendo)
    input  wire [3:0] b,          // Operando B (subtraendo)
    output wire [3:0] s,          // Resultado da subtração (4 bits)
    output wire       borrow_out, // Saída de "emprestou" (0 se A < B, 1 se A >= B)
);

    // --- Fios Intermediários ---
    wire [3:0] b_invertido; // Fio para armazenar o NOT(B)
    wire       vcc = 1'b1;  // Constante '1' para o cin do somador

    // --- Lógica de Complemento de Dois ---
    // 1. Inverte o operando B (subtraendo)
    not U_NOT0 (b_invertido[0], b[0]);
    not U_NOT1 (b_invertido[1], b[1]);
    not U_NOT2 (b_invertido[2], b[2]);
    not U_NOT3 (b_invertido[3], b[3]);

    // 2. Usa um módulo somador para calcular A + (~B) + 1
    somador_4bits U_Soma_Interna (
        .a(a),
        .b(b_invertido),
        .cin(vcc),          // O "+1" do complemento de dois vem do carry-in
        .s(s),
        .cout(borrow_out),  // Na subtração, o cout funciona como um "não emprestou"
    );

endmodule
