% Demonstração visual do backtracking
% Mostra passo a passo como o Prolog explora o espaço de soluções

:- consult('data.pl').
:- consult('explorar_espaco.pl').

% Versão que mostra cada tentativa (incluindo falhas)
testar_backtracking_visivel(Acao) :-
    write('========================================'), nl,
    format('DEMONSTRAÇÃO: BACKTRACKING para ~w~n', [Acao]),
    write('========================================'), nl, nl,
    write('O Prolog vai tentar TODAS as combinações possíveis:'), nl,
    write('(Você verá quando ele volta e tenta outra)'), nl, nl,
    
    contador_reset,
    
    gerar_nivel(CeN),
    gerar_nivel(SaN),
    gerar_infra(Infra),
    gerar_apoio(Apoio),
    gerar_reservas(Res),
    
    contador_inc(Tentativa),
    format('Tentativa ~w: CeN=~w, SaN=~w, Infra=~w, Apoio=~w, Res=~w', 
           [Tentativa, CeN, SaN, Infra, Apoio, Res]),
    
    configurar_cenario_simples(CeN, SaN, Infra, Apoio, Res),
    
    (   decisao(sim, Acao, Meses)
    ->  format(' → ✓ SUCESSO! (~w meses)~n', [Meses])
    ;   write(' → ✗ Falhou (backtrack...)'), nl,
        fail
    ).

% Contador simples para numerar tentativas
:- dynamic contador/1.
contador_reset :- retractall(contador(_)), assertz(contador(0)).
contador_inc(N) :- retract(contador(X)), N is X + 1, assertz(contador(N)).

% Versão simplificada que mostra apenas sucessos
testar_backtracking_sucessos(Acao) :-
    write('========================================'), nl,
    format('BACKTRACKING: Buscando cenários para ~w~n', [Acao]),
    write('========================================'), nl, nl,
    write('(Pressione ; para ver o Prolog voltar e tentar próxima solução)'), nl, nl,
    
    gerar_nivel(CeN),
    gerar_nivel(SaN),
    gerar_infra(Infra),
    gerar_apoio(Apoio),
    gerar_reservas(Res),
    
    configurar_cenario_simples(CeN, SaN, Infra, Apoio, Res),
    
    decisao(sim, Acao, Meses),
    
    melhor_decisao(sim, Melhor, _),
    format('✓ Encontrado: CeN=~w, SaN=~w, Infra=~w, Apoio=~w, Res=~w~n', 
           [CeN, SaN, Infra, Apoio, Res]),
    format('  → ~w disponível (~w meses) | Melhor: ~w~n', [Acao, Meses, Melhor]),
    nl.

% Mostrar estatísticas do backtracking
estatisticas_backtracking(Acao) :-
    write('========================================'), nl,
    format('ESTATÍSTICAS: Backtracking para ~w~n', [Acao]),
    write('========================================'), nl, nl,
    
    % Contar total de combinações possíveis
    findall(_, gerar_nivel(_), Niveis),
    length(Niveis, TotalNiveis),
    findall(_, gerar_infra(_), Infras),
    length(Infras, TotalInfras),
    findall(_, gerar_apoio(_), Apoios),
    length(Apoios, TotalApoios),
    findall(_, gerar_reservas(_), Reservas),
    length(Reservas, TotalReservas),
    
    TotalCombinacoes is TotalNiveis * TotalNiveis * TotalInfras * TotalApoios * TotalReservas,
    
    format('Total de combinações possíveis: ~w~n', [TotalCombinacoes]),
    format('  - Níveis de crise: ~w opções × 2 (econômica + saúde) = ~w~n', 
           [TotalNiveis, TotalNiveis * TotalNiveis]),
    format('  - Infraestrutura: ~w opções~n', [TotalInfras]),
    format('  - Apoio: ~w opções~n', [TotalApoios]),
    format('  - Reservas: ~w opções~n', [TotalReservas]),
    nl,
    
    % Contar quantas são soluções válidas
    findall(_, 
        (gerar_nivel(CeN), gerar_nivel(SaN), gerar_infra(Infra),
         gerar_apoio(Apoio), gerar_reservas(Res),
         configurar_cenario_simples(CeN, SaN, Infra, Apoio, Res),
         decisao(sim, Acao, _)),
        Solucoes),
    length(Solucoes, TotalSolucoes),
    
    format('Soluções válidas encontradas: ~w~n', [TotalSolucoes]),
    format('Taxa de sucesso: ~2f%%~n', [TotalSolucoes * 100.0 / TotalCombinacoes]),
    nl.

% Exemplo completo para apresentação
demo_completa_backtracking :-
    write('========================================'), nl,
    write('DEMONSTRAÇÃO COMPLETA: BACKTRACKING'), nl,
    write('========================================'), nl, nl,
    
    write('>>> 1. Estatísticas do espaço de busca'), nl,
    estatisticas_backtracking(plano_estabilizacao),
    nl,
    
    write('>>> 2. Ver backtracking em ação (sucessos)'), nl,
    write('(Aperte ; várias vezes para ver o Prolog voltar e tentar)'), nl, nl,
    testar_backtracking_sucessos(plano_estabilizacao).

