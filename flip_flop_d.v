// Flip-flop D básico
// Implementação puramente estrutural

module flip_flop_d (
    input  wire D,        // Entrada de dados
    input  wire clk,      // Clock
    input  wire rst,      // Reset (ativo baixo)
    output wire Q,        // Saída
    output wire Qn        // Saída negada
);

    // Fios intermediários
    wire D_inv, clk_inv, rst_inv;
    wire Q_temp, Qn_temp;
    wire D_gated, Q_gated, Qn_gated;
    
    // Inversores
    not U_NOT_D (D_inv, D);
    not U_NOT_CLK (clk_inv, clk);
    not U_NOT_RST (rst_inv, rst);
    
    // Lógica do flip-flop D usando portas NAND
    // Primeira etapa: D gated com clock
    nand U_NAND_D1 (D_gated, D, clk);
    nand U_NAND_D2 (D_gated, D_inv, clk);
    
    // Segunda etapa: Q gated com clock
    nand U_NAND_Q1 (Q_gated, Q_temp, clk_inv);
    nand U_NAND_Q2 (Q_gated, Qn_temp, clk_inv);
    
    // Terceira etapa: Q e Qn
    nand U_NAND_Q (Q_temp, D_gated, Qn_temp, rst_inv);
    nand U_NAND_QN (Qn_temp, Q_gated, Q_temp, rst_inv);
    
    // Saídas
    buf U_BUF_Q (Q, Q_temp);
    buf U_BUF_QN (Qn, Qn_temp);

endmodule
