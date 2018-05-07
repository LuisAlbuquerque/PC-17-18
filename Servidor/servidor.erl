-module(servidor).
-export([]).

%......................................................................
%               Funçoes auxiliares 
%.......................................................................
%
% funcao que retorna o tamanho de uma lista .
length([])-> 0;
length([H|T])-> 1 + length(T).


% funcao que retorna o primeiro elemento de uma lista generica,
% so funciona para listas com pelo menos um elemento. 
head([H|T])-> H. 


% funcao que retorna a lista atualizando o nivel se o jogador
% ja estiver na lista. 
% caso nao esteja, substitui o primeiro jogador pelo recebido.
replace([],E)-> [];
replace([H|T],E)-> case replace_aux([H|T],E,[],0) of
                       {0,List}->[E|T];
                       _-> List.
                       

replace_aux([H|T],E,Return,0)-> if
                              (element(1,H) == element(1,E))->
                                  replace_aux(T,E,lists:append(Return,[E]),1);
                              true->
                                  replace_aux(T,E,lists:append(Return,[H]).0);
replace_aux([H|T],E,Return,1)-> if
                              (element(1,H) == element(1,E))->
                                  replace_aux(T,E,lists:append(Return,[E]),1);
                              true->
                                  replace_aux(T,E,lists:append(Return,[H]).1);
replace_aux([],E,Return,flag)-> {falg,Return}.


% funcao se testa se um dado elemento se encontra numa lista
element_in_list([],E)-> false
element_in_list([H|T],E)-> if
                               (H == E)->
                                   true;
                               true->
                                   element_in_list(T,E).


%.......................................................................
%.......................................................................
                
% criaçao de uma sala
room(Pids)->
    receive {enter,Pid} -> 
    io:format("user entered ̃n", []),
    room([Pid | Pids]);
    {line, Data} = Msg ->
        io:format("received  ̃p ̃n", [Data]),
        [Pid ! Msg || Pid <- Pids],
        room(Pids);
    {leave, Pid} ->
        io:format("user left ̃n", []),
        room(Pids -- [Pid])
    end.


%
user(Sock, Room) ->
    receive {line, Data} ->
        gen_tcp:send(Sock, Data),
        user(Sock, Room);
    {tcp, _, Data} ->
        Room ! {line, Data},
        user(Sock, Room);
    {tcp_closed, _} ->
        Room ! {leave, self()};
    {tcp_error, _, _} ->
        Room ! {leave, self()}
end.

%
acceptor(Lsock,Room)->
    {ok,Sock} = gen_tcp:accept(Lsock),
    spawn(fun()->acceptor(Lsock,Room) end),
    Room ! {enter, self()},
    user(Sock,Room).

% É criada uma sala com uma dada porta
server(Port)->
    Room = spawn( fun()-> room([]) end),
    {ok, LSock} = gen_tcp:listen(Port,[binary,{packet,line},{reuseaddr,true}]),
    acceptor(LSock,Room).

