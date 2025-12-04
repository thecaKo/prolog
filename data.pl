:- dynamic crise_economica/6.
:- dynamic crise_saude/6.
:- dynamic crise_seguranca/6.
:- dynamic crise_social/6.
:- dynamic infraestrutura/2.
:- dynamic apoio_populacao/2.
:- dynamic reservas/2.

nivel_valor(alto, 3).
nivel_valor(medio, 2).
nivel_valor(baixo, 1).
nivel_valor(boa, 1).
nivel_valor(media, 2).
nivel_valor(ruim, 3).

tendencia_valor(alta, 3).
tendencia_valor(estavel, 2).
tendencia_valor(queda, 1).

severidade_valor(critica, 4).
severidade_valor(alta, 3).
severidade_valor(moderada, 2).
severidade_valor(leve, 1).

impacto_valor(alto, 3).
impacto_valor(medio, 2).
impacto_valor(baixo, 1).

variacao_valor(explosiva, 4).
variacao_valor(ascendente, 3).
variacao_valor(estavel, 2).
variacao_valor(decrescente, 1).

crise_score(N, T, S, I, V, Score) :-
    nivel_valor(N, NV),
    tendencia_valor(T, TV),
    severidade_valor(S, SV),
    impacto_valor(I, IV),
    variacao_valor(V, VV),
    Score is NV + TV + SV + IV + VV.

score_pais(P, ScoreFinal) :-
    crise_economica(P, EcN, EcT, EcS, EcI, EcV),
    crise_score(EcN, EcT, EcS, EcI, EcV, S1),
    crise_saude(P, SaN, SaT, SaS, SaI, SaV),
    crise_score(SaN, SaT, SaS, SaI, SaV, S2),
    crise_seguranca(P, SeN, SeT, SeS, SeI, SeV),
    crise_score(SeN, SeT, SeS, SeI, SeV, S3),
    crise_social(P, SoN, SoT, SoS, SoI, SoV),
    crise_score(SoN, SoT, SoS, SoI, SoV, S4),
    infraestrutura(P, In),
    nivel_valor(In, InV),
    apoio_populacao(P, Ap),
    nivel_valor(Ap, ApV),
    reservas(P, Re),
    nivel_valor(Re, ReV),
    ScoreFinal is S1 + S2 + S3 + S4 + InV + ApV + ReV.

score_pais_normalizado(P, ScoreNormalizado) :-
    score_pais(P, Score),
    ScoreNormalizado is (Score / 77) * 100.

classificar_score(Score, 'Estável') :- Score =< 20.
classificar_score(Score, 'Moderado') :- Score > 20, Score =< 50.
classificar_score(Score, 'Grave') :- Score > 50, Score =< 75.
classificar_score(Score, 'Colapso') :- Score > 75.

avaliar_pais(P, Score, Classificacao) :-
    score_pais_normalizado(P, Score),
    classificar_score(Score, Classificacao).

crise_grave(P) :-
    (crise_economica(P, alto, _, _, _, _);
     crise_saude(P, alto, _, _, _, _);
     crise_seguranca(P, alto, _, _, _, _)).

crise_moderada(P) :-
    (crise_economica(P, medio, _, _, _, _);
     crise_saude(P, medio, _, _, _, _);
     crise_seguranca(P, medio, _, _, _, _)).

crise_leve(P) :-
    crise_economica(P, baixo, _, _, _, _),
    crise_saude(P, baixo, _, _, _, _),
    crise_seguranca(P, baixo, _, _, _, _).

infra_boa(P) :- infraestrutura(P, boa).
infra_media(P) :- infraestrutura(P, media).
infra_ruim(P) :- infraestrutura(P, ruim).

apoio_baixo(P) :- apoio_populacao(P, baixo).
apoio_medio(P) :- apoio_populacao(P, medio).
apoio_alto(P) :- apoio_populacao(P, alto).

reservas_altas(P) :- reservas(P, alto).
reservas_baixas(P) :- reservas(P, baixo).

