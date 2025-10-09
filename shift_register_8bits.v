// Shift register de 8 bits
// Implementação puramente estrutural

module shift_register_8bits (
    input  wire [7:0] D,        // Entrada de dados
    input  wire clk,            // Clock
    input  wire rst,            // Reset (ativo baixo)
    input  wire shift,          // Sinal de shift (ativo alto)
    input  wire load,           // Sinal de carga (ativo alto)
    input  wire shift_in,       // Entrada de shift (bit a ser inserido)
    output wire [7:0] Q,        // Saída paralela
    output wire shift_out       // Saída de shift (bit deslocado)
);

    // Fios intermediários
    wire [7:0] D_gated;
    wire [7:0] shift_data;
    
    // Lógica de carga vs shift
    mux_2_para_1_8bits U_MUX_LOAD_SHIFT (
        .D0(shift_data),        // Dados para shift
        .D1(D),                 // Dados para carga
        .S(load),               // Seleciona carga quando load=1
        .Y(D_gated)
    );

    // Dados para shift (deslocamento à direita)
    buf U_SHIFT0 (shift_data[0], shift_in);
    buf U_SHIFT1 (shift_data[1], Q[0]);
    buf U_SHIFT2 (shift_data[2], Q[1]);
    buf U_SHIFT3 (shift_data[3], Q[2]);
    buf U_SHIFT4 (shift_data[4], Q[3]);
    buf U_SHIFT5 (shift_data[5], Q[4]);
    buf U_SHIFT6 (shift_data[6], Q[5]);
    buf U_SHIFT7 (shift_data[7], Q[6]);

    // Registradores (flip-flops D)
    flip_flop_d U_FF0 (.D(D_gated[0]), .clk(clk), .rst(rst), .Q(Q[0]), .Qn());
    flip_flop_d U_FF1 (.D(D_gated[1]), .clk(clk), .rst(rst), .Q(Q[1]), .Qn());
    flip_flop_d U_FF2 (.D(D_gated[2]), .clk(clk), .rst(rst), .Q(Q[2]), .Qn());
    flip_flop_d U_FF3 (.D(D_gated[3]), .clk(clk), .rst(rst), .Q(Q[3]), .Qn());
    flip_flop_d U_FF4 (.D(D_gated[4]), .clk(clk), .rst(rst), .Q(Q[4]), .Qn());
    flip_flop_d U_FF5 (.D(D_gated[5]), .clk(clk), .rst(rst), .Q(Q[5]), .Qn());
    flip_flop_d U_FF6 (.D(D_gated[6]), .clk(clk), .rst(rst), .Q(Q[6]), .Qn());
    flip_flop_d U_FF7 (.D(D_gated[7]), .clk(clk), .rst(rst), .Q(Q[7]), .Qn());

    // Saída de shift (bit mais significativo)
    buf U_SHIFT_OUT (shift_out, Q[7]);

endmodule
