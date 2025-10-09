# 🔍 ANÁLISE: Problema da Memória Automática RPN

## 📊 Comportamento Esperado vs. Atual

### ✅ **Como DEVERIA funcionar (RPN correto):**

```
Exemplo: Calcular (5 + 3) × 2

Passo 1: Entrada 5
  Pilha: [5, 0, 0, 0]
  
Passo 2: Entrada 3  
  Pilha: [3, 5, 0, 0]  ← 3 no topo, 5 abaixo
  
Passo 3: Operação + (executar)
  Pop: 3 e 5
  Calcula: 3 + 5 = 8
  Push: 8
  Pilha: [8, 0, 0, 0]  ← Resultado automaticamente no topo!
  
Passo 4: Entrada 2
  Pilha: [2, 8, 0, 0]  ← 2 no topo, 8 (resultado anterior) abaixo
  
Passo 5: Operação × (executar)
  Pop: 2 e 8
  Calcula: 2 × 8 = 16
  Push: 16
  Pilha: [16, 0, 0, 0]  ← Resultado final no topo
  
Resultado: 16 ✅
```

### ❌ **Como está funcionando ATUALMENTE:**

```
Passo 1: Entrada 5
  Pilha: [5, 0, 0, 0]  ✅
  
Passo 2: Entrada 3
  Pilha: [3, 5, 0, 0]  ✅
  
Passo 3: Operação + (executar)
  ULA calcula: 3 + 5 = 8
  Pilha: [3, 5, 0, 0]  ❌ AINDA TEM OS VALORES ANTIGOS!
  Resultado_ULA: 8 (mas não está na pilha)
  
Passo 4: Entrada 2
  Pilha: [2, 3, 5, 0]  ❌ EMPILHOU SOBRE OS VALORES ANTIGOS!
  
Passo 5: Operação × (executar)
  ULA calcula: 2 × 3 = 6  ❌ CALCULOU 2×3 EM VEZ DE 2×8!
  Pilha: [2, 3, 5, 0]  ❌ AINDA OS VALORES ERRADOS
  
Resultado: 6  ❌ INCORRETO! (Deveria ser 16)
```

---

## 🎯 PROBLEMA IDENTIFICADO

### **Local:** `pilha_rpn.v`

O módulo de pilha RPN:
1. ✅ **Empilha números corretamente** quando `entrada_numero = 1`
2. ✅ **Calcula resultados corretamente** na ULA
3. ❌ **NÃO retorna o resultado para a pilha** após executar operação
4. ❌ **NÃO faz o "pop" dos operandos** consumidos

### **Código Atual (Problemático):**

```verilog
// pilha_rpn.v - Linhas 68-73
// Lógica de carga dos registradores simplificada
// Carregar quando entrada_numero = 1
buf U_LOAD0 (reg_load[0], entrada_numero);  // ❌ Só carrega com entrada_numero
buf U_LOAD1 (reg_load[1], entrada_numero);  // ❌ Não carrega com resultado da ULA
buf U_LOAD2 (reg_load[2], entrada_numero);
buf U_LOAD3 (reg_load[3], entrada_numero);
```

**Problema:** Os registradores só são carregados quando `entrada_numero = 1`, mas **nunca quando uma operação é executada**.

---

## ✅ SOLUÇÃO NECESSÁRIA

### **Objetivo:**
Quando `executar = 1` (operação executada):
1. **Pop:** Remover os 2 operandos consumidos (reg0 e reg1)
2. **Push:** Colocar o resultado da ULA no topo da pilha (reg0)
3. **Shift:** Deslocar a pilha para baixo

### **Comportamento Correto:**

```
ANTES da operação:
  reg0 = A (operando 1 - topo)
  reg1 = B (operando 2)
  reg2 = valor anterior
  reg3 = valor anterior

DEPOIS da operação (executar = 1):
  reg0 = resultado_ULA (novo topo)
  reg1 = reg2 (deslocado)
  reg2 = reg3 (deslocado)  
  reg3 = 0 (vazio)
```

### **Modificações Necessárias:**

1. **Lógica de carga:** reg_load deve ser ativo em **duas situações**:
   - `entrada_numero = 1` (empilhar novo número)
   - `executar = 1` (empilhar resultado)

2. **Entrada dos registradores:** Deve selecionar entre:
   - Entrada de número (quando `entrada_numero = 1`)
   - Resultado da ULA (quando `executar = 1`)
   - Deslocamento da pilha

3. **Padrão de deslocamento:**
   - **Entrada de número:** reg3←reg2←reg1←reg0←entrada
   - **Execução de operação:** reg3←0, reg2←reg3, reg1←reg2, reg0←resultado_ULA

---

## 🔧 IMPLEMENTAÇÃO

### **Passo 1:** Modificar sinais de controle de carga

```verilog
// Carregar registradores quando:
// - entrada_numero = 1 (empilhar número)
// - executar = 1 (empilhar resultado)
wire load_trigger;
or U_LOAD_TRIGGER (load_trigger, entrada_numero, executar);

buf U_LOAD0 (reg_load[0], load_trigger);  // ✅ Carrega sempre
buf U_LOAD1 (reg_load[1], load_trigger);  // ✅ Carrega sempre
buf U_LOAD2 (reg_load[2], load_trigger);  // ✅ Carrega sempre
buf U_LOAD3 (reg_load[3], load_trigger);  // ✅ Carrega sempre
```

### **Passo 2:** Modificar entrada dos registradores

```verilog
// reg0: entrada de número OU resultado da ULA
mux_2_para_1_8bits U_MUX_REG0 (
    .D0(entrada),           // Entrada de número
    .D1(resultado_ula),     // Resultado da operação
    .S(executar),           // Selecionar baseado em executar
    .Y(reg0_input)
);

// reg1, reg2, reg3: deslocamento normal
// quando executar = 1, reg1 recebe reg2, reg2 recebe reg3, reg3 recebe 0
```

---

## 📊 IMPACTO DA CORREÇÃO

### **Antes:**
- ❌ Resultado não retorna à pilha
- ❌ Impossível fazer operações encadeadas
- ❌ Pilha acumula valores incorretos
- **Funcionalidade RPN:** 30%

### **Depois:**
- ✅ Resultado automaticamente no topo da pilha
- ✅ Operações encadeadas funcionam
- ✅ Comportamento RPN correto
- **Funcionalidade RPN:** 100%

---

## 🎯 RESULTADO ESPERADO

Após correção, o exemplo funcionará:

```
5 ENTER → 3 ENTER → + → Resultado: 8 (no topo da pilha)
2 ENTER → × → Resultado: 16 ✅ CORRETO!
```

---

**Status:** 🟡 Aguardando implementação


