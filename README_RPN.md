# Calculadora RPN (Reverse Polish Notation) em FPGA

## 📖 Visão Geral

Este projeto implementa uma calculadora digital baseada em RPN (Reverse Polish Notation) para a placa DE10-Lite. O sistema utiliza operandos de 8 bits e permite entrada de números e operadores seguindo o modelo RPN, com visualização em diferentes bases (decimal, octal e hexadecimal).

## 🏗️ Estrutura do Projeto

### ✅ **Módulos Implementados:**

#### **Operações Aritméticas:**
- `somador_8bits.v` - Soma de 8 bits com detecção de overflow
- `subtrator_8bits.v` - Subtração de 8 bits usando complemento de 2
- `multiplicador_8bits.v` - Multiplicação de 8 bits com saturação
- `divisor_8bits.v` - Divisão de 8 bits com detecção de divisão por zero

#### **Operações Lógicas:**
- `unidade_and_8bits.v` - Operação AND de 8 bits
- `unidade_or_8bits.v` - Operação OR de 8 bits
- `unidade_xor_8bits.v` - Operação XOR de 8 bits
- `unidade_not_8bits.v` - Operação NOT de 8 bits

#### **Sistema RPN:**
- `sistema_rpn.v` - Gerenciamento da pilha RPN com registradores
- `mux_2_para_1_8bits.v` - Multiplexador 2:1 de 8 bits
- `mux_2_para_1.v` - Multiplexador 2:1 básico

#### **Conversão de Bases:**
- `conversor_bases.v` - Conversão entre decimal, hexadecimal e octal
- `mux_4_para_1_4bits.v` - Multiplexador 4:1 de 4 bits
- `mux_4_para_1_7bits.v` - Multiplexador 4:1 de 7 bits
- `mux_4_para_1.v` - Multiplexador 4:1 básico
- `base_7seg.v` - Display da base selecionada

#### **ULA Principal:**
- `ula_8bits.v` - Unidade Lógica e Aritmética de 8 bits
- `calculadora_rpn.v` - Módulo principal da calculadora

#### **Módulos de Teste:**
- `teste_modulos.v` - Arquivo de teste para verificação de compilação

## 🔧 **Funcionalidades Implementadas:**

### **Operações Suportadas:**
1. **Aritméticas:**
   - Soma (A + B)
   - Subtração (A - B)
   - Multiplicação (A × B) com saturação
   - Divisão (A ÷ B) com detecção de divisão por zero

2. **Lógicas:**
   - AND (A & B)
   - OR (A | B)
   - XOR (A ^ B)
   - NOT (~A)

### **Flags de Status:**
- **Overflow (OV)** - Detecção de estouro aritmético
- **Zero (Z)** - Resultado igual a zero
- **Carry out (COUT)** - Carry de saída
- **Erro (ERR)** - Divisão por zero ou resultado negativo

### **Visualização:**
- **Decimal** - Exibição em base 10
- **Hexadecimal** - Exibição em base 16
- **Octal** - Exibição em base 8

## 🚧 **O que ainda precisa ser implementado:**

### **1. Sistema RPN Completo:**
- [ ] Implementação real de registradores (flip-flops)
- [ ] Lógica de empilhamento/desempilhamento
- [ ] Controle de estado da pilha
- [ ] Interface de entrada RPN

### **2. Integração com a Placa DE10-Lite:**
- [ ] Mapeamento correto dos pinos da placa
- [ ] Controle de clock e reset
- [ ] Interface de entrada de 8 bits
- [ ] Configuração do Quartus

### **3. Melhorias nos Módulos:**
- [ ] Implementação real do multiplicador (algoritmo de Booth)
- [ ] Implementação real do divisor (algoritmo de divisão)
- [ ] Otimização dos multiplexadores
- [ ] Tratamento de sinais de clock

### **4. Testes e Validação:**
- [ ] Testbench para simulação
- [ ] Testes de funcionalidade
- [ ] Validação na placa física
- [ ] Documentação de uso

## 📋 **Requisitos Atendidos:**

### ✅ **Parcialmente Atendidos:**
- Operações aritméticas e lógicas
- Flags de status
- Visualização em diferentes bases
- Estrutura modular

### ❌ **Não Atendidos:**
- Sistema RPN funcional
- Entrada de operandos de 8 bits
- Integração com a placa DE10-Lite
- Memória/registradores reais

## 🔄 **Próximos Passos:**

1. **Implementar registradores reais** usando flip-flops
2. **Criar sistema de clock** para sincronização
3. **Integrar com a placa DE10-Lite** mapeando pinos corretos
4. **Implementar interface RPN** com botões de entrada
5. **Criar testbench** para validação
6. **Otimizar módulos** para melhor performance

## 📁 **Arquivos do Projeto:**

```
/
├── unidade_not_8bits.v          # Operação NOT
├── conversor_bases.v            # Conversão de bases
├── mux_4_para_1_4bits.v        # MUX 4:1 de 4 bits
├── mux_4_para_1_7bits.v        # MUX 4:1 de 7 bits
├── mux_4_para_1.v              # MUX 4:1 básico
├── mux_2_para_1_8bits.v        # MUX 2:1 de 8 bits
├── mux_2_para_1.v              # MUX 2:1 básico
├── sistema_rpn.v               # Sistema RPN
├── ula_8bits.v                 # ULA principal
├── somador_8bits.v             # Somador de 8 bits
├── subtrator_8bits.v           # Subtrator de 8 bits
├── multiplicador_8bits.v       # Multiplicador de 8 bits
├── divisor_8bits.v             # Divisor de 8 bits
├── unidade_and_8bits.v         # Operação AND
├── unidade_or_8bits.v          # Operação OR
├── unidade_xor_8bits.v         # Operação XOR
├── calculadora_rpn.v           # Módulo principal
├── base_7seg.v                 # Display da base
├── teste_modulos.v             # Arquivo de teste
└── README_RPN.md               # Este arquivo
```

## ⚠️ **Notas Importantes:**

1. **Implementação Estrutural:** Todos os módulos foram implementados usando apenas portas lógicas básicas (AND, OR, NOT, XOR) e multiplexadores, sem uso de `assign` ou `always`.

2. **Simplificações:** Alguns módulos (multiplicador e divisor) foram simplificados para demonstração. Em uma implementação real, seriam necessários algoritmos mais complexos.

3. **Registradores:** O sistema RPN atual usa fios para simular registradores. Em uma implementação real, seriam necessários flip-flops.

4. **Clock:** O sistema atual não usa clock. Para funcionar corretamente, seria necessário implementar um sistema de clock.

## 🎯 **Objetivo Final:**

Criar uma calculadora RPN funcional que:
- Aceite entrada de números de 8 bits
- Execute operações aritméticas e lógicas
- Armazene resultados em registradores
- Exiba resultados em diferentes bases
- Funcione corretamente na placa DE10-Lite
