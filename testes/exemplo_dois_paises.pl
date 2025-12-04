% =====================================================
% EXEMPLO: CONFIGURAÇÃO DE DOIS PAÍSES COM DECISÕES DIFERENTES
% =====================================================
% Este arquivo demonstra como configurar dois países
% para obter decisões diferentes:
% - Brasil: intervencao_economica
% - Argentina: lockdown_parcial
% =====================================================

% Carregar o arquivo principal
:- consult('data.pl').

% =====================================================
% LIMPAR DADOS ANTERIORES
% =====================================================
limpar_dados :-
    retractall(crise_economica(_, _, _, _, _, _)),
    retractall(crise_saude(_, _, _, _, _, _)),
    retractall(crise_seguranca(_, _, _, _, _, _)),
    retractall(crise_social(_, _, _, _, _, _)),
    retractall(infraestrutura(_, _)),
    retractall(apoio_populacao(_, _)),
    retractall(reservas(_, _)),
    write('✓ Dados anteriores limpos'), nl.

% =====================================================
% CONFIGURAR PAÍS 1: BRASIL
% Objetivo: Obter decisão "intervencao_economica"
% =====================================================
% Condições necessárias:
% - Crise econômica: nível ALTO
% - Crise econômica: tendência ALTA
% - Crise econômica: severidade ALTA ou CRÍTICA
% - Reservas: ALTAS
% =====================================================
configurar_brasil :-
    % Dados principais para intervencao_economica
    assertz(crise_economica(brasil, alto, alta, critica, alto, explosiva)),
    assertz(reservas(brasil, alto)),
    
    % Dados complementares (obrigatórios para completar o perfil)
    assertz(crise_saude(brasil, medio, estavel, moderada, medio, estavel)),
    assertz(crise_seguranca(brasil, medio, estavel, moderada, medio, estavel)),
    assertz(crise_social(brasil, medio, estavel, moderada, medio, estavel)),
    assertz(infraestrutura(brasil, media)),
    assertz(apoio_populacao(brasil, medio)),
    
    write('✓ Brasil configurado'), nl,
    write('  - Crise econômica: ALTA (tendência alta, severidade crítica)'), nl,
    write('  - Reservas: ALTAS'), nl.

% =====================================================
% CONFIGURAR PAÍS 2: ARGENTINA
% Objetivo: Obter decisão "lockdown_parcial"
% =====================================================
% Condições necessárias:
% - Crise de saúde: nível ALTO
% - Apoio da população: MÉDIO ou ALTO
% =====================================================
configurar_argentina :-
    % Dados principais para lockdown_parcial
    assertz(crise_saude(argentina, alto, alta, critica, alto, explosiva)),
    assertz(apoio_populacao(argentina, medio)),
    
    % Dados complementares (obrigatórios para completar o perfil)
    assertz(crise_economica(argentina, medio, estavel, moderada, medio, estavel)),
    assertz(crise_seguranca(argentina, medio, estavel, moderada, medio, estavel)),
    assertz(crise_social(argentina, medio, estavel, moderada, medio, estavel)),
    assertz(infraestrutura(argentina, media)),
    assertz(reservas(argentina, medio)),
    
    write('✓ Argentina configurada'), nl,
    write('  - Crise de saúde: ALTA'), nl,
    write('  - Apoio da população: MÉDIO'), nl.

% =====================================================
% VERIFICAR DECISÕES DO BRASIL
% =====================================================
verificar_brasil :-
    write('==============================================='), nl,
    write('VERIFICAÇÃO: BRASIL'), nl,
    write('==============================================='), nl, nl,
    
    % Verificar intervencao_economica
    (   decisao(brasil, intervencao_economica, Meses1)
    ->  write('✓ INTERVENÇÃO ECONÔMICA: Disponível'), nl,
        format('  Duração: ~w meses~n', [Meses1])
    ;   write('✗ INTERVENÇÃO ECONÔMICA: Não disponível'), nl
    ),
    nl,
    
    % Ver melhor decisão
    (   melhor_decisao(brasil, Acao, Meses)
    ->  format('Melhor decisão: ~w (~w meses)~n', [Acao, Meses])
    ;   write('Nenhuma decisão disponível'), nl
    ),
    nl.

