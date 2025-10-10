# Sistema de Operações com Entrada Compartilhada de 8 Bits

## Resumo das Modificações

Foi implementado um sistema que utiliza as chaves SW[7:0] de forma compartilhada para entrada de números e operações, com o contador de 2 bits definindo o momento correto de cada entrada. O sistema suporta 8 operações completas conforme especificado no projeto.

## Mapeamento de Operações

### Operações Aritméticas:
- **000 (SW[2:0] = 000)**: Soma (A + B)
- **001 (SW[2:0] = 001)**: Subtração (A - B)
- **010 (SW[2:0] = 010)**: Multiplicação (A × B) com saturação
- **011 (SW[2:0] = 011)**: Divisão (A ÷ B) com detecção de divisão por zero

### Operações Lógicas:
- **100 (SW[2:0] = 100)**: AND (A & B)
- **101 (SW[2:0] = 101)**: OR (A | B)
- **110 (SW[2:0] = 110)**: XOR (A ^ B)
- **111 (SW[2:0] = 111)**: NOT (~A)

## Arquivos Criados/Modificados

### 1. decodificador_operacoes.v (NOVO)

**Funcionalidade:**
- Converte entrada de 8 bits para código interno de 3 bits
- Usa os 3 bits menos significativos (SW[2:0]) para codificar as operações
- Implementação 100% estrutural

**Entradas:**
- `operacao_8bits[7:0]`: Código da operação de 8 bits (SW[7:0])

**Saídas:**
- `codigo_operacao[2:0]`: Código interno da operação (0-7)

### 2. calculadora_rpn_completa.v (MODIFICADO)

**Principais mudanças:**
- Integrado decodificador de operações
- SW[7:0] usado compartilhadamente para números e operações
- Contador define o momento de cada entrada
- Operações processadas com código interno de 3 bits

## Funcionamento do Sistema

### Sequência de Entrada com Contador:

1. **Estado 00 (LEDR[1:0] = 00)**: Entrada do número A
   - Configure SW[7:0] com o valor desejado (0-255)
   - Pressione KEY[0] para confirmar entrada
   - LEDR[8] acende indicando entrada do número A

2. **Estado 01 (LEDR[1:0] = 01)**: Entrada do número B
   - Configure SW[7:0] com o segundo valor (0-255)
   - Pressione KEY[0] para confirmar entrada
   - LEDR[8] apaga, contador incrementa

3. **Estado 10 (LEDR[1:0] = 10)**: Entrada da operação
   - Configure SW[2:0] com o código da operação (000-111)
   - SW[7:3] são ignorados durante entrada de operação
   - Pressione KEY[0] para confirmar operação
   - LEDR[9] acende indicando entrada da operação

4. **Estado 11 (LEDR[1:0] = 11)**: Execução automática
   - Sistema executa a operação automaticamente
   - Contador reseta para 00
   - Resultado é exibido nos displays

### Exemplos de Uso:

#### Exemplo 1: Soma (5 + 3 = 8)
1. SW[7:0] = 00000101 (5), pressione KEY[0] (entrada A)
2. SW[7:0] = 00000011 (3), pressione KEY[0] (entrada B)
3. SW[2:0] = 000 (soma), pressione KEY[0] (operação)
4. Sistema executa e mostra resultado 8

#### Exemplo 2: AND Lógico (5 & 3 = 1)
1. SW[7:0] = 00000101 (5), pressione KEY[0] (entrada A)
2. SW[7:0] = 00000011 (3), pressione KEY[0] (entrada B)
3. SW[2:0] = 100 (AND), pressione KEY[0] (operação)
4. Sistema executa e mostra resultado 1

#### Exemplo 3: NOT Lógico (~5 = 250)
1. SW[7:0] = 00000101 (5), pressione KEY[0] (entrada A)
2. SW[7:0] = 00000000 (B ignorado), pressione KEY[0] (entrada B)
3. SW[2:0] = 111 (NOT), pressione KEY[0] (operação)
4. Sistema executa e mostra resultado 250

## Controles do Sistema

### Entradas Físicas:
- **SW[7:0]**: Entrada compartilhada (números 0-255 ou operações 000-111)
- **SW[9:8]**: Seleção de base (00=decimal, 01=hex, 10=octal)
- **KEY[0]**: Botão de entrada (incrementa contador)
- **KEY[1]**: Reset global

### Saídas:
- **HEX0-HEX2**: Resultado na base selecionada
- **HEX3**: Sempre desligado
- **HEX4**: Código da operação sendo executada
- **HEX5**: Base numérica selecionada (d/h/o)
- **LEDR[1:0]**: Estado do contador
- **LEDR[8]**: Entrada do número A ativa
- **LEDR[9]**: Entrada da operação ativa
- **LEDR[2-7]**: Flags do sistema

## Vantagens do Sistema

1. **Economia de Recursos**: Apenas 8 chaves para números e operações
2. **Sequência Garantida**: Contador garante ordem correta A → B → operação → execução
3. **8 Operações Completas**: Todas as operações aritméticas e lógicas especificadas
4. **Flexibilidade**: Suporte a operandos de 8 bits (0-255)
5. **Visualização Clara**: LEDs indicam o estado atual do sistema

## Implementação Estrutural

- Decodificador de operações usando apenas buffers
- Contador de 2 bits com flip-flops D
- Controle de entrada com portas lógicas
- Nenhum `assign` ou `always` utilizado
- Implementação 100% estrutural conforme especificação

O sistema agora atende completamente aos requisitos do projeto, utilizando eficientemente as chaves disponíveis e garantindo o funcionamento correto de todas as 8 operações especificadas.
