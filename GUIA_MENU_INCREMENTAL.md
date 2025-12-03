# Guia: Menu Interativo com Coleta Incremental

## 🎯 Nova Funcionalidade: Coleta Incremental Inteligente

O menu agora coleta dados **incrementalmente** e verifica se já consegue inferir uma resposta após cada dado inserido!

---

## 🚀 Como Funciona

### Fluxo Novo:

1. **Pergunta o país primeiro** → Salva
2. **Coleta dados um por um:**
   - Crise econômica
   - Crise de saúde
   - Crise de segurança
   - Crise social
   - Infraestrutura
   - Apoio da população
   - Reservas

3. **Após cada dado:** Verifica se já consegue inferir uma resposta

4. **Se conseguir:** Pergunta:
   ```
   >>> Já consigo inferir uma resposta meu chefe!
   Quer ver agora? (s/n):
   ```

5. **Se você disser `s`:**
   - Mostra a resposta
   - Pergunta: "Deseja continuar coletando dados? (s/n):"
   - Se `n`, para a coleta
   - Se `s`, continua coletando

---

## 📋 Opções que Usam Coleta Incremental

### Opção 1: Manual

**Fluxo:**
```
Escolha opção: 1
Digite o nome do país: brasil.

--- CRISE ECONÔMICA ---
Nível: alto.
Tendência: alta.
...
[Coleta todos os dados sem verificação]
✓ Configuração completa!
```

### Opção 3: Ver Melhor Decisão ⭐ NOVO!

**Fluxo:**
```
Escolha opção: 3
Digite o nome do país: brasil.

Vou coletar os dados. Após cada dado, verifico se já consigo inferir uma resposta.

--- CRISE ECONÔMICA ---
Nível: alto.
Tendência: alta.
Severidade: critica.
Impacto: alto.
Variação: explosiva.

--- CRISE DE SAÚDE ---
Nível: alto.
Tendência: alta.
Severidade: critica.
Impacto: alto.
Variação: explosiva.

--- CRISE DE SEGURANÇA ---
Nível: medio.
...

--- INFRAESTRUTURA ---
Nível: media.

--- APOIO DA POPULAÇÃO ---
Nível: medio.

>>> Já consigo inferir uma resposta meu chefe!
Quer ver agora? (s/n): s

Melhor decisão para brasil:
  Ação: lockdown_parcial
  Duração: 1 meses
  Prioridade: 6, Impacto: alto

Deseja continuar coletando dados? (s/n): n

[Para aqui]
```

---

## 💡 Exemplo Completo de Uso

### Cenário: Coleta Incremental com Parada Antecipada

```prolog
?- iniciar.
Escolha uma opção: 3

Digite o nome do país: teste.

--- CRISE ECONÔMICA ---
Nível: baixo.
Tendência: estavel.
Severidade: leve.
Impacto: baixo.
Variação: estavel.

--- CRISE DE SAÚDE ---
Nível: alto.
Tendência: alta.
Severidade: critica.
Impacto: alto.
Variação: explosiva.

--- CRISE DE SEGURANÇA ---
Nível: baixo.
Tendência: estavel.
Severidade: leve.
Impacto: baixo.
Variação: estavel.

--- CRISE SOCIAL ---
Nível: baixo.
Tendência: estavel.
Severidade: leve.
Impacto: baixo.
Variação: estavel.

--- INFRAESTRUTURA ---
Nível: boa.

--- APOIO DA POPULAÇÃO ---
Nível: medio.

>>> Já consigo inferir uma resposta meu chefe!
Quer ver agora? (s/n): s

Melhor decisão para teste:
  Ação: lockdown_parcial
  Duração: 1 meses
  Prioridade: 6, Impacto: alto

Deseja continuar coletando dados? (s/n): n

[Para aqui - não coleta reservas]
```

---

## 🎯 Por que isso é Legal?

### 1. **Inferência Incremental**

O sistema **detecta** quando já tem dados suficientes para inferir uma resposta, sem precisar de todos os dados!

### 2. **Controle do Usuário**

Você decide se quer ver a resposta antecipada ou continuar coletando dados.

### 3. **Demonstra Poder do Prolog**

Mostra como o Prolog pode **inferir** com dados parciais, não apenas consultar dados completos.

### 4. **Experiência Interativa**

Transforma o sistema em uma conversa inteligente, não apenas um formulário estático.

---

## 🔍 Quando o Sistema Consegue Inferir?

O sistema consegue inferir uma resposta quando:

1. ✅ **Todos os dados obrigatórios estão preenchidos:**
   - `crise_economica`
   - `crise_saude`
   - `crise_seguranca`
   - `crise_social`
   - `infraestrutura`
   - `apoio_populacao`
   - `reservas`

2. ✅ **Há pelo menos uma decisão disponível**

3. ✅ **Consegue calcular a melhor decisão**

---

## 📝 Valores Aceitos

- **Respostas sim/não:** `s`, `sim`, `S`, `SIM`, `n`, `nao`, `N`, `NAO`
- **Níveis:** `baixo`, `medio`, `alto`
- **Tendências:** `queda`, `estavel`, `alta`
- **Severidade:** `leve`, `moderada`, `alta`, `critica`
- **Impacto:** `baixo`, `medio`, `alto`
- **Variação:** `decrescente`, `estavel`, `ascendente`, `explosiva`
- **Infraestrutura:** `boa`, `media`, `ruim`
- **Apoio:** `baixo`, `medio`, `alto`
- **Reservas:** `baixo`, `alto`

**IMPORTANTE:** Sempre termine com ponto (`.`)!

---

## 🎬 Para a Apresentação

### Demonstração Recomendada:

1. **Inicie o menu:**
   ```prolog
   iniciar.
   ```

2. **Escolha opção 3 (Ver melhor decisão)**

3. **Configure um país que gere resposta rápida:**
   - Crise econômica: baixo
   - Crise de saúde: **alto** ← Isso já pode gerar decisões!
   - Continue coletando...

4. **Quando aparecer a mensagem:**
   ```
   >>> Já consigo inferir uma resposta meu chefe!
   ```
   
   **Explique:** "O sistema detectou que já tem dados suficientes!"

5. **Escolha `s` para ver**

6. **Escolha `n` para parar** ou `s` para continuar

**Mensagem:** "Isso mostra o poder do Prolog de inferir com dados parciais!"

---

## ✅ Vantagens

1. ✅ **Inteligente** - Detecta quando pode inferir
2. ✅ **Interativo** - Conversa com o usuário
3. ✅ **Flexível** - Você controla quando ver a resposta
4. ✅ **Demonstra Prolog** - Mostra inferência incremental
5. ✅ **Experiência melhor** - Não precisa preencher tudo se não quiser

