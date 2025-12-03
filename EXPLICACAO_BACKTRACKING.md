# Por que isso é Backtracking? Explicação Detalhada

## 🔄 O que é Backtracking?

**Backtracking** = "voltar atrás" (back + track)

No Prolog, quando uma consulta pode ter **múltiplas soluções**, o Prolog:
1. Tenta uma solução
2. Se você pedir mais (`;`), ele **volta atrás** e tenta outra
3. Continua até esgotar todas as possibilidades

---

## 🎯 Como o Backtracking Funciona no Nosso Código

### Código que você testou:

```prolog
explorar_cenarios_onde_acao_disponivel(plano_estabilizacao, CeN, SaN, Infra, Apoio, Res, Meses) :-
    gerar_nivel(CeN),        % ← Ponto de escolha 1
    gerar_nivel(SaN),        % ← Ponto de escolha 2
    gerar_infra(Infra),      % ← Ponto de escolha 3
    gerar_apoio(Apoio),      % ← Ponto de escolha 4
    gerar_reservas(Res),     % ← Ponto de escolha 5
    configurar_cenario_simples(CeN, SaN, Infra, Apoio, Res),
    decisao(sim, plano_estabilizacao, Meses).
```

### O que acontece passo a passo:

#### Passo 1: Primeira Tentativa
```
gerar_nivel(CeN) → CeN = baixo  (primeira opção)
gerar_nivel(SaN) → SaN = baixo  (primeira opção)
gerar_infra(Infra) → Infra = boa
gerar_apoio(Apoio) → Apoio = baixo
gerar_reservas(Res) → Res = baixo
configurar_cenario_simples(...)
decisao(...) → FALHA (plano_estabilizacao não está disponível)
```

#### Passo 2: Backtrack!
```
Prolog volta para o último ponto de escolha: gerar_reservas(Res)
Tenta próxima opção: Res = alto
configurar_cenario_simples(...)
decisao(...) → FALHA novamente
```

#### Passo 3: Mais Backtrack!
```
Volta para gerar_apoio(Apoio)
Tenta próxima opção: Apoio = medio
gerar_reservas(Res) → Res = baixo (começa de novo)
...
```

#### Passo 4: Continua até encontrar!
```
Após muitas tentativas...
CeN = alto, SaN = alto, Apoio = alto, Infra = boa, Res = baixo
configurar_cenario_simples(...)
decisao(...) → SUCESSO! ✅
Retorna: CeN=alto, SaN=alto, Apoio=alto, Infra=boa, Res=baixo, Meses=6
```

#### Passo 5: Você aperta `;` (quer mais soluções)
```
Prolog volta (backtrack) para o último ponto de escolha
Tenta próxima combinação...
Encontra outra solução!
```

---

## 🌳 Visualização: Árvore de Backtracking

```
                    gerar_nivel(CeN)
                    /      |      \
              baixo      medio     alto
                |          |         |
        gerar_nivel(SaN)  ...      ...
         /      |      \
    baixo    medio    alto
      |        |        |
   gerar_infra(...)
    /    |    \
  boa  media  ruim
   |     |      |
  ...   ...    ...
```

**O backtracking explora TODA essa árvore!**

---

## 💡 Por que isso é Backtracking?

### 1. **Múltiplas Escolhas em Cada Passo**

Cada `gerar_*` pode retornar múltiplos valores:
- `gerar_nivel(CeN)` → `baixo`, `medio`, `alto` (3 opções)
- `gerar_infra(Infra)` → `boa`, `media`, `ruim` (3 opções)
- `gerar_apoio(Apoio)` → `baixo`, `medio`, `alto` (3 opções)
- `gerar_reservas(Res)` → `baixo`, `alto` (2 opções)

**Total de combinações:** 3 × 3 × 3 × 3 × 2 = **162 combinações possíveis!**

### 2. **Prolog Tenta Todas Automaticamente**

Quando você faz:
```prolog
?- explorar_cenarios_onde_acao_disponivel(plano_estabilizacao, CeN, SaN, Infra, Apoio, Res, Meses).
```

O Prolog:
1. Tenta a primeira combinação: `CeN=baixo, SaN=baixo, ...`
2. Se falhar, **volta** e tenta: `CeN=baixo, SaN=baixo, Infra=media, ...`
3. Continua até encontrar uma que funcione
4. Quando você aperta `;`, ele **volta** e tenta a próxima

### 3. **O "Voltar" é o Backtracking**

Cada vez que você aperta `;`, o Prolog:
- **Volta** para o último ponto onde tinha escolha
- **Tenta** a próxima opção
- **Continua** a partir dali

Isso é **backtracking**! 🔄

---

## 🎬 Demonstração Prática

