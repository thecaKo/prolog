:- consult('data.pl').
:- consult('explorar_espaco.pl').

menu :-
    limpar_tela,
    write('========================================'), nl,
    write('    SISTEMA DE DECISÃO - MENU PRINCIPAL'), nl,
    write('========================================'), nl, nl,
    write('1. Manual - Configurar país manualmente'), nl,
    write('2. Backtracking - Explorar cenários para uma ação'), nl,
    write('3. Ver melhor decisão'), nl,
    write('4. Listar decisões por impacto'), nl,
    write('5. Explicar decisão'), nl,
    write('6. Avaliar país'), nl,
    write('7. Comparar países'), nl,
    write('8. Exemplos pré-configurados'), nl,
    write('9. Ajuda'), nl,
    write('0. Sair'), nl, nl,
    write('Escolha uma opção:'), nl,
    read(Opcao),
    processar_opcao(Opcao),
    (   Opcao \= 0
    ->  write('~nPressione Enter para continuar...'), nl,
        read(_),
        menu
    ;   write('~nSaindo...'), nl
    ).

processar_opcao(1) :- menu_manual.
processar_opcao(2) :- menu_backtracking.
processar_opcao(3) :- menu_melhor_decisao.
processar_opcao(4) :- menu_listar_por_impacto.
processar_opcao(5) :- menu_explicar_decisao.
processar_opcao(6) :- menu_avaliar_pais.
processar_opcao(7) :- menu_comparar_paises.
processar_opcao(8) :- menu_exemplos.
processar_opcao(9) :- menu_ajuda.
processar_opcao(0) :- true.
processar_opcao(_) :-
    write('Opção inválida!'), nl.

limpar_tela :-
    nl, nl, nl, nl, nl.

menu_manual :-
    limpar_tela,
    write('========================================'), nl,
    write('MANUAL - Configurar País (Incremental)'), nl,
    write('========================================'), nl, nl,
    
    write('Digite o nome do país:'), nl,
    read(Pais),
    nl,
    
    retractall(crise_economica(Pais, _, _, _, _, _)),
    retractall(crise_saude(Pais, _, _, _, _, _)),
    retractall(crise_seguranca(Pais, _, _, _, _, _)),
    retractall(crise_social(Pais, _, _, _, _, _)),
    retractall(infraestrutura(Pais, _)),
    retractall(apoio_populacao(Pais, _)),
    retractall(reservas(Pais, _)),
    
    format('✓ País ~w selecionado~n', [Pais]),
    nl,
    
    coletar_dados_incremental(Pais),
    
    nl,
    write('✓ Configuração completa!'), nl.

coletar_dados_incremental(Pais) :-
    write('--- CRISE ECONÔMICA ---'), nl,
    ler_crise(Pais, crise_economica),
    
    write('--- CRISE DE SAÚDE ---'), nl,
    ler_crise(Pais, crise_saude),
    
    write('--- CRISE DE SEGURANÇA ---'), nl,
    ler_crise(Pais, crise_seguranca),
    
    write('--- CRISE SOCIAL ---'), nl,
    ler_crise(Pais, crise_social),
    
    write('--- INFRAESTRUTURA ---'), nl,
    write('Nível (boa/media/ruim):'), nl,
    read(Infra),
    assertz(infraestrutura(Pais, Infra)),
    
    write('--- APOIO DA POPULAÇÃO ---'), nl,
    write('Nível (baixo/medio/alto):'), nl,
    read(Apoio),
    assertz(apoio_populacao(Pais, Apoio)),
    
    write('--- RESERVAS ---'), nl,
    write('Nível (baixo/alto):'), nl,
    read(Res),
    assertz(reservas(Pais, Res)).

