:- dynamic crise_economica/6.
:- dynamic crise_saude/6.
:- dynamic crise_seguranca/6.
:- dynamic crise_social/6.
:- dynamic infraestrutura/2.
:- dynamic apoio_populacao/2.
:- dynamic reservas/2.

% Bloco de atribuicao de qualidade => valor
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


% Calculo do score de uma crise
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

% Verifica se pelo menos uma crise nesse estado existe
crise_grave(P) :-
    (crise_economica(P, alto, _, _, _, _);
     crise_saude(P, alto, _, _, _, _);
     crise_seguranca(P, alto, _, _, _, _)).

infra_media(P) :- infraestrutura(P, media).
infra_ruim(P) :- infraestrutura(P, ruim).

apoio_baixo(P) :- apoio_populacao(P, baixo).
apoio_medio(P) :- apoio_populacao(P, medio).
apoio_alto(P) :- apoio_populacao(P, alto).

reservas_altas(P) :- reservas(P, alto).
reservas_baixas(P) :- reservas(P, baixo).


% Define prioridade das decisoes, menor => maior
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
decisao_prioridade(estado_de_emergencia, 1, alto).
decisao_prioridade(estado_de_calamidade, 1, alto).
decisao_prioridade(medidas_preventivas, 8, baixo).
decisao_prioridade(plano_recuperacao_gradual, 7, medio).
decisao_prioridade(pacote_mega_emergencial, 2, alto).
decisao_prioridade(intervencao_multipla, 1, alto).
decisao_prioridade(lockdown_total, 1, alto).


% Cria um dicicionario com as informacoes do pais
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


% Busca do dicionario/perfil as informacoes para decisao
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


decisao(P, estado_de_emergencia, 1) :-
    score_pais(P, Score),
    Score >= 50,
    Score < 60.

decisao(P, estado_de_calamidade, 1) :-
    score_pais(P, Score),
    Score >= 60.

decisao(P, medidas_preventivas, 8) :-
    score_pais(P, Score),
    Score >= 25,
    Score < 35,
    \+ crise_grave(P).

decisao(P, plano_recuperacao_gradual, 7) :-
    score_pais(P, Score),
    Score >= 35,
    Score < 45,
    reservas_altas(P).

decisao(P, pacote_mega_emergencial, 2) :-
    perfil_pais(P, Perfil),
    get_dict(crise_economica, Perfil, CE),
    CE.score >= 15,
    reservas_baixas(P).

decisao(P, intervencao_multipla, 1) :-
    perfil_pais(P, Perfil),
    get_dict(crise_economica, Perfil, CE),
    get_dict(crise_saude, Perfil, CS),
    get_dict(crise_seguranca, Perfil, CSe),
    get_dict(crise_social, Perfil, CSo),
    SomaCrises is CE.score + CS.score + CSe.score + CSo.score,
    SomaCrises >= 50.

decisao(P, lockdown_total, 1) :-
    perfil_pais(P, Perfil),
    get_dict(crise_saude, Perfil, CS),
    CS.score >= 16,
    apoio_alto(P).


urgencia_critica(P) :-
    score_pais(P, Score),
    Score >= 50.

urgencia_alta(P) :-
    score_pais(P, Score),
    Score >= 35,
    Score < 50.

urgencia_media(P) :-
    score_pais(P, Score),
    Score >= 20,
    Score < 35.

urgencia_baixa(P) :-
    score_pais(P, Score),
    Score < 20.

pior_que(P1, P2) :-
    score_pais(P1, Score1),
    score_pais(P2, Score2),
    Score1 > Score2.

melhor_que(P1, P2) :-
    score_pais(P1, Score1),
    score_pais(P2, Score2),
    Score1 < Score2.

situacao_similar(P1, P2) :-
    score_pais(P1, Score1),
    score_pais(P2, Score2),
    Diferenca is abs(Score1 - Score2),
    Diferenca =< 5.


