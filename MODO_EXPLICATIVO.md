# Modo Explicativo de Decisões

Este modo explica **por que** uma determinada decisão foi escolhida para um país, usando apenas Prolog.

## Predicados Principais

- `explicar_decisao(Pais, Acao)`  
  Explica passo a passo os motivos que ativaram a ação `Acao` para o `Pais`.

- `explicar_melhor_decisao(Pais)`  
  Calcula a melhor decisão com `melhor_decisao/3` e chama automaticamente `explicar_decisao/2`.

## Como Usar

### 1. Carregar o sistema

```prolog
['data.pl'].
```

### 2. Configurar um país (exemplo)

```prolog
assertz(crise_economica(brasil, alto, alta, critica, alto, explosiva)),
assertz(crise_saude(brasil, alto, alta, critica, alto, explosiva)),
assertz(crise_seguranca(brasil, medio, estavel, moderada, medio, estavel)),
assertz(crise_social(brasil, medio, estavel, moderada, medio, estavel)),
assertz(infraestrutura(brasil, media)),
assertz(apoio_populacao(brasil, medio)),
assertz(reservas(brasil, alto)).
```

### 3. Explicar a melhor decisão

```prolog
?- explicar_melhor_decisao(brasil).
Decisão: intervencao_economica
Duração estimada: 6 meses
Prioridade: 1, Impacto: medio
Motivos:
  - Crise econômica em nível alto, tendência alta, severidade critica, impacto alto, variação explosiva.
  - Reservas em nível alto (permite intervenção mais forte).
true.
```

### 4. Explicar uma decisão específica

```prolog
?- explicar_decisao(brasil, lockdown_parcial).
Decisão: lockdown_parcial
Duração estimada: 1 meses
Prioridade: 6, Impacto: alto
Motivos:
  - Crise de saúde em nível alto, tendência alta, severidade critica, impacto alto, variação explosiva.
  - Apoio da população em nível medio (permite medidas restritivas).
true.
```

### 5. Quando a decisão não está disponível

```prolog
?- explicar_decisao(brasil, chamar_onu).
Nenhuma decisão chamar_onu está disponível para brasil (condições não satisfeitas).
false.
```

Isso mostra claramente que as condições da regra de `chamar_onu` não foram atendidas para esse país.

## Decisões com Explicação Específica

As seguintes ações têm explicações detalhadas:

- `lockdown_parcial`
- `intervencao_economica`
- `pacote_emergencial`
- `reforco_hospitais`
- `chamar_onu`
- `reforco_policial`
- `deslocar_tropas`
- `reforma_infraestrutura`
- `plano_estabilizacao`

Para qualquer outra ação, o sistema mostra uma explicação genérica contendo:

- nome da decisão
- duração
- prioridade
- impacto

## Exemplos Rápidos

```prolog
% Ver melhor decisão e explicação
?- melhor_decisao(brasil, A, M), explicar_decisao(brasil, A).

% Explicar múltiplas ações disponíveis
?- decisao(brasil, Acao, _), explicar_decisao(brasil, Acao), fail; true.
```

Esses exemplos usam o **backtracking do Prolog** para percorrer todas as ações disponíveis e explicar cada uma.


