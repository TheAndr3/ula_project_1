// Contador de 2 bits
// Implementação puramente estrutural

module contador_2bits (
    input  wire clk,            // Clock
    input  wire rst,            // Reset (ativo baixo)
    input  wire inc,            // Incremento (ativo alto)
    input  wire dec,            // Decremento (ativo alto)
    output wire [1:0] Q,        // Saída do contador
    output wire empty,          // Flag de vazio
    output wire full            // Flag de cheio
);

    // Fios intermediários
    wire [1:0] D, Q_next;
    wire [1:0] Q_inv;
    wire inc_dec, inc_only, dec_only;
    wire [1:0] inc_bits, dec_bits;
    
    // Inversores para Q
    not U_NOT_Q0 (Q_inv[0], Q[0]);
    not U_NOT_Q1 (Q_inv[1], Q[1]);
    
    // Lógica de incremento/decremento
    and U_AND_INC (inc_only, inc, Q_inv[0], Q_inv[1]);  // inc quando Q=00
    and U_AND_DEC (dec_only, dec, Q[0], Q[1]);          // dec quando Q=11
    
    // Bits de incremento
    and U_INC_BIT0 (inc_bits[0], inc, Q_inv[0]);
    and U_INC_BIT1 (inc_bits[1], inc, Q[0], Q_inv[1]);
    
    // Bits de decremento
    and U_DEC_BIT0 (dec_bits[0], dec, Q[1]);
    and U_DEC_BIT1 (dec_bits[1], dec, Q_inv[0], Q[1]);
    
    // Lógica para D[0]
    wire D0_term1, D0_term2, D0_term3;
    and U_D0_AND1 (D0_term1, Q[0], Q_inv[1], Q_inv[0]);  // Mantém quando Q=01
    and U_D0_AND2 (D0_term2, inc_bits[0], Q_inv[1]);     // Incrementa quando Q=00
    and U_D0_AND3 (D0_term3, dec_bits[0], Q[1]);         // Decrementa quando Q=11
    or  U_D0_OR (D[0], D0_term1, D0_term2, D0_term3);
    
    // Lógica para D[1]
    wire D1_term1, D1_term2, D1_term3;
    and U_D1_AND1 (D1_term1, Q[1], Q_inv[0], Q_inv[1]);  // Mantém quando Q=10
    and U_D1_AND2 (D1_term2, inc_bits[1], Q_inv[0]);     // Incrementa quando Q=01
    and U_D1_AND3 (D1_term3, dec_bits[1], Q[0]);         // Decrementa quando Q=10
    or  U_D1_OR (D[1], D1_term1, D1_term2, D1_term3);
    
    // Flip-flops para o contador
    flip_flop_d U_FF0 (.D(D[0]), .clk(clk), .rst(rst), .Q(Q[0]), .Qn());
    flip_flop_d U_FF1 (.D(D[1]), .clk(clk), .rst(rst), .Q(Q[1]), .Qn());
    
    // Flags de estado
    and U_EMPTY (empty, Q_inv[0], Q_inv[1]);  // Q=00
    and U_FULL (full, Q[0], Q[1]);            // Q=11

endmodule
