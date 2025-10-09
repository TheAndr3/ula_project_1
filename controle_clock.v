// Módulo de controle de clock
// Implementação puramente estrutural

module controle_clock (
    input  wire clk_in,             // Clock de entrada
    input  wire rst,                // Reset
    input  wire entrada_numero,     // Sinal de entrada de número
    input  wire entrada_operacao,   // Sinal de entrada de operação
    input  wire executar,           // Sinal de execução
    output wire clk_out,            // Clock de saída
    output wire clk_numero,         // Clock para entrada de número
    output wire clk_operacao,       // Clock para entrada de operação
    output wire clk_execucao        // Clock para execução
);

    // Fios intermediários
    wire entrada_numero_sync, entrada_operacao_sync, executar_sync;
    wire clk_numero_temp, clk_operacao_temp, clk_execucao_temp;
    
    // Sincronização dos sinais de entrada
    flip_flop_d U_SYNC_NUM (
        .D(entrada_numero),
        .clk(clk_in),
        .rst(rst),
        .Q(entrada_numero_sync),
        .Qn()
    );
    
    flip_flop_d U_SYNC_OP (
        .D(entrada_operacao),
        .clk(clk_in),
        .rst(rst),
        .Q(entrada_operacao_sync),
        .Qn()
    );
    
    flip_flop_d U_SYNC_EXEC (
        .D(executar),
        .clk(clk_in),
        .rst(rst),
        .Q(executar_sync),
        .Qn()
    );
    
    // Geração de clocks específicos
    and U_CLK_NUM (clk_numero_temp, clk_in, entrada_numero_sync);
    and U_CLK_OP (clk_operacao_temp, clk_in, entrada_operacao_sync);
    and U_CLK_EXEC (clk_execucao_temp, clk_in, executar_sync);
    
    // Saídas
    buf U_CLK_OUT (clk_out, clk_in);
    buf U_CLK_NUM_OUT (clk_numero, clk_numero_temp);
    buf U_CLK_OP_OUT (clk_operacao, clk_operacao_temp);
    buf U_CLK_EXEC_OUT (clk_execucao, clk_execucao_temp);

endmodule