crise_dominante(P, TipoCrise) :-
    perfil_pais(P, Perfil),
    get_dict(crise_economica, Perfil, CE),
    get_dict(crise_saude, Perfil, CS),
    get_dict(crise_seguranca, Perfil, CSe),
    get_dict(crise_social, Perfil, CSo),
    findall((Score, Tipo), (
        (Score = CE.score, Tipo = economia);
        (Score = CS.score, Tipo = saude);
        (Score = CSe.score, Tipo = seguranca);
        (Score = CSo.score, Tipo = social)
    ), Crises),
    sort(Crises, CrisesOrdenadas),
    reverse(CrisesOrdenadas, [(MaiorScore, TipoCrise) | _]).

crise_critica(P, TipoCrise) :-
    perfil_pais(P, Perfil),
    (
        (get_dict(crise_economica, Perfil, CE), CE.score >= 15, TipoCrise = economia);
        (get_dict(crise_saude, Perfil, CS), CS.score >= 15, TipoCrise = saude);
        (get_dict(crise_seguranca, Perfil, CSe), CSe.score >= 15, TipoCrise = seguranca);
        (get_dict(crise_social, Perfil, CSo), CSo.score >= 15, TipoCrise = social)
    ).

contar_crises_criticas(P, NumCrises) :-
    perfil_pais(P, Perfil),
    get_dict(crise_economica, Perfil, CE),
    get_dict(crise_saude, Perfil, CS),
    get_dict(crise_seguranca, Perfil, CSe),
    get_dict(crise_social, Perfil, CSo),
    findall(Tipo, (
        (CE.score >= 15, Tipo = economia);
        (CS.score >= 15, Tipo = saude);
        (CSe.score >= 15, Tipo = seguranca);
        (CSo.score >= 15, Tipo = social)
    ), ListaCrises),
    length(ListaCrises, NumCrises).

multiplas_crises_criticas(P, NumCrises) :-
    contar_crises_criticas(P, NumCrises),
    NumCrises >= 2.

prioridade_por_score(P, Prioridade) :-
    score_pais(P, Score),
    Score >= 50, Prioridade = 1, !.
prioridade_por_score(P, Prioridade) :-
    score_pais(P, Score),
    Score >= 40, Score < 50, Prioridade = 2, !.
prioridade_por_score(P, Prioridade) :-
    score_pais(P, Score),
    Score >= 30, Score < 40, Prioridade = 3, !.
prioridade_por_score(P, Prioridade) :-
    score_pais(P, Score),
    Score >= 20, Score < 30, Prioridade = 4, !.
prioridade_por_score(P, Prioridade) :-
    score_pais(P, Score),
    Score < 20, Prioridade = 5.

alerta_vermelho(P) :-
    score_pais(P, Score),
    Score >= 50.

alerta_laranja(P) :-
    score_pais(P, Score),
    Score >= 35,
    Score < 50.

alerta_amarelo(P) :-
    score_pais(P, Score),
    Score >= 20,
    Score < 35.

alerta_verde(P) :-
    score_pais(P, Score),
    Score < 20.

acima_media_critica(P) :-
    score_pais(P, Score),
    Score >= 38.

abaixo_media(P) :-
    score_pais(P, Score),
    Score =< 20.

zona_risco(P) :-
    score_pais(P, Score),
    Score >= 30,
    Score < 40.

zona_segura(P) :-
    score_pais(P, Score),
    Score < 15.

valor_tendencia_piora(alta, 3).
valor_tendencia_piora(estavel, 1).
valor_tendencia_piora(queda, 0).

valor_variacao_piora(explosiva, 4).
valor_variacao_piora(ascendente, 2).
valor_variacao_piora(estavel, 0).
valor_variacao_piora(decrescente, 0).

