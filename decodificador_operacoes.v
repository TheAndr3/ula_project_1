// Módulo decodificador de operações de 8 bits
// Implementação puramente estrutural

module decodificador_operacoes (
    input  wire [7:0] operacao_8bits,    // Código da operação de 8 bits
    output wire [2:0] codigo_operacao    // Código interno da operação (0-7)
);

    // Mapeamento das operações (usando os 3 bits menos significativos):
    // 000 = Soma (A + B)
    // 001 = Subtração (A - B)  
    // 010 = Multiplicação (A × B)
    // 011 = Divisão (A ÷ B)
    // 100 = AND (A & B)
    // 101 = OR (A | B)
    // 110 = XOR (A ^ B)
    // 111 = NOT (~A)

    // Simplesmente passar os 3 bits menos significativos
    buf U_COD_OP_0 (codigo_operacao[0], operacao_8bits[0]);
    buf U_COD_OP_1 (codigo_operacao[1], operacao_8bits[1]);
    buf U_COD_OP_2 (codigo_operacao[2], operacao_8bits[2]);

endmodule
