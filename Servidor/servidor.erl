-module(servidor).
-export([start/1]).
-export([move_player/3, play_game/8, head/1,replace_aux/4,replace/2,element_in_list/2]).
-export([levelUp/2, spawn_reds/3, spawn_green/3, top3/0]).
-export([move_redBall/3]).


%......................................................................
%               Funçoes auxiliares 
%.......................................................................
%
% funcao que retorna o tamanho de uma lista .
%length([])-> 0;
%length([H|T])-> 1 + length(T).


% funcao que retorna o primeiro elemento de uma lista generica,
head([])-> throw(error); 
head([H|_])-> H.

% funcao que dado um indice e uma lista, retorna o elemento dessa lista.
indice(i,[])-> throw(error);
indice(i,_) when i < 0 -> throw(error);
indice(i,[_|T]) when i > 0 -> indice(i-1,T);
indice(0,[H|_]) -> H.


replace_aux([H|T],E,Return,0)-> if
                              (element(1,H) == element(1,E))->
                                  replace_aux(T,E,lists:append(Return,[E]),1);
                              true->
                                  replace_aux(T,E,lists:append(Return,[H]),0)
                              end;
replace_aux([H|T],E,Return,1)-> if
                              (element(1,H) == element(1,E))->
                                  replace_aux(T,E,lists:append(Return,[E]),1);
                              true->
                                  replace_aux(T,E,lists:append(Return,[H]),1)
                              end;
replace_aux([],_,Return,flag)->{falg,Return}.

% funcao que retorna a lista atualizando o nivel se o jogador
% ja estiver na lista. 
% caso nao esteja, substitui o primeiro jogador pelo recebido.
replace([],_)-> [];
replace([H|T],E)-> case replace_aux([H|T],E,[],0) of
                       {0,_}->
                           [E|T];
                       {_,List}->
                           List
                   end.

                       
% funcao se testa se um dado elemento se encontra numa lista
element_in_list([],_)-> false;
element_in_list([H|T],E)-> if
                               (H == E)->
                                   true;
                               true->
                                   element_in_list(T,E)
                           end.

analyze(Data)->Data.
%.......................................................................
%.......................................................................
                
% criaçao de uma sala
%room(Pids)->
%    receive {enter,Pid} -> 
%    io:format("user entered ̃n", []),
%    room([Pid | Pids]);
%    {line, Data} = Msg ->
%        io:format("received  ̃p ̃n", [Data]),
%        [Pid ! Msg || Pid <- Pids],
%        room(Pids);
%    {leave, Pid} ->
%        io:format("user left ̃n", []),
%        room(Pids -- [Pid])
%    end.
%
%
%%
%user(Sock, Room) ->
%    receive {line, Data} ->
%        gen_tcp:send(Sock, Data),
%        user(Sock, Room);
%    {tcp, _, Data} ->
%        Room ! {line, Data},
%        user(Sock, Room);
%    {tcp_closed, _} ->
%        Room ! {leave, self()};
%    {tcp_error, _, _} ->
%        Room ! {leave, self()}
%end.
%
%%
%acceptor(Lsock,Room)->
%    {ok,Sock} = gen_tcp:accept(Lsock),
%    spawn(fun()->acceptor(Lsock,Room) end),
%    Room ! {enter, self()},
%    user(Sock,Room).