coletar_dados_incremental_com_verificacao(Pais, TipoConsulta) :-
    write('Vou coletar todos os dados necessários.'), nl, nl,
    
    write('--- CRISE ECONÔMICA ---'), nl,
    ler_crise(Pais, crise_economica),
    
    write('--- CRISE DE SAÚDE ---'), nl,
    ler_crise(Pais, crise_saude),
    
    write('--- CRISE DE SEGURANÇA ---'), nl,
    ler_crise(Pais, crise_seguranca),
    
    write('--- CRISE SOCIAL ---'), nl,
    ler_crise(Pais, crise_social),
    
    write('--- INFRAESTRUTURA ---'), nl,
    write('Nível (boa/media/ruim):'), nl,
    read(Infra),
    assertz(infraestrutura(Pais, Infra)),
    
    write('--- APOIO DA POPULAÇÃO ---'), nl,
    write('Nível (baixo/medio/alto):'), nl,
    read(Apoio),
    assertz(apoio_populacao(Pais, Apoio)),
    
    write('--- RESERVAS ---'), nl,
    write('Nível (baixo/alto):'), nl,
    read(Res),
    assertz(reservas(Pais, Res)),
    
    nl,
    write('>>> Todos os dados coletados. Resultado final:'), nl,
    executar_consulta(Pais, TipoConsulta).


executar_consulta(Pais, melhor_decisao) :-
    (   melhor_decisao(Pais, Acao, Meses)
    ->  (   Acao == nenhuma
        ->  format('Análise para ~w:~n', [Pais]),
            write('  Nenhuma ação de emergência é necessária no momento.'), nl,
            write('  O país está em situação estável.'), nl
        ;   format('Melhor decisão para ~w:~n', [Pais]),
            format('  Ação: ~w~n', [Acao]),
            format('  Duração: ~w meses~n', [Meses]),
            (   decisao_prioridade(Acao, Prioridade, Impacto)
            ->  format('  Prioridade: ~w, Impacto: ~w~n', [Prioridade, Impacto])
            ;   true
            )
        )
    ;   write('Nenhuma decisão disponível ou dados incompletos.'), nl
    ).

ler_crise(Pais, TipoCrise) :-
    write('Nível (baixo/medio/alto):'), nl,
    read(Nivel),
    write('Tendência (queda/estavel/alta):'), nl,
    read(Tendencia),
    write('Severidade (leve/moderada/alta/critica):'), nl,
    read(Severidade),
    write('Impacto (baixo/medio/alto):'), nl,
    read(Impacto),
    write('Variação (decrescente/estavel/ascendente/explosiva):'), nl,
    read(Variacao),
    (   TipoCrise == crise_economica
    ->  assertz(crise_economica(Pais, Nivel, Tendencia, Severidade, Impacto, Variacao))
    ;   TipoCrise == crise_saude
    ->  assertz(crise_saude(Pais, Nivel, Tendencia, Severidade, Impacto, Variacao))
    ;   TipoCrise == crise_seguranca
    ->  assertz(crise_seguranca(Pais, Nivel, Tendencia, Severidade, Impacto, Variacao))
    ;   TipoCrise == crise_social
    ->  assertz(crise_social(Pais, Nivel, Tendencia, Severidade, Impacto, Variacao))
    ).


menu_backtracking :-
    limpar_tela,
    write('========================================'), nl,
    write('BACKTRACKING - Explorar Cenários'), nl,
    write('========================================'), nl, nl,
    write('Escolha o modo:'), nl,
    write('1. Mostrar onde ação é a MELHOR decisão'), nl,
    write('2. Mostrar onde ação está DISPONÍVEL'), nl,
    write('3. Ver diferença (melhor vs disponível)'), nl,
    write('4. Explorar interativo (um por vez)'), nl,
    nl,
    write('Opção:'), nl,
    read(Modo),
    nl,
    
    write('Digite o nome da ação (ex: lockdown_parcial, plano_estabilizacao):'), nl,
    read(Acao),
    nl,
    
    (   Modo == 1
    ->  write('>>> Cenários onde ~w é a MELHOR decisão:', [Acao]), nl, nl,
        (   explorar_cenarios_para_acao(Acao, CeN, SaN, Infra, Apoio, Res, Meses)
        ->  format('CeN=~w, SaN=~w, Infra=~w, Apoio=~w, Res=~w => ~w meses~n',
                   [CeN, SaN, Infra, Apoio, Res, Meses]),
            write('(Pressione ; para ver mais, Enter para parar)'), nl,
            fail
        ;   write('(Nenhum cenário encontrado)'), nl
        )
    ;   Modo == 2
    ->  write('>>> Cenários onde ~w está DISPONÍVEL:', [Acao]), nl, nl,
        explorar_cenarios_onde_acao_disponivel_formatado(Acao)
    ;   Modo == 3
    ->  mostrar_diferenca_melhor_vs_disponivel(Acao)
    ;   Modo == 4
    ->  write('>>> Modo interativo - aperte ; para ver mais cenários:'), nl, nl,
        explorar_interativo(Acao)
    ;   write('Modo inválido!'), nl
    ),
    nl.


