# Sistema de Memória - Calculadora RPN

## 📖 Visão Geral

Este documento descreve a implementação do sistema de memória dedicado para armazenar automaticamente o último resultado calculado na calculadora RPN.

## 🏗️ Arquitetura do Sistema de Memória

### **Módulos Implementados:**

#### **1. Registrador de Memória (`registrador_memoria.v`)**
- **Função:** Armazena o último resultado calculado
- **Entradas:** 
  - `resultado_entrada[7:0]` - Resultado a ser armazenado
  - `clk` - Clock para sincronização
  - `rst` - Reset (ativo baixo)
  - `carregar` - Sinal para carregar novo resultado
  - `valor_memoria[7:0]` - Valor atual da memória
- **Saídas:**
  - `memoria_saida[7:0]` - Valor armazenado na memória
  - `resultado_saida[7:0]` - Resultado para exibição

#### **2. Controle de Memória (`controle_memoria.v`)**
- **Função:** Gerencia quando carregar o resultado na memória
- **Entradas:**
  - `operacao[2:0]` - Código da operação
  - `resultado_ula[7:0]` - Resultado da ULA
  - `executar` - Sinal de execução
  - `clk` - Clock
  - `rst` - Reset
- **Saídas:**
  - `carregar_memoria` - Sinal para carregar na memória
  - `valor_memoria[7:0]` - Valor atual da memória
  - `resultado_final[7:0]` - Resultado final para exibição

## 🔧 **Funcionalidades do Sistema de Memória:**

### **Armazenamento Automático:**
- **Quando:** Após cada operação válida executada
- **Condição:** `executar = 1` AND `operacao != 000`
- **Resultado:** O último resultado é automaticamente salvo na memória

### **Acesso à Memória:**
- **Exibição:** O valor da memória pode ser exibido nos displays
- **Reutilização:** O valor pode ser usado em operações futuras
- **Persistência:** O valor permanece até ser substituído por um novo resultado

### **Controle de Exibição:**
- **SW[8] = 0, executar = 0:** Mostra registrador A da pilha
- **SW[8] = 0, executar = 1:** Mostra resultado da ULA
- **SW[8] = 1, executar = 0:** Mostra valor da memória
- **SW[8] = 1, executar = 1:** Mostra resultado da ULA

## 🚀 **Como Funciona:**

### **Fluxo de Operação:**
1. **Entrada de Operandos:** Usuário insere números na pilha RPN
2. **Seleção de Operação:** Usuário seleciona a operação desejada
3. **Execução:** Usuário pressiona executar (SW[9])
4. **Cálculo:** ULA executa a operação
5. **Armazenamento Automático:** Resultado é salvo na memória
6. **Exibição:** Resultado é mostrado nos displays

### **Exemplo de Uso:**
```
1. Inserir: 5 → Pilha: [5]
2. Inserir: 3 → Pilha: [5, 3]
3. Operação: Soma (000)
4. Executar: SW[9] = 1
5. Resultado: 8 → Memória: [8]
6. Exibir memória: SW[8] = 1, executar = 0
```

## 📁 **Arquivos do Sistema de Memória:**

```
/
├── registrador_memoria.v          # Registrador de memória
├── controle_memoria.v             # Controle de memória
├── calculadora_rpn_completa.v     # Módulo principal atualizado
└── README_MEMORIA.md              # Este arquivo
```

## ⚠️ **Notas Importantes:**

1. **Implementação Estrutural:** Todos os módulos usam apenas portas lógicas básicas
2. **Sincronização:** O sistema usa clock para sincronizar as operações
3. **Reset:** O reset limpa a memória
4. **Persistência:** A memória mantém o valor até ser substituída

## 🎯 **Vantagens do Sistema de Memória:**

1. **Reutilização:** Permite reutilizar o último resultado
2. **Conveniência:** Não precisa re-inserir números
3. **Eficiência:** Acelera cálculos sequenciais
4. **Flexibilidade:** Permite diferentes modos de exibição

## 📊 **Status do Projeto:**

- ✅ **Registrador de Memória:** Implementado e testado
- ✅ **Controle de Memória:** Implementado e testado
- ✅ **Integração Principal:** Implementada e testada
- ✅ **Sistema de Exibição:** Implementado e testado
- ❌ **Validação Física:** Ainda não testado na placa

## 🔄 **Integração com o Projeto:**

O sistema de memória está totalmente integrado ao projeto principal:
- **Entrada:** Recebe resultado da ULA
- **Armazenamento:** Salva automaticamente após operações
- **Exibição:** Permite visualizar o valor armazenado
- **Reutilização:** Valor pode ser usado em operações futuras

## 🚧 **Limitações:**

1. **Uma Memória:** Apenas um valor pode ser armazenado por vez
2. **Substituição:** Novo resultado substitui o anterior
3. **Volatilidade:** Memória é perdida no reset

## 📋 **Requisitos Atendidos:**

- ✅ **Armazenamento Automático:** Último resultado é salvo automaticamente
- ✅ **Registrador Dedicado:** Memória separada da pilha RPN
- ✅ **Reutilização:** Valor pode ser usado posteriormente
- ✅ **Exibição:** Valor pode ser visualizado nos displays
- ✅ **Implementação Estrutural:** 100% com portas lógicas
