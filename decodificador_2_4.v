// Decodificador de 2 para 4
// Implementação puramente estrutural

module decodificador_2_4 (
    input  wire [1:0] A,        // Entrada de 2 bits
    output wire [3:0] Y         // Saída de 4 bits
);

    // Inversores para as entradas
    wire A0_inv, A1_inv;
    not U_NOT_A0 (A0_inv, A[0]);
    not U_NOT_A1 (A1_inv, A[1]);
    
    // Lógica de decodificação
    and U_Y0 (Y[0], A1_inv, A0_inv);  // A=00
    and U_Y1 (Y[1], A1_inv, A[0]);    // A=01
    and U_Y2 (Y[2], A[1], A0_inv);    // A=10
    and U_Y3 (Y[3], A[1], A[0]);      // A=11

endmodule