%..................................
%
%..................................
%
% argumentos do player:
% Socket -> socket de onde vai ler
% Info -> informaçao do jogador
%       [ Username, Password ]
% Flag -> se Info ja está completa : 1
%         caso contrario           : 0
%
player(Socket,Info,Flag,Jogo)->
    receive
        {tcp, Socket, Data} ->
            %tratar os dados
            case analyze(Data) of
                {create_accont, Username, Password}-> 
                    create_accont(Username, Password),
                    player(Socket,[Username|Password],1,Jogo);
                {login, Username, Password}-> 
                    login(Username, Password),
                    player(Socket,[Username|Password],1,Jogo);
                {logout, Username, Password}-> 
                    logout(Username, Password);
                {close_accont, Username, Password}-> 
                    close_accont(Username, Password);
                {play, Username, Password}->
                    play(Username,Password),
                    player(Socket,[Username|Password],1,Jogo);
                Tecla->
                    % ...

                    Jogo ! {self(),Tecla},
                    player(Socket,Info,1,Jogo)
            end;


        {tcp_closed, Socket} ->
            case flag of
                % ainda nao ha nelhum restito do jogador
                % por isso nao ha nada a fazer.
                0-> ok;
                %atualizar o estado do jogador para OFLINE
                _-> loop ! {logout(indice(0,Info),indice(1,Info))}
            end;

        {Play,1}->
            Data = binary_to_term(Play),
            gen_tcp:send(Socket, Data),
            player(Socket,Info,Flag,Jogo);

        {Player1, Player2,Pos1,Pos2,E1,E2,Red_bals,Green_bals}->
            Data = binary_to_term(Player1),
            gen_tcp:send(Socket, Data),
            Data = binary_to_term(Player2),
            gen_tcp:send(Socket, Data),
            Data = binary_to_term(Pos1),
            gen_tcp:send(Socket, Data),
            Data = binary_to_term(Pos2),
            gen_tcp:send(Socket, Data),
            Data = binary_to_term(E1),
            gen_tcp:send(Socket, Data),
            Data = binary_to_term(E2),
            gen_tcp:send(Socket, Data),
            Data = binary_to_term(Red_bals),
            gen_tcp:send(Socket, Data),
            Data = binary_to_term(Green_bals),
            gen_tcp:send(Socket, Data),
            player(Socket,Info,Flag,Jogo)
    end.

server(Listen)->
    {ok,Socket} = gen_tcp:accept(Listen),
    spawn( fun() -> server(Listen) end),
    player(Socket,[],0,0).

% É criada uma sala com uma dada porta
start_server(Port)->
%    Room = spawn( fun()-> room([]) end),
    % fica bloqueado até receber uma conecçao
    {ok, LSock} = gen_tcp:listen(Port,[binary,{packet,line},{active,true},{reuseaddr,true}]),
    spawn( fun() -> server(LSock) end).
%
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

logout(Username,Password)->
    ?MODULE ! {logout, Username, Password, self()},
    receive { Res, ?MODULE} -> Res end.

levelUp(Username,Password)->
    ?MODULE ! {levelUp, Username, Password, self()},
    receive { Res, ?MODULE} -> Res end.

top3()->
    ?MODULE ! {top3, self()},
    receive { Res, ?MODULE} -> Res end.

play(Username,Password)->
    ?MODULE ! {play,Username,Password, self()},
    receive { Res, ?MODULE} -> Res end.

%................................................
%
%
spawn_reds(Pid,P1,P2)->
    lib_misc:sleep(10),
    POS = generate_pos(P1,P2),
    Pid !{red_bals, element(0,POS),element(1,POS)}.

spawn_green(Pid,P1,P2)->
    lib_misc:sleep(10),
    POS = generate_pos(P1,P2),
    Pid !{green_bals, element(0,POS),element(1,POS)}.

dist([],_)-> throw("error");
dist(_,[])-> throw("error");
dist(Pos1,Pos2)->
    math:sqrt(math:power(element(0,Pos2)-element(0,Pos1),2) + math:power(element(0,Pos2)-element(0,Pos1),2)). 

generate_pos(P1,P2)->
    X = rand:uniform(100),
    Y = rand:uniform(100),
    Dist1 = dist(P1,[X|Y]),
    Dist2 = dist(P2,[X|Y]),
    if 
        ( Dist1 > 30 )-> 
            if 
                ( Dist2 > 30 )-> 
                    [X|Y];
            
                true-> generate_pos(P1,P2)
            end;
        true-> generate_pos(P1,P2)
    end.
       
test_collisions(1,[])->
    false;
test_collisions(P1,[H|T])->
    Dist = dist(P1,H), 
    if 
        ( Dist < 2)->
            true; 
        true->
            test_collisions(P1,T)
    end.

create_vector(Point1, Point2)->
    [element(0,Point2) - element(0,Point1) | element(1,Point2) - element(1,Point1)].

point_plus_vector(Point,Vector)->
    [element(0,Point) + element(0,Vector) | element(1,Point) + element(1,Vector)].

move_redBall(PosBall, PosJ1, PosJ2)->
    Dist1 = dist(PosBall,PosJ1),
    Dist2 = dist(PosBall,PosJ2),
    if
        ( Dist1 > Dist2 )->
            point_plus_vector(PosBall,create_vector(PosBall,PosJ2));
        true->
            point_plus_vector(PosBall,create_vector(PosBall,PosJ1))
    end.