decisao_prioridade(intervencao_economica, 1, medio).
decisao_prioridade(pacote_emergencial, 2, baixo).
decisao_prioridade(reforma_tributaria, 3, medio).
decisao_prioridade(reforco_hospitais, 4, baixo).
decisao_prioridade(campanha_confianca, 5, baixo).
decisao_prioridade(lockdown_parcial, 6, alto).
decisao_prioridade(reforco_policial, 7, baixo).
decisao_prioridade(deslocar_tropas, 8, medio).
decisao_prioridade(chamar_onu, 9, baixo).
decisao_prioridade(acordo_internacional, 10, baixo).
decisao_prioridade(plano_estabilizacao, 11, medio).
decisao_prioridade(contencao_social, 12, baixo).
decisao_prioridade(reforma_infraestrutura, 13, baixo).
decisao_prioridade(auxilio_financeiro, 14, baixo).
decisao_prioridade(programa_social, 15, baixo).
decisao_prioridade(controle_de_precos, 16, medio).

perfil_pais(P, Perfil) :-
    crise_economica(P, EN, ET, ES, EI, EV),
    crise_score(EN, ET, ES, EI, EV, ScoreEc),
    crise_saude(P, SN, ST, SS, SI, SV),
    crise_score(SN, ST, SS, SI, SV, ScoreSaude),
    crise_seguranca(P, SeN, SeT, SeS, SeI, SeV),
    crise_score(SeN, SeT, SeS, SeI, SeV, ScoreSeguranca),
    crise_social(P, SoN, SoT, SoS, SoI, SoV),
    crise_score(SoN, SoT, SoS, SoI, SoV, ScoreSocial),
    infraestrutura(P, Infra),
    apoio_populacao(P, Apoio),
    reservas(P, Reservas),
    Perfil = perfil{
        crise_economica: score_ec{nivel: EN, tendencia: ET, severidade: ES, impacto: EI, variacao: EV, score: ScoreEc},
        crise_saude: score_saude{nivel: SN, tendencia: ST, severidade: SS, impacto: SI, variacao: SV, score: ScoreSaude},
        crise_seguranca: score_seguranca{nivel: SeN, tendencia: SeT, severidade: SeS, impacto: SeI, variacao: SeV, score: ScoreSeguranca},
        crise_social: score_social{nivel: SoN, tendencia: SoT, severidade: SoS, impacto: SoI, variacao: SoV, score: ScoreSocial},
        infraestrutura: Infra,
        apoio: Apoio,
        reservas: Reservas
    }.

decisao(P, intervencao_economica, 6) :-
    perfil_pais(P, Perfil),
    get_dict(crise_economica, Perfil, CE),
    CE.nivel == alto,
    CE.tendencia == alta,
    (CE.severidade == alta; CE.severidade == critica),
    reservas_altas(P).

decisao(P, pacote_emergencial, 3) :-
    perfil_pais(P, Perfil),
    get_dict(crise_economica, Perfil, CE),
    CE.nivel == alto,
    reservas_baixas(P).

decisao(P, reforma_tributaria, 6) :-
    perfil_pais(P, Perfil),
    get_dict(crise_economica, Perfil, CE),
    CE.nivel == alto,
    infra_ruim(P).

decisao(P, reforco_hospitais, 4) :-
    perfil_pais(P, Perfil),
    get_dict(crise_saude, Perfil, CS),
    CS.nivel == alto,
    (infra_media(P); infra_ruim(P)).

decisao(P, lockdown_parcial, 1) :-
    crise_saude(P, alto, _, _, _, _),
    (apoio_medio(P); apoio_alto(P)).

decisao(P, chamar_onu, 2) :-
    perfil_pais(P, Perfil),
    get_dict(crise_saude, Perfil, CS),
    CS.nivel == alto,
    infra_ruim(P).

decisao(P, reforco_policial, 2) :-
    perfil_pais(P, Perfil),
    get_dict(crise_seguranca, Perfil, CSe),
    CSe.nivel == alto,
    apoio_alto(P).