% =====================================================
% VERIFICAR DECISÕES DA ARGENTINA
% =====================================================
verificar_argentina :-
    write('==============================================='), nl,
    write('VERIFICAÇÃO: ARGENTINA'), nl,
    write('==============================================='), nl, nl,
    
    % Verificar lockdown_parcial
    (   decisao(argentina, lockdown_parcial, Meses1)
    ->  write('✓ LOCKDOWN PARCIAL: Disponível'), nl,
        format('  Duração: ~w meses~n', [Meses1])
    ;   write('✗ LOCKDOWN PARCIAL: Não disponível'), nl
    ),
    nl,
    
    % Ver melhor decisão
    (   melhor_decisao(argentina, Acao, Meses)
    ->  format('Melhor decisão: ~w (~w meses)~n', [Acao, Meses])
    ;   write('Nenhuma decisão disponível'), nl
    ),
    nl.

% =====================================================
% COMPARAR OS DOIS PAÍSES
% =====================================================
comparar_paises :-
    write('==============================================='), nl,
    write('COMPARAÇÃO: BRASIL vs ARGENTINA'), nl,
    write('==============================================='), nl, nl,
    
    (   melhor_decisao(brasil, Acao1, Meses1),
        melhor_decisao(argentina, Acao2, Meses2)
    ->  write('BRASIL:'), nl,
        format('  Melhor decisão: ~w~n', [Acao1]),
        format('  Duração: ~w meses~n', [Meses1]),
        nl,
        write('ARGENTINA:'), nl,
        format('  Melhor decisão: ~w~n', [Acao2]),
        format('  Duração: ~w meses~n', [Meses2])
    ;   write('Erro ao comparar países'), nl
    ),
    nl.

% =====================================================
% EXPLICAR DECISÕES
% =====================================================
explicar_decisoes :-
    write('==============================================='), nl,
    write('EXPLICAÇÃO DAS DECISÕES'), nl,
    write('==============================================='), nl, nl,
    
    write('--- BRASIL ---'), nl,
    explicar_decisao(brasil, intervencao_economica),
    nl,
    
    write('--- ARGENTINA ---'), nl,
    explicar_decisao(argentina, lockdown_parcial),
    nl.

% =====================================================
% EXECUTAR TUDO
% =====================================================
executar_exemplo :-
    write('==============================================='), nl,
    write('CONFIGURAÇÃO DE DOIS PAÍSES'), nl,
    write('==============================================='), nl, nl,
    
    % Limpar dados
    write('>>> Passo 1: Limpando dados anteriores...'), nl,
    limpar_dados,
    nl,
    
    % Configurar Brasil
    write('>>> Passo 2: Configurando Brasil...'), nl,
    configurar_brasil,
    nl,
    
    % Configurar Argentina
    write('>>> Passo 3: Configurando Argentina...'), nl,
    configurar_argentina,
    nl,
    
    % Verificar Brasil
    write('>>> Passo 4: Verificando decisões do Brasil...'), nl,
    verificar_brasil,
    nl,
    
    % Verificar Argentina
    write('>>> Passo 5: Verificando decisões da Argentina...'), nl,
    verificar_argentina,
    nl,
    
    % Comparar
    write('>>> Passo 6: Comparando países...'), nl,
    comparar_paises,
    nl,
    
    % Explicar
    write('>>> Passo 7: Explicando decisões...'), nl,
    explicar_decisoes,
    nl,
    
    write('==============================================='), nl,
    write('CONFIGURAÇÃO CONCLUÍDA'), nl,
    write('==============================================='), nl.

% =====================================================
% COMANDOS RÁPIDOS
% =====================================================
% Para executar tudo de uma vez:
% ?- executar_exemplo.
%
% Para executar passo a passo:
% ?- limpar_dados.
% ?- configurar_brasil.
% ?- configurar_argentina.
% ?- verificar_brasil.
% ?- verificar_argentina.
% ?- comparar_paises.
% ?- explicar_decisoes.