move_redBalls(Red_bals,PosJ1,PosJ2)->
    lists:map(fun(X)-> move_redBall(X,PosJ1,PosJ2) end,Red_bals).

move_player(Move, {X,Y},Energia)->
    case Move of
        "w"-> 
            {{X,Y+1},Energia-1}
    end.

plus_energy(Energia)-> Energia + 1. 


play_game(Player1, Player2,Pos1,Pos2,E1,E2,Red_bals,Green_bals)->
    receive
        {Player1,Move}->
            Pos1 = move_player(Move,Pos1,E1),
            Red = test_collisions(Pos1,Red_bals), 
            if 
            ( Red )->
                Player1 ! {game_over},
                Player2 ! {win};
            true->
                    Pos = ( test_collisions(Pos1,Green_bals) ),
                    if
                        (Pos)->
                            E1= plus_energy(E1),
                            Green_bals = lists:delete(Pos,Green_bals),
                            Player1 ! {Player1,Player2,Pos1,Pos2,E1,E2,Red_bals,Green_bals},
                            Player2 ! {Player1,Player2,Pos1,Pos2,E1,E2,Red_bals,Green_bals},
                            play_game(Player1,Player2,Pos1,Pos2,E1,E2,Red_bals,Green_bals);
                        true->

                            T1 = indice(0,Pos1),
                            T2 = indice(1,Pos1),
                            T3 = indice(0,Pos1),
                            T4 = indice(1,Pos1),
                            if
                                ( (T1  > 100) or (T2 > 100) or (T3 < 0) or (T4 < 0) )->
                                    Player1 ! {game_over},
                                    Player2 ! {win};
                                true->
                                    Player1 ! {Player1,Player2,Pos1,Pos2,E1,E2,Red_bals,Green_bals},
                                    Player2 ! {Player1,Player2,Pos1,Pos2,E1,E2,Red_bals,Green_bals}
                            end
                    end
            end;
        {Player2,Move}->
            Pos2 = move_player(Move,Pos2,E2),
            T = test_collisions(Pos2,Red_bals), 
            if 
            ( T )->
                Player2 ! {game_over},
                Player1 ! {win};
            true->
                    Pos = ( test_collisions(Pos2,Green_bals) ),
                    if
                        (Pos)->
                            E1= plus_energy(E1),
                            Green_bals = lists:delete(Pos,Green_bals),
                            Player1 ! {Player1,Player2,Pos1,Pos2,E1,E2,Red_bals,Green_bals},
                            Player2 ! {Player1,Player2,Pos1,Pos2,E1,E2,Red_bals,Green_bals},
                            play_game(Player1,Player2,Pos1,Pos2,E1,E2,Red_bals,Green_bals);

                        true->
                            T1 = indice(0,Pos2),
                            T2 = indice(1,Pos2),
                            T3 = indice(0,Pos2),
                            T4 = indice(1,Pos2),
                            if
                                ( (T1  > 100) or (T2 > 100) or (T3 < 0) or (T4 < 0) )->
                                    Player2 ! {game_over},
                                    Player1 ! {win};
                                true->
                                    Player1 ! {Player1,Player2,Pos1,Pos2,E1,E2,Red_bals,Green_bals},
                                    Player2 ! {Player1,Player2,Pos1,Pos2,E1,E2,Red_bals,Green_bals}
                            end
                    end
            end;
        {green_bals,X,Y}->
            Player1 ! {Player1,Player2,Pos1,Pos2,E1,E2,Red_bals,lists:append([[X|Y]],Green_bals)},
            Player2 ! {Player1,Player2,Pos1,Pos2,E1,E2,Red_bals,lists:append([[X|Y]],Green_bals)};

        {red_bals,X,Y}->
            Player1 ! {Player1,Player2,Pos1,Pos2,E1,E2,lists:append([[X|Y]],Red_bals),Green_bals},
            Player2 ! {Player1,Player2,Pos1,Pos2,E1,E2,lists:append([[X|Y]],Red_bals),Green_bals}
        end.


