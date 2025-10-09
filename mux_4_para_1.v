// Módulo MUX 4 para 1 básico
// Implementação puramente estrutural

module mux_4_para_1 (
    input  wire D0, D1, D2, D3,  // Entradas
    input  wire [1:0] S,         // Seletor de 2 bits
    output wire Y                // Saída
);

    // Inversores para o seletor
    wire not_S0, not_S1;
    not U_NOT_S0 (not_S0, S[0]);
    not U_NOT_S1 (not_S1, S[1]);

    // Fios intermediários
    wire term0, term1, term2, term3;

    // Lógica para cada entrada
    and U_AND0 (term0, D0, not_S1, not_S0);  // S=00
    and U_AND1 (term1, D1, not_S1, S[0]);    // S=01
    and U_AND2 (term2, D2, S[1], not_S0);    // S=10
    and U_AND3 (term3, D3, S[1], S[0]);      // S=11

    // Saída final
    or U_OR (Y, term0, term1, term2, term3);

endmodule