decisao(P, deslocar_tropas, 3) :-
    perfil_pais(P, Perfil),
    get_dict(crise_seguranca, Perfil, CSe),
    CSe.nivel == alto,
    apoio_medio(P).

decisao(P, acordo_internacional, 6) :-
    perfil_pais(P, Perfil),
    get_dict(crise_seguranca, Perfil, CSe),
    (CSe.nivel == medio; CSe.nivel == alto).

decisao(P, programa_social, 5) :-
    perfil_pais(P, Perfil),
    get_dict(crise_social, Perfil, CSo),
    CSo.nivel == alto,
    apoio_baixo(P).

decisao(P, contencao_social, 2) :-
    perfil_pais(P, Perfil),
    get_dict(crise_social, Perfil, CSo),
    CSo.nivel == medio,
    apoio_medio(P).

decisao(P, campanha_confianca, 4) :-
    perfil_pais(P, Perfil),
    get_dict(crise_social, Perfil, CSo),
    CSo.nivel == medio,
    apoio_alto(P).

decisao(P, reforma_infraestrutura, 12) :-
    infra_ruim(P).

decisao(P, plano_estabilizacao, 6) :-
    crise_grave(P),
    apoio_alto(P).

coletar_dados_faltantes(P, Faltantes) :-
    findall(Dado, (
        (\+ crise_economica(P, _, _, _, _, _), Dado = crise_economica);
        (\+ crise_saude(P, _, _, _, _, _), Dado = crise_saude);
        (\+ crise_seguranca(P, _, _, _, _, _), Dado = crise_seguranca);
        (\+ crise_social(P, _, _, _, _, _), Dado = crise_social);
        (\+ infraestrutura(P, _), Dado = infraestrutura);
        (\+ apoio_populacao(P, _), Dado = apoio_populacao);
        (\+ reservas(P, _), Dado = reservas)
    ), Faltantes).

mostrar_dados_faltantes(P) :-
    coletar_dados_faltantes(P, Faltantes),
    Faltantes \= [],
    Faltantes = [Primeiro | Resto],
    format('Impossível amigão: ainda falta ~w', [Primeiro]),
    mostrar_resto_faltantes(Resto),
    format('~n', []),
    !,
    fail.

mostrar_dados_faltantes(_).

mostrar_resto_faltantes([]).
mostrar_resto_faltantes([F | Resto]) :-
    format(', ~w', [F]),
    mostrar_resto_faltantes(Resto).

validar_dados_completos(P) :-
    coletar_dados_faltantes(P, Faltantes),
    Faltantes = [],
    !.

melhor_decisao(P, nenhuma, 0) :-
    coletar_dados_faltantes(P, Faltantes),
    Faltantes \= [],
    Faltantes = [Primeiro | Resto],
    format('Impossível amigão: ainda falta ~w', [Primeiro]),
    mostrar_resto_faltantes(Resto),
    format('~n', []),
    !.

melhor_decisao(P, nenhuma, 0) :-
    \+ decisao(P, _, _).

melhor_decisao(P, Acao, Meses) :-
    validar_dados_completos(P),
    findall((Prioridade, A, M),
        (decisao(P, A, M), decisao_prioridade(A, Prioridade, _)),
        Lista),
    sort(Lista, [(_, Acao, Meses) | _]).

melhor_decisao_considerando_impacto(P, _Acao, _Meses, _ImpactoDesejado) :-
    % Validar dados primeiro
    coletar_dados_faltantes(P, Faltantes),
    Faltantes \= [],
    Faltantes = [Primeiro | Resto],
    format('Impossível amigão: ainda falta ~w', [Primeiro]),
    mostrar_resto_faltantes(Resto),
    format('~n', []),
    !,
    fail.

melhor_decisao_considerando_impacto(P, Acao, Meses, ImpactoDesejado) :-
    findall(
        (Prioridade-ValorImpacto-A-M-I),
        (
            decisao(P, A, M),
            decisao_prioridade(A, Prioridade, I),
            I == ImpactoDesejado,
            impacto_valor(I, ValorImpacto)
        ),
        Lista
    ),
    Lista \= [],
    keysort(Lista, ListaOrdenada),
    ListaOrdenada = [(_-_-Acao-Meses-ImpactoDesejado) | _].


