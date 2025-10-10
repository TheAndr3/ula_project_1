# 🧹 LIMPEZA DO PROJETO - ARQUIVOS USADOS vs. NÃO USADOS

## 📊 ANÁLISE DE DEPENDÊNCIAS

### ✅ **ARQUIVOS VERILOG NECESSÁRIOS (31 módulos):**

#### **Módulo Principal:**
1. `calculadora_rpn_completa.v` - Módulo top-level

#### **Controle e Sistema:**
2. `pilha_rpn.v` - Pilha RPN de 2 níveis
3. `ula_8bits.v` - ULA principal
4. `controle_clock.v` - Sincronização de clock
5. `controle_memoria.v` - Controle de memória

#### **Conversão e Display:**
6. `conversor_bases.v` - Conversão decimal/hex/octal
7. `operacao_7seg.v` - Display da operação
8. `base_7seg.v` - Display da base
9. `decodificador_7seg.v` - Decodificador para displays
10. `bin_to_bcd_8bit.v` - Conversor binário para BCD

#### **Contadores:**
11. `contador_1bit.v` - Contador para pilha (0-1) **[NOVO!]**
12. `contador_3bits.v` - Contador para mult/div (0-7)

#### **Registradores:**
13. `registrador_8bits.v` - Registrador genérico de 8 bits
14. `registrador_memoria.v` - Registrador de memória
15. `flip_flop_d.v` - Flip-flop tipo D (primitiva)

#### **Operações Aritméticas:**
16. `somador_8bits.v` - Somador de 8 bits
17. `subtrator_8bits.v` - Subtrator de 8 bits
18. `multiplicador_recursivo.v` - Multiplicação recursiva
19. `divisor_real.v` - Divisão com subtrações
20. `full_adder.v` - Full adder (primitiva)

#### **Operações Lógicas:**
21. `unidade_and_8bits.v` - AND de 8 bits
22. `unidade_or_8bits.v` - OR de 8 bits
23. `unidade_xor_8bits.v` - XOR de 8 bits
24. `unidade_not_8bits.v` - NOT de 8 bits

#### **Utilitários:**
25. `comparador_8bits.v` - Comparador de 8 bits
26. `shift_register_8bits.v` - Shift register

#### **Multiplexadores:**
27. `mux_2_para_1_8bits.v` - MUX 2:1 de 8 bits
28. `mux_4_para_1_4bits.v` - MUX 4:1 de 4 bits
29. `mux_4_para_1_7bits.v` - MUX 4:1 de 7 bits
30. `mux_4_para_1_8bits.v` - MUX 4:1 de 8 bits
31. `mux_8_para_1_8bits.v` - MUX 8:1 de 8 bits
32. `mux_8_para_1.v` - MUX 8:1 de 1 bit

---

## ❌ **ARQUIVOS PARA REMOVER:**

### **Backups (.bak) - 16 arquivos:**
1. `divisao_5por4.v.bak`
2. `flag_cout.v.bak`
3. `flag_error.v.bak`
4. `flag_zero.v.bak`
5. `full_adder.v.bak`
6. `mutiplicacao_5x4.v.bak`
7. `operacao_7seg.v.bak`
8. `mux_8_para_1_8bits.v.bak`
9. `porta_xor.v.bak`
10. `soma_cin_a.v.bak`
11. `somador_subtrator_4bits.v.bak`
12. `subtrator_5x4bits.v.bak`
13. `ULA_TOP.v.bak`
14. `unidade_and_4bits.v.bak`
15. `unidade_or_4bits.v.bak`
16. `unidade_xor_5x4.v.bak`

### **Módulos Obsoletos - 2 arquivos:**
1. `contador_2bits.v` - Substituído por `contador_1bit.v`
2. `decodificador_2_4.v` - Não é mais necessário

### **Outros Módulos Não Usados:**
3. `mux_2_para_1.v` - Versão de 1 bit (não usado)
4. `mux_4_para_1.v` - Versão de 1 bit (não usado)

---

## 📦 **TOTAL DE ARQUIVOS A REMOVER: 22**

- Backups (.bak): 16
- Obsoletos: 2
- Não usados: 4

---

## ✅ **AÇÕES DE LIMPEZA:**

### **1. Remover todos os .bak**
```
16 arquivos de backup desnecessários
```

### **2. Remover módulos obsoletos**
```
contador_2bits.v → Substituído por contador_1bit.v
decodificador_2_4.v → Pilha agora tem controle direto
```

### **3. Remover multiplexadores de 1 bit não usados**
```
mux_2_para_1.v
mux_4_para_1.v
```

---

## 📊 **RESUMO:**

| Categoria | Quantidade |
|-----------|------------|
| **Arquivos .v necessários** | 32 |
| **Arquivos .bak para remover** | 16 |
| **Arquivos .v obsoletos** | 2 |
| **Arquivos .v não usados** | 2 |
| **Total para remover** | 20 |

---

**Após a limpeza, o projeto terá apenas os 32 arquivos essenciais!** 🎯

