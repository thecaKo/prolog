# Guia: Menu Interativo

## 🎯 O que é?

Um **menu interativo** que transforma o sistema em uma aplicação de linha de comando completa, **tudo em Prolog**!

---

## 🚀 Como Usar

### Passo 1: Carregar o Menu

```prolog
['menu_interativo.pl'].
```

### Passo 2: Iniciar o Menu

```prolog
iniciar.
```

Ou simplesmente:

```prolog
menu.
```

---

## 📋 Opções do Menu

### 1. Manual - Configurar país manualmente

**O que faz:** Você configura um país passo a passo, informando todos os dados manualmente.

**Uso:**
- Escolha opção `1`
- Digite o nome do país
- Para cada crise, informe: nível, tendência, severidade, impacto, variação
- Informe infraestrutura, apoio e reservas

**Exemplo:**
```
Escolha uma opção: 1
Digite o nome do país: brasil.

--- CRISE ECONÔMICA ---
Nível (baixo/medio/alto): alto.
Tendência (queda/estavel/alta): alta.
Severidade (leve/moderada/alta/critica): critica.
Impacto (baixo/medio/alto): alto.
Variação (decrescente/estavel/ascendente/explosiva): explosiva.
...
```

**Por que é legal:** Mostra como configurar dados **comandos secos** (sem scripts pré-feitos).

---

### 2. Backtracking - Explorar cenários para uma ação

**O que faz:** Usa backtracking para mostrar **todos os casos possíveis** onde uma ação está disponível ou é a melhor decisão.

**Uso:**
- Escolha opção `2`
- Escolha o modo:
  - `1` - Onde ação é a **MELHOR** decisão
  - `2` - Onde ação está **DISPONÍVEL** (formatado)
  - `3` - Ver diferença (melhor vs disponível)
  - `4` - Modo interativo (um por vez, aperte `;`)
- Digite o nome da ação

**Exemplo:**
```
Escolha uma opção: 2
Escolha o modo: 2
Digite o nome da ação: plano_estabilizacao.

>>> Cenários onde plano_estabilizacao está DISPONÍVEL:

CeN=alto, SaN=alto, Infra=boa, Apoio=alto, Res=baixo => 6 meses (melhor: pacote_emergencial)
CeN=alto, SaN=alto, Infra=media, Apoio=alto, Res=alto => 6 meses (melhor: reforco_hospitais)
...
```

**Por que é legal:** Demonstra o **backtracking do Prolog** em ação, gerando todas as combinações possíveis automaticamente!

---

### 3. Ver melhor decisão

**O que faz:** Mostra a melhor decisão para um país configurado.

**Uso:**
- Escolha opção `3`
- Digite o nome do país

---

### 4. Listar decisões por impacto

**O que faz:** Lista todas as decisões disponíveis agrupadas por impacto (alto/médio/baixo).

**Uso:**
- Escolha opção `4`
- Digite o nome do país

---

### 5. Explicar decisão

**O que faz:** Explica detalhadamente por que uma decisão está disponível para um país.

**Uso:**
- Escolha opção `5`
- Digite o nome do país
- Digite o nome da ação

---

### 6. Avaliar país

**O que faz:** Calcula o score normalizado e classificação do país.

**Uso:**
- Escolha opção `6`
- Digite o nome do país

---

### 7. Comparar países

**O que faz:** Compara dois países lado a lado.

**Uso:**
- Escolha opção `7`
- Digite o nome do primeiro país
- Digite o nome do segundo país

---

### 8. Exemplos pré-configurados

**O que faz:** Carrega e executa exemplos pré-configurados.

**Opções:**
- `1` - Lockdown Parcial
- `2` - Intervenção Econômica
- `3` - Chamar ONU
- `4` - Reforma de Infraestrutura
- `5` - Plano de Estabilização
- `6` - Múltiplas decisões (todos os impactos)

---

### 9. Ajuda

**O que faz:** Mostra ajuda sobre todas as opções e valores possíveis.

---

### 0. Sair

**O que faz:** Sai do menu.

---