menu_melhor_decisao :-
    limpar_tela,
    write('========================================'), nl,
    write('MELHOR DECISÃO'), nl,
    write('========================================'), nl, nl,
    
    write('Digite o nome do país:'), nl,
    read(Pais),
    nl,
    
    (   coletar_dados_faltantes(Pais, Faltantes),
        Faltantes = []
    ->  % País tem todos os dados, mostra melhor decisão
        executar_consulta(Pais, melhor_decisao),
        nl
    ;   % País não tem dados completos
        format('País ~w não possui todos os dados configurados.~n', [Pais]),
        write('Use a opção 1 (Manual) para configurar o país primeiro.'), nl,
        nl
    ).

menu_listar_por_impacto :-
    limpar_tela,
    write('========================================'), nl,
    write('LISTAR DECISÕES POR IMPACTO'), nl,
    write('========================================'), nl, nl,
    write('Digite o nome do país:'), nl,
    read(Pais),
    nl,
    
    listar_decisoes_por_impacto(Pais),
    nl.

menu_explicar_decisao :-
    limpar_tela,
    write('========================================'), nl,
    write('EXPLICAR DECISÃO'), nl,
    write('========================================'), nl, nl,
    write('Digite o nome do país:'), nl,
    read(Pais),
    write('Digite o nome da ação:'), nl,
    read(Acao),
    nl,
    
    (   explicar_decisao(Pais, Acao)
    ->  true
    ;   format('Decisão ~w não está disponível para ~w.~n', [Acao, Pais])
    ),
    nl.

menu_avaliar_pais :-
    limpar_tela,
    write('========================================'), nl,
    write('AVALIAR PAÍS'), nl,
    write('========================================'), nl, nl,
    write('Digite o nome do país:'), nl,
    read(Pais),
    nl,
    
    (   coletar_dados_faltantes(Pais, Faltantes),
        Faltantes = []
    ->  mostrar_pesos_detalhados(Pais),
        nl,
        avaliar_pais(Pais, Score, Classificacao),
        format('Score Total Normalizado: ~2f%%~n', [Score]),
        format('Classificação: ~w~n', [Classificacao])
    ;   write('Erro ao avaliar país (dados incompletos).'), nl,
        write('Use a opção 1 (Manual) para configurar o país primeiro.'), nl
    ),
    nl.