%
%
%................................................
% loop recebe 3 argumentos.
% Map -> que é onde se guarda toda a informaçao
%       User => {Password,online,level}
%
% Level -> que é onde se encontram os jogadores 
%          que estão à espera de parceiro para jogar
%          LEVEL => [Jogador1,Jogador2...Jogadorn]
%
% List -> top "3" de jogadores com mais nivel
%
% Pids -> associa a cada Pid o numero de utilizador
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
loop(Map,Level,List,Pids) ->
    % criar conta................................
    %
    receive {create_accont,U,P,From}->
        case maps:find(U,Map) of
            % se nao encontrar nelhum utilizador com esse nome
            % deixa criar
            error ->
                From ! {ok, ?MODULE},
                    % username -> [Password , online, level]
                Map = maps:put(User,{P,true,0},Map),
                loop(Map,Level,List,Pids);
            % caso ja exista algum utilizador com esse nome
            % envia uma mensagem de erro
            % e nao faz nada.
            _->
                From ! {invalid, ?MODULE},
                    loop(Map,Level,List,Pids)
        end;
    % fechar uma conta............................
    % 
    receive {close_accont,U,P,From}->
        % verificar se a conta realmente existe
        % e se a Password é a correta
        case maps:find(U,Map) of
            % se a conta existir, 
            % a password for a correta 
            % e estiver online
            % a conta é apagada
            {ok, {P,true,_}}-> 
                From ! { ok , ?MODULE},
                Map = maps:remove(User,Map),
                loop(Map,Level,List,Pids);
            % qualquer outro caso é enviado uma mensagem de erro
            _->
                From ! { invalid, ?MODULE},
                loop(Map,Level,List,Pids)
        end;
    % login de uma conta..........................
    % 
    receive {login,U,P,From}->
        % vereficar se a conta existe
        % e se a password é a correta
        % estar online é algo irrelevante (apsar de ser estranho) 
        case maps:find(U,Map) of
            {ok,{P,_,L}}->
                From ! {ok, ?MODULE },
                Map = maps:put(U,{P,true,L},Map),
                loop(Map,Level,List,put(From,U,Pids));
            % qualquer outro caso é enviado uma mensagem de erro
            _->
                From ! { invalid, ?MODULE},
                loop(Map,Level,List,Pids)
        end;
    % logout de umma conta .........................
    % 
    receive {logout,U,P,From}->
        % vereficar se a conta existe
        % e se a password é a correta
        % estar ofline é algo irrelevante (apsar de ser estranho) 
        case maps:find(U,Map) of
            {ok,{P,_,_}}->
                From ! {ok, ?MODULE },
                Map = maps:put(U,{P,false,_},Map),
                loop(Map,Level,List,maps:remove(From,Pids));
            % qualquer outro caso é enviado uma mensagem de erro
            _->
                From ! { invalid, ?MODULE},
                loop(Map,Level,List,Pids)
        end;
    % subir de nivel...............................
    % 
    receive {levelUp,U,P,From}->
        % verificar se a conta realmente existe
        % se a password está correta
        % e atribuir a X o nivel atual do jogador. 
        case maps:find(U,Map) of
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
                            ( (length(List) < 3) or (X+1 > element(2,head(list))) )-> 
                                Map = maps:put(User,{P,true,X+1},Map),
                                List_aux = replace(List,{U,X+1}),
                                List = lists:keysort(2, List_aux),
                                loop(Map,Level,List,Pids)
                                            
                        end;
            % qualquer outro caso é enviado uma mensagem de erro
            _->
                From ! {invalid, ?MODULE},
                    loop(Map,Level,List,Pids)
        end;
    % top3...............................
    % 
    %receive {top3,_,_,From}->
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
    receive {play,U,P,From}->
        case maps:find(U,Map) of
            {ok,{P,_,X}} -> From ! {ok, ?MODULE},
                case find(X,Level) of
                    {ok,L} when length(L)>0 -> 
                        spawn( fun()-> play_game(From,indice(1,L)) end),
                        loop(Map,Level,List,Pids);

                    _-> case find(X+1,Level) of
                        {ok,L} when length(L)>0 -> 
                            spawn( fun()-> play_game(From,indice(1,L)) end),
                            loop(Map,Level,List,Pids);

                        _-> case find(X-1,Level) of
                            {ok,L} when length(L)>0 -> 
                                spawn( fun()-> play_game(From,indice(1,L)) end),
                                loop(Map,Level,List,Pids);

                            _-> loop(Map,put([X],From,Level),List,Pids)
                            end
                        end
                end
        end.

start(Port)->
    start_server(Port),
    Pid = spawn(fun() -> loop(#{},#{},[],#{}) end),
    register(?MODULE,Pid).


%...............................................
%
