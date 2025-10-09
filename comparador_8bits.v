// Comparador de 8 bits
// Implementação puramente estrutural

module comparador_8bits (
    input  wire [7:0] a,        // Operando A
    input  wire [7:0] b,        // Operando B
    output wire a_gt_b,         // A > B
    output wire a_eq_b,         // A = B
    output wire a_lt_b          // A < B
);

    // Fios intermediários para cada bit
    wire [7:0] a_not, b_not;
    wire [7:0] a_gt_bit, a_eq_bit, a_lt_bit;
    
    // Inversores para A e B
    not U_NOT_A0 (a_not[0], a[0]);
    not U_NOT_A1 (a_not[1], a[1]);
    not U_NOT_A2 (a_not[2], a[2]);
    not U_NOT_A3 (a_not[3], a[3]);
    not U_NOT_A4 (a_not[4], a[4]);
    not U_NOT_A5 (a_not[5], a[5]);
    not U_NOT_A6 (a_not[6], a[6]);
    not U_NOT_A7 (a_not[7], a[7]);
    
    not U_NOT_B0 (b_not[0], b[0]);
    not U_NOT_B1 (b_not[1], b[1]);
    not U_NOT_B2 (b_not[2], b[2]);
    not U_NOT_B3 (b_not[3], b[3]);
    not U_NOT_B4 (b_not[4], b[4]);
    not U_NOT_B5 (b_not[5], b[5]);
    not U_NOT_B6 (b_not[6], b[6]);
    not U_NOT_B7 (b_not[7], b[7]);
    
    // Comparação bit a bit (da esquerda para a direita)
    // A > B: a[7] > b[7] OU (a[7] = b[7] E a[6] > b[6]) OU ...
    
    // Bit 7 (mais significativo)
    and U_GT7 (a_gt_bit[7], a[7], b_not[7]);
    and U_EQ7 (a_eq_bit[7], a[7], b[7]);
    and U_LT7 (a_lt_bit[7], a_not[7], b[7]);
    
    // Bit 6
    wire gt6_term1, gt6_term2, eq6_term1, eq6_term2, lt6_term1, lt6_term2;
    and U_GT6_1 (gt6_term1, a[6], b_not[6]);
    and U_GT6_2 (gt6_term2, a_eq_bit[7], gt6_term1);
    or  U_GT6 (a_gt_bit[6], a_gt_bit[7], gt6_term2);
    
    and U_EQ6_1 (eq6_term1, a[6], b[6]);
    and U_EQ6_2 (eq6_term2, a_eq_bit[7], eq6_term1);
    or  U_EQ6 (a_eq_bit[6], a_eq_bit[7], eq6_term2);
    
    and U_LT6_1 (lt6_term1, a_not[6], b[6]);
    and U_LT6_2 (lt6_term2, a_eq_bit[7], lt6_term1);
    or  U_LT6 (a_lt_bit[6], a_lt_bit[7], lt6_term2);
    
    // Bit 5
    wire gt5_term1, gt5_term2, eq5_term1, eq5_term2, lt5_term1, lt5_term2;
    and U_GT5_1 (gt5_term1, a[5], b_not[5]);
    and U_GT5_2 (gt5_term2, a_eq_bit[6], gt5_term1);
    or  U_GT5 (a_gt_bit[5], a_gt_bit[6], gt5_term2);
    
    and U_EQ5_1 (eq5_term1, a[5], b[5]);
    and U_EQ5_2 (eq5_term2, a_eq_bit[6], eq5_term1);
    or  U_EQ5 (a_eq_bit[5], a_eq_bit[6], eq5_term2);
    
    and U_LT5_1 (lt5_term1, a_not[5], b[5]);
    and U_LT5_2 (lt5_term2, a_eq_bit[6], lt5_term1);
    or  U_LT5 (a_lt_bit[5], a_lt_bit[6], lt5_term2);
    
    // Bit 4
    wire gt4_term1, gt4_term2, eq4_term1, eq4_term2, lt4_term1, lt4_term2;
    and U_GT4_1 (gt4_term1, a[4], b_not[4]);
    and U_GT4_2 (gt4_term2, a_eq_bit[5], gt4_term1);
    or  U_GT4 (a_gt_bit[4], a_gt_bit[5], gt4_term2);
    
    and U_EQ4_1 (eq4_term1, a[4], b[4]);
    and U_EQ4_2 (eq4_term2, a_eq_bit[5], eq4_term1);
    or  U_EQ4 (a_eq_bit[4], a_eq_bit[5], eq4_term2);
    
    and U_LT4_1 (lt4_term1, a_not[4], b[4]);
    and U_LT4_2 (lt4_term2, a_eq_bit[5], lt4_term1);
    or  U_LT4 (a_lt_bit[4], a_lt_bit[5], lt4_term2);
    
    // Bit 3
    wire gt3_term1, gt3_term2, eq3_term1, eq3_term2, lt3_term1, lt3_term2;
    and U_GT3_1 (gt3_term1, a[3], b_not[3]);
    and U_GT3_2 (gt3_term2, a_eq_bit[4], gt3_term1);
    or  U_GT3 (a_gt_bit[3], a_gt_bit[4], gt3_term2);
    
    and U_EQ3_1 (eq3_term1, a[3], b[3]);
    and U_EQ3_2 (eq3_term2, a_eq_bit[4], eq3_term1);
    or  U_EQ3 (a_eq_bit[3], a_eq_bit[4], eq3_term2);
    
    and U_LT3_1 (lt3_term1, a_not[3], b[3]);
    and U_LT3_2 (lt3_term2, a_eq_bit[4], lt3_term1);
    or  U_LT3 (a_lt_bit[3], a_lt_bit[4], lt3_term2);
    
    // Bit 2
    wire gt2_term1, gt2_term2, eq2_term1, eq2_term2, lt2_term1, lt2_term2;
    and U_GT2_1 (gt2_term1, a[2], b_not[2]);
    and U_GT2_2 (gt2_term2, a_eq_bit[3], gt2_term1);
    or  U_GT2 (a_gt_bit[2], a_gt_bit[3], gt2_term2);
    
    and U_EQ2_1 (eq2_term1, a[2], b[2]);
    and U_EQ2_2 (eq2_term2, a_eq_bit[3], eq2_term1);
    or  U_EQ2 (a_eq_bit[2], a_eq_bit[3], eq2_term2);
    
    and U_LT2_1 (lt2_term1, a_not[2], b[2]);
    and U_LT2_2 (lt2_term2, a_eq_bit[3], lt2_term1);
    or  U_LT2 (a_lt_bit[2], a_lt_bit[3], lt2_term2);
    
    // Bit 1
    wire gt1_term1, gt1_term2, eq1_term1, eq1_term2, lt1_term1, lt1_term2;
    and U_GT1_1 (gt1_term1, a[1], b_not[1]);
    and U_GT1_2 (gt1_term2, a_eq_bit[2], gt1_term1);
    or  U_GT1 (a_gt_bit[1], a_gt_bit[2], gt1_term2);
    
    and U_EQ1_1 (eq1_term1, a[1], b[1]);
    and U_EQ1_2 (eq1_term2, a_eq_bit[2], eq1_term1);
    or  U_EQ1 (a_eq_bit[1], a_eq_bit[2], eq1_term2);
    
    and U_LT1_1 (lt1_term1, a_not[1], b[1]);
    and U_LT1_2 (lt2_term2, a_eq_bit[2], lt1_term1);
    or  U_LT1 (a_lt_bit[1], a_lt_bit[2], lt2_term2);
    
    // Bit 0 (menos significativo)
    wire gt0_term1, gt0_term2, eq0_term1, eq0_term2, lt0_term1, lt0_term2;
    and U_GT0_1 (gt0_term1, a[0], b_not[0]);
    and U_GT0_2 (gt0_term2, a_eq_bit[1], gt0_term1);
    or  U_GT0 (a_gt_bit[0], a_gt_bit[1], gt0_term2);
    
    and U_EQ0_1 (eq0_term1, a[0], b[0]);
    and U_EQ0_2 (eq0_term2, a_eq_bit[1], eq0_term1);
    or  U_EQ0 (a_eq_bit[0], a_eq_bit[1], eq0_term2);
    
    and U_LT0_1 (lt0_term1, a_not[0], b[0]);
    and U_LT0_2 (lt0_term2, a_eq_bit[1], lt0_term1);
    or  U_LT0 (a_lt_bit[0], a_lt_bit[1], lt0_term2);
    
    // Saídas finais
    buf U_A_GT_B (a_gt_b, a_gt_bit[0]);
    buf U_A_EQ_B (a_eq_b, a_eq_bit[0]);
    buf U_A_LT_B (a_lt_b, a_lt_bit[0]);

endmodule
