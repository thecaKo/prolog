# Explorar o Espaço de Soluções com Backtracking

Este módulo mostra como usar **backtracking em Prolog** para explorar automaticamente o espaço de cenários possíveis e descobrir **para quais configurações** cada decisão é a melhor.

## Arquivo

- Código: `explorar_espaco.pl`
- Depende de: `data.pl`

## Predicados Principais

- `explorar_cenarios_para_acao/7`
- `explorar_cenarios_para_acao_lista/2`
- `explorar_exemplo_basico/0`

---

## 1. Carregar o módulo

```prolog
['explorar_espaco.pl'].
```

Isso já carrega `data.pl` automaticamente.

---

## 2. Predicado `explorar_cenarios_para_acao/7`

```prolog
explorar_cenarios_para_acao(
    AcaoDesejada,
    CeN, SaN, Infra, Apoio, Res,
    Meses
).
```

Onde:

- `AcaoDesejada`: nome da ação (ex: `lockdown_parcial`, `intervencao_economica`)
- `CeN`: nível da crise econômica (`baixo`, `medio`, `alto`)
- `SaN`: nível da crise de saúde (`baixo`, `medio`, `alto`)
- `Infra`: `boa`, `media`, `ruim`
- `Apoio`: `baixo`, `medio`, `alto`
- `Res`: `baixo`, `alto`
- `Meses`: duração da ação retornada por `melhor_decisao/3`

### Exemplo: encontrar cenários para `lockdown_parcial`

```prolog
?- explorar_cenarios_para_acao(lockdown_parcial,
                               CeN, SaN, Infra, Apoio, Res,
                               Meses).
CeN = baixo,
SaN = alto,
Infra = boa,
Apoio = medio,
Res = baixo,
Meses = 1 ;
CeN = medio,
SaN = alto,
Infra = boa,
Apoio = medio,
Res = baixo,
Meses = 1 ;
...
```

Com **backtracking**, Prolog vai devolvendo **várias combinações de cenários** em que `lockdown_parcial` é a melhor decisão.

### Exemplo: `intervencao_economica`

```prolog
?- explorar_cenarios_para_acao(intervencao_economica,
                               CeN, SaN, Infra, Apoio, Res,
                               Meses).
CeN = alto,
SaN = baixo,
Infra = boa,
Apoio = medio,
Res = alto,
Meses = 6 ;
...
```

---

## 3. Predicado `explorar_cenarios_para_acao_lista/2`

```prolog
explorar_cenarios_para_acao_lista(AcaoDesejada, ListaCenarios).
```

Retorna uma lista de dicionários (`cenario{...}`) com todos os cenários em que a ação é a melhor.

### Exemplo:

```prolog
?- explorar_cenarios_para_acao_lista(reforma_infraestrutura, L).
L = [ cenario{
        acao:reforma_infraestrutura,
        meses:12,
        crise_economica_nivel:baixo,
        crise_saude_nivel:baixo,
        infraestrutura:ruim,
        apoio:baixo,
        reservas:baixo
     },
     ...].
```

Isso é ótimo para:

- análise programática
- exportação de cenários
- visualização em outras ferramentas

---

## 4. Predicado `explorar_exemplo_basico/0`

```prolog
?- explorar_exemplo_basico.
```

Saída (aproximada):

```text
=== EXPLORAÇÃO DE CENÁRIOS (BÁSICO) ===

>> Cenários onde LOCKDOWN PARCIAL é a melhor decisão:
  - CeN=baixo, SaN=alto, Infra=boa, Apoio=medio, Res=baixo => 1 meses
  - ...

>> Cenários onde INTERVENÇÃO ECONÔMICA é a melhor decisão:
  - CeN=alto, SaN=baixo, Infra=boa, Apoio=medio, Res=alto => 6 meses
  - ...

>> Cenários onde REFORMA DE INFRAESTRUTURA é a melhor decisão:
  - CeN=baixo, SaN=baixo, Infra=ruim, Apoio=baixo, Res=baixo => 12 meses
  - ...
```

Isso demonstra bem:

- backtracking
- geração de cenários
- escolha ótima via `melhor_decisao/3`

---

## 5. Como Funciona por Baixo dos Panos (Resumo)

1. Gera combinações de:
   - nível da crise econômica (`CeN`)
   - nível da crise de saúde (`SaN`)
   - infraestrutura (`Infra`)
   - apoio (`Apoio`)
   - reservas (`Res`)

2. Para cada combinação:
   - configura um país simbólico `sim` com esses valores
   - preenche os outros dados com valores médios
   - chama `melhor_decisao(sim, Acao, Meses)`

3. Usa **backtracking** para encontrar **todas** as combinações em que:

```prolog
Acao == AcaoDesejada.
```

---

## 6. Ideias para Apresentação

- Mostrar ao vivo:
  - uma consulta com `explorar_cenarios_para_acao/7`
  - ir apertando `;` e explicando como o Prolog está “testando” vários mundos possíveis
- Combinar com `explicar_decisao/2`:

```prolog
?- explorar_cenarios_para_acao(lockdown_parcial, CeN, SaN, Infra, Apoio, Res, Meses),
   configurar_cenario_simples(CeN, SaN, Infra, Apoio, Res),
   explicar_decisao(sim, lockdown_parcial).
```

Assim você mostra:

- geração de cenário (backtracking)
- melhor decisão
- explicação textual da decisão


