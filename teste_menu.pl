% Teste rápido do menu interativo
% Demonstra as principais funcionalidades

:- consult('menu_interativo.pl').

% Teste rápido: configurar país e ver resultados
teste_rapido_menu :-
    write('========================================'), nl,
    write('TESTE RÁPIDO DO MENU'), nl,
    write('========================================'), nl, nl,
    
    % Configurar um país de teste
    write('>>> Configurando país de teste...'), nl,
    retractall(crise_economica(pais_teste, _, _, _, _, _)),
    retractall(crise_saude(pais_teste, _, _, _, _, _)),
    retractall(crise_seguranca(pais_teste, _, _, _, _, _)),
    retractall(crise_social(pais_teste, _, _, _, _, _)),
    retractall(infraestrutura(pais_teste, _)),
    retractall(apoio_populacao(pais_teste, _)),
    retractall(reservas(pais_teste, _)),
    
    assertz(crise_economica(pais_teste, alto, alta, critica, alto, explosiva)),
    assertz(crise_saude(pais_teste, alto, alta, critica, alto, explosiva)),
    assertz(crise_seguranca(pais_teste, medio, estavel, moderada, medio, estavel)),
    assertz(crise_social(pais_teste, medio, estavel, moderada, medio, estavel)),
    assertz(infraestrutura(pais_teste, media)),
    assertz(apoio_populacao(pais_teste, medio)),
    assertz(reservas(pais_teste, alto)),
    
    write('✓ País configurado: pais_teste'), nl, nl,
    
    % Testar melhor decisão
    write('>>> Testando melhor decisão...'), nl,
    (   melhor_decisao(pais_teste, Acao, Meses)
    ->  format('Melhor decisão: ~w (~w meses)~n', [Acao, Meses])
    ;   write('Nenhuma decisão disponível'), nl
    ),
    nl,
    
    % Testar listar por impacto
    write('>>> Testando listar por impacto...'), nl,
    listar_decisoes_por_impacto(pais_teste),
    nl,
    
    write('========================================'), nl,
    write('TESTE CONCLUÍDO'), nl,
    write('========================================'), nl,
    write('Agora você pode usar: iniciar. para abrir o menu'), nl.