score_tendencia_piora(P, ScoreTendencia) :-
    perfil_pais(P, Perfil),
    get_dict(crise_economica, Perfil, CE),
    get_dict(crise_saude, Perfil, CS),
    get_dict(crise_seguranca, Perfil, CSe),
    get_dict(crise_social, Perfil, CSo),
    valor_tendencia_piora(CE.tendencia, TendenciaEc),
    valor_tendencia_piora(CS.tendencia, TendenciaSaude),
    valor_tendencia_piora(CSe.tendencia, TendenciaSeg),
    valor_tendencia_piora(CSo.tendencia, TendenciaSoc),
    valor_variacao_piora(CE.variacao, VarEc),
    valor_variacao_piora(CS.variacao, VarSaude),
    valor_variacao_piora(CSe.variacao, VarSeg),
    valor_variacao_piora(CSo.variacao, VarSoc),
    ScoreTendencia is TendenciaEc + TendenciaSaude + TendenciaSeg + TendenciaSoc + VarEc + VarSaude + VarSeg + VarSoc.

fator_reservas(baixo, 3).
fator_reservas(medio, 1).
fator_reservas(alto, 0).

fator_infraestrutura(ruim, 3).
fator_infraestrutura(media, 1).
fator_infraestrutura(boa, 0).

fator_apoio(baixo, 2).
fator_apoio(medio, 1).
fator_apoio(alto, 0).

fator_recursos(P, Fator) :-
    reservas(P, Res),
    infraestrutura(P, Infra),
    apoio_populacao(P, Apoio),
    fator_reservas(Res, F1),
    fator_infraestrutura(Infra, F2),
    fator_apoio(Apoio, F3),
    Fator is F1 + F2 + F3.

fator_decisoes_disponiveis(P, Fator) :-
    findall(Prioridade, (
        decisao(P, Acao, _),
        decisao_prioridade(Acao, Prioridade, _)
    ), Prioridades),
    (Prioridades = [] -> Fator = 10;
     sort(Prioridades, PrioridadesOrdenadas),
     PrioridadesOrdenadas = [MinPrioridade | _],
     (MinPrioridade =< 3 -> Fator = 0;
      MinPrioridade =< 6 -> Fator = 2;
      MinPrioridade =< 10 -> Fator = 5;
      Fator = 8)
    ).

score_sucumbencia(P, ScoreSucumbencia) :-
    score_pais(P, ScoreAtual),
    score_tendencia_piora(P, ScoreTendencia),
    fator_recursos(P, FatorRecursos),
    fator_decisoes_disponiveis(P, FatorDecisoes),
    (multiplas_crises_criticas(P, NumCrises) -> 
        (NumCrises >= 2 -> FatorMultiplas = 5; FatorMultiplas = 0)
    ; FatorMultiplas = 0),
    ScoreSucumbencia is ScoreAtual + ScoreTendencia + FatorRecursos + FatorDecisoes + FatorMultiplas.

