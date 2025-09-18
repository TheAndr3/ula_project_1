// Módulo conversor de Binário para BCD, derivado diretamente
// da tabela-verdade e implementado em Verilog 100% Estrutural.
module bcd (
    input  wire [3:0] B,         // Entrada binária (B3, B2, B1, B0)
    output wire [3:0] dezena_out,  // Saída para o dígito da dezena
    output wire [3:0] unidade_out // Saída para o dígito da unidade
);

    // --- Fios Intermediários ---
    wire d0; // Apenas um bit é necessário para a dezena (0 ou 1)
    wire not_b1, not_b2, not_b3;
    wire gnd; // Fio para a constante '0'
    wire not_b0; // Fio auxiliar para gerar gnd

    // Termos intermediários para as equações
    wire term_d0_1;
    wire term_u1_1;
    wire term_u2_1, term_u2_2, term_u2_3;
    wire term_u3_1;

    // --- Lógica Estrutural ---

    // Gerar inversores para uso geral
    not U_NOT0 (not_b0, B[0]);
    not U_NOT1 (not_b1, B[1]);
    not U_NOT2 (not_b2, B[2]);
    not U_NOT3 (not_b3, B[3]);
    
    // Gerar a constante '0' (gnd)
    and U_GND (gnd, B[0], not_b0);

    // 1. Lógica para a Dezena (D0 = B3 & (B2 | B1))
    or  U_D0_OR   (term_d0_1, B[2], B[1]);
    and U_D0_AND  (d0, B[3], term_d0_1);

    // Conectar a saída da dezena (usa-se buffers para atribuir)
    buf U_DEZ0 (dezena_out[0], d0);
    buf U_DEZ1 (dezena_out[1], gnd);
    buf U_DEZ2 (dezena_out[2], gnd);
    buf U_DEZ3 (dezena_out[3], gnd);

    // 2. Lógica para a Unidade
    // U0 = B0
    buf U_U0 (unidade_out[0], B[0]);

    // U1 = B1 ^ (B3 & B2)
    and U_U1_AND (term_u1_1, B[3], B[2]);
    xor U_U1_XOR (unidade_out[1], B[1], term_u1_1);

    // U2 = (B2 & ~B3) | (B2 & ~B1) | (~B2 & B3 & B1)
    and U_U2_AND1 (term_u2_1, B[2], not_b3);
    and U_U2_AND2 (term_u2_2, B[2], not_b1);
    and U_U2_AND3 (term_u2_3, not_b2, B[3], B[1]);
    or  U_U2_OR   (unidade_out[2], term_u2_1, term_u2_2, term_u2_3);

    // U3 = B3 & ~B2 & ~B1
    and U_U3_AND (unidade_out[3], B[3], not_b2, not_b1);

endmodule
