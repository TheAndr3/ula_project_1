// Contador de 1 bit (0 ou 1)
// Implementação puramente estrutural

module contador_1bit (
    input  wire clk,            // Clock
    input  wire rst,            // Reset (ativo alto)
    input  wire inc,            // Incremento (ativo alto)
    input  wire dec,            // Decremento (ativo alto)
    output wire Q,              // Saída do contador (0 ou 1)
    output wire empty,          // Flag de vazio (Q=0)
    output wire full            // Flag de cheio (Q=1)
);

    // Fios intermediários
    wire D;
    wire Q_inv;
    wire inc_only, dec_only;
    
    // Inversor para Q
    not U_NOT_Q (Q_inv, Q);
    
    // Lógica de incremento/decremento
    // inc_only: incrementa quando Q=0 e inc=1
    and U_AND_INC (inc_only, inc, Q_inv);
    
    // dec_only: decrementa quando Q=1 e dec=1
    and U_AND_DEC (dec_only, dec, Q);
    
    // Lógica para D
    // D = (Q e não dec) ou (não Q e inc)
    wire keep_one, set_one;
    wire Q_not_dec, Qinv_inc;
    
    not U_NOT_DEC (dec_inv, dec);
    not U_NOT_INC (inc_inv, inc);
    
    // Q permanece 1 se Q=1 e dec=0
    and U_KEEP_ONE (keep_one, Q, dec_inv);
    
    // Q vira 1 se Q=0 e inc=1
    and U_SET_ONE (set_one, Q_inv, inc);
    
    // D = keep_one OU set_one
    or U_D_OR (D, keep_one, set_one);
    
    // Flip-flop para o contador
    flip_flop_d U_FF (.D(D), .clk(clk), .rst(rst), .Q(Q), .Qn());
    
    // Flags de estado
    buf U_EMPTY (empty, Q_inv);   // Vazio quando Q=0
    buf U_FULL (full, Q);          // Cheio quando Q=1

endmodule