qual_vai_sucumbir_daqui_cinco_ano(P1, P2) :-
    (score_sucumbencia(P1, Score1) -> true; Score1 = 0),
    (score_sucumbencia(P2, Score2) -> true; Score2 = 0),
    (score_pais(P1, ScoreAtual1) -> true; ScoreAtual1 = 0),
    (score_pais(P2, ScoreAtual2) -> true; ScoreAtual2 = 0),
    (score_tendencia_piora(P1, Tendencia1) -> true; Tendencia1 = 0),
    (score_tendencia_piora(P2, Tendencia2) -> true; Tendencia2 = 0),
    (fator_recursos(P1, FatorRec1) -> true; FatorRec1 = 0),
    (fator_recursos(P2, FatorRec2) -> true; FatorRec2 = 0),
    (fator_decisoes_disponiveis(P1, FatorDec1) -> true; FatorDec1 = 10),
    (fator_decisoes_disponiveis(P2, FatorDec2) -> true; FatorDec2 = 10),
    (contar_crises_criticas(P1, NumCrises1) -> true; NumCrises1 = 0),
    (contar_crises_criticas(P2, NumCrises2) -> true; NumCrises2 = 0),
    nl,
    write('========================================'), nl,
    write('  ANÁLISE DE SUCUMBÊNCIA (5 ANOS)'), nl,
    write('========================================'), nl, nl,
    format('PAÍS 1: ~w~n', [P1]),
    format('  Score Atual: ~w~n', [ScoreAtual1]),
    format('  Score Tendência Piora: ~w~n', [Tendencia1]),
    format('  Fator Recursos: ~w~n', [FatorRec1]),
    format('  Fator Decisões: ~w~n', [FatorDec1]),
    format('  Múltiplas Crises Críticas: ~w~n', [NumCrises1]),
    format('  SCORE SUCUMBÊNCIA TOTAL: ~w~n', [Score1]),
    nl,
    format('PAÍS 2: ~w~n', [P2]),
    format('  Score Atual: ~w~n', [ScoreAtual2]),
    format('  Score Tendência Piora: ~w~n', [Tendencia2]),
    format('  Fator Recursos: ~w~n', [FatorRec2]),
    format('  Fator Decisões: ~w~n', [FatorDec2]),
    format('  Múltiplas Crises Críticas: ~w~n', [NumCrises2]),
    format('  SCORE SUCUMBÊNCIA TOTAL: ~w~n', [Score2]),
    nl,
    (Score1 > Score2 ->
        format('>>> RESULTADO: ~w tem MAIS chances de sucumbir que ~w~n', [P1, P2]),
        format('   Diferença no score de sucumbência: ~w pontos~n', [Score1 - Score2])
    ; Score1 < Score2 ->
        format('>>> RESULTADO: ~w tem MAIS chances de sucumbir que ~w~n', [P2, P1]),
        format('   Diferença no score de sucumbência: ~w pontos~n', [Score2 - Score1])
    ; Score1 =:= Score2 ->
        (ScoreAtual1 > ScoreAtual2 ->
            format('>>> RESULTADO: ~w tem MAIS chances de sucumbir que ~w~n', [P1, P2]),
            format('   Empate no score de sucumbência. Decisão por score atual maior.~n')
        ; ScoreAtual1 < ScoreAtual2 ->
            format('>>> RESULTADO: ~w tem MAIS chances de sucumbir que ~w~n', [P2, P1]),
            format('   Empate no score de sucumbência. Decisão por score atual maior.~n')
        ; ScoreAtual1 =:= ScoreAtual2 ->
            (FatorRec1 > FatorRec2 ->
                format('>>> RESULTADO: ~w tem MAIS chances de sucumbir que ~w~n', [P1, P2]),
                format('   Empate em scores. Decisão por recursos mais limitados.~n')
            ; FatorRec1 < FatorRec2 ->
                format('>>> RESULTADO: ~w tem MAIS chances de sucumbir que ~w~n', [P2, P1]),
                format('   Empate em scores. Decisão por recursos mais limitados.~n')
            ; FatorRec1 =:= FatorRec2 ->
                (FatorDec1 > FatorDec2 ->
                    format('>>> RESULTADO: ~w tem MAIS chances de sucumbir que ~w~n', [P1, P2]),
                    format('   Empate em scores e recursos. Decisão por menos decisões disponíveis.~n')
                ; FatorDec1 < FatorDec2 ->
                    format('>>> RESULTADO: ~w tem MAIS chances de sucumbir que ~w~n', [P2, P1]),
                    format('   Empate em scores e recursos. Decisão por menos decisões disponíveis.~n')
                ; format('>>> RESULTADO: Situação EQUIVALENTE entre ~w e ~w~n', [P1, P2]),
                  format('   Ambos países têm chances similares de sucumbir.~n')
                )
            )
        )
    ),
    write('========================================'), nl,
    nl,
    true.

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

avaliar_pais(Score, Estado) :-
    number(Score),
    Score < 10,
    Estado = 'de boa', !.