listar_decisoes_com_impacto(P) :-
    decisao(P, Acao, Meses),
    decisao_prioridade(Acao, Prioridade, Impacto),
    format("Prioridade: ~w, Acao: ~w, Meses: ~w, Impacto: ~w~n", [Prioridade, Acao, Meses, Impacto]),
    fail.
listar_decisoes_com_impacto(_).

listar_decisoes_por_impacto(P) :-
    write('=== DECISÕES DISPONÍVEIS POR IMPACTO ==='), nl, nl,

    write('--- IMPACTO ALTO ---'), nl,
    (   findall((Prioridade, Acao, Meses),
            (decisao(P, Acao, Meses),
             decisao_prioridade(Acao, Prioridade, alto)),
            ListaAlto),
        ListaAlto \= []
    ->  sort(ListaAlto, ListaAltoOrd),
        forall(member((Prio, A, M), ListaAltoOrd),
            format('  Prioridade ~w: ~w (~w meses)~n', [Prio, A, M]))
    ;   write('  Nenhuma decisão disponível'), nl
    ),
    nl,

    write('--- IMPACTO MÉDIO ---'), nl,
    (   findall((Prioridade, Acao, Meses),
            (decisao(P, Acao, Meses),
             decisao_prioridade(Acao, Prioridade, medio)),
            ListaMedio),
        ListaMedio \= []
    ->  sort(ListaMedio, ListaMedioOrd),
        forall(member((Prio, A, M), ListaMedioOrd),
            format('  Prioridade ~w: ~w (~w meses)~n', [Prio, A, M]))
    ;   write('  Nenhuma decisão disponível'), nl
    ),
    nl,

    write('--- IMPACTO BAIXO ---'), nl,
    (   findall((Prioridade, Acao, Meses),
            (decisao(P, Acao, Meses),
             decisao_prioridade(Acao, Prioridade, baixo)),
            ListaBaixo),
        ListaBaixo \= []
    ->  sort(ListaBaixo, ListaBaixoOrd),
        forall(member((Prio, A, M), ListaBaixoOrd),
            format('  Prioridade ~w: ~w (~w meses)~n', [Prio, A, M]))
    ;   write('  Nenhuma decisão disponível'), nl
    ),
    nl.

melhor_decisao_por_impacto(P, Resultados) :-
    findall(
        (Impacto-Acao-Meses),
        (
            member(Impacto, [alto, medio, baixo]),
            melhor_decisao_considerando_impacto(P, Acao, Meses, Impacto)
        ),
        Resultados
    ).

melhor_decisao_impacto_minimo(P, ImpactoMin, Acao, Meses) :-
    impacto_valor(ImpactoMin, ValorMin),
    findall(
        (Prioridade-ValorImpacto-A-M-I),
        (
            decisao(P, A, M),
            decisao_prioridade(A, Prioridade, I),
            impacto_valor(I, ValorImpacto),
            ValorImpacto >= ValorMin
        ),
        Lista
    ),
    keysort(Lista, ListaOrdenada),
    ListaOrdenada = [(_-_-Acao-Meses-_)|_].


decisao_com_impacto_baixo(P, Acao, Meses) :-
    decisao(P, Acao, Meses),
    decisao_prioridade(Acao, _, baixo).

decisao_com_impacto_medio(P, Acao, Meses) :-
    decisao(P, Acao, Meses),
    decisao_prioridade(Acao, _, medio).

decisao_com_impacto_alto(P, Acao, Meses) :-
    decisao(P, Acao, Meses),
    decisao_prioridade(Acao, _, alto).

melhor_decisao_impacto(P, Impacto, Acao, Meses) :-
    findall((Prioridade, A, M),
        (decisao(P, A, M), decisao_prioridade(A, Prioridade, Impacto)),
        Lista),
    sort(Lista, [(_, Acao, Meses)|_]).