### Teste 1: Ver o Backtracking em Ação

```prolog
?- ['explorar_espaco.pl'].

% Veja quantas vezes ele "volta" e tenta novas combinações
?- explorar_cenarios_onde_acao_disponivel(plano_estabilizacao, CeN, SaN, Infra, Apoio, Res, Meses).
CeN = alto, SaN = alto, Apoio = alto, Infra = boa, Res = baixo, Meses = 6.

% Aperte ; - Prolog volta e tenta próxima combinação
; CeN = alto, SaN = alto, Apoio = alto, Infra = boa, Res = alto, Meses = 6.

% Aperte ; novamente - mais backtracking
; CeN = alto, SaN = alto, Apoio = alto, Infra = media, Res = baixo, Meses = 6.

% E assim por diante...
```

### Teste 2: Ver Todas as Tentativas (Incluindo Falhas)

Crie este teste para ver o backtracking completo:

```prolog
% Mostra TODAS as tentativas (sucesso e falha)
testar_backtracking_visivel :-
    write('=== BACKTRACKING VISÍVEL ==='), nl, nl,
    gerar_nivel(CeN),
    gerar_nivel(SaN),
    gerar_infra(Infra),
    gerar_apoio(Apoio),
    gerar_reservas(Res),
    format('Tentando: CeN=~w, SaN=~w, Infra=~w, Apoio=~w, Res=~w... ', 
           [CeN, SaN, Infra, Apoio, Res]),
    configurar_cenario_simples(CeN, SaN, Infra, Apoio, Res),
    (   decisao(sim, plano_estabilizacao, Meses)
    ->  format('✓ SUCESSO! Meses=~w~n', [Meses])
    ;   write('✗ Falhou (volta e tenta próxima)...'), nl,
        fail
    ).
```

Execute:
```prolog
?- testar_backtracking_visivel.
```

Você verá todas as tentativas, incluindo quando ele "volta" e tenta outra combinação!

---

## 🔍 Comparação: Com vs Sem Backtracking

### ❌ Sem Backtracking (Linguagens Imperativas)

```python
# Python - você precisa fazer loop manual
for ce_nivel in ['baixo', 'medio', 'alto']:
    for sa_nivel in ['baixo', 'medio', 'alto']:
        for infra in ['boa', 'media', 'ruim']:
            # ... loops aninhados ...
            if decisao_disponivel(...):
                print(...)
```

**Você precisa:** Escrever loops explícitos

### ✅ Com Backtracking (Prolog)

```prolog
% Prolog - backtracking automático!
explorar_cenarios_onde_acao_disponivel(plano_estabilizacao, CeN, SaN, Infra, Apoio, Res, Meses).
```

**Você só precisa:** Pedir a solução, o Prolog explora tudo automaticamente!

---

## 🎯 Por que isso é Poderoso?

### 1. **Exploração Automática**

Você não precisa escrever loops - o Prolog explora **todas** as possibilidades automaticamente.

### 2. **Geração de Soluções**

O Prolog **gera** soluções, não apenas consulta. Ele cria cenários que satisfazem suas condições.

### 3. **Múltiplas Respostas**

Uma consulta pode ter **múltiplas respostas** - você pede mais com `;`.

### 4. **Busca Completa**

O backtracking garante que **todas** as soluções serão encontradas (se existirem).

---

## 📊 Resumo Visual

```
Consulta: explorar_cenarios_onde_acao_disponivel(...)
           ↓
    [Tenta CeN=baixo, SaN=baixo, ...] → FALHA
           ↓ BACKTRACK
    [Tenta CeN=baixo, SaN=baixo, Infra=media, ...] → FALHA
           ↓ BACKTRACK
    [Tenta CeN=baixo, SaN=medio, ...] → FALHA
           ↓ BACKTRACK
    ...
           ↓ BACKTRACK
    [Tenta CeN=alto, SaN=alto, Apoio=alto, ...] → SUCESSO! ✅
           ↓
    Retorna primeira solução
    
    Você aperta ; → BACKTRACK
           ↓
    [Tenta próxima combinação] → SUCESSO! ✅
           ↓
    Retorna segunda solução
    
    E assim por diante...
```

---

## ✅ Conclusão

**Isso é backtracking porque:**

1. ✅ O Prolog tenta múltiplas combinações de valores
2. ✅ Quando uma falha, ele **volta** (backtrack) e tenta outra
3. ✅ Quando você pede mais (`;`), ele continua explorando
4. ✅ Ele explora **todo o espaço de soluções** automaticamente
5. ✅ Você não precisa escrever loops - o backtracking faz isso por você!

**É o poder do Prolog:** você descreve **o que** quer, não **como** encontrar! 🚀

