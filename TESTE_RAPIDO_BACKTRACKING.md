# Teste Rápido: Backtracking de Cenários

## ✅ O que você viu está correto!

Quando você vê:
```prolog
CeN = SaN, SaN = Apoio, Apoio = alto
```

Isso significa que **todas essas variáveis são `alto`**! É a forma do Prolog mostrar unificações.

---

## 🎯 Formas de Testar (Escolha a que preferir)

### Opção 1: Versão Formatada (Mais Legível)

```prolog
?- ['explorar_espaco.pl'].

% Mostra todos os cenários formatados de uma vez
?- explorar_cenarios_onde_acao_disponivel_formatado(plano_estabilizacao).
```

**Saída esperada:**
```
========================================
Cenários onde plano_estabilizacao está DISPONÍVEL
========================================

CeN=alto, SaN=alto, Infra=boa, Apoio=alto, Res=baixo => 6 meses (melhor: reforco_hospitais)
CeN=alto, SaN=alto, Infra=media, Apoio=alto, Res=baixo => 6 meses (melhor: reforco_hospitais)
...
```

### Opção 2: Versão Interativa (Para Apresentação)

```prolog
?- ['explorar_espaco.pl'].

% Mostra um cenário por vez (aperte ; para ver mais)
?- explorar_interativo(plano_estabilizacao).
```

**Saída esperada:**
```
========================================
EXPLORAÇÃO INTERATIVA: plano_estabilizacao
========================================

Pressione ; para ver mais cenários, Enter para parar

Cenário: CeN=alto | SaN=alto | Infra=boa | Apoio=alto | Res=baixo
  → plano_estabilizacao disponível (6 meses) | Melhor decisão: reforco_hospitais

;  (você aperta ; aqui)

Cenário: CeN=alto | SaN=alto | Infra=media | Apoio=alto | Res=baixo
  → plano_estabilizacao disponível (6 meses) | Melhor decisão: reforco_hospitais

;  (mais uma vez)

...
```

### Opção 3: Versão Original (Com Variáveis)

```prolog
?- ['explorar_espaco.pl'].

?- explorar_cenarios_onde_acao_disponivel(plano_estabilizacao, CeN, SaN, Infra, Apoio, Res, Meses).
```

**Saída:** Variáveis unificadas (como você viu)

---

## 🔍 Entendendo a Saída

Quando você vê:
```prolog
CeN = SaN, SaN = Apoio, Apoio = alto,
Infra = boa,
Res = baixo,
Meses = 6
```

**Tradução:**
- `CeN = alto` (Crise Econômica em nível alto)
- `SaN = alto` (Crise de Saúde em nível alto)  
- `Apoio = alto` (Apoio da população em nível alto)
- `Infra = boa` (Infraestrutura boa)
- `Res = baixo` (Reservas baixas)
- `Meses = 6` (Duração de 6 meses)

**Por que `CeN = SaN = Apoio = alto`?**
- Porque todas são `alto`, então o Prolog mostra que estão unificadas entre si.

---

## 💡 Para a Apresentação

### Recomendação: Use a versão formatada

```prolog
?- explorar_cenarios_onde_acao_disponivel_formatado(plano_estabilizacao).
```

**Vantagens:**
- ✅ Saída clara e legível
- ✅ Mostra qual é a melhor decisão em cada cenário
- ✅ Fácil de entender para a audiência

### Ou use a versão interativa

```prolog
?- explorar_interativo(plano_estabilizacao).
```

**Vantagens:**
- ✅ Você controla o ritmo (aperta `;` quando quiser)
- ✅ Pode explicar cada cenário conforme aparece
- ✅ Mostra o backtracking em ação

---

## 🎬 Exemplo Completo para Demo

```prolog
% 1. Carregar
?- ['explorar_espaco.pl'].

% 2. Mostrar cenários formatados
?- explorar_cenarios_onde_acao_disponivel_formatado(plano_estabilizacao).

% 3. Mostrar diferença entre melhor vs disponível
?- mostrar_diferenca_melhor_vs_disponivel(plano_estabilizacao).

% 4. Explorar outra ação que funciona como melhor
?- explorar_cenarios_para_acao_formatado(reforma_infraestrutura).
```

---

## 📊 Comparação das Versões

| Versão | Uso | Saída |
|--------|-----|-------|
| `explorar_cenarios_onde_acao_disponivel` | Programática | Variáveis unificadas |
| `explorar_cenarios_onde_acao_disponivel_formatado` | Apresentação | Texto formatado completo |
| `explorar_interativo` | Demo ao vivo | Um cenário por vez |

---

## ✅ Resumo

**O que você testou está funcionando perfeitamente!** 

A saída `CeN = SaN, SaN = Apoio, Apoio = alto` está correta - significa que todas são `alto`.

Para a apresentação, use as versões formatadas para ficar mais claro! 🎯

