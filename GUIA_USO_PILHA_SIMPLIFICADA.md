# 🎮 GUIA RÁPIDO: Usando a Pilha RPN Simplificada (2 Níveis)

## 🎯 Conceito Básico

Com **2 níveis de pilha**, você pode fazer **qualquer operação simples** em 3 passos:

```
1️⃣ PUSH primeiro número
2️⃣ PUSH segundo número  
3️⃣ EXECUTAR operação
```

---

## 📊 ENTENDENDO A PILHA

```
┌─────────────────────────────────────┐
│         PILHA (2 NÍVEIS)            │
├─────────────────────────────────────┤
│                                     │
│  ┌─────────┐                        │
│  │  REG0   │ ← TOPO (você vê isso) │
│  └─────────┘                        │
│                                     │
│  ┌─────────┐                        │
│  │  REG1   │ ← SEGUNDO (escondido)  │
│  └─────────┘                        │
│                                     │
└─────────────────────────────────────┘
```

**Display mostra:** Sempre o valor do **TOPO (REG0)**  
**Operação usa:** REG0 e REG1 juntos

---

## 🔢 EXEMPLOS PRÁTICOS

### **Exemplo 1: 5 + 3 = ?**

```
┌─────┬──────────────┬──────────────┬──────────────┬──────────┐
│Passo│ Configure SW │    Aperte    │    Pilha     │ Display  │
├─────┼──────────────┼──────────────┼──────────────┼──────────┤
│  1  │ SW[7:0] = 5  │   KEY[0]     │  [5, 0]      │    5     │
│     │              │   (PUSH)     │              │          │
├─────┼──────────────┼──────────────┼──────────────┼──────────┤
│  2  │ SW[7:0] = 3  │   KEY[0]     │  [3, 5]      │    3     │
│     │              │   (PUSH)     │              │          │
├─────┼──────────────┼──────────────┼──────────────┼──────────┤
│  3  │ SW[8:6] = 000│   KEY[1]     │  [8, 0]      │    8 ✅  │
│     │ (SOMA)       │   (EXEC)     │              │          │
└─────┴──────────────┴──────────────┴──────────────┴──────────┘

🎉 Resultado: 8
```

---

### **Exemplo 2: 6 × 4 = ?**

```
┌─────┬──────────────┬──────────────┬──────────────┬──────────┐
│Passo│ Configure SW │    Aperte    │    Pilha     │ Display  │
├─────┼──────────────┼──────────────┼──────────────┼──────────┤
│  1  │ SW[7:0] = 6  │   KEY[0]     │  [6, 0]      │    6     │
├─────┼──────────────┼──────────────┼──────────────┼──────────┤
│  2  │ SW[7:0] = 4  │   KEY[0]     │  [4, 6]      │    4     │
├─────┼──────────────┼──────────────┼──────────────┼──────────┤
│  3  │ SW[8:6] = 010│   KEY[1]     │  [24, 0]     │   24 ✅  │
│     │ (MULT)       │   (EXEC)     │              │          │
└─────┴──────────────┴──────────────┴──────────────┴──────────┘

🎉 Resultado: 24
```

---

### **Exemplo 3: 15 ÷ 3 = ?**

```
┌─────┬──────────────┬──────────────┬──────────────┬──────────┐
│Passo│ Configure SW │    Aperte    │    Pilha     │ Display  │
├─────┼──────────────┼──────────────┼──────────────┼──────────┤
│  1  │ SW[7:0] = 15 │   KEY[0]     │  [15, 0]     │   15     │
├─────┼──────────────┼──────────────┼──────────────┼──────────┤
│  2  │ SW[7:0] = 3  │   KEY[0]     │  [3, 15]     │    3     │
├─────┼──────────────┼──────────────┼──────────────┼──────────┤
│  3  │ SW[8:6] = 011│   KEY[1]     │  [5, 0]      │    5 ✅  │
│     │ (DIV)        │   (EXEC)     │              │          │
└─────┴──────────────┴──────────────┴──────────────┴──────────┘

🎉 Resultado: 5
```

---

### **Exemplo 4: 7 AND 3 = ?**