%..................................
%
%
%..................................
start(Port)->
    server(Port),
    Pid = spawn(fun() -> loop(#{},[]) end),
    register(?MODULE,Pid).


%...............................................
%
%
%
create_accont(Username,Password)->
    ?MODULE ! {create_accont, Username, Password, self()},
    receive {Res, ?MODULE} -> Res end.

close_accont(Username,Password)->
    ?MODULE ! {close_accont, Username, Password,self()},
    receive { Res, ?MODULE} -> Res end.

login(Username,Password)->
    ?MODULE ! {login, Username, Password, self()},
    receive { Res, ?MODULE} -> Res end.

levelUp(Username)->
    ?MODULE ! {levelUp, Username, Password, self()},
    receive { Res, ?MODULE} -> Res end.

top3()->
    ?MODULE ! {top3, self()},
    receive { Res, ?MODULE} -> Res end.

%................................................
% loop recebe 2 argumentos.
% Map -> que é onde se guarda toda a informaçao
%       User => {Password,online,level}
%
% List -> top "3" de jogadores com mais nivel
%..........................................
% Loop é o processo que faz a gestao principal do jogo.
% é um processo que está sempre a correr e que vai atualizando 
% os dados do jogo, e dos jogadores.
%
% é o que controla a :
% criacao de conta
% os logins
% o que permite fechar uma conta
% o que sobe o nivel ao jogaor assim que ele ganhe um jogo.
%
loop(Map,List) ->
    % criar conta................................
    %
    receive {create_accont,U,P,From}->
        case maps:: find(U,Map) of
            % se nao encontrar nelhum utilizador com esse nome
            % deixa criar
            error ->
                From ! {ok, ?MODULE},
                    % username -> [Password , online, level]
                    loop((maps:put(User,{P,true,0),Map),List);
            % caso ja exista algum utilizador com esse nome
            % envia uma mensagem de erro
            % e nao faz nada.
            _->
                From ! {invalid, ?MODULE},
                    loop(Map,List)
        end;
    % fechar uma conta............................
    % 
    receive {close_accont,U,P,From}->
        % verificar se a conta realmente existe
        % e se a Password é a correta
        case maps:: find(U,Map) of
            % se a conta existir, 
            % a password for a correta 
            % e estiver online
            % a conta é apagada
            {ok, {P,true,_}}-> 
                From ! { ok , ?MODULE},
                loop((maps:remove(User,Map),List);
            % qualquer outro caso é enviado uma mensagem de erro
            _->
                From ! { invalid, ?MODULE},
                loop(Map,List)
        end;
    % login de uma conta..........................
    % 
    receive {login,U,P,From}->
        % vereficar se a conta existe
        % e se a password é a correta
        % estar online é algo irrelevante (apsar de ser estranho) 
        case maps:: find(U,Map) of
            {ok.{P,_,L}}->
                From ! {ok, ?MODULE },
                loop((maps::put(U,{P,true,L},Map),List);
            % qualquer outro caso é enviado uma mensagem de erro
            _->
                From ! { invalid, ?MODULE},
                loop(Map,List)
    end;
    % subir de nivel...............................
    % 
    receive {levelUp,U,P,From}->
        % verificar se a conta realmente existe
        % se a password está correta
        % e atribuir a X o nivel atual do jogador. 
        case maps:: find(U,Map) of
            {ok,{P,_,X}} -> From ! {ok, ?MODULE},
                    % username -> [Password , online, level]
                    % acrescentar 1 ao nivel do jogador. 
                        % se o top tiver menos que 3 jogadores, 
                        % independente do nivel, vai para a lista de tops 
                            % (a nao ser que ja se encontre na lista)
                            % se ja estiverem mais do que 3, mas se tiver
                            % nivel superior ao com nivel infeiror, é trocado por ele.
                            % replace verifica primeiro se está, se tiver troca,
                            % so se nao estiver é que acrescenta à cabeça da lista.
                            %
                            %........  NOTA !!!............................................
                            %
                            %  se replace for só usado aqui, é mais eficiente se adicionar 
                            %  logo no sitio certo e depois ja nao se fazer sort.
                        if
                            ( length(List) < 3 or X+1 > element(2,head(list)) )-> 
                                loop((maps:put(User,{P,true,X+1),Map),lists:lists:keysort(2, replace(List,{U,X+1})));
                                            
                        end;
            % qualquer outro caso é enviado uma mensagem de erro
            _->
                From ! {invalid, ?MODULE},
                    loop(Map)
    end;
    % top3...............................
    % 
    receive {top3,_,_,From}->
        % funcao que envia para o jogador o top 3 de jogadores com mais nivel, e os seus usernames. 
%        case maps:: find(U,Map) of
%            {ok,{P,_,X}} -> From ! {ok, ?MODULE},
%                    % username -> [Password , online, level]
%                    % acrescentar 1 ao nivel do jogador. 
%                    loop(maps:put(User,{P,true,X+1),Map);
%            % qualquer outro caso é enviado uma mensagem de erro
%            _->
%                From ! {invalid, ?MODULE},
%                    loop(Map)
%    end.