explicar_decisao(P, Acao) :-
    \+ decisao(P, Acao, _),
    format('Nenhuma decisão ~w está disponível para ~w (condições não satisfeitas).~n', [Acao, P]),
    !,
    fail.

explicar_decisao(P, lockdown_parcial) :-
    decisao(P, lockdown_parcial, Meses),
    decisao_prioridade(lockdown_parcial, Prioridade, Impacto),
    write('Decisão: lockdown_parcial'), nl,
    format('Duração estimada: ~w meses~n', [Meses]),
    format('Prioridade: ~w, Impacto: ~w~n', [Prioridade, Impacto]),
    write('Motivos:'), nl,
    crise_saude(P, NivelSaude, TendSaude, SevSaude, ImpSaude, VarSaude),
    format('  - Crise de saúde em nível ~w, tendência ~w, severidade ~w, impacto ~w, variação ~w.~n',
           [NivelSaude, TendSaude, SevSaude, ImpSaude, VarSaude]),
    apoio_populacao(P, Apoio),
    format('  - Apoio da população em nível ~w (permite medidas restritivas).~n', [Apoio]),
    nl.

explicar_decisao(P, intervencao_economica) :-
    decisao(P, intervencao_economica, Meses),
    decisao_prioridade(intervencao_economica, Prioridade, Impacto),
    write('Decisão: intervencao_economica'), nl,
    format('Duração estimada: ~w meses~n', [Meses]),
    format('Prioridade: ~w, Impacto: ~w~n', [Prioridade, Impacto]),
    write('Motivos:'), nl,
    crise_economica(P, EN, ET, ES, EI, EV),
    format('  - Crise econômica em nível ~w, tendência ~w, severidade ~w, impacto ~w, variação ~w.~n',
           [EN, ET, ES, EI, EV]),
    reservas(P, Res),
    format('  - Reservas em nível ~w (permite intervenção mais forte).~n', [Res]),
    nl.

explicar_decisao(P, pacote_emergencial) :-
    decisao(P, pacote_emergencial, Meses),
    decisao_prioridade(pacote_emergencial, Prioridade, Impacto),
    write('Decisão: pacote_emergencial'), nl,
    format('Duração estimada: ~w meses~n', [Meses]),
    format('Prioridade: ~w, Impacto: ~w~n', [Prioridade, Impacto]),
    write('Motivos:'), nl,
    crise_economica(P, EN, ET, ES, EI, EV),
    format('  - Crise econômica em nível ~w, tendência ~w, severidade ~w, impacto ~w, variação ~w.~n',
           [EN, ET, ES, EI, EV]),
    reservas(P, Res),
    format('  - Reservas em nível ~w (limitadas, exige pacote emergencial).~n', [Res]),
    nl.

explicar_decisao(P, reforco_hospitais) :-
    decisao(P, reforco_hospitais, Meses),
    decisao_prioridade(reforco_hospitais, Prioridade, Impacto),
    write('Decisão: reforco_hospitais'), nl,
    format('Duração estimada: ~w meses~n', [Meses]),
    format('Prioridade: ~w, Impacto: ~w~n', [Prioridade, Impacto]),
    write('Motivos:'), nl,
    crise_saude(P, SN, ST, SS, SI, SV),
    format('  - Crise de saúde em nível ~w, tendência ~w, severidade ~w, impacto ~w, variação ~w.~n',
           [SN, ST, SS, SI, SV]),
    infraestrutura(P, Infra),
    format('  - Infraestrutura em nível ~w (precisa reforço hospitalar).~n', [Infra]),
    nl.

explicar_decisao(P, chamar_onu) :-
    decisao(P, chamar_onu, Meses),
    decisao_prioridade(chamar_onu, Prioridade, Impacto),
    write('Decisão: chamar_onu'), nl,
    format('Duração estimada: ~w meses~n', [Meses]),
    format('Prioridade: ~w, Impacto: ~w~n', [Prioridade, Impacto]),
    write('Motivos:'), nl,
    crise_saude(P, SN, ST, SS, SI, SV),
    format('  - Crise de saúde em nível ~w, tendência ~w, severidade ~w, impacto ~w, variação ~w.~n',
           [SN, ST, SS, SI, SV]),
    infraestrutura(P, Infra),
    format('  - Infraestrutura em nível ~w (insuficiente, requer apoio internacional).~n', [Infra]),
    nl.