## 🎬 Exemplo Completo de Uso

```prolog
% 1. Carregar menu
?- ['menu_interativo.pl'].

% 2. Iniciar
?- iniciar.

========================================
    SISTEMA DE DECISÃO - MENU PRINCIPAL
========================================

1. Manual - Configurar país manualmente
2. Backtracking - Explorar cenários para uma ação
3. Ver melhor decisão
4. Listar decisões por impacto
5. Explicar decisão
6. Avaliar país
7. Comparar países
8. Exemplos pré-configurados
9. Ajuda
0. Sair

Escolha uma opção: 2

========================================
BACKTRACKING - Explorar Cenários
========================================

Escolha o modo:
1. Mostrar onde ação é a MELHOR decisão
2. Mostrar onde ação está DISPONÍVEL
3. Ver diferença (melhor vs disponível)
4. Explorar interativo (um por vez)

Opção: 2

Digite o nome da ação: plano_estabilizacao.

>>> Cenários onde plano_estabilizacao está DISPONÍVEL:

CeN=alto, SaN=alto, Infra=boa, Apoio=alto, Res=baixo => 6 meses (melhor: pacote_emergencial)
...
```

---

## 💡 Dicas para Apresentação

### Demonstração 1: Manual (Comandos Secos)

1. Escolha opção `1`
2. Configure um país passo a passo
3. Mostre como cada dado é inserido manualmente
4. Depois use opção `3` para ver a melhor decisão

**Mensagem:** "Aqui você configura tudo manualmente, comandos secos, sem scripts."

### Demonstração 2: Backtracking (Todos os Casos)

1. Escolha opção `2`
2. Escolha modo `2` (disponível formatado)
3. Digite uma ação (ex: `plano_estabilizacao`)
4. Mostre todos os cenários sendo gerados

**Mensagem:** "Aqui o Prolog usa backtracking para gerar TODAS as combinações possíveis automaticamente!"

### Demonstração 3: Comparar Ambos

1. Primeiro mostre Manual (opção 1)
2. Depois mostre Backtracking (opção 2)
3. Compare: Manual = você controla, Backtracking = Prolog explora tudo

---

## 🎯 Fluxo Recomendado para Apresentação

```
1. Iniciar menu
   → iniciar.

2. Mostrar Manual (opção 1)
   → Configure um país simples
   → Mostre melhor decisão (opção 3)

3. Mostrar Backtracking (opção 2)
   → Escolha modo 2
   → Digite plano_estabilizacao
   → Mostre todos os cenários

4. Mostrar Explicação (opção 5)
   → Explique uma decisão

5. Mostrar Exemplos (opção 8)
   → Escolha exemplo 6 (múltiplas decisões)
```

---

## ✅ Vantagens do Menu Interativo

1. ✅ **Tudo em Prolog** - Não precisa de outra linguagem
2. ✅ **Fácil de usar** - Menu intuitivo
3. ✅ **Completo** - Todas as funcionalidades em um lugar
4. ✅ **Ideal para apresentação** - Mostra tudo de forma organizada
5. ✅ **Demonstra poder do Prolog** - Menu interativo puro Prolog!

---

## 🐛 Solução de Problemas

### Menu não aparece corretamente

**Causa:** Terminal não suporta códigos ANSI para limpar tela.

**Solução:** O menu ainda funciona, apenas não limpa a tela. Continue normalmente.

### Erro ao ler valores

**Causa:** Valores devem terminar com ponto (`.`) no Prolog.

**Solução:** Sempre termine com ponto: `alto.` não `alto`

### Ação não encontrada no backtracking

**Causa:** Ação nunca está disponível ou nunca é a melhor.

**Solução:** Tente outra ação ou use modo 2 (disponível) ao invés de modo 1 (melhor).

---

## 📝 Notas Importantes

- Todos os valores devem terminar com **ponto** (`.`) no Prolog
- Nomes de ações são em **minúsculas** com underscore: `lockdown_parcial`
- O menu volta automaticamente após cada operação
- Pressione Enter para continuar após cada operação

