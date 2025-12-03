% Explorar o espaço de soluções com backtracking
% Geração de cenários simples e busca da melhor decisão para cada configuração

:- consult('data.pl').

% Gera valores possíveis de nível (reutilizando o domínio já definido)
gerar_nivel(N) :-
    nivel_valor(N, _).

% Gera valores possíveis para infraestrutura, apoio e reservas
gerar_infra(boa).
gerar_infra(media).
gerar_infra(ruim).

gerar_apoio(baixo).
gerar_apoio(medio).
gerar_apoio(alto).

gerar_reservas(baixo).
gerar_reservas(alto).

% Configura um cenário sintético para o país simbólico 'sim'
% Varia apenas:
%   - nível da crise econômica (CeN)
%   - nível da crise de saúde    (SaN)
%   - infraestrutura             (Infra)
%   - apoio da população         (Apoio)
%   - reservas                   (Res)
% Os demais atributos são fixados em valores "médios" para reduzir o espaço.

configurar_cenario_simples(CeN, SaN, Infra, Apoio, Res) :-
    % Limpa configuração anterior
    retractall(crise_economica(sim, _, _, _, _, _)),
    retractall(crise_saude(sim, _, _, _, _, _)),
    retractall(crise_seguranca(sim, _, _, _, _, _)),
    retractall(crise_social(sim, _, _, _, _, _)),
    retractall(infraestrutura(sim, _)),
    retractall(apoio_populacao(sim, _)),
    retractall(reservas(sim, _)),

    % Crise econômica e de saúde variando nível
    assertz(crise_economica(sim, CeN, estavel, moderada, medio, estavel)),
    assertz(crise_saude(sim, SaN, estavel, moderada, medio, estavel)),

    % Segurança e social fixos em "médio"
    assertz(crise_seguranca(sim, medio, estavel, moderada, medio, estavel)),
    assertz(crise_social(sim, medio, estavel, moderada, medio, estavel)),

    % Infraestrutura, apoio e reservas parametrizados
    assertz(infraestrutura(sim, Infra)),
    assertz(apoio_populacao(sim, Apoio)),
    assertz(reservas(sim, Res)).

% Explora o espaço de cenários para encontrar configurações
% em que uma determinada Ação é a MELHOR decisão.
%
% Uso típico:
%   ?- explorar_cenarios_para_acao(lockdown_parcial, CeN, SaN, Infra, Apoio, Res, Meses).
%
% Com backtracking, Prolog retorna múltiplas configurações.

explorar_cenarios_para_acao(AcaoDesejada,
                            CeN, SaN, Infra, Apoio, Res,
                            Meses) :-
    gerar_nivel(CeN),
    gerar_nivel(SaN),
    gerar_infra(Infra),
    gerar_apoio(Apoio),
    gerar_reservas(Res),

    configurar_cenario_simples(CeN, SaN, Infra, Apoio, Res),

    % Verifica se a ação está disponível
    decisao(sim, AcaoDesejada, Meses),
    
    % Verifica se é a melhor decisão
    melhor_decisao(sim, AcaoMelhor, _),
    AcaoMelhor == AcaoDesejada.

% Versão alternativa: busca cenários onde a ação está DISPONÍVEL
% (mesmo que não seja necessariamente a melhor)
explorar_cenarios_onde_acao_disponivel(AcaoDesejada,
                                      CeN, SaN, Infra, Apoio, Res,
                                      Meses) :-
    gerar_nivel(CeN),
    gerar_nivel(SaN),
    gerar_infra(Infra),
    gerar_apoio(Apoio),
    gerar_reservas(Res),

    configurar_cenario_simples(CeN, SaN, Infra, Apoio, Res),

    % Verifica se a ação está disponível
    decisao(sim, AcaoDesejada, Meses).

% Versão com saída formatada (mais legível)
explorar_cenarios_onde_acao_disponivel_formatado(AcaoDesejada) :-
    write('========================================'), nl,
    format('Cenários onde ~w está DISPONÍVEL~n', [AcaoDesejada]),
    write('========================================'), nl, nl,
    (   explorar_cenarios_onde_acao_disponivel(AcaoDesejada, CeN, SaN, Infra, Apoio, Res, Meses),
        melhor_decisao(sim, Melhor, _),
        format('CeN=~w, SaN=~w, Infra=~w, Apoio=~w, Res=~w => ~w meses (melhor: ~w)~n',
               [CeN, SaN, Infra, Apoio, Res, Meses, Melhor]),
        fail
    ;   write('(fim da busca)'), nl
    ),
    nl.

% Versão com saída formatada para "melhor decisão"
explorar_cenarios_para_acao_formatado(AcaoDesejada) :-
    write('========================================'), nl,
    format('Cenários onde ~w é a MELHOR decisão~n', [AcaoDesejada]),
    write('========================================'), nl, nl,
    (   explorar_cenarios_para_acao(AcaoDesejada, CeN, SaN, Infra, Apoio, Res, Meses),
        format('CeN=~w, SaN=~w, Infra=~w, Apoio=~w, Res=~w => ~w meses~n',
               [CeN, SaN, Infra, Apoio, Res, Meses]),
        fail
    ;   write('(nenhum cenário encontrado - ação nunca é a melhor)'), nl
    ),
    nl.