mostrar_pesos_detalhados(Pais) :-
    write('=== PESOS DE CADA DADO INSERIDO ==='), nl, nl,
    
    (   crise_economica(Pais, EcN, EcT, EcS, EcI, EcV),
        nivel_valor(EcN, EcNV),
        tendencia_valor(EcT, EcTV),
        severidade_valor(EcS, EcSV),
        impacto_valor(EcI, EcIV),
        variacao_valor(EcV, EcVV),
        crise_score(EcN, EcT, EcS, EcI, EcV, EcScore)
    ->  write('CRISE ECONÔMICA:'), nl,
        format('  Nível: ~w (peso: ~w)~n', [EcN, EcNV]),
        format('  Tendência: ~w (peso: ~w)~n', [EcT, EcTV]),
        format('  Severidade: ~w (peso: ~w)~n', [EcS, EcSV]),
        format('  Impacto: ~w (peso: ~w)~n', [EcI, EcIV]),
        format('  Variação: ~w (peso: ~w)~n', [EcV, EcVV]),
        format('  Score Total: ~w~n', [EcScore]),
        nl
    ;   true
    ),
    
    (   crise_saude(Pais, SaN, SaT, SaS, SaI, SaV),
        nivel_valor(SaN, SaNV),
        tendencia_valor(SaT, SaTV),
        severidade_valor(SaS, SaSV),
        impacto_valor(SaI, SaIV),
        variacao_valor(SaV, SaVV),
        crise_score(SaN, SaT, SaS, SaI, SaV, SaScore)
    ->  write('CRISE DE SAÚDE:'), nl,
        format('  Nível: ~w (peso: ~w)~n', [SaN, SaNV]),
        format('  Tendência: ~w (peso: ~w)~n', [SaT, SaTV]),
        format('  Severidade: ~w (peso: ~w)~n', [SaS, SaSV]),
        format('  Impacto: ~w (peso: ~w)~n', [SaI, SaIV]),
        format('  Variação: ~w (peso: ~w)~n', [SaV, SaVV]),
        format('  Score Total: ~w~n', [SaScore]),
        nl
    ;   true
    ),
    
    (   crise_seguranca(Pais, SeN, SeT, SeS, SeI, SeV),
        nivel_valor(SeN, SeNV),
        tendencia_valor(SeT, SeTV),
        severidade_valor(SeS, SeSV),
        impacto_valor(SeI, SeIV),
        variacao_valor(SeV, SeVV),
        crise_score(SeN, SeT, SeS, SeI, SeV, SeScore)
    ->  write('CRISE DE SEGURANÇA:'), nl,
        format('  Nível: ~w (peso: ~w)~n', [SeN, SeNV]),
        format('  Tendência: ~w (peso: ~w)~n', [SeT, SeTV]),
        format('  Severidade: ~w (peso: ~w)~n', [SeS, SeSV]),
        format('  Impacto: ~w (peso: ~w)~n', [SeI, SeIV]),
        format('  Variação: ~w (peso: ~w)~n', [SeV, SeVV]),
        format('  Score Total: ~w~n', [SeScore]),
        nl
    ;   true
    ),
    
    (   crise_social(Pais, SoN, SoT, SoS, SoI, SoV),
        nivel_valor(SoN, SoNV),
        tendencia_valor(SoT, SoTV),
        severidade_valor(SoS, SoSV),
        impacto_valor(SoI, SoIV),
        variacao_valor(SoV, SoVV),
        crise_score(SoN, SoT, SoS, SoI, SoV, SoScore)
    ->  write('CRISE SOCIAL:'), nl,
        format('  Nível: ~w (peso: ~w)~n', [SoN, SoNV]),
        format('  Tendência: ~w (peso: ~w)~n', [SoT, SoTV]),
        format('  Severidade: ~w (peso: ~w)~n', [SoS, SoSV]),
        format('  Impacto: ~w (peso: ~w)~n', [SoI, SoIV]),
        format('  Variação: ~w (peso: ~w)~n', [SoV, SoVV]),
        format('  Score Total: ~w~n', [SoScore]),
        nl
    ;   true
    ),
    
    (   infraestrutura(Pais, Infra),
        nivel_valor(Infra, InfraV)
    ->  write('INFRAESTRUTURA:'), nl,
        format('  Nível: ~w (peso: ~w)~n', [Infra, InfraV]),
        nl
    ;   true
    ),
    
    (   apoio_populacao(Pais, Apoio),
        nivel_valor(Apoio, ApoioV)
    ->  write('APOIO DA POPULAÇÃO:'), nl,
        format('  Nível: ~w (peso: ~w)~n', [Apoio, ApoioV]),
        nl
    ;   true
    ),
    
    (   reservas(Pais, Reservas),
        nivel_valor(Reservas, ReservasV)
    ->  write('RESERVAS:'), nl,
        format('  Nível: ~w (peso: ~w)~n', [Reservas, ReservasV]),
        nl
    ;   true
    ),
    
    (   score_pais(Pais, ScoreTotal)
    ->  write('=== RESUMO ==='), nl,
        format('Score Total Bruto: ~w~n', [ScoreTotal]),
        format('Score Máximo Possível: 77~n', []),
        format('Porcentagem: ~2f%%~n', [(ScoreTotal / 77) * 100])
    ;   true
    ).

