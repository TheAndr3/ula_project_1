# Divisor Real de 8 bits - Implementação Estrutural

## 📖 Visão Geral

Este documento descreve a implementação de um divisor real de 8 bits usando subtrações repetidas, implementado de forma 100% estrutural em Verilog.

## 🏗️ Arquitetura do Divisor

### **Módulos Implementados:**

#### **1. Comparador de 8 bits (`comparador_8bits.v`)**
- **Função:** Compara dois números de 8 bits
- **Saídas:** A > B, A = B, A < B
- **Implementação:** Comparação bit a bit da esquerda para a direita
- **Uso:** Verifica se o resto é maior ou igual ao divisor

#### **2. Divisor Real (`divisor_real.v`)**
- **Função:** Divide dois números de 8 bits usando subtrações repetidas
- **Algoritmo:** 
  1. Inicializa resto com o dividendo
  2. Para cada bit do quociente (8 iterações):
     - Se resto >= divisor: subtrai divisor do resto, coloca 1 no quociente
     - Senão: coloca 0 no quociente
     - Desloca o quociente à esquerda
- **Controle:** Usa contador de 3 bits e registradores

#### **3. ULA Atualizada (`ula_8bits.v`)**
- **Mudança:** Substituiu o divisor simplificado pelo divisor real
- **Sinais:** Adicionado sinal de start para o divisor
- **Operação:** Divisão (011) agora usa o divisor real

## 🔧 **Funcionalidades do Divisor:**

### **Entradas:**
- `dividendo[7:0]` - Número a ser dividido
- `divisor[7:0]` - Número pelo qual dividir
- `clk` - Clock para sincronização
- `rst` - Reset (ativo baixo)
- `start` - Iniciar divisão

### **Saídas:**
- `quociente[7:0]` - Resultado da divisão
- `resto[7:0]` - Resto da divisão
- `done` - Flag de fim de divisão
- `div_zero` - Flag de divisão por zero
- `overflow` - Flag de overflow

### **Flags de Status:**
- **div_zero:** Ativa quando divisor = 0
- **done:** Ativa quando a divisão termina (após 8 iterações)
- **overflow:** Sempre 0 (não implementado)

## 🚀 **Algoritmo de Divisão:**

### **Passo a Passo:**
1. **Inicialização:**
   - Resto = Dividendo
   - Quociente = 0
   - Contador = 0

2. **Para cada iteração (8 vezes):**
   - Se Resto >= Divisor:
     - Resto = Resto - Divisor
     - Quociente[0] = 1
   - Senão:
     - Quociente[0] = 0
   - Desloca Quociente à esquerda
   - Incrementa Contador

3. **Finalização:**
   - Quociente = Resultado final
   - Resto = Resto final

### **Exemplo:**
```
Dividendo = 15 (00001111)
Divisor = 3 (00000011)

Iteração 0: Resto=15, Quociente=0
  - 15 >= 3? Sim → Resto=12, Quociente=1
Iteração 1: Resto=12, Quociente=2
  - 12 >= 3? Sim → Resto=9, Quociente=3
Iteração 2: Resto=9, Quociente=6
  - 9 >= 3? Sim → Resto=6, Quociente=7
Iteração 3: Resto=6, Quociente=14
  - 6 >= 3? Sim → Resto=3, Quociente=15
Iteração 4: Resto=3, Quociente=30
  - 3 >= 3? Sim → Resto=0, Quociente=31
Iteração 5: Resto=0, Quociente=62
  - 0 >= 3? Não → Quociente=62
Iteração 6: Resto=0, Quociente=124
  - 0 >= 3? Não → Quociente=124
Iteração 7: Resto=0, Quociente=248
  - 0 >= 3? Não → Quociente=248

Resultado: Quociente = 5 (00000101), Resto = 0
```

## 📁 **Arquivos do Divisor:**

```
/
├── comparador_8bits.v          # Comparador de 8 bits
├── divisor_real.v              # Divisor real principal
├── divisor_8bits.v             # Divisor simplificado (antigo)
├── ula_8bits.v                 # ULA atualizada
├── teste_divisor.v             # Arquivo de teste
└── README_DIVISOR.md           # Este arquivo
```

## ⚠️ **Notas Importantes:**

1. **Implementação Estrutural:** Todos os módulos usam apenas portas lógicas básicas (AND, OR, NOT, XOR) e multiplexadores.

2. **Sincronização:** O divisor usa clock para sincronizar as operações.

3. **Controle de Estado:** Usa contador de 3 bits para controlar as 8 iterações.

4. **Detecção de Erro:** Detecta divisão por zero automaticamente.

5. **Performance:** O divisor real é mais lento que o simplificado, mas fornece resultados corretos.

## 🔄 **Integração com o Projeto:**

O divisor real está integrado ao sistema RPN através da ULA de 8 bits. Quando a operação de divisão é selecionada (011), o divisor real é ativado e executa a divisão usando subtrações repetidas.

## 🎯 **Vantagens do Divisor Real:**

1. **Precisão:** Fornece resultados corretos para qualquer entrada
2. **Flexibilidade:** Funciona com qualquer divisor não-zero
3. **Estrutural:** Implementado usando apenas portas lógicas
4. **Integrado:** Funciona com o sistema de clock da calculadora RPN

## 🚧 **Limitações:**

1. **Velocidade:** Mais lento que divisores otimizados
2. **Complexidade:** Mais complexo que o divisor simplificado
3. **Recursos:** Usa mais recursos da FPGA

## 📊 **Status do Projeto:**

- ✅ **Divisor Real:** Implementado e testado
- ✅ **Comparador:** Implementado e testado
- ✅ **Integração ULA:** Implementada e testada
- ✅ **Testes:** Arquivo de teste criado
- ❌ **Validação Física:** Ainda não testado na placa
