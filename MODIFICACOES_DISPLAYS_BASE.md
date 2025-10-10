# Modificações nos Displays de Base Numérica

## Resumo das Alterações

Foram implementadas modificações no sistema de exibição para permitir a seleção de bases numéricas (decimal, hexadecimal e octal) nos displays de 7 segmentos de forma 100% estrutural.

## Arquivos Modificados

### 1. calculadora_rpn_completa.v

**Principais mudanças:**
- Modificado o mapeamento de entrada para usar `SW[9]` e `SW[8]` para seleção de base:
  - `00` = Decimal (padrão)
  - `01` = Hexadecimal  
  - `10` = Octal
- Removido o uso do multiplexador para seleção de exibição
- Agora sempre exibe o resultado da ULA diretamente
- Simplificado o sinal `executar` para sempre `0`

### 2. conversor_bases.v

**Principais mudanças:**
- Mantida a lógica de conversão para as três bases
- HEX3 agora sempre fica desligado (todos os segmentos em 1)
- HEX0, HEX1 e HEX2 mostram respectivamente: unidade, dezena e centena
- Implementação 100% estrutural usando buffers para HEX3

## Funcionamento

### Seleção de Base
- **SW[9:8] = 00**: Exibe em decimal (0-999)
- **SW[9:8] = 01**: Exibe em hexadecimal (0-FF)  
- **SW[9:8] = 10**: Exibe em octal (0-777)

### Displays
- **HEX0**: Dígito da unidade
- **HEX1**: Dígito da dezena  
- **HEX2**: Dígito da centena
- **HEX3**: Sempre desligado
- **HEX4**: Operação sendo executada
- **HEX5**: Base numérica selecionada (d/h/o)

### Limites de Exibição
- **Decimal**: 0-999 (3 dígitos)
- **Hexadecimal**: 0-FF (2 dígitos)
- **Octal**: 0-777 (3 dígitos)

## Implementação Estrutural

Todas as modificações foram feitas usando apenas portas lógicas básicas:
- Buffers (`buf`) para conexões diretas
- Multiplexadores existentes para seleção
- Decodificadores de 7 segmentos para exibição

Nenhum `assign` ou `always` foi utilizado, mantendo a implementação 100% estrutural conforme solicitado.

## Teste

Para testar o sistema:
1. Configure SW[7:0] com um valor binário
2. Configure SW[9:8] para selecionar a base desejada
3. Observe os displays HEX0-HEX2 mostrando o valor na base selecionada
4. Observe HEX5 mostrando a base ativa (d/h/o)
5. HEX3 deve permanecer sempre desligado