avaliar_pais(Score, Estado) :-
    number(Score),
    Score >= 10, Score =< 15,
    Estado = 'de boa também (quase normal)', !.

avaliar_pais(Score, Estado) :-
    number(Score),
    Score > 15, Score < 30,
    Estado = 'normalzinho', !.

avaliar_pais(Score, Estado) :-
    number(Score),
    Score >= 30, Score < 40,
    Estado = 'tá se lascando / tamo se lascando', !.

avaliar_pais(Score, Estado) :-
    number(Score),
    Score >= 40,
    Estado = 'lascou'.

avaliar_pais(Pais, Resultado) :-
    score_pais(Pais, Score),
    Score < 10,
    Resultado = 'de boa', !.

avaliar_pais(Pais, Resultado) :-
    score_pais(Pais, Score),
    Score > 15, Score < 30,
    Resultado = 'normalzinho', !.

avaliar_pais(Pais, Resultado) :-
    score_pais(Pais, Score),
    Score > 30, Score < 40,
    Resultado = 'tamo se lascando', !.

avaliar_pais(Pais, Resultado) :-
    score_pais(Pais, Score),
    Score >= 40,
    Resultado = 'lascou', !.

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
    Faltantes = [Primeiro | Resto],primeira
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
    Lista \= [],
    sort(Lista, [(_, Acao, Meses) | _]).

listar_decisoes_com_impacto(P) :-
    decisao(P, Acao, Meses),
    decisao_prioridade(Acao, Prioridade, Impacto),
    format("Prioridade: ~w, Acao: ~w, Meses: ~w, Impacto: ~w~n", [Prioridade, Acao, Meses, Impacto]),
    fail.
listar_decisoes_com_impacto(_).

% Função unificada para decisões por impacto
decisao_com_impacto(P, Impacto, Acao, Meses) :-
    decisao(P, Acao, Meses),
    decisao_prioridade(Acao, _, Impacto).

% Mantidas para compatibilidade com código existente
decisao_com_impacto_baixo(P, Acao, Meses) :-
    decisao_com_impacto(P, baixo, Acao, Meses).

decisao_com_impacto_medio(P, Acao, Meses) :-
    decisao_com_impacto(P, medio, Acao, Meses).

decisao_com_impacto_alto(P, Acao, Meses) :-
    decisao_com_impacto(P, alto, Acao, Meses).

% Função auxiliar para exibir cabeçalho comum de explicação
explicar_decisao_cabecalho(_P, Acao, Meses, Prioridade, Impacto) :-
    format('Decisão: ~w~n', [Acao]),
    format('Duração estimada: ~w meses~n', [Meses]),
    format('Prioridade: ~w, Impacto: ~w~n', [Prioridade, Impacto]),
    write('Motivos:'), nl.

explicar_decisao(P, Acao) :-
    var(Acao),
    format('Erro: você deve especificar uma ação específica. Use explicar_decisao(~w, nome_da_acao).~n', [P]),
    !,
    fail.

explicar_decisao(P, Acao) :-
    \+ var(Acao),
    \+ decisao(P, Acao, _),
    format('Nenhuma decisão ~w está disponível para ~w (condições não satisfeitas).~n', [Acao, P]),
    !,
    fail.

explicar_decisao(P, lockdown_parcial) :-
    decisao(P, lockdown_parcial, Meses),
    decisao_prioridade(lockdown_parcial, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, lockdown_parcial, Meses, Prioridade, Impacto),
    crise_saude(P, NivelSaude, TendSaude, SevSaude, ImpSaude, VarSaude),
    format('  - Crise de saúde em nível ~w, tendência ~w, severidade ~w, impacto ~w, variação ~w.~n',
           [NivelSaude, TendSaude, SevSaude, ImpSaude, VarSaude]),
    apoio_populacao(P, Apoio),
    format('  - Apoio da população em nível ~w (permite medidas restritivas).~n', [Apoio]),
    nl.