% Versão que coleta todas as soluções em uma lista de "cenarios{}"

explorar_cenarios_para_acao_lista(AcaoDesejada, ListaCenarios) :-
    findall(
        cenario{
            acao: AcaoDesejada,
            meses: Meses,
            crise_economica_nivel: CeN,
            crise_saude_nivel: SaN,
            infraestrutura: Infra,
            apoio: Apoio,
            reservas: Res
        },
        explorar_cenarios_para_acao(AcaoDesejada, CeN, SaN, Infra, Apoio, Res, Meses),
        ListaCenarios
    ).

% Mostrar diferença entre "melhor decisão" e "disponível"
mostrar_diferenca_melhor_vs_disponivel(Acao) :-
    write('========================================'), nl,
    format('ANÁLISE: ~w~n', [Acao]),
    write('========================================'), nl, nl,
    
    write('>> Cenários onde é a MELHOR decisão:'), nl,
    (   explorar_cenarios_para_acao(Acao, CeN1, SaN1, Infra1, Apoio1, Res1, M1),
        format('  - CeN=~w, SaN=~w, Infra=~w, Apoio=~w, Res=~w => ~w meses~n',
               [CeN1, SaN1, Infra1, Apoio1, Res1, M1]),
        fail
    ;   write('  (nenhum encontrado)'), nl
    ),
    nl,
    
    write('>> Cenários onde está DISPONÍVEL (pode não ser a melhor):'), nl,
    (   explorar_cenarios_onde_acao_disponivel(Acao, CeN2, SaN2, Infra2, Apoio2, Res2, M2),
        melhor_decisao(sim, Melhor, _),
        format('  - CeN=~w, SaN=~w, Infra=~w, Apoio=~w, Res=~w => ~w meses (melhor: ~w)~n',
               [CeN2, SaN2, Infra2, Apoio2, Res2, M2, Melhor]),
        fail
    ;   write('  (nenhum encontrado)'), nl
    ),
    nl.

% Exemplo pronto: explorar cenários para três ações diferentes

explorar_exemplo_basico :-
    write('=== EXPLORAÇÃO DE CENÁRIOS (BÁSICO) ==='), nl, nl,

    write('>> Cenários onde LOCKDOWN PARCIAL é a melhor decisão:'), nl,
    (   explorar_cenarios_para_acao(lockdown_parcial, CeN1, SaN1, Infra1, Apoio1, Res1, M1),
        format('  - CeN=~w, SaN=~w, Infra=~w, Apoio=~w, Res=~w => ~w meses~n',
               [CeN1, SaN1, Infra1, Apoio1, Res1, M1]),
        fail
    ;   true
    ),
    nl,

    write('>> Cenários onde INTERVENÇÃO ECONÔMICA é a melhor decisão:'), nl,
    (   explorar_cenarios_para_acao(intervencao_economica, CeN2, SaN2, Infra2, Apoio2, Res2, M2),
        format('  - CeN=~w, SaN=~w, Infra=~w, Apoio=~w, Res=~w => ~w meses~n',
               [CeN2, SaN2, Infra2, Apoio2, Res2, M2]),
        fail
    ;   true
    ),
    nl,

    write('>> Cenários onde REFORMA DE INFRAESTRUTURA é a melhor decisão:'), nl,
    (   explorar_cenarios_para_acao(reforma_infraestrutura, CeN3, SaN3, Infra3, Apoio3, Res3, M3),
        format('  - CeN=~w, SaN=~w, Infra=~w, Apoio=~w, Res=~w => ~w meses~n',
               [CeN3, SaN3, Infra3, Apoio3, Res3, M3]),
        fail
    ;   true
    ),
    nl.

% Exemplo específico para plano_estabilizacao
explorar_plano_estabilizacao :-
    write('=== EXPLORAÇÃO: PLANO DE ESTABILIZAÇÃO ==='), nl, nl,
    mostrar_diferenca_melhor_vs_disponivel(plano_estabilizacao).

% Versão interativa: mostra resultados formatados enquanto você aperta ;
explorar_interativo(Acao) :-
    write('========================================'), nl,
    format('EXPLORAÇÃO INTERATIVA: ~w~n', [Acao]),
    write('========================================'), nl, nl,
    write('Pressione ; para ver mais cenários, Enter para parar'), nl, nl,
    explorar_cenarios_onde_acao_disponivel(Acao, CeN, SaN, Infra, Apoio, Res, Meses),
    melhor_decisao(sim, Melhor, _),
    format('Cenário: CeN=~w | SaN=~w | Infra=~w | Apoio=~w | Res=~w~n', [CeN, SaN, Infra, Apoio, Res]),
    format('  → ~w disponível (~w meses) | Melhor decisão: ~w~n', [Acao, Meses, Melhor]),
    nl.


