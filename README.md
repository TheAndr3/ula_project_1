# Calculadora RPN Digital em FPGA - DE10-Lite

## 📖 Visão Geral

Este projeto foi implementado por **André Vinícius, Felipe Tenório e Antônio Herval**, formulamos uma **calculadora digital baseada em RPN (Reverse Polish Notation)** para a placa FPGA DE10-Lite. O sistema utiliza operandos de 8 bits e permite entrada de números e operadores seguindo o modelo RPN, execução de operações aritméticas, lógicas e especiais, armazenamento automático do último resultado em um registrador de memória reutilizável, e visualização do resultado em diferentes bases (decimal, octal e hexadecimal).

O projeto foi desenvolvido com **implementação 100% estrutural** em Verilog, utilizando apenas portas lógicas primitivas e instâncias de módulos, sem uso de `assign`, `always` ou construções comportamentais.

## 🎯 Requisitos Atendidos

### ✅ Entradas
- **Dois operandos de 8 bits**: `SW[7:0]` para entrada de números
- **Seleção da operação (OP)**: `{KEY[1], KEY[0], SW[8]}` (3 bits)
- **Botões para entrada/execução**: `KEY[0]` (entrada número), `KEY[1]` (entrada operação), `SW[9]` (executar)
- **Seleção da base de exibição (BASE)**: `{SW[9], 1'b0}` (2 bits)

### ✅ Saídas
- **Resultado em displays de 7 segmentos**: `HEX0-HEX5`
- **LEDs para flags**: `LEDR[9:0]`

### ✅ Operações Aritméticas
- **Soma (A + B)**: Código `000`
- **Subtração (A – B)**: Código `001`
- **Multiplicação (A × B)**: Código `010` - com saturação, utilizando somador recursivamente
- **Divisão (A ÷ B)**: Código `011` - com detecção de divisão por zero

### ✅ Operações Lógicas
- **AND (A & B)**: Código `100`
- **OR (A | B)**: Código `101`
- **XOR (A ^ B)**: Código `110`
- **NOT (~A)**: Código `111`

### ✅ Memória
- **Armazenamento automático** do último resultado em registrador A

### ✅ Flags
- **Overflow (OV)**: `LEDR[1]`
- **Zero (Z)**: `LEDR[0]`
- **Carry out (COUT)**: `LEDR[2]`
- **Erro (ERR)**: `LEDR[3]`
- **Pilha vazia**: `LEDR[4]`
- **Pilha cheia**: `LEDR[5]`

### ✅ Visualização em Diferentes Bases
- **Hexadecimal**: `00` - Exibe em base 16
- **Decimal**: `01` - Exibe em base 10 (BCD)
- **Octal**: `10` - Exibe em base 8

## 🏗️ Arquitetura do Sistema

### Módulo Principal: `calculadora_rpn_completa.v`
O sistema é controlado pelo módulo principal que integra todos os componentes:

```
┌─────────────────────────────────────────────────────────────┐
│                    CALCULADORA RPN COMPLETA                 │
├─────────────────────────────────────────────────────────────┤
│  Entradas: SW[9:0], KEY[1:0], CLOCK_50                    │
│  Saídas: HEX0-HEX5, LEDR[9:0]                             │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    SISTEMA DE PILHA RPN                    │
├─────────────────────────────────────────────────────────────┤
│  • 2 Registradores de 8 bits (reg0, reg1)                 │
│  • Pilha simplificada para operações básicas               │
│  • Operandos A = reg0 (topo), B = reg1 (segundo)          │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                      ULA DE 8 BITS                         │
├─────────────────────────────────────────────────────────────┤
│  • Todas as operações aritméticas e lógicas                │
│  • Flags: Overflow, Zero, Carry Out, Erro                  │
│  • Implementação 100% estrutural                           │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                 SISTEMA DE CONVERSÃO DE BASES              │
├─────────────────────────────────────────────────────────────┤
│  • Conversão para Decimal (BCD)                            │
│  • Conversão para Hexadecimal                              │
│  • Conversão para Octal                                    │
│  • Seleção via chaves da placa                             │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    CONTROLE DE MEMÓRIA                     │
├─────────────────────────────────────────────────────────────┤
│  • Armazenamento automático do último resultado            │
│  • Registrador de memória reutilizável                     │
│  • Integração com sistema de exibição                      │
└─────────────────────────────────────────────────────────────┘
```

## 📁 Estrutura do Projeto

