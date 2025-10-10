# Sistema de Contador de Entrada RPN

## Resumo das Modificações

Foi implementado um contador de 2 bits para controlar o fluxo de entrada da calculadora RPN, permitindo uma sequência ordenada de entrada: número A → número B → operação → execução.

## Arquivos Criados

### 1. contador_2bits.v

**Funcionalidade:**
- Contador de 2 bits que incrementa a cada pulso de enable
- Reset automático quando chega em 11 (3 em decimal)
- Reset manual via sinal rst
- Implementação 100% estrutural usando flip-flops D

**Entradas:**
- `clk`: Clock de entrada
- `rst`: Reset (ativo baixo)
- `enable`: Enable para incrementar

**Saídas:**
- `count[1:0]`: Valor do contador

### 2. controle_entrada.v

**Funcionalidade:**
- Decodifica o estado do contador
- Gera sinais de controle para cada tipo de entrada
- Implementação 100% estrutural

**Entradas:**
- `entrada_numero[7:0]`: Número de entrada
- `operacao[2:0]`: Código da operação
- `contador_entrada[1:0]`: Estado do contador
- `entrada_botao`: Botão de entrada

**Saídas:**
- `entrada_numero_a`: Enable para entrada do número A
- `entrada_numero_b`: Enable para entrada do número B
- `entrada_operacao`: Enable para entrada da operação
- `executar_operacao`: Enable para executar operação

## Arquivos Modificados

### 3. calculadora_rpn_completa.v

**Principais mudanças:**
- Integrado o contador de 2 bits
- Integrado o módulo de controle de entrada
- Modificado mapeamento de entradas:
  - `KEY[0]`: Botão de entrada (A, B ou operação)
  - `KEY[1]`: Reset global
- Atualizado sistema de LEDs para mostrar estado do contador
- Conectado sinais de controle ao sistema de pilha RPN

## Funcionamento

### Sequência de Entrada

1. **Estado 00 (LEDR[1:0] = 00)**: Entrada do número A
   - Configure SW[7:0] com o valor desejado
   - Pressione KEY[0] para confirmar entrada
   - LEDR[8] acende indicando entrada do número A

2. **Estado 01 (LEDR[1:0] = 01)**: Entrada do número B
   - Configure SW[7:0] com o segundo valor
   - Pressione KEY[0] para confirmar entrada
   - LEDR[8] apaga, contador incrementa

3. **Estado 10 (LEDR[1:0] = 10)**: Entrada da operação
   - Configure SW[8] com o bit da operação
   - Pressione KEY[0] para confirmar operação
   - LEDR[9] acende indicando entrada da operação

4. **Estado 11 (LEDR[1:0] = 11)**: Execução automática
   - Sistema executa a operação automaticamente
   - Contador reseta para 00
   - Resultado é exibido nos displays

### Controles

- **KEY[0]**: Botão de entrada (incrementa contador e confirma entrada)
- **KEY[1]**: Reset global (reseta contador e sistema)
- **SW[7:0]**: Entrada de números (8 bits)
- **SW[8]**: Bit da operação
- **SW[9:8]**: Seleção de base (00=dec, 01=hex, 10=oct)

### Indicadores Visuais

- **LEDR[1:0]**: Estado do contador (00, 01, 10, 11)
- **LEDR[8]**: Entrada do número A ativa
- **LEDR[9]**: Entrada da operação ativa
- **LEDR[2-7]**: Flags do sistema (zero, overflow, carry, erro, pilha vazia/cheia)

## Implementação Estrutural

Todos os módulos foram implementados usando apenas:
- Portas lógicas básicas (AND, OR, NOT, XOR)
- Flip-flops D para registradores
- Multiplexadores para seleção
- Buffers para conexões

Nenhum `assign` ou `always` foi utilizado, mantendo a implementação 100% estrutural.

## Exemplo de Uso

1. Configure SW[9:8] = 00 para exibição decimal
2. Configure SW[7:0] = 00000101 (5 em decimal)
3. Pressione KEY[0] (entrada A)
4. Configure SW[7:0] = 00000011 (3 em decimal)
5. Pressione KEY[0] (entrada B)
6. Configure SW[8] = 0 (operação de soma)
7. Pressione KEY[0] (confirma operação)
8. Sistema executa automaticamente e mostra resultado (8) nos displays

O contador garante que a sequência seja sempre respeitada e facilita o uso da calculadora RPN.
