// Registrador de memória dedicado para armazenar o último resultado
// Implementação puramente estrutural

module registrador_memoria (
    input  wire [7:0] resultado_entrada,  // Resultado a ser armazenado
    input  wire clk,                      // Clock
    input  wire rst,                      // Reset (ativo baixo)
    input  wire carregar,                 // Sinal para carregar novo resultado
    input  wire [7:0] valor_memoria,      // Valor atual da memória
    output wire [7:0] memoria_saida,      // Saída da memória
    output wire [7:0] resultado_saida     // Saída do resultado (para exibição)
);

    // Registrador de 8 bits para armazenar o último resultado
    registrador_8bits U_REG_MEMORIA (
        .D(resultado_entrada),
        .CLK(clk),
        .RST(rst),
        .EN(carregar),
        .Q(memoria_saida)
    );

    // Multiplexador para selecionar entre memória e resultado atual
    mux_2_para_1_8bits U_MUX_SAIDA (
        .D0(valor_memoria),      // Valor da memória
        .D1(resultado_entrada),  // Resultado atual
        .S(carregar),            // Selecionar baseado no sinal de carregar
        .Y(resultado_saida)
    );

endmodule
