// Contador de 3 bits (0 a 7)
// Implementação puramente estrutural

module contador_3bits (
    input  wire clk,            // Clock
    input  wire rst,            // Reset (ativo baixo)
    input  wire enable,         // Enable (ativo alto)
    output wire [2:0] Q,        // Saída do contador
    output wire done            // Flag de fim de contagem
);

    // Fios intermediários
    wire [2:0] D, Q_inv;
    wire [2:0] carry;
    
    // Inversores para Q
    not U_NOT_Q0 (Q_inv[0], Q[0]);
    not U_NOT_Q1 (Q_inv[1], Q[1]);
    not U_NOT_Q2 (Q_inv[2], Q[2]);
    
    // Lógica de carry
    and U_CARRY0 (carry[0], Q[0], enable);
    and U_CARRY1 (carry[1], Q[1], carry[0]);
    and U_CARRY2 (carry[2], Q[2], carry[1]);
    
    // Lógica para D[0]
    xor U_D0 (D[0], Q[0], enable);
    
    // Lógica para D[1]
    xor U_D1 (D[1], Q[1], carry[0]);
    
    // Lógica para D[2]
    xor U_D2 (D[2], Q[2], carry[1]);
    
    // Flip-flops para o contador
    flip_flop_d U_FF0 (.D(D[0]), .clk(clk), .rst(rst), .Q(Q[0]), .Qn());
    flip_flop_d U_FF1 (.D(D[1]), .clk(clk), .rst(rst), .Q(Q[1]), .Qn());
    flip_flop_d U_FF2 (.D(D[2]), .clk(clk), .rst(rst), .Q(Q[2]), .Qn());
    
    // Flag de fim de contagem (Q=111)
    and U_DONE (done, Q[2], Q[1], Q[0]);

endmodule
