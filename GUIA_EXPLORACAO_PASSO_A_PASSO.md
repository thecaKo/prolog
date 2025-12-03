# Guia Passo a Passo: Explorar Espaço de Soluções com Backtracking

## 🎯 Objetivo

Usar o **backtracking do Prolog** para explorar **todas as combinações** de crises que geram uma determinada decisão como melhor opção ou que a tornam disponível.

---

## 📋 Passo a Passo Completo

### Passo 1: Abrir o SWI-Prolog

```bash
cd /home/cako/Documents/Atividades/prolog-infer-decision
swipl
```

### Passo 2: Carregar o Módulo de Exploração

```prolog
?- ['explorar_espaco.pl'].
true.
```

Isso carrega automaticamente `data.pl` também.

---

## 🔍 Pergunta 1: "Quais combinações geram `plano_estabilizacao` como melhor decisão?"

### Opção A: Buscar onde é a MELHOR decisão

```prolog
?- explorar_cenarios_para_acao(plano_estabilizacao, CeN, SaN, Infra, Apoio, Res, Meses).
```

**O que acontece:**
- Prolog gera todas as combinações possíveis de `CeN`, `SaN`, `Infra`, `Apoio`, `Res`
- Para cada combinação, configura o país `sim` e verifica se `plano_estabilizacao` é a **melhor decisão**
- Retorna apenas os cenários onde ela é realmente a melhor

**Resultado esperado:** Pode retornar `false` se nunca for a melhor (outras decisões têm prioridade maior)

### Opção B: Buscar onde está DISPONÍVEL (mesmo que não seja a melhor)

```prolog
?- explorar_cenarios_onde_acao_disponivel(plano_estabilizacao, CeN, SaN, Infra, Apoio, Res, Meses).
```

**O que acontece:**
- Prolog gera todas as combinações
- Verifica se `plano_estabilizacao` está **disponível** (condições satisfeitas)
- Retorna todos os cenários onde ela pode ser escolhida

**Resultado esperado:** Retorna múltiplos cenários! Por exemplo:
```prolog
CeN = alto,
SaN = alto,
Infra = boa,
Apoio = alto,
Res = baixo,
Meses = 6 ;
```

**Pressione `;` para ver mais cenários!**

---

## 🔍 Pergunta 2: "Para quais configurações a melhor decisão de impacto baixo é `reforma_infraestrutura`?"

```prolog
?- explorar_cenarios_para_acao(reforma_infraestrutura, CeN, SaN, Infra, Apoio, Res, Meses).
```

**Resultado esperado:**
```prolog
CeN = baixo,
SaN = baixo,
Infra = ruim,
Apoio = baixo,
Res = baixo,
Meses = 12 ;
```

**Pressione `;` para ver mais cenários!**

---

## 🎨 Demonstração Visual: Ver Diferença entre "Melhor" vs "Disponível"

Para entender melhor a diferença:

```prolog
?- mostrar_diferenca_melhor_vs_disponivel(plano_estabilizacao).
```

Isso mostra:
- Cenários onde `plano_estabilizacao` é a **melhor** decisão
- Cenários onde está **disponível** (mas outra pode ser melhor)

---

## 📊 Exemplo Completo: Explorar Múltiplas Ações

```prolog
?- explorar_exemplo_basico.
```

Isso mostra cenários para:
- `lockdown_parcial`
- `intervencao_economica`
- `reforma_infraestrutura`

---

## 🎯 Exemplo Específico para Plano de Estabilização

```prolog
?- explorar_plano_estabilizacao.
```

Mostra análise completa de `plano_estabilizacao` com diferença entre melhor vs disponível.

---

## 💡 Dicas para a Apresentação

### 1. Mostrar o Backtracking em Ação

```prolog
?- explorar_cenarios_onde_acao_disponivel(plano_estabilizacao, CeN, SaN, Infra, Apoio, Res, Meses).
```

**Aperte `;` várias vezes** enquanto explica:
- "O Prolog está **gerando** todas as combinações..."
- "Para cada combinação, ele **configura** o país..."
- "E **verifica** se a decisão está disponível..."
- "Agora ele encontrou outra combinação..."

### 2. Combinar com Modo Explicativo

Depois de encontrar um cenário interessante:

```prolog
% Primeiro, explore
?- explorar_cenarios_onde_acao_disponivel(plano_estabilizacao, CeN, SaN, Infra, Apoio, Res, Meses).
CeN = alto, SaN = alto, Infra = boa, Apoio = alto, Res = baixo, Meses = 6.

% Depois, configure e explique
?- configurar_cenario_simples(alto, alto, boa, alto, baixo),
   explicar_decisao(sim, plano_estabilizacao).
```

### 3. Mostrar Todas as Soluções de Uma Vez

```prolog
?- explorar_cenarios_para_acao_lista(reforma_infraestrutura, Lista).
Lista = [cenario{...}, cenario{...}, ...].
```

---

## 🐛 Solução de Problemas

### Problema: Retorna `false` para `explorar_cenarios_para_acao`

**Causa:** A ação nunca é a melhor decisão (outras têm prioridade maior).

**Solução:** Use `explorar_cenarios_onde_acao_disponivel` para ver onde ela está disponível.

### Problema: Muitos resultados

**Solução:** Use `findall` ou `explorar_cenarios_para_acao_lista` para coletar todos de uma vez.

### Problema: Não encontra nenhum cenário

**Causa:** As condições da decisão são muito específicas.

**Solução:** Verifique as condições necessárias com `explicar_decisao(Pais, Acao)`.

---

## 📝 Resumo dos Predicados

| Predicado | O que faz |
|-----------|-----------|
| `explorar_cenarios_para_acao(Acao, ...)` | Busca onde `Acao` é a **melhor** decisão |
| `explorar_cenarios_onde_acao_disponivel(Acao, ...)` | Busca onde `Acao` está **disponível** |
| `explorar_cenarios_para_acao_lista(Acao, Lista)` | Coleta todos os cenários em uma lista |
| `mostrar_diferenca_melhor_vs_disponivel(Acao)` | Mostra diferença entre melhor vs disponível |
| `explorar_exemplo_basico` | Exemplo com 3 ações diferentes |
| `explorar_plano_estabilizacao` | Exemplo específico para plano de estabilização |

---

## 🎬 Roteiro para Apresentação

1. **Carregar módulo:**
   ```prolog
   ?- ['explorar_espaco.pl'].
   ```

2. **Mostrar backtracking:**
   ```prolog
   ?- explorar_cenarios_onde_acao_disponivel(plano_estabilizacao, CeN, SaN, Infra, Apoio, Res, Meses).
   ```
   (Apertar `;` várias vezes)

3. **Explicar um cenário:**
   ```prolog
   ?- configurar_cenario_simples(alto, alto, boa, alto, baixo),
      explicar_decisao(sim, plano_estabilizacao).
   ```

4. **Mostrar diferença:**
   ```prolog
   ?- mostrar_diferenca_melhor_vs_disponivel(plano_estabilizacao).
   ```

5. **Explorar outra ação:**
   ```prolog
   ?- explorar_cenarios_para_acao(reforma_infraestrutura, CeN, SaN, Infra, Apoio, Res, Meses).
   ```

