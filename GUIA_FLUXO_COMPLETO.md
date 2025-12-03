# Guia: Fluxo Completo - Opção 3 → Opção 5

## 🎯 Fluxo Desejado

1. **Opção 3** - Ver melhor decisão (incremental)
   - Configura país passo a passo
   - Quando consegue inferir, mostra resultado
   - Usuário escolhe não continuar coletando dados (`n`)
   - **Retorna ao menu principal**

2. **Opção 5** - Explicar decisão
   - Usa o mesmo país configurado anteriormente
   - Explica a decisão encontrada

---

## 📋 Passo a Passo

### Passo 1: Configurar e Ver Decisão

```
Escolha uma opção: 3

Digite o nome do país: brasil.

--- CRISE ECONÔMICA ---
[coleta dados]

--- APOIO DA POPULAÇÃO ---
[coleta dados]

>>> Já consigo inferir uma resposta meu chefe!
Quer ver agora? (s/n): s

Melhor decisão para brasil:
  Ação: lockdown_parcial
  Duração: 1 meses

Deseja continuar coletando dados? (s/n): n

>>> Retornando ao menu principal...
```

### Passo 2: Explicar a Decisão

```
Escolha uma opção: 5

Digite o nome do país: brasil.
Digite o nome da ação: lockdown_parcial.

[Mostra explicação detalhada]
```

---

## ✅ O que foi Implementado

### 1. **Retorno Automático ao Menu**

Quando o usuário escolhe `n` para não continuar coletando dados:
- Sistema para a coleta
- Mostra mensagem: ">>> Retornando ao menu principal..."
- **Retorna ao menu automaticamente**

### 2. **Dados Persistem**

Os dados do país configurado **permanecem na memória**, então:
- Você pode usar o mesmo país na opção 5
- Não precisa reconfigurar tudo

### 3. **Fluxo Natural**

```
Menu → Opção 3 → Configura → Vê resultado → Escolhe não continuar
  ↓
Menu → Opção 5 → Explica decisão
```

---

## 🎬 Exemplo Completo

```prolog
?- iniciar.

Escolha uma opção: 3.

Digite o nome do país: brasil.

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
Quer ver agora? (s/n): s.

Melhor decisão para brasil:
  Ação: lockdown_parcial
  Duração: 1 meses
  Prioridade: 6, Impacto: alto

Deseja continuar coletando dados? (s/n): n.

>>> Retornando ao menu principal...

[Menu aparece novamente]

Escolha uma opção: 5.

Digite o nome do país: brasil.
Digite o nome da ação: lockdown_parcial.

[Mostra explicação detalhada da decisão]
```

---

## 💡 Dicas

1. **Use o mesmo nome de país** nas opções 3 e 5
2. **Os dados persistem** entre as opções do menu
3. **Você pode escolher `s`** para continuar coletando se quiser ver o resultado final completo
4. **Escolha `n`** quando quiser parar e usar outras opções do menu

---

## 🔧 Como Funciona Tecnicamente

1. Quando usuário escolhe `n`:
   - Flag `retornar_ao_menu` é definida
   - `coletar_dados_incremental_com_verificacao` falha (retorna `false`)
   - `menu_melhor_decisao` detecta o `false` e mostra mensagem
   - Menu principal é chamado novamente

2. Dados persistem porque:
   - São armazenados com `assertz/1`
   - Permanecem na memória do Prolog
   - Podem ser consultados por qualquer opção do menu

---

## ✅ Pronto para Usar!

O fluxo está completo e funcionando! 🎉

