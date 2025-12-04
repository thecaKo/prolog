:- consult('data.pl').

menu :-
    limpar_tela,
    write('========================================'), nl,
    write('    SISTEMA DE DECISÃO - MENU PRINCIPAL'), nl,
    write('========================================'), nl, nl,
    write('1. Manual (Livre) - Comandos brutos'), nl,
    write('2. Assistência - Configurar país passo a passo'), nl,
    write('3. Listar decisões'), nl,
    write('4. Melhor decisão'), nl,
    write('5. Perfil país'), nl,
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

processar_opcao(1) :- menu_manual_livre.
processar_opcao(2) :- menu_assistencia.
processar_opcao(3) :- menu_listar_decisoes.
processar_opcao(4) :- menu_melhor_decisao_completo.
processar_opcao(5) :- menu_perfil_pais.
processar_opcao(0) :- true.
processar_opcao(_) :-
    write('Opção inválida!'), nl.

limpar_tela :-
    nl, nl, nl, nl, nl.

menu_manual_livre :-
    limpar_tela,
    write('========================================'), nl,
    write('MANUAL (LIVRE) - Comandos Brutos'), nl,
    write('========================================'), nl, nl,
    write('Digite comandos Prolog diretamente.'), nl,
    write('Exemplos:'), nl,
    write('  assertz(crise_economica(brasil, alto, alta, critica, alto, explosiva)).'), nl,
    write('  assertz(reservas(brasil, alto)).'), nl,
    write('  melhor_decisao(brasil, A, M).'), nl,
    write(''), nl,
    write('Digite "voltar" para retornar ao menu.'), nl,
    nl,
    loop_comandos_livres.

loop_comandos_livres :-
    write('?- '),
    read(Comando),
    (   Comando == voltar
    ->  true
    ;   (   catch(call(Comando), E, 
            (write('Erro: '), write(E), nl))
        ->  true
        ;   write('Falhou ou não retornou verdadeiro.'), nl
        ),
        nl,
        loop_comandos_livres
    ).

menu_assistencia :-
    limpar_tela,
    write('========================================'), nl,
    write('ASSISTÊNCIA - Configurar País'), nl,
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

menu_melhor_decisao_completo :-
    limpar_tela,
    write('========================================'), nl,
    write('MELHOR DECISÃO'), nl,
    write('========================================'), nl, nl,
    
    write('Digite o nome do país:'), nl,
    read(Pais),
    nl,
    
    (   coletar_dados_faltantes(Pais, Faltantes),
        Faltantes = []
    ->  (   melhor_decisao(Pais, Acao, Meses)
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
                ),
                nl,
                write('=== EXPLICAÇÃO ==='), nl,
                explicar_decisao(Pais, Acao)
            )
        ;   write('Nenhuma decisão disponível ou dados incompletos.'), nl
        )
    ;   format('País ~w não possui todos os dados configurados.~n', [Pais]),
        write('Use a opção 2 (Assistência) para configurar o país primeiro.'), nl,
        nl
    ).

menu_listar_decisoes :-
    limpar_tela,
    write('========================================'), nl,
    write('LISTAR DECISÕES'), nl,
    write('========================================'), nl, nl,
    write('Digite o nome do país:'), nl,
    read(Pais),
    nl,
    
    (   coletar_dados_faltantes(Pais, Faltantes),
        Faltantes = []
    ->  listar_decisoes_com_impacto(Pais),
        nl
    ;   format('País ~w não possui todos os dados configurados.~n', [Pais]),
        write('Use a opção 2 (Assistência) para configurar o país primeiro.'), nl,
        nl
    ).

menu_perfil_pais :-
    limpar_tela,
    write('========================================'), nl,
    write('PERFIL DO PAÍS'), nl,
    write('========================================'), nl, nl,
    write('Digite o nome do país:'), nl,
    read(Pais),
    nl,
    
    (   coletar_dados_faltantes(Pais, Faltantes),
        Faltantes = []
    ->  (   perfil_pais(Pais, Perfil)
        ->  write('=== PERFIL COMPLETO DO PAÍS ==='), nl, nl,
            write(Perfil), nl, nl
        ;   write('Erro ao obter perfil do país.'), nl
        )
    ;   format('País ~w não possui todos os dados configurados.~n', [Pais]),
        write('Dados faltantes: '),
        coletar_dados_faltantes(Pais, Faltantes),
        write(Faltantes), nl,
        write('Use a opção 2 (Assistência) para configurar o país primeiro.'), nl,
        nl
    ).

iniciar :-
    menu.

