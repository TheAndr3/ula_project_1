module decodificador_7seg (
    input  wire [3:0] D,      // Entrada de dados de 4 bits (0-15)
    output wire [6:0] SEG     // Saída de 7 segmentos (gfedcba)
);

    // --- Fios Intermediários ---
    wire not_D0, not_D1, not_D2, not_D3;
    wire active_high_a, active_high_b, active_high_c, active_high_d;
    wire active_high_e, active_high_f, active_high_g;
    
    // --- Lógica Estrutural ---

    // 1. Gerar as inversões das entradas de dados
    not U_NOT0 (not_D0, D[0]);
    not U_NOT1 (not_D1, D[1]);
    not U_NOT2 (not_D2, D[2]);
    not U_NOT3 (not_D3, D[3]);

    // 2. Lógica Estrutural para cada segmento (versão active-high)

    // Lógica para 'a' = D3 | D1 | (D2&D0) | (~D2&~D0)
    wire term_a1, term_a2, term_a3;
    or  U_A1 (term_a1, D[3], D[1]);
    and U_A2 (term_a2, D[2], D[0]);
    and U_A3 (term_a3, not_D2, not_D0);
    or  U_A_OR (active_high_a, term_a1, term_a2, term_a3);

    // Lógica para 'b' = ~D2 | (~D1&~D0) | (D1&D0)
    wire term_b1, term_b2;
    and U_B1 (term_b1, not_D1, not_D0);
    and U_B2 (term_b2, D[1], D[0]);
    or  U_B_OR (active_high_b, not_D2, term_b1, term_b2);

    // Lógica para 'c' = ~D1 | D0
    or U_C_OR (active_high_c, not_D1, D[0]);

    // Lógica para 'd' = (D3 | D1 | (~D2&D0)) & ~(D2&~D0)
    wire term_d1, term_d2, term_d3, term_d4_inv;
    and U_D1 (term_d1, not_D2, D[0]);
    or  U_D2 (term_d2, D[3], D[1], term_d1);
    and U_D3 (term_d3, D[2], not_D0);
    not U_D4 (term_d4_inv, term_d3);
    and U_D_AND (active_high_d, term_d2, term_d4_inv);

    // Lógica para 'e' = (~D2&~D0) | (D1&~D0)
    wire term_e1, term_e2;
    and U_E1 (term_e1, not_D2, not_D0);
    and U_E2 (term_e2, D[1], not_D0);
    or  U_E_OR (active_high_e, term_e1, term_e2);

    // Lógica para 'f' = (D3 | D2 | (~D1&D0)) & ~(~D1&~D0)
    wire term_f1, term_f2, term_f3, term_f4_inv;
    and U_F1 (term_f1, not_D1, D[0]);
    or  U_F2 (term_f2, D[3], D[2], term_f1);
    and U_F3 (term_f3, not_D1, not_D0);
    not U_F4 (term_f4_inv, term_f3);
    and U_F_AND (active_high_f, term_f2, term_f4_inv);

    // Lógica para 'g' = (D3 | ~D1 | D2) & ~(D2&D1) | (D2&D0)
    wire term_g1, term_g2, term_g3_inv, term_g4, term_g5;
    or  U_G1 (term_g1, D[3], not_D1, D[2]);
    and U_G2 (term_g2, D[2], D[1]);
    not U_G3 (term_g3_inv, term_g2);
    and U_G4 (term_g4, term_g1, term_g3_inv);
    and U_G5 (term_g5, D[2], D[0]);
    or  U_G_OR (active_high_g, term_g4, term_g5);

    // 3. Inverter todas as saídas para a lógica de Anodo Comum (active-low)
    not U_INV_A (SEG[0], active_high_a);
    not U_INV_B (SEG[1], active_high_b);
    not U_INV_C (SEG[2], active_high_c);
    not U_INV_D (SEG[3], active_high_d);
    not U_INV_E (SEG[4], active_high_e);
    not U_INV_F (SEG[5], active_high_f);
    not U_INV_G (SEG[6], active_high_g);

endmodule
