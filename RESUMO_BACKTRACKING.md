# Resumo: Por que isso é Backtracking?

## 🎯 Resposta Rápida

**É backtracking porque o Prolog explora múltiplas combinações automaticamente, voltando e tentando novas opções quando uma falha ou quando você pede mais soluções.**

---

## 🔄 O que Acontece Quando Você Executa:

```prolog
?- explorar_cenarios_onde_acao_disponivel(plano_estabilizacao, CeN, SaN, Infra, Apoio, Res, Meses).
```

### Passo a Passo:

1. **Prolog tenta:** `CeN=baixo, SaN=baixo, Infra=boa, Apoio=baixo, Res=baixo`
   - Configura o país
   - Verifica se `plano_estabilizacao` está disponível
   - ❌ **FALHA** (não está disponível)

2. **BACKTRACK:** Prolog **volta** para `gerar_reservas(Res)`
   - Tenta próxima opção: `Res=alto`
   - Configura novamente
   - Verifica novamente
   - ❌ **FALHA** novamente

3. **BACKTRACK:** Prolog **volta** para `gerar_apoio(Apoio)`
   - Tenta próxima opção: `Apoio=medio`
   - `gerar_reservas(Res)` começa de novo: `Res=baixo`
   - Configura e verifica
   - ❌ **FALHA**

4. **Continua assim...** até encontrar uma combinação que funcione:
   - ✅ `CeN=alto, SaN=alto, Apoio=alto, Infra=boa, Res=baixo`
   - **SUCESSO!** Retorna essa solução

5. **Você aperta `;`** (quer mais):
   - Prolog **volta** (backtrack) e tenta próxima combinação
   - Encontra outra solução
   - E assim por diante...

---

## 💡 Por que isso é Backtracking?

### Características do Backtracking:

1. ✅ **Múltiplas escolhas:** Cada `gerar_*` pode retornar vários valores
2. ✅ **Tentativa e erro:** Prolog tenta uma combinação, se falhar, tenta outra
3. ✅ **Volta automaticamente:** Quando falha, volta para última escolha e tenta próxima
4. ✅ **Explora tudo:** Eventualmente explora todas as combinações possíveis
5. ✅ **Múltiplas soluções:** Uma consulta pode ter várias respostas

### No nosso código:

```prolog
explorar_cenarios_onde_acao_disponivel(...) :-
    gerar_nivel(CeN),      % ← Pode ser: baixo, medio, alto (3 opções)
    gerar_nivel(SaN),      % ← Pode ser: baixo, medio, alto (3 opções)
    gerar_infra(Infra),    % ← Pode ser: boa, media, ruim (3 opções)
    gerar_apoio(Apoio),    % ← Pode ser: baixo, medio, alto (3 opções)
    gerar_reservas(Res),   % ← Pode ser: baixo, alto (2 opções)
    ...
```

**Total:** 3 × 3 × 3 × 3 × 2 = **162 combinações possíveis!**

O backtracking explora **todas** essas combinações automaticamente!

---

## 🎬 Demonstração Prática

### Teste 1: Ver o Backtracking em Ação

```prolog
?- ['demo_backtracking_visivel.pl'].

% Mostra cada tentativa (incluindo quando volta)
?- testar_backtracking_visivel(plano_estabilizacao).
```

### Teste 2: Ver Apenas Sucessos (Mais Limpo)

```prolog
% Mostra apenas quando encontra solução
?- testar_backtracking_sucessos(plano_estabilizacao).
```

**Aperte `;` várias vezes** e veja o Prolog voltar e encontrar novas soluções!

### Teste 3: Ver Estatísticas

```prolog
% Mostra quantas combinações existem e quantas são soluções
?- estatisticas_backtracking(plano_estabilizacao).
```

---

## 📊 Comparação Visual

### Sem Backtracking (Linguagens Tradicionais):

```python
# Você precisa escrever loops explícitos
solutions = []
for ce_nivel in ['baixo', 'medio', 'alto']:
    for sa_nivel in ['baixo', 'medio', 'alto']:
        for infra in ['boa', 'media', 'ruim']:
            for apoio in ['baixo', 'medio', 'alto']:
                for res in ['baixo', 'alto']:
                    if decisao_disponivel(...):
                        solutions.append(...)
```

**Você controla:** Cada loop, cada iteração

### Com Backtracking (Prolog):

```prolog
% Você só descreve o que quer
explorar_cenarios_onde_acao_disponivel(plano_estabilizacao, CeN, SaN, Infra, Apoio, Res, Meses).
```

**Prolog controla:** Exploração automática de todas as combinações!

---

## ✅ Conclusão

**Isso é backtracking porque:**

1. ✅ O Prolog **gera** múltiplas combinações de valores
2. ✅ Quando uma falha, ele **volta** (backtrack) e tenta outra
3. ✅ Quando você pede mais (`;`), ele continua explorando
4. ✅ Ele explora **todo o espaço de soluções** sem você precisar escrever loops
5. ✅ É **automático** - você descreve o problema, o Prolog resolve!

**É o poder do Prolog:** Programação **declarativa** vs **imperativa**! 🚀

