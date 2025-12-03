# Como Usar o Menu Interativo

## 🚀 Início Rápido

```prolog
['menu_interativo.pl'].
iniciar.
```

---

## ⭐ As Duas Opções Principais

### 1️⃣ Manual - Comandos Secos

**O que é:** Configure um país **manualmente**, passo a passo.

**Como usar:**
1. Escolha opção `1`
2. Digite o nome do país (ex: `brasil.`)
3. Para cada crise, informe os valores quando solicitado
4. Informe infraestrutura, apoio e reservas

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

--- CRISE DE SAÚDE ---
[... continua para todas as crises ...]

✓ País configurado com sucesso!
```

**Por que é legal:** Mostra como configurar dados "comandos secos", sem scripts pré-feitos.

---

### 2️⃣ Backtracking - Todos os Casos Possíveis

**O que é:** Usa backtracking para mostrar **TODOS os cenários** onde uma ação está disponível.

**Como usar:**
1. Escolha opção `2`
2. Escolha o modo:
   - `1` - Onde ação é a **MELHOR** decisão
   - `2` - Onde ação está **DISPONÍVEL** (recomendado - mostra todos formatados)
   - `3` - Ver diferença (melhor vs disponível)
   - `4` - Interativo (um por vez, aperte `;`)
3. Digite o nome da ação (ex: `plano_estabilizacao.`)

**Exemplo:**
```
Escolha uma opção: 2

Escolha o modo: 2
Digite o nome da ação: plano_estabilizacao.

========================================
Cenários onde plano_estabilizacao está DISPONÍVEL
========================================

CeN=alto, SaN=alto, Infra=boa, Apoio=alto, Res=baixo => 6 meses (melhor: pacote_emergencial)
CeN=alto, SaN=alto, Infra=media, Apoio=alto, Res=alto => 6 meses (melhor: reforco_hospitais)
CeN=alto, SaN=medio, Infra=boa, Apoio=alto, Res=baixo => 6 meses (melhor: pacote_emergencial)
...
```

**Por que é legal:** Demonstra o **backtracking do Prolog** gerando automaticamente todas as combinações possíveis!

---

## 🎬 Roteiro para Apresentação

### Parte 1: Manual (Comandos Secos)

```
1. iniciar.
2. Escolha opção: 1
3. Configure um país simples
4. Explique: "Aqui você configura tudo manualmente, comandos secos"
5. Depois use opção 3 para ver a melhor decisão
```

### Parte 2: Backtracking (Todos os Casos)

```
1. Escolha opção: 2
2. Escolha modo: 2
3. Digite: plano_estabilizacao.
4. Mostre todos os cenários sendo gerados
5. Explique: "Aqui o Prolog usa backtracking para explorar TODAS as combinações automaticamente!"
```

### Parte 3: Comparação

```
Explique a diferença:
- Manual = Você controla cada valor
- Backtracking = Prolog explora tudo automaticamente
```

---

## 📝 Valores Possíveis

Ao usar o menu, use estes valores:

- **Níveis:** `baixo.`, `medio.`, `alto.`
- **Tendências:** `queda.`, `estavel.`, `alta.`
- **Severidade:** `leve.`, `moderada.`, `alta.`, `critica.`
- **Impacto:** `baixo.`, `medio.`, `alto.`
- **Variação:** `decrescente.`, `estavel.`, `ascendente.`, `explosiva.`
- **Infraestrutura:** `boa.`, `media.`, `ruim.`
- **Apoio:** `baixo.`, `medio.`, `alto.`
- **Reservas:** `baixo.`, `alto.`

**IMPORTANTE:** Sempre termine com ponto (`.`)!

---

## ✅ Pronto para Usar!

O menu está completo e pronto para sua apresentação! 🎉

