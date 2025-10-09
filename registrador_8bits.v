// Registrador de 8 bits usando flip-flops D
// Implementação puramente estrutural

module registrador_8bits (
    input  wire [7:0] D,        // Entrada de dados de 8 bits
    input  wire clk,            // Clock
    input  wire rst,            // Reset (ativo baixo)
    input  wire load,           // Sinal de carga (ativo alto)
    output wire [7:0] Q,        // Saída de 8 bits
    output wire [7:0] Qn        // Saída negada de 8 bits
);

    // Fio para D gated com load
    wire [7:0] D_gated;
    
    // Lógica de carga: D_gated = D quando load=1, senão mantém Q
    mux_2_para_1_8bits U_MUX_LOAD (
        .D0(Q),         // Mantém valor atual
        .D1(D),         // Carrega novo valor
        .S(load),       // Seleciona baseado no sinal load
        .Y(D_gated)
    );

    // Instanciação de 8 flip-flops D
    flip_flop_d U_FF0 (.D(D_gated[0]), .clk(clk), .rst(rst), .Q(Q[0]), .Qn(Qn[0]));
    flip_flop_d U_FF1 (.D(D_gated[1]), .clk(clk), .rst(rst), .Q(Q[1]), .Qn(Qn[1]));
    flip_flop_d U_FF2 (.D(D_gated[2]), .clk(clk), .rst(rst), .Q(Q[2]), .Qn(Qn[2]));
    flip_flop_d U_FF3 (.D(D_gated[3]), .clk(clk), .rst(rst), .Q(Q[3]), .Qn(Qn[3]));
    flip_flop_d U_FF4 (.D(D_gated[4]), .clk(clk), .rst(rst), .Q(Q[4]), .Qn(Qn[4]));
    flip_flop_d U_FF5 (.D(D_gated[5]), .clk(clk), .rst(rst), .Q(Q[5]), .Qn(Qn[5]));
    flip_flop_d U_FF6 (.D(D_gated[6]), .clk(clk), .rst(rst), .Q(Q[6]), .Qn(Qn[6]));
    flip_flop_d U_FF7 (.D(D_gated[7]), .clk(clk), .rst(rst), .Q(Q[7]), .Qn(Qn[7]));

endmodule