explicar_decisao(P, intervencao_economica) :-
    decisao(P, intervencao_economica, Meses),
    decisao_prioridade(intervencao_economica, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, intervencao_economica, Meses, Prioridade, Impacto),
    crise_economica(P, EN, ET, ES, EI, EV),
    format('  - Crise econômica em nível ~w, tendência ~w, severidade ~w, impacto ~w, variação ~w.~n',
           [EN, ET, ES, EI, EV]),
    reservas(P, Res),
    format('  - Reservas em nível ~w (permite intervenção mais forte).~n', [Res]),
    nl.

explicar_decisao(P, pacote_emergencial) :-
    decisao(P, pacote_emergencial, Meses),
    decisao_prioridade(pacote_emergencial, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, pacote_emergencial, Meses, Prioridade, Impacto),
    crise_economica(P, EN, ET, ES, EI, EV),
    format('  - Crise econômica em nível ~w, tendência ~w, severidade ~w, impacto ~w, variação ~w.~n',
           [EN, ET, ES, EI, EV]),
    reservas(P, Res),
    format('  - Reservas em nível ~w (limitadas, exige pacote emergencial).~n', [Res]),
    nl.

explicar_decisao(P, reforco_hospitais) :-
    decisao(P, reforco_hospitais, Meses),
    decisao_prioridade(reforco_hospitais, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, reforco_hospitais, Meses, Prioridade, Impacto),
    crise_saude(P, SN, ST, SS, SI, SV),
    format('  - Crise de saúde em nível ~w, tendência ~w, severidade ~w, impacto ~w, variação ~w.~n',
           [SN, ST, SS, SI, SV]),
    infraestrutura(P, Infra),
    format('  - Infraestrutura em nível ~w (precisa reforço hospitalar).~n', [Infra]),
    nl.

explicar_decisao(P, chamar_onu) :-
    decisao(P, chamar_onu, Meses),
    decisao_prioridade(chamar_onu, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, chamar_onu, Meses, Prioridade, Impacto),
    crise_saude(P, SN, ST, SS, SI, SV),
    format('  - Crise de saúde em nível ~w, tendência ~w, severidade ~w, impacto ~w, variação ~w.~n',
           [SN, ST, SS, SI, SV]),
    infraestrutura(P, Infra),
    format('  - Infraestrutura em nível ~w (insuficiente, requer apoio internacional).~n', [Infra]),
    nl.

explicar_decisao(P, reforco_policial) :-
    decisao(P, reforco_policial, Meses),
    decisao_prioridade(reforco_policial, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, reforco_policial, Meses, Prioridade, Impacto),
    crise_seguranca(P, SeN, SeT, SeS, SeI, SeV),
    format('  - Crise de segurança em nível ~w, tendência ~w, severidade ~w, impacto ~w, variação ~w.~n',
           [SeN, SeT, SeS, SeI, SeV]),
    apoio_populacao(P, Apoio),
    format('  - Apoio da população em nível ~w (legitima reforço policial).~n', [Apoio]),
    nl.

explicar_decisao(P, deslocar_tropas) :-
    decisao(P, deslocar_tropas, Meses),
    decisao_prioridade(deslocar_tropas, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, deslocar_tropas, Meses, Prioridade, Impacto),
    crise_seguranca(P, SeN, SeT, SeS, SeI, SeV),
    format('  - Crise de segurança em nível ~w, tendência ~w, severidade ~w, impacto ~w, variação ~w.~n',
           [SeN, SeT, SeS, SeI, SeV]),
    apoio_populacao(P, Apoio),
    format('  - Apoio da população em nível ~w (aceita presença de tropas).~n', [Apoio]),
    nl.

explicar_decisao(P, reforma_infraestrutura) :-
    decisao(P, reforma_infraestrutura, Meses),
    decisao_prioridade(reforma_infraestrutura, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, reforma_infraestrutura, Meses, Prioridade, Impacto),
    infraestrutura(P, Infra),
    format('  - Infraestrutura em nível ~w (demanda reforma estrutural).~n', [Infra]),
    nl.

