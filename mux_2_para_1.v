// Módulo MUX 2 para 1 básico
// Implementação puramente estrutural

module mux_2_para_1 (
    input  wire D0, D1,  // Entradas
    input  wire S,       // Seletor
    output wire Y        // Saída
);

    // Inversor para o seletor
    wire not_S;
    not U_NOT_S (not_S, S);

    // Fios intermediários
    wire term0, term1;

    // Lógica para cada entrada
    and U_AND0 (term0, D0, not_S);  // S=0
    and U_AND1 (term1, D1, S);      // S=1

    // Saída final
    or U_OR (Y, term0, term1);

endmodule
