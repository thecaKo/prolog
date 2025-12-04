# 📋 Guia Passo a Passo: Configuração de Dois Países com Decisões Diferentes

Este guia mostra como configurar dois países no sistema Prolog para obter decisões diferentes.

---

## 🎯 Objetivo

Configurar:
- **País 1 (Brasil)**: Obter decisão `intervencao_economica`
- **País 2 (Argentina)**: Obter decisão `lockdown_parcial`

---

## 📝 Passo 1: Abrir o Prolog e Carregar o Arquivo

```prolog
% No terminal, abra o SWI-Prolog:
swipl

% Carregue o arquivo data.pl:
?- [data].
```

**Resultado esperado:**
```
true.
```

---

## 📝 Passo 2: Limpar Dados Anteriores (Opcional)

Se você já configurou países anteriormente, limpe os dados:

```prolog
?- retractall(crise_economica(_, _, _, _, _, _)),
   retractall(crise_saude(_, _, _, _, _, _)),
   retractall(crise_seguranca(_, _, _, _, _, _)),
   retractall(crise_social(_, _, _, _, _, _)),
   retractall(infraestrutura(_, _)),
   retractall(apoio_populacao(_, _)),
   retractall(reservas(_, _)).
```

**Resultado esperado:**
```
true.
```

---

## 📝 Passo 3: Configurar PAÍS 1 (Brasil) - Para obter `intervencao_economica`

### Condições necessárias para `intervencao_economica`:
- ✅ Crise econômica: **nível ALTO**
- ✅ Crise econômica: **tendência ALTA**
- ✅ Crise econômica: **severidade ALTA ou CRÍTICA**
- ✅ Reservas: **ALTAS**

### Comandos:

```prolog
% Configurar crise econômica (alto, alta, critica, alto, explosiva)
?- assertz(crise_economica(brasil, alto, alta, critica, alto, explosiva)).

% Configurar reservas altas
?- assertz(reservas(brasil, alto)).

% Preencher os outros dados obrigatórios (para completar o perfil)
?- assertz(crise_saude(brasil, medio, estavel, moderada, medio, estavel)),
   assertz(crise_seguranca(brasil, medio, estavel, moderada, medio, estavel)),
   assertz(crise_social(brasil, medio, estavel, moderada, medio, estavel)),
   assertz(infraestrutura(brasil, media)),
   assertz(apoio_populacao(brasil, medio)).
```

**Resultado esperado:**
```
true.
true.
true.
```

---

## 📝 Passo 4: Verificar Decisão do PAÍS 1

```prolog
% Verificar se a decisão intervencao_economica está disponível
?- decisao(brasil, intervencao_economica, Meses).
```

**Resultado esperado:**
```
Meses = 6.
```

```prolog
% Ver a melhor decisão para o Brasil
?- melhor_decisao(brasil, Acao, Meses).
```

**Resultado esperado:**
```
Acao = intervencao_economica,
Meses = 6.
```

```prolog
% Explicar a decisão
?- explicar_decisao(brasil, intervencao_economica).
```

**Resultado esperado:**
```
Decisão: intervencao_economica
Duração estimada: 6 meses
Prioridade: 1, Impacto: medio
Motivos:
  - Crise econômica em nível alto, tendência alta, severidade critica, impacto alto, variação explosiva.
  - Reservas em nível alto (permite intervenção mais forte).
```

---

## 📝 Passo 5: Configurar PAÍS 2 (Argentina) - Para obter `lockdown_parcial`

### Condições necessárias para `lockdown_parcial`:
- ✅ Crise de saúde: **nível ALTO**
- ✅ Apoio da população: **MÉDIO ou ALTO**

### Comandos:

```prolog
% Configurar crise de saúde (alto, alta, critica, alto, explosiva)
?- assertz(crise_saude(argentina, alto, alta, critica, alto, explosiva)).

% Configurar apoio médio (permite lockdown)
?- assertz(apoio_populacao(argentina, medio)).

% Preencher os outros dados obrigatórios (para completar o perfil)
?- assertz(crise_economica(argentina, medio, estavel, moderada, medio, estavel)),
   assertz(crise_seguranca(argentina, medio, estavel, moderada, medio, estavel)),
   assertz(crise_social(argentina, medio, estavel, moderada, medio, estavel)),
   assertz(infraestrutura(argentina, media)),
   assertz(reservas(argentina, medio)).
```

**Resultado esperado:**
```
true.
true.
true.
```

---

## 📝 Passo 6: Verificar Decisão do PAÍS 2

```prolog
% Verificar se a decisão lockdown_parcial está disponível
?- decisao(argentina, lockdown_parcial, Meses).
```

**Resultado esperado:**
```
Meses = 1.
```

```prolog
% Ver a melhor decisão para a Argentina
?- melhor_decisao(argentina, Acao, Meses).
```

**Resultado esperado:**
```
Acao = lockdown_parcial,
Meses = 1.
```

```prolog
% Explicar a decisão
?- explicar_decisao(argentina, lockdown_parcial).
```