explicar_decisao(P, plano_estabilizacao) :-
    decisao(P, plano_estabilizacao, Meses),
    decisao_prioridade(plano_estabilizacao, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, plano_estabilizacao, Meses, Prioridade, Impacto),
    (   crise_grave(P)
    ->  write('  - Situação classificada como crise grave (econômica/saúde/segurança em nível alto).'), nl
    ;   true
    ),
    apoio_populacao(P, Apoio),
    format('  - Apoio da população em nível ~w (necessário para medidas de estabilização).~n', [Apoio]),
    nl.

explicar_decisao(P, acordo_internacional) :-
    decisao(P, acordo_internacional, Meses),
    decisao_prioridade(acordo_internacional, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, acordo_internacional, Meses, Prioridade, Impacto),
    perfil_pais(P, Perfil),
    get_dict(crise_seguranca, Perfil, CSe),
    format('  - Crise de segurança em nível ~w (requer cooperação internacional).~n', [CSe.nivel]),
    nl.

explicar_decisao(P, contencao_social) :-
    decisao(P, contencao_social, Meses),
    decisao_prioridade(contencao_social, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, contencao_social, Meses, Prioridade, Impacto),
    perfil_pais(P, Perfil),
    get_dict(crise_social, Perfil, CSo),
    format('  - Crise social em nível ~w (demanda medidas de contenção).~n', [CSo.nivel]),
    apoio_populacao(P, Apoio),
    format('  - Apoio da população em nível ~w (permite medidas de contenção).~n', [Apoio]),
    nl.

explicar_decisao(P, reforma_tributaria) :-
    decisao(P, reforma_tributaria, Meses),
    decisao_prioridade(reforma_tributaria, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, reforma_tributaria, Meses, Prioridade, Impacto),
    perfil_pais(P, Perfil),
    get_dict(crise_economica, Perfil, CE),
    format('  - Crise econômica em nível ~w (exige reforma estrutural).~n', [CE.nivel]),
    infraestrutura(P, Infra),
    format('  - Infraestrutura em nível ~w (precisa de reforma tributária para melhorar).~n', [Infra]),
    nl.

explicar_decisao(P, campanha_confianca) :-
    decisao(P, campanha_confianca, Meses),
    decisao_prioridade(campanha_confianca, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, campanha_confianca, Meses, Prioridade, Impacto),
    perfil_pais(P, Perfil),
    get_dict(crise_social, Perfil, CSo),
    format('  - Crise social em nível ~w (requer restauração de confiança).~n', [CSo.nivel]),
    apoio_populacao(P, Apoio),
    format('  - Apoio da população em nível ~w (permite campanha de confiança).~n', [Apoio]),
    nl.

explicar_decisao(P, programa_social) :-
    decisao(P, programa_social, Meses),
    decisao_prioridade(programa_social, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, programa_social, Meses, Prioridade, Impacto),
    perfil_pais(P, Perfil),
    get_dict(crise_social, Perfil, CSo),
    format('  - Crise social em nível ~w (exige programas sociais urgentes).~n', [CSo.nivel]),
    apoio_populacao(P, Apoio),
    format('  - Apoio da população em nível ~w (baixo apoio exige programas sociais).~n', [Apoio]),
    nl.

explicar_decisao(P, estado_de_emergencia) :-
    decisao(P, estado_de_emergencia, Meses),
    decisao_prioridade(estado_de_emergencia, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, estado_de_emergencia, Meses, Prioridade, Impacto),
    score_pais(P, Score),
    format('  - Score total do país: ~w (situação crítica, requer ação imediata).~n', [Score]),
    nl.

explicar_decisao(P, estado_de_calamidade) :-
    decisao(P, estado_de_calamidade, Meses),
    decisao_prioridade(estado_de_calamidade, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, estado_de_calamidade, Meses, Prioridade, Impacto),
    score_pais(P, Score),
    format('  - Score total do país: ~w (situação extrema, emergência máxima).~n', [Score]),
    nl.