explicar_decisao(P, reforco_policial) :-
    decisao(P, reforco_policial, Meses),
    decisao_prioridade(reforco_policial, Prioridade, Impacto),
    write('Decisão: reforco_policial'), nl,
    format('Duração estimada: ~w meses~n', [Meses]),
    format('Prioridade: ~w, Impacto: ~w~n', [Prioridade, Impacto]),
    write('Motivos:'), nl,
    crise_seguranca(P, SeN, SeT, SeS, SeI, SeV),
    format('  - Crise de segurança em nível ~w, tendência ~w, severidade ~w, impacto ~w, variação ~w.~n',
           [SeN, SeT, SeS, SeI, SeV]),
    apoio_populacao(P, Apoio),
    format('  - Apoio da população em nível ~w (legitima reforço policial).~n', [Apoio]),
    nl.

explicar_decisao(P, deslocar_tropas) :-
    decisao(P, deslocar_tropas, Meses),
    decisao_prioridade(deslocar_tropas, Prioridade, Impacto),
    write('Decisão: deslocar_tropas'), nl,
    format('Duração estimada: ~w meses~n', [Meses]),
    format('Prioridade: ~w, Impacto: ~w~n', [Prioridade, Impacto]),
    write('Motivos:'), nl,
    crise_seguranca(P, SeN, SeT, SeS, SeI, SeV),
    format('  - Crise de segurança em nível ~w, tendência ~w, severidade ~w, impacto ~w, variação ~w.~n',
           [SeN, SeT, SeS, SeI, SeV]),
    apoio_populacao(P, Apoio),
    format('  - Apoio da população em nível ~w (aceita presença de tropas).~n', [Apoio]),
    nl.

explicar_decisao(P, reforma_infraestrutura) :-
    decisao(P, reforma_infraestrutura, Meses),
    decisao_prioridade(reforma_infraestrutura, Prioridade, Impacto),
    write('Decisão: reforma_infraestrutura'), nl,
    format('Duração estimada: ~w meses~n', [Meses]),
    format('Prioridade: ~w, Impacto: ~w~n', [Prioridade, Impacto]),
    write('Motivos:'), nl,
    infraestrutura(P, Infra),
    format('  - Infraestrutura em nível ~w (demanda reforma estrutural).~n', [Infra]),
    nl.

explicar_decisao(P, plano_estabilizacao) :-
    decisao(P, plano_estabilizacao, Meses),
    decisao_prioridade(plano_estabilizacao, Prioridade, Impacto),
    write('Decisão: plano_estabilizacao'), nl,
    format('Duração estimada: ~w meses~n', [Meses]),
    format('Prioridade: ~w, Impacto: ~w~n', [Prioridade, Impacto]),
    write('Motivos:'), nl,
    (   crise_grave(P)
    ->  write('  - Situação classificada como crise grave (econômica/saúde/segurança em nível alto).'), nl
    ;   true
    ),
    apoio_populacao(P, Apoio),
    format('  - Apoio da população em nível ~w (necessário para medidas de estabilização).~n', [Apoio]),
    nl.

explicar_decisao(P, Outra) :-
    decisao(P, Outra, Meses),
    decisao_prioridade(Outra, Prioridade, Impacto),
    format('Decisão: ~w~n', [Outra]),
    format('Duração estimada: ~w meses~n', [Meses]),
    format('Prioridade: ~w, Impacto: ~w~n', [Prioridade, Impacto]),
    nl.

explicar_melhor_decisao(P) :-
    (   melhor_decisao(P, nenhuma, 0)
    ->  format('Nenhuma decisão disponível para ~w.~n', [P])
    ;   melhor_decisao(P, Acao, _),
        explicar_decisao(P, Acao)
    ).