**Resultado esperado:**
```
Decisão: lockdown_parcial
Duração estimada: 1 meses
Prioridade: 6, Impacto: alto
Motivos:
  - Crise de saúde em nível alto, tendência alta, severidade critica, impacto alto, variação explosiva.
  - Apoio da população em nível medio (permite medidas restritivas).
```

---

## 📝 Passo 7: Comparar os Dois Países

```prolog
% Listar todas as decisões disponíveis para o Brasil
?- listar_decisoes_com_impacto(brasil).
```

```prolog
% Listar todas as decisões disponíveis para a Argentina
?- listar_decisoes_com_impacto(argentina).
```

```prolog
% Comparar as melhores decisões
?- melhor_decisao(brasil, Acao1, Meses1), melhor_decisao(argentina, Acao2, Meses2).
```

**Resultado esperado:**
```
Acao1 = intervencao_economica,
Meses1 = 6,
Acao2 = lockdown_parcial,
Meses2 = 1.
```

---

## 📊 Resumo dos Comandos Completos

Aqui está um script completo que você pode copiar e colar:

```prolog
% ============================================
% CONFIGURAÇÃO COMPLETA DOS DOIS PAÍSES
% ============================================

% Limpar dados anteriores
retractall(crise_economica(_, _, _, _, _, _)),
retractall(crise_saude(_, _, _, _, _, _)),
retractall(crise_seguranca(_, _, _, _, _, _)),
retractall(crise_social(_, _, _, _, _, _)),
retractall(infraestrutura(_, _)),
retractall(apoio_populacao(_, _)),
retractall(reservas(_, _)).

% ============================================
% PAÍS 1: BRASIL - intervencao_economica
% ============================================
assertz(crise_economica(brasil, alto, alta, critica, alto, explosiva)),
assertz(reservas(brasil, alto)),
assertz(crise_saude(brasil, medio, estavel, moderada, medio, estavel)),
assertz(crise_seguranca(brasil, medio, estavel, moderada, medio, estavel)),
assertz(crise_social(brasil, medio, estavel, moderada, medio, estavel)),
assertz(infraestrutura(brasil, media)),
assertz(apoio_populacao(brasil, medio)).

% ============================================
% PAÍS 2: ARGENTINA - lockdown_parcial
% ============================================
assertz(crise_saude(argentina, alto, alta, critica, alto, explosiva)),
assertz(apoio_populacao(argentina, medio)),
assertz(crise_economica(argentina, medio, estavel, moderada, medio, estavel)),
assertz(crise_seguranca(argentina, medio, estavel, moderada, medio, estavel)),
assertz(crise_social(argentina, medio, estavel, moderada, medio, estavel)),
assertz(infraestrutura(argentina, media)),
assertz(reservas(argentina, medio)).

% ============================================
% VERIFICAÇÕES
% ============================================
% Verificar Brasil
melhor_decisao(brasil, Acao1, Meses1),
format('Brasil - Melhor decisão: ~w (~w meses)~n', [Acao1, Meses1]).

% Verificar Argentina
melhor_decisao(argentina, Acao2, Meses2),
format('Argentina - Melhor decisão: ~w (~w meses)~n', [Acao2, Meses2]).
```

---

## 🔍 Valores Possíveis para Cada Campo

### Níveis de Crise:
- `baixo`, `medio`, `alto`

### Tendências:
- `queda`, `estavel`, `alta`

### Severidades:
- `leve`, `moderada`, `alta`, `critica`

### Impactos:
- `baixo`, `medio`, `alto`

### Variações:
- `decrescente`, `estavel`, `ascendente`, `explosiva`

### Infraestrutura:
- `boa`, `media`, `ruim`

### Apoio da População:
- `baixo`, `medio`, `alto`

### Reservas:
- `baixo`, `medio`, `alto`

---

## ✅ Checklist de Validação

Após configurar cada país, verifique:

- [ ] Todos os 7 dados estão configurados (4 crises + infraestrutura + apoio + reservas)
- [ ] A decisão desejada está disponível: `decisao(pais, decisao_desejada, _)`
- [ ] A melhor decisão corresponde ao esperado: `melhor_decisao(pais, _, _)`
- [ ] Não há dados faltantes: `coletar_dados_faltantes(pais, [])`

---

## 🎓 Exemplos de Outras Decisões

### Para obter `pacote_emergencial`:
```prolog
assertz(crise_economica(pais, alto, alta, alta, alto, explosiva)),
assertz(reservas(pais, baixo)).
```

### Para obter `reforco_policial`:
```prolog
assertz(crise_seguranca(pais, alto, alta, alta, alto, explosiva)),
assertz(apoio_populacao(pais, alto)).
```

### Para obter `chamar_onu`:
```prolog
assertz(crise_saude(pais, alto, alta, alta, alto, explosiva)),
assertz(infraestrutura(pais, ruim)).
```

---

## 📚 Comandos Úteis Adicionais

```prolog
% Ver score do país
?- score_pais_normalizado(brasil, Score).

% Ver classificação do país
?- avaliar_pais(brasil, Score, Classificacao).

% Listar decisões por impacto
?- listar_decisoes_por_impacto(brasil).

% Ver todas as decisões disponíveis
?- findall((A, M), decisao(brasil, A, M), Lista).
```

---

**Fim do Guia** 🎉

