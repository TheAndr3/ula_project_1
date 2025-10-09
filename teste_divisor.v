// Arquivo de teste para o divisor real
// Este arquivo não será usado no projeto final

module teste_divisor;

    // Teste do comparador de 8 bits
    wire [7:0] a_comp, b_comp;
    wire a_gt_b_comp, a_eq_b_comp, a_lt_b_comp;
    comparador_8bits U_TESTE_COMP (
        .a(a_comp), .b(b_comp),
        .a_gt_b(a_gt_b_comp), .a_eq_b(a_eq_b_comp), .a_lt_b(a_lt_b_comp)
    );

    // Teste do divisor real
    wire [7:0] dividendo_div, divisor_div;
    wire clk_div, rst_div, start_div;
    wire [7:0] quociente_div, resto_div;
    wire done_div, div_zero_div, overflow_div;
    divisor_real U_TESTE_DIV (
        .dividendo(dividendo_div), .divisor(divisor_div),
        .clk(clk_div), .rst(rst_div), .start(start_div),
        .quociente(quociente_div), .resto(resto_div),
        .done(done_div), .div_zero(div_zero_div), .overflow(overflow_div)
    );

    // Teste da ULA com divisor real
    wire [7:0] a_ula, b_ula;
    wire [2:0] operacao_ula;
    wire clk_ula, rst_ula;
    wire [7:0] resultado_ula;
    wire overflow_ula, zero_ula, carry_out_ula, erro_ula;
    ula_8bits U_TESTE_ULA (
        .a(a_ula), .b(b_ula), .operacao(operacao_ula),
        .clk(clk_ula), .rst(rst_ula),
        .resultado(resultado_ula), .overflow(overflow_ula),
        .zero(zero_ula), .carry_out(carry_out_ula), .erro(erro_ula)
    );

endmodule