```
ula_project/
├── calculadora_rpn_completa.v      # Módulo principal da calculadora
├── pilha_rpn.v                     # Sistema de pilha RPN com 4 registradores
├── ula_8bits.v                     # ULA principal com todas as operações
├── conversor_bases.v               # Conversão entre bases (dec, hex, oct)
├── controle_memoria.v              # Controle de armazenamento automático
├── controle_clock.v                # Sistema de controle de clock
├── operacao_7seg.v                 # Display da operação selecionada
├── base_7seg.v                     # Display da base selecionada
│
├── # Módulos de Operações Aritméticas
├── somador_8bits.v                 # Somador de 8 bits
├── subtrator_8bits.v               # Subtrator de 8 bits
├── multiplicador_recursivo.v       # Multiplicação usando soma recursiva
├── divisor_real.v                  # Divisão com detecção de divisão por zero
│
├── # Módulos de Operações Lógicas
├── unidade_and_8bits.v             # Operação AND de 8 bits
├── unidade_or_8bits.v              # Operação OR de 8 bits
├── unidade_xor_8bits.v             # Operação XOR de 8 bits
├── unidade_not_8bits.v             # Operação NOT de 8 bits
│
├── # Módulos de Suporte
├── registrador_8bits.v             # Registrador de 8 bits
├── registrador_memoria.v           # Registrador de memória especializado
├── contador_1bit.v                 # Contador simplificado para pilha (NOVO!)
├── contador_3bits.v                # Contador para operações sequenciais
├── shift_register_8bits.v          # Registrador de deslocamento
├── comparador_8bits.v              # Comparador de 8 bits
├── bin_to_bcd_8bit.v               # Conversor binário para BCD
├── decodificador_7seg.v            # Decodificador para displays
│
├── # Multiplexadores
├── mux_2_para_1.v                  # Multiplexador 2:1
├── mux_2_para_1_8bits.v            # Multiplexador 2:1 de 8 bits
├── mux_4_para_1.v                  # Multiplexador 4:1
├── mux_4_para_1_4bits.v            # Multiplexador 4:1 de 4 bits
├── mux_4_para_1_7bits.v            # Multiplexador 4:1 de 7 bits
├── mux_8_para_1.v                  # Multiplexador 8:1
├── mux_8_para_1_8bits.v            # Multiplexador 8:1 de 8 bits
│
├── # Arquivos do Quartus
├── PBL1.qpf                        # Arquivo de projeto
├── PBL1.qsf                        # Arquivo de configurações
├── PBL1.qws                        # Arquivo de workspace
│
├── # Diretórios
├── output_files/                   # Arquivos de saída da compilação
├── db/                             # Banco de dados do Quartus
├── simulation/                     # Arquivos de simulação
└── README.md                       # Este arquivo
```

## 🔧 Implementação Técnica

### Características da Implementação
- **100% Estrutural**: Utiliza apenas portas lógicas primitivas e instâncias de módulos
- **Sem construções comportamentais**: Não usa `assign`, `always`, `case`, `if-else`
- **Portas primitivas**: `buf`, `not`, `and`, `or`, `xor`, `nand`, `nor`
- **Módulos customizados**: Todos os componentes são implementados estruturalmente

### Sistema de Pilha RPN
- **2 registradores de 8 bits**: Pilha simplificada para operações básicas
- **Deslocamento**: `reg1 ← reg0 ← entrada`
- **Operandos**: A = reg0 (topo), B = reg1 (segundo)
- **Controle**: Contador de 1 bit para gerenciar estado da pilha (0 ou 1)

### Operações Aritméticas Avançadas
- **Multiplicação recursiva**: Usa soma repetida com shift registers
- **Divisão real**: Implementa algoritmo de divisão com subtrações repetidas
- **Detecção de erros**: Divisão por zero, overflow, underflow
- **Saturação**: Resultados limitados a 8 bits

### Conversão de Bases
- **Decimal**: Conversão binário para BCD (3 dígitos)
- **Hexadecimal**: Separação em nibbles (2 dígitos hex)
- **Octal**: Agrupamento em grupos de 3 bits (3 dígitos octais)
- **Seleção**: Multiplexadores para escolha da base

## 🎮 Como Usar

### Entrada de Números
1. Configure o número desejado nas chaves `SW[7:0]`
2. Pressione `KEY[0]` para inserir o número na pilha
3. O número será deslocado para o topo da pilha

### Entrada de Operações
1. Configure a operação desejada em `{KEY[1], KEY[0], SW[8]}`
2. Pressione `KEY[1]` para inserir a operação
3. Configure `SW[9]` para executar a operação

### Seleção de Base
- **Decimal**: `{SW[9], 1'b0} = 00`
- **Hexadecimal**: `{SW[9], 1'b0} = 01`
- **Octal**: `{SW[9], 1'b0} = 10`

### Exemplo de Uso RPN
```
Entrada: 5 → KEY[0] → 3 → KEY[0] → + → KEY[1] → SW[9]
Resultado: 8 (5 + 3 = 8)
```

## 🔍 Códigos de Operação

| Código | Operação | Descrição |
|--------|----------|-----------|
| `000` | Soma | A + B |
| `001` | Subtração | A - B |
| `010` | Multiplicação | A × B (recursiva) |
| `011` | Divisão | A ÷ B (com detecção de erro) |
| `100` | AND | A & B |
| `101` | OR | A \| B |
| `110` | XOR | A ^ B |
| `111` | NOT | ~A |

## 🚀 Compilação e Uso

1. **Abrir no Quartus**: Carregar `PBL1.qpf`
2. **Compilar**: Compilar o projeto (Ctrl+L)
3. **Programar FPGA**: Conectar placa DE10-Lite e programar
4. **Testar**: Usar chaves e botões para testar funcionalidades

## 📊 Status do Projeto

- ✅ **Implementação 100% estrutural** concluída
- ✅ **Todas as operações** implementadas e testadas
- ✅ **Sistema RPN** funcional
- ✅ **Conversão de bases** implementada
- ✅ **Flags e indicadores** funcionais
- ✅ **Memória automática** implementada
- ✅ **Sem erros de sintaxe** ou compilação
- ✅ **Pronto para FPGA** DE10-Lite

## 👥 Desenvolvedores

Projeto desenvolvido para a disciplina TEC498 - Laboratório de Eletrônica Digital e Sistemas.

---

**Nota**: Este projeto implementa uma calculadora RPN completa seguindo rigorosamente os princípios de design estrutural em Verilog, garantindo máxima compatibilidade com ferramentas de síntese e implementação em FPGA.