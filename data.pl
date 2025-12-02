
crise_economica(Pais, Nivel, Tendencia, Severidade, Impacto, Variacao).
crise_saude(Pais, Nivel, Tendencia, Severidade, Impacto, Variacao).
crise_seguranca(Pais, Nivel, Tendencia, Severidade, Impacto, Variacao).
crise_social(Pais, Nivel, Tendencia, Severidade, Impacto, Variacao).

infraestrutura(Pais, Nivel).
apoio_populacao(Pais, Nivel).
reservas(Pais, Nivel).

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
    crise_economica(P, EcN, EcT, EcS, EcI, EcV), crise_score(EcN, EcT, EcS, EcI, EcV, S1),
    crise_saude(P, SaN, SaT, SaS, SaI, SaV),    crise_score(SaN, SaT, SaS, SaI, SaV, S2),
    crise_seguranca(P, SeN, SeT, SeS, SeI, SeV), crise_score(SeN, SeT, SeS, SeI, SeV, S3),
    crise_social(P, SoN, SoT, SoS, SoI, SoV),   crise_score(SoN, SoT, SoS, SoI, SoV, S4),

    infraestrutura(P, In),   nivel_valor(In, InV),
    apoio_populacao(P, Ap),  nivel_valor(Ap, ApV),
    reservas(P, Re),         nivel_valor(Re, ReV),

    ScoreFinal is S1 + S2 + S3 + S4 + InV + ApV + ReV.

classificar_score(Score, 'Estável') :- Score =< 7.
classificar_score(Score, 'Moderado') :- Score > 7, Score =< 12.
classificar_score(Score, 'Grave') :- Score > 12, Score =< 17.
classificar_score(Score, 'Colapso') :- Score > 17.

avaliar_pais(P, Score, Classificacao) :-
    score_pais(P, Score),
    classificar_score(Score, Classificacao).

crise_grave(P) :-
    crise_economica(P, alto,_,_,_,_);
    crise_saude(P, alto,_,_,_,_);
    crise_seguranca(P, alto,_,_,_,_).

crise_moderada(P) :-
    crise_economica(P, medio,_,_,_,_);
    crise_saude(P, medio,_,_,_,_);
    crise_seguranca(P, medio,_,_,_,_).

crise_leve(P) :-
    crise_economica(P, baixo,_,_,_,_),
    crise_saude(P, baixo,_,_,_,_),
    crise_seguranca(P, baixo,_,_,_,_).

infra_boa(P) :- infraestrutura(P, boa).
infra_media(P) :- infraestrutura(P, media).
infra_ruim(P) :- infraestrutura(P, ruim).

apoio_baixo(P) :- apoio_populacao(P, baixo).
apoio_medio(P) :- apoio_populacao(P, medio).
apoio_alto(P) :- apoio_populacao(P, alto).

reservas_altas(P) :- reservas(P, alto).
reservas_baixas(P) :- reservas(P, baixo).

action(intervencao_economica).
action(pacote_emergencial).
action(reforco_hospitais).
action(reforco_policial).
action(acordo_internacional).
action(reforma_tributaria).
action(programa_social).
action(auxilio_financeiro).
action(controle_de_precos).
action(reforma_infraestrutura).
action(campanha_confianca).
action(lockdown_parcial).
action(chamar_onu).
action(deslocar_tropas).
action(plano_estabilizacao).
action(contencao_social).

decisao(P, intervencao_economica, 6) :-
    crise_economica(P, alto,_,_,_,_),
    reservas_altas(P).

decisao(P, pacote_emergencial, 3) :-
    crise_economica(P, alto,_,_,_,_),
    reservas_baixas(P).

decisao(P, controle_de_precos, 2) :-
    crise_economica(P, medio,_,_,_,_).

decisao(P, reforco_hospitais, 4) :-
    crise_saude(P, alto,_,_,_,_),
    infra_media(P).

decisao(P, lockdown_parcial, 1) :-
    crise_saude(P, alto,_,_,_,_),
    apoio_medio(P).

decisao(P, chamar_onu, 2) :-
    crise_saude(P, alto,_,_,_,_),
    infra_ruim(P).

decisao(P, reforco_policial, 2) :-
    crise_seguranca(P, alto,_,_,_,_),
    apoio_alto(P).

decisao(P, deslocar_tropas, 3) :-
    crise_seguranca(P, alto,_,_,_,_),
    apoio_medio(P).

decisao(P, acordo_internacional, 6) :-
    crise_seguranca(P, medio,_,_,_,_).

decisao(P, programa_social, 5) :-
    crise_social(P, alto,_,_,_,_),
    apoio_baixo(P).

decisao(P, contencao_social, 2) :-
    crise_social(P, medio,_,_,_,_),
    apoio_medio(P).

decisao(P, campanha_confianca, 4) :-
    crise_social(P, medio,_,_,_,_),
    apoio_alto(P).

decisao(P, reforma_infraestrutura, 12) :-
    infra_ruim(P).

decisao(P, plano_estabilizacao, 6) :-
    crise_grave(P),
    apoio_alto(P).

melhor_decisao(P, nenhuma, 0) :-
    \+ decisao(P, _, _).

melhor_decisao(P, Acao, Meses) :-
    findall((A,M), decisao(P,A,M), Lista),
    sort(2, @=<, Lista, [(Acao, Meses)|_]).