explicar_decisao(P, medidas_preventivas) :-
    decisao(P, medidas_preventivas, Meses),
    decisao_prioridade(medidas_preventivas, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, medidas_preventivas, Meses, Prioridade, Impacto),
    score_pais(P, Score),
    format('  - Score total do país: ~w (situação média-alta, medidas preventivas necessárias).~n', [Score]),
    nl.

explicar_decisao(P, plano_recuperacao_gradual) :-
    decisao(P, plano_recuperacao_gradual, Meses),
    decisao_prioridade(plano_recuperacao_gradual, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, plano_recuperacao_gradual, Meses, Prioridade, Impacto),
    score_pais(P, Score),
    format('  - Score total do país: ~w (situação grave mas com recursos disponíveis).~n', [Score]),
    reservas(P, Res),
    format('  - Reservas em nível ~w (permite plano de recuperação gradual).~n', [Res]),
    nl.

explicar_decisao(P, pacote_mega_emergencial) :-
    decisao(P, pacote_mega_emergencial, Meses),
    decisao_prioridade(pacote_mega_emergencial, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, pacote_mega_emergencial, Meses, Prioridade, Impacto),
    perfil_pais(P, Perfil),
    get_dict(crise_economica, Perfil, CE),
    format('  - Crise econômica com score ~w (crítica, requer pacote mega emergencial).~n', [CE.score]),
    reservas(P, Res),
    format('  - Reservas em nível ~w (limitadas, exige pacote maior).~n', [Res]),
    nl.

explicar_decisao(P, intervencao_multipla) :-
    decisao(P, intervencao_multipla, Meses),
    decisao_prioridade(intervencao_multipla, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, intervencao_multipla, Meses, Prioridade, Impacto),
    perfil_pais(P, Perfil),
    get_dict(crise_economica, Perfil, CE),
    get_dict(crise_saude, Perfil, CS),
    get_dict(crise_seguranca, Perfil, CSe),
    get_dict(crise_social, Perfil, CSo),
    SomaCrises is CE.score + CS.score + CSe.score + CSo.score,
    format('  - Soma dos scores das crises: ~w (múltiplas crises graves simultâneas).~n', [SomaCrises]),
    format('  - Scores individuais: Econômica=~w, Saúde=~w, Segurança=~w, Social=~w~n', 
           [CE.score, CS.score, CSe.score, CSo.score]),
    nl.

explicar_decisao(P, lockdown_total) :-
    decisao(P, lockdown_total, Meses),
    decisao_prioridade(lockdown_total, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, lockdown_total, Meses, Prioridade, Impacto),
    perfil_pais(P, Perfil),
    get_dict(crise_saude, Perfil, CS),
    format('  - Crise de saúde com score ~w (extrema, requer lockdown total).~n', [CS.score]),
    apoio_populacao(P, Apoio),
    format('  - Apoio da população em nível ~w (permite medidas extremas).~n', [Apoio]),
    nl.

explicar_decisao(P, Outra) :-
    \+ member(Outra, [lockdown_parcial, intervencao_economica, pacote_emergencial,
                      reforco_hospitais, chamar_onu, reforco_policial,
                      deslocar_tropas, reforma_infraestrutura, plano_estabilizacao,
                      acordo_internacional, contencao_social, reforma_tributaria,
                      campanha_confianca, programa_social, estado_de_emergencia,
                      estado_de_calamidade, medidas_preventivas, plano_recuperacao_gradual,
                      pacote_mega_emergencial, intervencao_multipla, lockdown_total]),
    decisao(P, Outra, Meses),
    decisao_prioridade(Outra, Prioridade, Impacto),
    explicar_decisao_cabecalho(P, Outra, Meses, Prioridade, Impacto),
    nl.