```
7 em binário:  00000111
3 em binário:  00000011
AND resultado: 00000011 = 3

┌─────┬──────────────┬──────────────┬──────────────┬──────────┐
│Passo│ Configure SW │    Aperte    │    Pilha     │ Display  │
├─────┼──────────────┼──────────────┼──────────────┼──────────┤
│  1  │ SW[7:0] = 7  │   KEY[0]     │  [7, 0]      │    7     │
├─────┼──────────────┼──────────────┼──────────────┼──────────┤
│  2  │ SW[7:0] = 3  │   KEY[0]     │  [3, 7]      │    3     │
├─────┼──────────────┼──────────────┼──────────────┼──────────┤
│  3  │ SW[8:6] = 100│   KEY[1]     │  [3, 0]      │    3 ✅  │
│     │ (AND)        │   (EXEC)     │              │          │
└─────┴──────────────┴──────────────┴──────────────┴──────────┘

🎉 Resultado: 3
```

---

### **Exemplo 5: NOT 5 = ?**

```
5 em binário:   00000101
NOT resultado:  11111010 = 250

⚠️ Operação unária: só precisa de 1 número!

┌─────┬──────────────┬──────────────┬──────────────┬──────────┐
│Passo│ Configure SW │    Aperte    │    Pilha     │ Display  │
├─────┼──────────────┼──────────────┼──────────────┼──────────┤
│  1  │ SW[7:0] = 5  │   KEY[0]     │  [5, 0]      │    5     │
├─────┼──────────────┼──────────────┼──────────────┼──────────┤
│  2  │ SW[8:6] = 111│   KEY[1]     │  [250, 0]    │  250 ✅  │
│     │ (NOT)        │   (EXEC)     │              │          │
└─────┴──────────────┴──────────────┴──────────────┴──────────┘

🎉 Resultado: 250 (complemento de 5)
```

---

## 🎨 TABELA DE OPERAÇÕES

| Código SW[8:6] | Operação | Tipo | Precisa de |
|----------------|----------|------|------------|
| **000** | Soma (A + B) | Binária | 2 números |
| **001** | Subtração (A - B) | Binária | 2 números |
| **010** | Multiplicação (A × B) | Binária | 2 números |
| **011** | Divisão (A ÷ B) | Binária | 2 números |
| **100** | AND (A & B) | Binária | 2 números |
| **101** | OR (A \| B) | Binária | 2 números |
| **110** | XOR (A ^ B) | Binária | 2 números |
| **111** | NOT (~A) | Unária | 1 número |

---

## 🚨 INDICADORES (LEDs)

```
LEDR[5] = Pilha CHEIA (2 elementos)
  ✅ ON  → Pode executar operação binária!
  ❌ OFF → Falta números, empilhe mais

LEDR[4] = Pilha VAZIA (0 ou 1 elemento)
  ✅ OFF → Tem números suficientes
  ❌ ON  → Pilha vazia ou só tem 1 número

LEDR[3] = ERRO (divisão por zero ou negativo)
LEDR[2] = CARRY OUT
LEDR[1] = OVERFLOW
LEDR[0] = ZERO (resultado = 0)
```

---

## ⚡ DICAS RÁPIDAS

### ✅ **FAÇA:**
- Sempre empilhe 2 números antes de operações binárias
- Aguarde LEDR[5] acender antes de executar
- Use NOT com apenas 1 número na pilha

### ❌ **NÃO FAÇA:**
- Executar operação sem números suficientes
- Empilhar mais de 2 números (vai perder o controle)
- Confundir a ordem (RPN é invertido!)

---

## 🧮 CONVERSÃO DE BASES

Configure **SW[9]** para mudar a base do display:

```
SW[9] = 0  →  Decimal (base 10)
              Exemplo: 255 aparece como "255"

SW[9] = 1  →  Hexadecimal (base 16)
              Exemplo: 255 aparece como "FF"
```

---

## 📝 FLUXO DE TRABALHO TÍPICO

```
1. Reset da placa (se necessário)
   
2. Configure o primeiro número
   SW[7:0] = primeiro valor
   
3. Empilhe
   Aperte KEY[0]
   
4. Configure o segundo número
   SW[7:0] = segundo valor
   
5. Empilhe
   Aperte KEY[0]
   
6. Verifique LEDR[5]
   Deve estar ON (pilha cheia)
   
7. Configure a operação
   SW[8:6] = código da operação
   
8. Execute
   Aperte KEY[1]
   
9. Veja o resultado no display
   Display mostra o resultado
   LEDR[5] apaga (pilha tem 1 elemento agora)
```

---

## 🎯 RESUMO ULTRA-RÁPIDO

Para fazer **qualquer cálculo**:

```
📌 SW[7:0] = número 1  →  KEY[0]
📌 SW[7:0] = número 2  →  KEY[0]
📌 SW[8:6] = operação  →  KEY[1]
📌 Veja resultado no display! ✅
```

---

**Isso é tudo! Simples assim!** 🚀

