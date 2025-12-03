# Menu Interativo - Sistema de Decisão

## 🎯 Menu Completo em Prolog

Um menu interativo que transforma o sistema em uma aplicação de linha de comando completa, **100% em Prolog**!

---

## 🚀 Início Rápido

```prolog
['menu_interativo.pl'].
iniciar.
```

---

## ⭐ Opções Principais Destacadas

### 1️⃣ Manual - Comandos Secos

**O que faz:** Configure um país **manualmente**, passo a passo, sem scripts pré-feitos.

**Por que é legal:**
- ✅ Mostra como configurar dados "comandos secos"
- ✅ Você tem controle total sobre cada valor
- ✅ Ideal para entender como os dados são estruturados

**Como usar:**
```
Escolha opção: 1
Digite o nome do país: brasil.
Informe cada dado quando solicitado...
```

**Exemplo de uso:**
- Configure um país do zero
- Veja como cada crise é definida
- Entenda a estrutura completa dos dados

---

### 2️⃣ Backtracking - Todos os Casos Possíveis

**O que faz:** Usa **backtracking do Prolog** para mostrar **TODOS os casos possíveis** onde uma ação está disponível ou é a melhor decisão.

**Por que é legal:**
- ✅ Demonstra o poder do backtracking
- ✅ Gera automaticamente todas as combinações
- ✅ Mostra o lado "gerativo" do Prolog
- ✅ Explora todo o espaço de soluções

**Como usar:**
```
Escolha opção: 2
Escolha o modo: 2 (disponível formatado)
Digite a ação: plano_estabilizacao.
```

**Modos disponíveis:**
- **Modo 1:** Onde ação é a **MELHOR** decisão
- **Modo 2:** Onde ação está **DISPONÍVEL** (formatado, mostra todos)
- **Modo 3:** Ver diferença (melhor vs disponível)
- **Modo 4:** Interativo (um por vez, aperte `;`)

**Exemplo de saída:**
```
>>> Cenários onde plano_estabilizacao está DISPONÍVEL:

CeN=alto, SaN=alto, Infra=boa, Apoio=alto, Res=baixo => 6 meses (melhor: pacote_emergencial)
CeN=alto, SaN=alto, Infra=media, Apoio=alto, Res=alto => 6 meses (melhor: reforco_hospitais)
CeN=alto, SaN=medio, Infra=boa, Apoio=alto, Res=baixo => 6 meses (melhor: pacote_emergencial)
...
```

**O que acontece:**
- Prolog gera **162 combinações possíveis** (3×3×3×3×2)
- Para cada combinação, configura o país e verifica se a ação está disponível
- Mostra apenas as combinações onde a ação está disponível
- **Tudo automático** - você não precisa escrever loops!

---

## 📋 Todas as Opções

| Opção | Descrição |
|-------|-----------|
| **1. Manual** | Configure país manualmente (comandos secos) |
| **2. Backtracking** | Explore todos os cenários para uma ação |
| 3. Ver melhor decisão | Mostra melhor decisão para um país |
| 4. Listar por impacto | Decisões agrupadas por impacto |
| 5. Explicar decisão | Explica por que uma decisão está disponível |
| 6. Avaliar país | Calcula score e classificação |
| 7. Comparar países | Compara dois países lado a lado |
| 8. Exemplos | Carrega exemplos pré-configurados |
| 9. Ajuda | Mostra ajuda completa |
| 0. Sair | Sai do menu |

---

## 🎬 Exemplo Completo para Apresentação

### Demonstração 1: Manual (Comandos Secos)

```prolog
?- iniciar.
Escolha uma opção: 1

Digite o nome do país: brasil.
--- CRISE ECONÔMICA ---
Nível (baixo/medio/alto): alto.
Tendência (queda/estavel/alta): alta.
...
✓ País configurado com sucesso!
```

**Mensagem:** "Aqui você configura tudo manualmente, comandos secos, sem scripts."

### Demonstração 2: Backtracking (Todos os Casos)

```prolog
Escolha uma opção: 2
Escolha o modo: 2
Digite o nome da ação: plano_estabilizacao.

>>> Cenários onde plano_estabilizacao está DISPONÍVEL:
[Mostra todos os cenários gerados automaticamente]
```

**Mensagem:** "Aqui o Prolog usa backtracking para gerar TODAS as combinações possíveis automaticamente!"

---

## 💡 Comparação: Manual vs Backtracking

| Aspecto | Manual (Opção 1) | Backtracking (Opção 2) |
|---------|-----------------|------------------------|
| **Controle** | Você controla cada valor | Prolog explora tudo automaticamente |
| **Velocidade** | Um país por vez | Gera múltiplos cenários |
| **Uso** | Configuração específica | Exploração de possibilidades |
| **Demonstra** | Estrutura de dados | Poder do backtracking |
| **Ideal para** | Entender dados | Encontrar padrões |

---

## 🎯 Fluxo Recomendado para Apresentação

```
1. Iniciar menu
   → iniciar.

2. Mostrar Manual (opção 1)
   → Configure um país simples
   → Explique: "comandos secos, você controla tudo"

3. Mostrar Backtracking (opção 2)
   → Escolha modo 2
   → Digite: plano_estabilizacao
   → Mostre todos os cenários sendo gerados
   → Explique: "backtracking explora tudo automaticamente"

4. Comparar ambos
   → Manual = você controla
   → Backtracking = Prolog explora

5. Mostrar outras opções
   → Opção 3: Ver melhor decisão
   → Opção 5: Explicar decisão
```

---

## ✅ Vantagens do Menu

1. ✅ **100% Prolog** - Não precisa de outra linguagem
2. ✅ **Completo** - Todas as funcionalidades em um lugar
3. ✅ **Interativo** - Fácil de usar e demonstrar
4. ✅ **Ideal para apresentação** - Mostra tudo de forma organizada
5. ✅ **Demonstra poder do Prolog** - Menu interativo puro Prolog!

---

## 📝 Notas Importantes

- Todos os valores devem terminar com **ponto** (`.`) no Prolog
- Nomes de ações são em **minúsculas** com underscore: `lockdown_parcial`
- O menu volta automaticamente após cada operação
- Pressione Enter para continuar após cada operação

---

## 🐛 Solução de Problemas

### Erro ao ler valores

**Solução:** Sempre termine com ponto: `alto.` não `alto`

### Ação não encontrada no backtracking

**Solução:** Tente outra ação ou use modo 2 (disponível) ao invés de modo 1 (melhor)

### Menu não limpa tela

**Solução:** Normal em alguns terminais. Continue normalmente.

