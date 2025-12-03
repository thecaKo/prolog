# Sistema de Decisão em Prolog

Sistema inteligente de tomada de decisão baseado em regras Prolog que avalia crises de países e sugere a melhor ação a ser tomada.

---

## 📋 Índice

1. [Como Funciona o Sistema de Decisões](#como-funciona-o-sistema-de-decisões)
2. [Processo de Cálculo da Melhor Decisão](#processo-de-cálculo-da-melhor-decisão)
3. [Sistema de Pontuação](#sistema-de-pontuação)
4. [Como Usar](#como-usar)
5. [Estrutura de Dados](#estrutura-de-dados)

---

## 🎯 Como Funciona o Sistema de Decisões

### Visão Geral

O sistema funciona em **3 etapas principais**:

1. **Coleta de Dados**: Informações sobre o país são inseridas (crises, infraestrutura, apoio, reservas)
2. **Avaliação de Condições**: Cada decisão verifica se suas condições são atendidas
3. **Seleção da Melhor Decisão**: Entre todas as decisões disponíveis, escolhe a de **menor prioridade**

---

## 🔍 Processo de Cálculo da Melhor Decisão

### Passo 1: Validação de Dados

Antes de calcular qualquer decisão, o sistema verifica se **todos os dados obrigatórios** estão preenchidos:

- ✅ Crise Econômica (nível, tendência, severidade, impacto, variação)
- ✅ Crise de Saúde (nível, tendência, severidade, impacto, variação)
- ✅ Crise de Segurança (nível, tendência, severidade, impacto, variação)
- ✅ Crise Social (nível, tendência, severidade, impacto, variação)
- ✅ Infraestrutura (boa/media/ruim)
- ✅ Apoio da População (baixo/medio/alto)
- ✅ Reservas (baixo/alto)

**Se faltar algum dado**, o sistema retorna uma mensagem indicando quais dados estão faltando.

### Passo 2: Verificação de Decisões Disponíveis

Para cada uma das **16 decisões possíveis**, o sistema verifica se as **condições específicas** são atendidas.

#### Exemplo: Decisão `lockdown_parcial`

```prolog
decisao(P, lockdown_parcial, 1) :-
    crise_saude(P, alto, _, _, _, _),
    (apoio_medio(P); apoio_alto(P)).
```

**Condições necessárias:**
- Crise de saúde com nível **alto**
- Apoio da população **médio** OU **alto**

Se ambas as condições forem verdadeiras → `lockdown_parcial` está **disponível**

#### Exemplo: Decisão `intervencao_economica`

```prolog
decisao(P, intervencao_economica, 6) :-
    perfil_pais(P, Perfil),
    get_dict(crise_economica, Perfil, CE),
    CE.nivel == alto,
    CE.tendencia == alta,
    (CE.severidade == alta; CE.severidade == critica),
    reservas_altas(P).
```

**Condições necessárias:**
- Crise econômica com nível **alto**
- Tendência **alta**
- Severidade **alta** OU **crítica**
- Reservas **altas**

Se todas as condições forem verdadeiras → `intervencao_economica` está **disponível**

### Passo 3: Priorização das Decisões

Cada decisão tem uma **prioridade** (número de 1 a 16):

| Prioridade | Decisão | Impacto |
|------------|---------|---------|
| 1 | intervencao_economica | médio |
| 2 | pacote_emergencial | baixo |
| 3 | reforma_tributaria | médio |
| 4 | reforco_hospitais | baixo |
| 5 | campanha_confianca | baixo |
| 6 | lockdown_parcial | **alto** |
| 7 | reforco_policial | baixo |
| 8 | deslocar_tropas | médio |
| 9 | chamar_onu | baixo |
| 10 | acordo_internacional | baixo |
| 11 | plano_estabilizacao | médio |
| 12 | contencao_social | baixo |
| 13 | reforma_infraestrutura | baixo |
| 14 | auxilio_financeiro | baixo |
| 15 | programa_social | baixo |
| 16 | controle_de_precos | médio |

**Regra de Ouro:** 
> **A melhor decisão = a decisão com MENOR número de prioridade entre todas as disponíveis**

### Passo 4: Seleção Final

O algoritmo `melhor_decisao/3` funciona assim:

```prolog
melhor_decisao(P, Acao, Meses) :-
    validar_dados_completos(P),
    findall((Prioridade, A, M),
        (decisao(P, A, M), decisao_prioridade(A, Prioridade, _)),
        Lista),
    sort(Lista, [(_, Acao, Meses) | _]).
```

**Processo:**
1. Valida que todos os dados estão completos
2. Coleta todas as decisões disponíveis com suas prioridades
3. Ordena por prioridade (menor primeiro)
4. Retorna a primeira (menor prioridade)

**Exemplo Prático:**

Se um país tem as seguintes decisões disponíveis:
- `lockdown_parcial` (prioridade 6)
- `chamar_onu` (prioridade 9)
- `reforma_infraestrutura` (prioridade 13)

**Resultado:** `lockdown_parcial` é escolhida porque tem a menor prioridade (6).

---

## 📊 Sistema de Pontuação

### Cálculo de Score por Crise

Cada crise recebe um **score** baseado na soma dos valores de seus atributos:

```prolog
crise_score(N, T, S, I, V, Score) :-
    nivel_valor(N, NV),        % Nível: baixo=1, medio=2, alto=3
    tendencia_valor(T, TV),    % Tendência: queda=1, estavel=2, alta=3
    severidade_valor(S, SV),   % Severidade: leve=1, moderada=2, alta=3, critica=4
    impacto_valor(I, IV),      % Impacto: baixo=1, medio=2, alto=3
    variacao_valor(V, VV),     % Variação: decrescente=1, estavel=2, ascendente=3, explosiva=4
    Score is NV + TV + SV + IV + VV.
```

**Exemplo:**
- Crise de saúde: `alto, alta, critica, alto, explosiva`
- Score = 3 + 3 + 4 + 3 + 4 = **17**

### Score Total do País

O score total é a soma de:
- Score da crise econômica (máx: 17)
- Score da crise de saúde (máx: 17)
- Score da crise de segurança (máx: 17)
- Score da crise social (máx: 17)
- Infraestrutura: boa=1, media=2, ruim=3
- Apoio: baixo=1, medio=2, alto=3
- Reservas: baixo=1, alto=2

**Score máximo possível:** 77

**Score normalizado:** `(Score / 77) * 100`

### Classificação do País

| Score Normalizado | Classificação |
|------------------|---------------|
| ≤ 20% | Estável |
| 21-50% | Moderado |
| 51-75% | Grave |
| > 75% | Colapso |

---

## 🚀 Como Usar

### Menu Interativo (Recomendado)

```prolog
['menu_interativo.pl'].
iniciar.
```

O menu oferece as seguintes opções:
1. **Manual** - Configurar país manualmente
2. **Backtracking** - Explorar cenários para uma ação
3. **Ver melhor decisão** - Consultar decisão de um país configurado
4. **Listar decisões por impacto** - Ver todas as decisões disponíveis agrupadas
5. **Explicar decisão** - Entender por que uma decisão está disponível
6. **Avaliar país** - Ver pesos detalhados e score
7. **Comparar países** - Comparar dois países lado a lado
8. **Exemplos** - Carregar exemplos pré-configurados
9. **Ajuda** - Ver ajuda completa

### Uso Direto (Programático)

#### 1. Configurar um país

```prolog
['data.pl'].

% Limpar dados anteriores
retractall(crise_economica(brasil, _, _, _, _, _)),
retractall(crise_saude(brasil, _, _, _, _, _)),
retractall(crise_seguranca(brasil, _, _, _, _, _)),
retractall(crise_social(brasil, _, _, _, _, _)),
retractall(infraestrutura(brasil, _)),
retractall(apoio_populacao(brasil, _)),
retractall(reservas(brasil, _)),

% Configurar dados
assertz(crise_economica(brasil, baixo, estavel, leve, baixo, estavel)),
assertz(crise_saude(brasil, alto, alta, critica, alto, explosiva)),
assertz(crise_seguranca(brasil, baixo, estavel, leve, baixo, estavel)),
assertz(crise_social(brasil, baixo, estavel, leve, baixo, estavel)),
assertz(infraestrutura(brasil, boa)),
assertz(apoio_populacao(brasil, medio)),
assertz(reservas(brasil, baixo)).
```

#### 2. Obter melhor decisão

```prolog
melhor_decisao(brasil, Acao, Meses).
% Resultado: Acao = lockdown_parcial, Meses = 1
```

#### 3. Ver todas as decisões disponíveis

```prolog
findall((A, M), decisao(brasil, A, M), Decisoes).
```

#### 4. Avaliar o país

```prolog
avaliar_pais(brasil, Score, Classificacao).
% Resultado: Score = 58.44, Classificacao = 'Grave'
```

---

## 📐 Estrutura de Dados

### Crises (6 parâmetros cada)

```prolog
crise_economica(Pais, Nivel, Tendencia, Severidade, Impacto, Variacao).
crise_saude(Pais, Nivel, Tendencia, Severidade, Impacto, Variacao).
crise_seguranca(Pais, Nivel, Tendencia, Severidade, Impacto, Variacao).
crise_social(Pais, Nivel, Tendencia, Severidade, Impacto, Variacao).
```

**Valores possíveis:**
- **Nível:** `baixo`, `medio`, `alto`
- **Tendência:** `queda`, `estavel`, `alta`
- **Severidade:** `leve`, `moderada`, `alta`, `critica`
- **Impacto:** `baixo`, `medio`, `alto`
- **Variação:** `decrescente`, `estavel`, `ascendente`, `explosiva`

### Outros Dados

```prolog
infraestrutura(Pais, Nivel).      % boa, media, ruim
apoio_populacao(Pais, Nivel).    % baixo, medio, alto
reservas(Pais, Nivel).           % baixo, alto
```

---

## 📚 Decisões Disponíveis

O sistema possui **16 decisões** diferentes, cada uma com condições específicas:

1. **intervencao_economica** - Crise econômica grave + reservas altas
2. **pacote_emergencial** - Crise econômica alta + reservas baixas
3. **reforma_tributaria** - Crise econômica alta + infraestrutura ruim
4. **reforco_hospitais** - Crise de saúde alta + infraestrutura média/ruim
5. **campanha_confianca** - Crise econômica moderada + apoio baixo
6. **lockdown_parcial** - Crise de saúde alta + apoio médio/alto
7. **reforco_policial** - Crise de segurança alta + apoio alto
8. **deslocar_tropas** - Crise de segurança alta + infraestrutura ruim
9. **chamar_onu** - Crise de saúde alta + infraestrutura ruim
10. **acordo_internacional** - Crise de segurança média/alta
11. **plano_estabilizacao** - Crise grave + apoio alto
12. **contencao_social** - Crise social média + apoio médio
13. **reforma_infraestrutura** - Infraestrutura ruim
14. **auxilio_financeiro** - (condições específicas)
15. **programa_social** - Crise social alta + apoio baixo
16. **controle_de_precos** - (condições específicas)

---

## 💡 Exemplos Práticos

### Exemplo 1: Obter "lockdown_parcial"

```prolog
% Configurar para lockdown_parcial (prioridade 6)
assertz(crise_saude(brasil, alto, alta, critica, alto, explosiva)),
assertz(apoio_populacao(brasil, medio)),

% Outras crises em níveis baixos
assertz(crise_economica(brasil, baixo, estavel, leve, baixo, estavel)),
assertz(crise_seguranca(brasil, baixo, estavel, leve, baixo, estavel)),
assertz(crise_social(brasil, baixo, estavel, leve, baixo, estavel)),
assertz(infraestrutura(brasil, boa)),
assertz(reservas(brasil, baixo)),

melhor_decisao(brasil, Acao, Meses).
% Resultado: Acao = lockdown_parcial, Meses = 1
```

### Exemplo 2: Obter "intervencao_economica"

```prolog
% Configurar para intervencao_economica (prioridade 1)
assertz(crise_economica(brasil, alto, alta, critica, alto, explosiva)),
assertz(reservas(brasil, alto)),

% Outras crises em níveis baixos
assertz(crise_saude(brasil, baixo, estavel, leve, baixo, estavel)),
assertz(crise_seguranca(brasil, baixo, estavel, leve, baixo, estavel)),
assertz(crise_social(brasil, baixo, estavel, leve, baixo, estavel)),
assertz(infraestrutura(brasil, boa)),
assertz(apoio_populacao(brasil, medio)),

melhor_decisao(brasil, Acao, Meses).
% Resultado: Acao = intervencao_economica, Meses = 6
```

---

## 🔧 Arquivos Principais

- **`data.pl`** - Lógica principal do sistema (decisões, scores, validações)
- **`menu_interativo.pl`** - Menu interativo completo
- **`explorar_espaco.pl`** - Funcionalidades de backtracking e exploração
- **`GUIA_USO.md`** - Guia detalhado de uso
- **`README_MENU.md`** - Documentação do menu interativo

---

## 📝 Notas Importantes

- Todos os valores devem terminar com **ponto** (`.`) no Prolog
- Nomes de ações são em **minúsculas** com underscore: `lockdown_parcial`
- O sistema valida automaticamente se todos os dados estão preenchidos
- A melhor decisão é sempre a de **menor prioridade** entre as disponíveis
- Se nenhuma decisão estiver disponível, retorna `nenhuma` com 0 meses

---

## 🎓 Conceitos-Chave

### Prioridade vs Impacto

- **Prioridade**: Determina qual decisão é escolhida (menor número = escolhida primeiro)
- **Impacto**: Classifica o nível de impacto da decisão (alto/médio/baixo)

### Decisão Disponível vs Melhor Decisão

- **Disponível**: A decisão atende suas condições específicas
- **Melhor Decisão**: Entre todas as disponíveis, é a de menor prioridade

### Score vs Classificação

- **Score**: Valor numérico calculado (0-77, normalizado para 0-100%)
- **Classificação**: Categoria baseada no score (Estável/Moderado/Grave/Colapso)

---

## 📖 Documentação Adicional

- **`GUIA_USO.md`** - Guia completo com exemplos detalhados
- **`GUIA_MENU_INTERATIVO.md`** - Como usar o menu interativo
- **`EXPLORAR_ESPACO.md`** - Como usar backtracking para explorar cenários
- **`MODO_EXPLICATIVO.md`** - Como usar o modo explicativo

---

**Desenvolvido em Prolog - Demonstração de Sistema de Regras e Inferência**
