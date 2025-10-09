// Flip-Flop D Master-Slave (nível) com Reset - Versão Estrutural Correta
module flip_flop_d (
    input  wire d,
    input  wire clock,
    input  wire reset_n, // Reset ativo-baixo
    output wire q
);

    // Sinais internos
    wire clock_n;       // Clock invertido
    wire d_n;           // Entrada D invertida
    wire m_out, m_out_n; // Saídas do latch Mestre (Q e Q_n)
    wire q_n;           // Saída Q_n do flip-flop

    // Inversores (feitos com NAND para ser 100% NAND)
    nand inv_clk(clock_n, clock, clock);
    nand inv_d(d_n, d, d);

    // --- LATCH MESTRE (Transparente quando clock = 1) ---
    // Etapa de entrada do latch D
    wire s_m, r_m;
    nand u1_m(s_m, d, clock);
    nand u2_m(r_m, d_n, clock);

    // Latch SR cruzado (com reset)
    nand u3_m(m_out, s_m, m_out_n, reset_n); // Reset afeta o mestre
    nand u4_m(m_out_n, r_m, m_out);


    // --- LATCH ESCRAVO (Transparente quando clock = 0) ---
    // Etapa de entrada do latch D (usa a saída do mestre como entrada)
    wire s_s, r_s;
    nand u1_s(s_s, m_out, clock_n);
    nand u2_s(r_s, m_out_n, clock_n);

    // Latch SR cruzado (com reset)
    nand u3_s(q, s_s, q_n, reset_n); // Reset afeta o escravo para garantir a saída em 0
    nand u4_s(q_n, r_s, q);

endmodule