menu_comparar_paises :-
    limpar_tela,
    write('========================================'), nl,
    write('COMPARAR PAÍSES'), nl,
    write('========================================'), nl, nl,
    write('Digite o nome do primeiro país:'), nl,
    read(P1),
    write('Digite o nome do segundo país:'), nl,
    read(P2),
    nl,
    
    write('--- COMPARAÇÃO ---'), nl, nl,
    
    (   melhor_decisao(P1, A1, M1),
        avaliar_pais(P1, S1, C1)
    ->  format('~w:~n', [P1]),
        format('  Melhor decisão: ~w (~w meses)~n', [A1, M1]),
        format('  Score: ~2f%%, Classificação: ~w~n', [S1, C1])
    ;   format('~w: Dados incompletos~n', [P1])
    ),
    nl,
    
    (   melhor_decisao(P2, A2, M2),
        avaliar_pais(P2, S2, C2)
    ->  format('~w:~n', [P2]),
        format('  Melhor decisão: ~w (~w meses)~n', [A2, M2]),
        format('  Score: ~2f%%, Classificação: ~w~n', [S2, C2])
    ;   format('~w: Dados incompletos~n', [P2])
    ),
    nl.


menu_exemplos :-
    limpar_tela,
    write('========================================'), nl,
    write('EXEMPLOS PRÉ-CONFIGURADOS'), nl,
    write('========================================'), nl, nl,
    write('Escolha um exemplo:'), nl,
    write('1. Lockdown Parcial'), nl,
    write('2. Intervenção Econômica'), nl,
    write('3. Chamar ONU'), nl,
    write('4. Reforma de Infraestrutura'), nl,
    write('5. Plano de Estabilização'), nl,
    write('6. Múltiplas decisões (todos os impactos)'), nl,
    nl,
    write('Opção: '), nl,
    read(Opcao),
    nl,
    
    (   Opcao == 1
    ->  consult('testes/teste_lockdown_parcial.pl'),
        executar_teste(pais_exemplo)
    ;   Opcao == 2
    ->  consult('testes/teste_intervencao_economica.pl'),
        executar_teste(pais_exemplo)
    ;   Opcao == 3
    ->  consult('testes/teste_chamar_onu.pl'),
        executar_teste(pais_exemplo)
    ;   Opcao == 4
    ->  consult('testes/teste_reforma_infraestrutura.pl'),
        executar_teste(pais_exemplo)
    ;   Opcao == 5
    ->  consult('testes/teste_plano_estabilizacao.pl'),
        executar_teste(pais_exemplo)
    ;   Opcao == 6
    ->  consult('testes/exemplo_multiplos_impactos.pl'),
        executar_exemplos
    ;   write('Opção inválida!'), nl
    ),
    nl.


menu_ajuda :-
    limpar_tela,
    write('========================================'), nl,
    write('AJUDA'), nl,
    write('========================================'), nl, nl,
    write('OPÇÕES DISPONÍVEIS:'), nl, nl,
    write('1. Manual - Configure um país passo a passo'), nl,
    write('   Você informa todos os dados manualmente'), nl, nl,
    write('2. Backtracking - Explore cenários para uma ação'), nl,
    write('   O Prolog gera todas as combinações possíveis'), nl,
    write('   e mostra onde uma ação está disponível'), nl, nl,
    write('3. Ver melhor decisão - Mostra a melhor decisão'), nl,
    write('   para um país configurado'), nl, nl,
    write('4. Listar por impacto - Mostra decisões agrupadas'), nl,
    write('   por nível de impacto (alto/médio/baixo)'), nl, nl,
    write('5. Explicar decisão - Explica por que uma decisão'), nl,
    write('   está disponível para um país'), nl, nl,
    write('6. Avaliar país - Calcula score e classificação'), nl, nl,
    write('7. Comparar países - Compara dois países'), nl, nl,
    write('8. Exemplos - Carrega exemplos pré-configurados'), nl, nl,
    write('========================================'), nl,
    write('VALORES POSSÍVEIS:'), nl,
    write('========================================'), nl, nl,
    write('Níveis: baixo, medio, alto'), nl,
    write('Tendências: queda, estavel, alta'), nl,
    write('Severidade: leve, moderada, alta, critica'), nl,
    write('Impacto: baixo, medio, alto'), nl,
    write('Variação: decrescente, estavel, ascendente, explosiva'), nl,
    write('Infraestrutura: boa, media, ruim'), nl,
    write('Apoio: baixo, medio, alto'), nl,
    write('Reservas: baixo, alto'), nl, nl.


iniciar :-
    menu.

