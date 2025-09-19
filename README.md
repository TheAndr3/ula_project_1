# ULA (Unidade Lógica e Aritmética) de 5x4 bits em Verilog

## 📖 Visão Geral

Este projeto implementa uma Unidade Lógica e Aritmética (ULA) completa em Verilog, projetada para a placa de desenvolvimento DE10Lite. A ULA é capaz de realizar diversas operações aritméticas e lógicas em dois operandos de entrada, exibindo os resultados em displays de 7 segmentos e o status da operação através de LEDs.

O sistema é controlado por chaves (SW) e botões (KEY) na placa, permitindo ao usuário selecionar os operandos e a operação desejada de forma interativa.

## 🏗️ Estrutura do Projeto

O projeto é organizado em módulos Verilog, onde cada arquivo `.v` representa um componente específico do circuito. A compilação e a configuração do projeto são gerenciadas por arquivos do Quartus (`.qpf`, `.qsf`).

```
/
|-- ULA_TOP.v                   # Módulo principal que conecta todos os componentes
|-- somador_subtrator_4bits.v   # Módulo para soma e subtração
|-- mutiplicacao_5x4.v          # Módulo de multiplicação
|-- divisao_5por4.v             # Módulo de divisão
|-- unidade_and_4bits.v         # Módulo para operação AND
|-- unidade_or_4bits.v          # Módulo para operação OR
|-- unidade_xor_5x4.v           # Módulo para operação XOR
|-- mux_8_para_1_8bits.v        # Multiplexador para selecionar o resultado da operação
|-- bin_to_bcd_8bit_v2.v        # Conversor de binário para BCD
|-- decodificador_7seg.v        # Decodificador para displays de 7 segmentos
|-- operacao_7seg.v             # Módulo para exibir a operação selecionada
|-- soma_cin_a.v                # Módulo auxiliar para somar carry-in ao operando 'a'
|-- flag_*.v                    # Módulos para controle das flags (Zero, Erro, Carry Out, Overflow)
|-- PBL1.qpf                    # Arquivo de Projeto do Quartus
|-- PBL1.qsf                    # Arquivo de Configurações do Quartus
|-- /output_files/              # Diretório com os arquivos de saída da compilação
|-- /db/                        # Banco de dados do Quartus
|-- /simulation/                # Arquivos de simulação
`-- README.md                   # Este arquivo
```

## 📐 Arquitetura da ULA

O coração do projeto é o módulo `ULA_TOP.v`, que instancia e interconecta todos os outros componentes. O fluxo de dados segue os seguintes passos:

1.  **Entrada de Dados**: Os operandos e o seletor de operação são definidos pelas chaves e botões da placa.
2.  **Processamento**: Todas as operações (soma, subtração, AND, etc.) são executadas em paralelo por seus respectivos módulos.
3.  **Seleção**: Um multiplexador de 8 para 1 (`mux_8_para_1_8bits`) seleciona o resultado da operação correta com base nos sinais do seletor.
4.  **Conversão e Exibição**: O resultado final, em binário, é convertido para BCD (`bin_to_bcd_8bit_v2`) e, em seguida, decodificado (`decodificador_7seg`) para ser exibido nos displays de 7 segmentos.
5.  **Sinalização (Flags)**: Módulos específicos analisam o resultado e as entradas para acender os LEDs de status (flags).

### Entradas

As entradas são mapeadas a partir das chaves `SW` e dos botões `KEY` da placa:

  * **Operando `a` (4 bits)**: `SW[3:0]`
  * **Operando `b` (4 bits)**: `SW[7:4]`
  * **Carry-in (1 bit)**: `SW[8]` (usado na soma)
  * **Seletor de Operação (3 bits)**: `{KEY[1], KEY[0], SW[9]}` (com os botões KEY invertidos)

### Operações Suportadas

A ULA seleciona a operação com base na combinação de `{KEY[1], KEY[0], SW[9]}`:

| Seletor (`S`) | Operação | Módulo Utilizado |
| :-----------: | :--- | :--- |
| `000` | Soma A+B | `somador_subtrator_4bits` |
| `001` | Subtração A-B | `subtrator_5x4bits_v2` |
| `010` | A AND B | `unidade_and_4bits` |
| `011` | A OR B | `unidade_or_4bits` |
| `100` | Multiplicação A\*B | `mutiplicacao_5x4` |
| `101` | A XOR B | `unidade_xor_5x4` |
| `110` | Divisão A/B | `divisao_5por4` |
| `111` | Não utilizado | (Saída em 0) |

### Saídas e Flags

Os resultados e o status são exibidos nos periféricos da placa:

  * **`HEX2`, `HEX1`, `HEX0`**: Exibem o resultado da operação (centena, dezena e unidade).
  * **`HEX5`**: Exibe um caractere que representa a operação selecionada.
  * **`LEDR9` (Flag de Erro)**: Acende se ocorrer uma divisão por zero ou se o resultado da subtração for negativo.
  * **`LEDR8` (Flag de Zero)**: Acende se o resultado da operação for igual a zero.
  * **`LEDR7` (Flag de Carry Out)**: Acende se a operação de soma gerar um carry de saída.
  * **`LEDR6` (Flag de Overflow)**: Constantemente no valor 0, não acende no nosso projeto.

## 🧩 Descrição dos Módulos

  * **`ULA_TOP`**: Módulo principal que integra toda a lógica do projeto.
  * **`soma_cin_a`**: Prepara o operando `a` para operações de 5 bits, somando-o com o `carry_in_switch`.
  * **`somador_subtrator_4bits`**: Realiza soma e subtração de 4 bits. No projeto, é usado exclusivamente para a soma A+B.
  * **`subtrator_5x4bits_v2`**: Realiza a subtração de um operando de 5 bits por um de 4 bits. Usado para a operação A-B.
  * **`unidade_and_4bits`, `unidade_or_4bits`, `unidade_xor_5x4`**: Módulos que executam as operações lógicas bit a bit.
  * **`mutiplicacao_5x4`**: Multiplica os operandos `a` (5 bits) e `b` (4 bits), gerando um resultado de até 8 bits.
  * **`divisao_5por4`**: Divide o operando `a` (5 bits) por `b` (4 bits).
  * **`mux_8_para_1_8bits`**: Componente crucial que direciona o resultado de uma das oito operações para a saída final da ULA, com base no seletor de 3 bits.
  * **`bin_to_bcd_8bit_v2`**: Converte o resultado binário de 8 bits da ULA em três dígitos BCD (centena, dezena, unidade) para exibição.
  * **`decodificador_7seg`**: Converte um dígito BCD de 4 bits para os 7 sinais necessários para acender um display de 7 segmentos.
  * **`operacao_7seg`**: Decodifica o seletor de 3 bits para exibir no `HEX5` um símbolo representando a operação atual.
  * **`flag_zero`, `flag_error`, `flag_cout`, `flag_ov`**: Módulos responsáveis por implementar a lógica de sinalização das flags de status nos LEDs.
