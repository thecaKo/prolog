% Exemplo de uso do menu incremental
% Demonstra como o sistema detecta quando já pode inferir uma resposta

:- consult('menu_interativo.pl').

% Exemplo: Configuração que gera resposta rápida
% (crise de saúde alta + apoio médio = lockdown_parcial)

demonstrar_incremental :-
    write('========================================'), nl,
    write('DEMONSTRAÇÃO: Menu Incremental'), nl,
    write('========================================'), nl, nl,
    
    write('Este exemplo mostra como o sistema detecta quando'), nl,
    write('já consegue inferir uma resposta antes de coletar'), nl,
    write('todos os dados.~n'), nl,
    
    write('Para testar:'), nl,
    write('1. Execute: iniciar.'), nl,
    write('2. Escolha opção 3 (Ver melhor decisão)'), nl,
    write('3. Digite um nome de país (ex: teste)'), nl,
    write('4. Configure:'), nl,
    write('   - Crise econômica: baixo, estavel, leve, baixo, estavel'), nl,
    write('   - Crise de saúde: alto, alta, critica, alto, explosiva'), nl,
    write('   - Crise de segurança: baixo, estavel, leve, baixo, estavel'), nl,
    write('   - Crise social: baixo, estavel, leve, baixo, estavel'), nl,
    write('   - Infraestrutura: boa'), nl,
    write('   - Apoio: medio'), nl,
    nl,
    write('5. Após inserir apoio, o sistema deve detectar que já'), nl,
    write('   consegue inferir uma resposta (lockdown_parcial)!'), nl,
    nl.

% Teste automatizado (simula entrada)
teste_automatizado :-
    write('========================================'), nl,
    write('TESTE AUTOMATIZADO'), nl,
    write('========================================'), nl, nl,
    
    Pais = teste_auto,
    
    % Limpa dados anteriores
    retractall(crise_economica(Pais, _, _, _, _, _)),
    retractall(crise_saude(Pais, _, _, _, _, _)),
    retractall(crise_seguranca(Pais, _, _, _, _, _)),
    retractall(crise_social(Pais, _, _, _, _, _)),
    retractall(infraestrutura(Pais, _)),
    retractall(apoio_populacao(Pais, _)),
    retractall(reservas(Pais, _)),
    
    % Configura dados que geram resposta rápida
    assertz(crise_economica(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_saude(Pais, alto, alta, critica, alto, explosiva)),
    assertz(crise_seguranca(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_social(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(infraestrutura(Pais, boa)),
    assertz(apoio_populacao(Pais, medio)),
    % Reservas não são necessárias para lockdown_parcial
    
    write('✓ País configurado: ~w~n', [Pais]), nl,
    
    write('Verificando se consegue inferir...'), nl,
    (   coletar_dados_faltantes(Pais, Faltantes),
        Faltantes = [],
        melhor_decisao(Pais, Acao, Meses),
        Acao \= nenhuma
    ->  write('>>> SIM! Já consegue inferir uma resposta!'), nl,
        format('Melhor decisão: ~w (~w meses)~n', [Acao, Meses])
    ;   write('Ainda não consegue inferir (faltam dados)'), nl
    ),
    nl.

