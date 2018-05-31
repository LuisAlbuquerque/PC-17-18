-module(servidor).
-export([start/1]).
%-export([move_player/8, play_game/17, head/1,replace_aux/4,replace/2,element_in_list/2]).
%-export([levelUp/2, spawn_reds/3, spawn_green/3, top3/0]).
%-export([move_redBall/3]).


%......................................................................
%               Funçoes auxiliares
%.......................................................................
%
% funcao que retorna o tamanho de uma lista .
%length([])-> 0;
%length([H|T])-> 1 + length(T).


% funcao que retorna o primeiro elemento de uma lista generica,
%head([])-> throw(error);
%head([H|_])-> H.

% funcao que dado um lists:get e uma lista, retorna o elemento dessa lista.
%lists:get(i,[])-> throw(error);
%lists:get(i,_) when i < 0 -> throw(error);
%lists:get(i,[_|T]) when i > 0 -> lists:get(i-1,T);
%lists:get(0,[H|_]) -> H.


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
replace_aux([],_,Return,flag)->{flag,Return}.

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

analyze(Data) when is_binary(Data) ->
    List = binary_to_list(Data),
    list_to_tuple(string:split(string:trim(List),",",all));

analyze(Data) ->
    %List = binary_to_list(Data),
    list_to_tuple(string:split(string:trim(Data),",",all)).
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
%
%
listPoint_to_list([])-> "";
listPoint_to_list([Point|CPoint])->
        integer_to_list(element(1,Point)) ++"," ++
               integer_to_list(element(2,Point)) ++"," ++
               listPoint_to_list(CPoint).

bool_to_list(Bool)->
    if
        (Bool)->
            "true";
        true->
            "false"
    end.


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
    %io:fwrite("Hello World!\n"),

    %    ?MODULE ! {create_accont, "ola", "xau", self()},
    %gen_tcp:send(Socket, "ola"),
    case gen_tcp:recv(Socket,0) of
        {ok,B}->
            case analyze(B) of
                {"create_accont", Username, Password,_}->
                    ?MODULE ! {create_accont, Username, Password, self(),Socket},
                    %create_accont(Username, Password),
                    player(Socket,[Username|Password],1,Jogo);
                {"login", Username, Password}->
                    %login(Username, Password),
                    ?MODULE ! {login, Username, Password, self(),Socket},
                    player(Socket,[Username|Password],1,Jogo);
                {"logout", Username, Password}->
                    ?MODULE ! {logout, Username, Password, self(),Socket};
%                    logout(Username, Password);
                {"close_accont", Username, Password,_}->
                    ?MODULE ! {close_accont, Username, Password, self(),Socket};
%                    close_accont(Username, Password);
                {"play", Username, Password}->
                    ?MODULE ! {play, Username, Password, self(),Socket},
%                    play(Username,Password),
                    player(Socket,[Username|Password],1,Jogo);
                {"tecla",Tecla} when Flag == 2->
                    Jogo ! {self(),Tecla},
                    player(Socket,Info,Flag,Jogo);
                _->
                  player(Socket,Info,Flag,Jogo)
            end;
        {error,closed}->
            [H|T] = Info,
            [H2|_] = T,
            ?MODULE ! {logout,H,H2,self(),Socket}
    end,


    receive
%        {tcp, Socket, Data} ->
%            %tratar os dados
%            io:fwrite("TCP!\n"),
%            gen_tcp:send(Socket, "ela"),
%            case analyze(Data) of
%                {"create_accont", Username, Password}->
%                    create_accont(Username, Password),
%                    player(Socket,[Username|Password],1,Jogo);
%                {"login", Username, Password}->
%                    login(Username, Password),
%                    player(Socket,[Username|Password],1,Jogo);
%                {"logout", Username, Password}->
%                    logout(Username, Password);
%                {"close_accont", Username, Password}->
%                    close_accont(Username, Password);
%                {"play", Username, Password}->
%                    play(Username,Password),
%                    player(Socket,[Username|Password],1,Jogo);
%                {Tecla,_,_}->
%                    Jogo ! {self(),Tecla},
%                    player(Socket,Info,1,Jogo)
%            end;
%
%
%        {tcp_closed, Socket} ->
%        io:fwrite("Hello World!\n"),
%            case flag of
%                % ainda nao ha nelhum restito do jogador
%                % por isso nao ha nada a fazer.
%                0-> ok;
%                %atualizar o estado do jogador para OFFLINE
%                _-> ?MODULE ! {logout(lists:get(0,Info),lists:get(1,Info))}
%            end;

%        {play,1}->
%            Data = binary_to_term(Play),
%            gen_tcp:send(Socket, Data),
%            player(Socket,Info,Flag,Jogo);

        {_,_,Pos1,Pos2,E1,E2,Angle1,Angle2,Speed1,Speed2,Aceleration1,Aceleration2,Switch1,Switch2,Red_balls,Green_balls}->
            Data = integer_to_list(element(1,Pos1)) ++"," ++
                   integer_to_list(element(2,Pos1)) ++"," ++
                   integer_to_list(element(1,Pos2)) ++"," ++
                   integer_to_list(element(2,Pos2)) ++"," ++
                   integer_to_list(E1) ++"," ++
                   integer_to_list(E2) ++"," ++
                   float_to_list(Angle1) ++"," ++
                   float_to_list(Angle2) ++"," ++
                   integer_to_list(Speed1) ++"," ++
                   integer_to_list(Speed2) ++"," ++
                   float_to_list(element(1,Aceleration1)) ++"," ++
                   float_to_list(element(2,Aceleration1)) ++"," ++
                   float_to_list(element(1,Aceleration2)) ++"," ++
                   float_to_list(element(2,Aceleration2)) ++"," ++
                   bool_to_list(Switch1) ++"," ++
                   bool_to_list(Switch2) ++"," ++
                   listPoint_to_list(Green_balls) ++","++
                   listPoint_to_list(Red_balls),
           % Data2 = list_to_binary(Data),
            gen_tcp:send(Socket,Data),
            player(Socket,Info,Flag,Jogo);

        {top3,Data,Data2}->
            %<<jogador1 nivel, jogar2 nivel2, jogar3 nivel3>>
            gen_tcp:send(Socket,Data),
            %<<jogador1 pontos, jogar2 pontos2, jogar3 pontos3>>
            gen_tcp:send(Socket,Data2),
            player(Socket,Info,Flag,Jogo);

        {socket,Pid}->
            player(Socket,Info,2,Pid);

        {win,Level,Points,V}->
            Data = integer_to_list(Level) ++ "," ++
            integer_to_list(Points) ++ "," ++
            integer_to_list(V),
            %Data2 = list_to_binary(Data),
            %Win = list_to_binary("win"),
            %gen_tcp:send(Socket,Win),
            gen_tcp:send(Socket,"win"++","++Data),
            player(Socket,Info,Flag,Jogo);


        {lose,Level,Points,V}->
            Data = integer_to_list(Level) ++ "," ++
            integer_to_list(Points) ++ "," ++
            integer_to_list(V),
            %Data2 = list_to_binary(Data),
            %Lose = list_to_binary("lose"),
            %gen_tcp:send(Socket,Lose),
            gen_tcp:send(Socket,"lose"++","++Data),
            player(Socket,Info,Flag,Jogo)


%        {ok,_}->
%            %Data = list_to_binary("ok"),
%            io:fwrite("3\n"),
%            gen_tcp:send(Socket,ok),
%            player(Socket,Info,Flag,Jogo);
%
%        {invalid,_}->
%            Data = list_to_binary("invalid"),
%            gen_tcp:send(Socket,Data),
%            player(Socket,Info,Flag,Jogo)


    end.
%        {invalid,_}->
%            Data = list_to_binary("invalid"),
%            gen_tcp:send(Socket,Data),
%            player(Socket,Info,Flag,Jogo)
%
%    end.

server(Listen)->
    {ok,Socket} = gen_tcp:accept(Listen),
    Player =  spawn(fun() -> player(Socket,[],0,0)end),
    gen_tcp:controlling_process(Socket, Player),
    server(Listen).

% É criada uma sala com uma dada porta
start_server(Port)->
%    Room = spawn( fun()-> room([]) end),
    % fica bloqueado até receber uma conecçao
    {ok, LSock} = gen_tcp:listen(Port,[binary,{active,false},{packet,line},{reuseaddr,true}]),
    %spawn(fun() -> server(LSock) end).
    server(LSock).
%
%...............................................
%
%
%
%create_accont(Username,Password)->
%
%    %io:fwrite(Username),
%    %io:fwrite(Password),
%    ?MODULE ! {create_accont, Username, Password, self()},
%    %io:fwrite("1!\n"),
%    receive {Res, ?MODULE} -> Res end.
%
%close_accont(Username,Password)->
%    ?MODULE ! {close_accont, Username, Password,self()},
%    receive { Res, ?MODULE} -> Res end.
%
%login(Username,Password)->
%    ?MODULE ! {login, Username, Password, self()},
%    receive { Res, ?MODULE} -> Res end.
%
%logout(Username,Password)->
%    ?MODULE ! {logout, Username, Password, self()},
%    receive { Res, ?MODULE} -> Res end.
%
%levelUp(Username,Password)->
%    ?MODULE ! {levelUp, Username, Password, self()},
%    receive { Res, ?MODULE} -> Res end.

%top3()->
%    ?MODULE ! {top3, self()},
%    receive { Res, ?MODULE} -> Res end.

%play(Username,Password)->
%    ?MODULE ! {play,Username,Password, self()},
%    receive { Res, ?MODULE} -> Res end.

%................................................
%
%
time_reds(Pid)->
    timer:sleep(10),
    Pid ! {red,self()},
    time_reds(Pid).

%time_green(Pid)->
%    lib_misc:sleep(10),
%    Pid ! {green,self()},
%    time_green(Pid).

spawn_reds(Pid,P1,P2)->
    POS = generate_pos(P1,P2),
    Pid !{red_bals, element(1,POS),element(2,POS)}.

spawn_green(Pid,P1,P2)->
    POS = generate_pos(P1,P2),
    Pid !{green_bals, element(1,POS),element(2,POS)}.

%dist({},_)-> throw("error");
%dist(_,{})-> throw("error");
dist(Pos1,Pos2)->
    A = math:pow(element(1,Pos2)-element(1,Pos1),2),
    B = math:pow(element(2,Pos2)-element(2,Pos1),2),
    math:sqrt(A + B). 
%    math:sqrt(math:power(element(1,Pos2)-element(1,Pos1),2) + math:power(element(2,Pos2)-element(2,Pos1),2)).

generate_pos(P1,P2)->
    X = rand:uniform(1300),
    Y = rand:uniform(700),
    Dist1 = dist(P1,{X,Y}),
    Dist2 = dist(P2,{X,Y}),
    if
        ( Dist1 > 30 )->
            if
                ( Dist2 > 30 )->
                    {X,Y};

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

normalize(Vector)->
    Norma = math:sqrt(math:pow(element(1,Vector),2) + math:pow(element(2,Vector)),2),
    {element(1,Vector)/Norma, element(2,Vector)/Norma}.

set_magnitude(Vector, Mag)->
    {X,Y}  = normalize(Vector),
    {X * Mag, Y * Mag }.


create_vector(Point1, Point2)->
    {element(1,Point2) - element(1,Point1) , element(2,Point2) - element(2,Point1)}.

point_plus_vector(Point,Vector)->
    {element(1,Point) + element(1,Vector) , element(2,Point) + element(2,Vector)}.

point_minus_vector(Point,Vector)->
    {element(1,Point) - element(1,Vector) , element(2,Point) - element(2,Vector)}.


move_redBall(PosBall, PosJ1, PosJ2)->
    Dist1 = dist(PosBall,PosJ1),
    Dist2 = dist(PosBall,PosJ2),
    if
        ( Dist1 > Dist2 )->
            Vector = create_vector(PosBall,PosJ2),
            Vector2 = set_magnitude(Vector,1),
            point_plus_vector(PosBall,Vector2);
        true->
            Vector = create_vector(PosBall,PosJ1),
            Vector2 = set_magnitude(Vector,1),
            point_plus_vector(PosBall,Vector2)
    end.

move_redBalls(Red_balls,PosJ1,PosJ2)->
    lists:map(fun(X)-> move_redBall(X,PosJ1,PosJ2) end,Red_balls).

move_player_aux(Move, {X,Y}, Energy, Angle, Speed, Aceleration, Switch) ->
    case Move of
        "a"->
            {{X,Y}, Energy, (Angle -0.07), Speed, Aceleration, true};
        "d"->
            {{X,Y}, Energy, (Angle +0.07), Speed, Aceleration, true};

        "w" when Switch == true ->
            {{X,Y}, Energy - 1, Angle, 0.05, {math:cos(Angle),math:sin(Angle)}, false};

        "w" when ((Switch == false) and (Speed < 0.3 ))->
            {{X,Y}, Energy - 1, Angle, Speed + 0.01, Aceleration, false};

        "w" when Switch == false ->
            {{X,Y}, Energy - 1, Angle, Speed, Aceleration, false};

        "wa" ->
            {{X,Y}, Energy - 1, (Angle - 0.07), 0.05, {math:cos(Angle-0.07),math:sin(Angle-0.07)}, false};

        "wd" ->
            {{X,Y}, Energy - 1, (Angle + 0.07), 0.05, {math:cos(Angle+0.07),math:sin(Angle+0.07)}, false}
    end.


move_player(Move, {X,Y}, Energy, Angle, Speed, Aceleration, Switch, {X2,Y2}) ->
        {{X,Y}, Energy, Angle, Speed , Aceleration, Switch} = move_player_aux(Move, {X,Y}, Energy, Angle, Speed, Aceleration, Switch),
        Aceleration_aux = set_magnitude(Aceleration,Speed),
        Angle_aux = math:atan2((Y2-Y), (X2-X)),
        Vector_aux =  {math:cos(Angle_aux),math:sin(Angle_aux)},
        Dist = dist( {X,Y},{X2,Y2}),
        Vector_aux2 = set_magnitude(Vector_aux,(1000/math:pow(Dist))),
        {X,Y} = point_minus_vector(point_plus_vector({X,Y},Aceleration_aux),Vector_aux2),
        {{X,Y}, Energy + 0.01 , Angle, Speed , Aceleration_aux, Switch}.


plus_energy(Energia)-> Energia + 1.

init_game(Player1,Player2)->
    Pid = spawn(fun()->play_game(self(),Player1, Player2,{0,0},{50,50},300,300,[],[],0,0,0,0,0,0,true,true)end),
    spawn_green(Pid,{0,0},{50,50}),
    spawn_green(Pid,{0,0},{50,50}),

    Init_time = erlang:system_time(),
    spawn(fun()->time_reds(Pid)end),
    %spawn(fun()->time_green(Pid)end),

    receive
        {Pid_playerWin, Pid_playerLose}->
            ?MODULE ! {Pid_playerWin,Pid_playerLose,erlang:system_time() - Init_time}
    end.


play_game(Pid,Player1, Player2,Pos1,Pos2,E1,E2,Red_balls,Green_balls,Angle1,Angle2,Speed1,Speed2,Aceleration1,Aceleration2,Switch1,Switch2)->
    move_redBalls(Red_balls,Pos1,Pos2),
    receive
        {Player1,Move}->

            {Pos1, E1, Angle1, Speed1 , Aceleration1, Switch1} = move_player(Move, Pos1, E1, Angle1, Speed1, Aceleration1, Switch1,Pos2),
            Red = test_collisions(Pos1,Red_balls),
            if
            ( Red )->
%                Player1 ! {game_over},
%                Player2 ! {win},
                Pid ! {Player2,Player1};
            true->
                    Pos = ( test_collisions(Pos1,Green_balls) ),
                    if
                        (Pos)->
                            E1_aux = plus_energy(E1),
                            Green_balls_aux = lists:delete(Pos,Green_balls),
                            spawn_green(self(),Pos1,Pos2),
                            Player1 ! {Player1,Player2,Pos1,Pos2,E1_aux,E2,Angle1,Angle2,Speed1,Speed2,Aceleration1,Aceleration2,Switch1,Switch2, Red_balls,Green_balls_aux},
                            Player2 ! {Player1,Player2,Pos2,Pos1,E2,E1_aux,Angle2,Angle1,Speed2,Speed1,Aceleration2,Aceleration1,Switch2,Switch1, Red_balls,Green_balls_aux},
                            play_game(Pid,Player1, Player2,Pos1,Pos2,E1_aux,E2,Red_balls,Green_balls_aux,Angle1,Angle2,Speed1,Speed2,Aceleration1,Aceleration2,Switch1,Switch2);
                        true->

                            T1 = lists:get(0,Pos1),
                            T2 = lists:get(1,Pos1),
                            if
                                ( (T1  > 1300) or (T2 > 700) or (T1 < 0) or (T2 < 0) )->
%                                    Player1 ! {game_over},
%                                    Player2 ! {win};
                                    Pid ! {Player2,Player1};
                                true->
                            Player1 ! {Player1,Player2,Pos1,Pos2,E1,E2,Angle1,Angle2,Speed1,Speed2,Aceleration1,Aceleration2,Switch1,Switch2, Red_balls,Green_balls},
                            Player2 ! {Player1,Player2,Pos2,Pos1,E2,E1,Angle2,Angle1,Speed2,Speed1,Aceleration2,Aceleration1,Switch2,Switch1, Red_balls,Green_balls}
                            end
                    end
            end;
        {Player2,Move}->
            {Pos2, E2, Angle2, Speed2 , Aceleration2, Switch2} = move_player(Move, Pos1, E1, Angle1, Speed1, Aceleration1, Switch1,Pos2),
            T = test_collisions(Pos2,Red_balls),
            if
            ( T )->
%                Player2 ! {game_over},
%                Player1 ! {win},
                Pid ! {Player1,Player2};
            true->
                    Pos = ( test_collisions(Pos2,Green_balls) ),
                    if
                        (Pos)->
                            E2_aux= plus_energy(E2),
                            Green_balls_aux = lists:delete(Pos,Green_balls),
                            Player1 ! {Player1,Player2,Pos1,Pos2,E1,E2_aux,Angle1,Angle2,Speed1,Speed2,Aceleration1,Aceleration2,Switch1,Switch2, Red_balls,Green_balls_aux},
                            Player2 ! {Player1,Player2,Pos2,Pos1,E2_aux,E1,Angle2,Angle1,Speed2,Speed1,Aceleration2,Aceleration1,Switch2,Switch1, Red_balls,Green_balls_aux},
                            play_game(Pid,Player1, Player2,Pos1,Pos2,E1,E2_aux,Red_balls,Green_balls_aux,Angle1,Angle2,Speed1,Speed2,Aceleration1,Aceleration2,Switch1,Switch2);
                        true->
                            T1 = lists:get(0,Pos2),
                            T2 = lists:get(1,Pos2),
                            if
                                ( (T1  > 1300) or (T2 > 700) or (T1 < 0) or (T2 < 0) )->
%                                    Player2 ! {game_over},
%                                    Player1 ! {win},
                                    Pid ! {Player1,Player2};
                                true->
                                    Player1 ! {Player1,Player2,Pos1,Pos2,E1,E2,Angle1,Angle2,Speed1,Speed2,Aceleration1,Aceleration2,Switch1,Switch2, Red_balls,Green_balls},
                                    Player2 ! {Player1,Player2,Pos2,Pos1,E2,E1,Angle2,Angle1,Speed2,Speed1,Aceleration2,Aceleration1,Switch2,Switch1, Red_balls,Green_balls},
                                    play_game(Pid,Player1, Player2,Pos1,Pos2,E1,E2,Red_balls,Green_balls,Angle1,Angle2,Speed1,Speed2,Aceleration1,Aceleration2,Switch1,Switch2)
                            end
                    end
            end;
        {green_bals,X,Y}->
            Player1 ! {Player1,Player2,Pos1,Pos2,E1,E2,Angle1,Angle2,Speed1,Speed2,Aceleration1,Aceleration2,Switch1,Switch2, Red_balls,lists:append([[X|Y]],Green_balls)},
            Player2 ! {Player1,Player2,Pos2,Pos1,E2,E1,Angle2,Angle1,Speed2,Speed1,Aceleration2,Aceleration1,Switch2,Switch1, Red_balls,lists:append([[X|Y]],Green_balls)};

        {red_bals,X,Y}->
            Player1 ! {Player1,Player2,Pos1,Pos2,E1,E2,Angle1,Angle2,Speed1,Speed2,Aceleration1,Aceleration2,Switch1,Switch2, lists:append([[X|Y]],Red_balls),Green_balls},
            Player2 ! {Player1,Player2,Pos2,Pos1,E2,E1,Angle2,Angle1,Speed2,Speed1,Aceleration2,Aceleration1,Switch2,Switch1, lists:append([[X|Y]],Red_balls),Green_balls};

        {red,_}->
           spawn(fun()-> spawn_reds(self(),Pos1,Pos2) end);

        {green,_}->
            spawn(fun()-> spawn_green(self(),Pos1,Pos2) end)
            end.



%
%
%................................................
% loop recebe 3 argumentos.
% Map -> que é onde se guarda toda a informaçao
%       User => {Password,online,level,Pontos,nvitorias}
%
% Level -> que é onde se encontram os jogadores
%          que estão à espera de parceiro para jogar
%          LEVEL => [Jogador1,Jogador2...Jogadorn]
%
% List -> top "3" de jogadores com mais nivel
%
%
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
        io:fwrite("2!\n"),
    receive {create_accont,U,P,_,Socket}->

        case maps:find(U,Map) of
            % se nao encontrar nelhum utilizador com esse nome
            % deixa criar
            error ->
                    % username -> [Password , online, level]
                Map2 = maps:put(U,{P,true,1,0,0},Map),
%                From ! {ok, ?MODULE},
                gen_tcp:send(Socket,"ok\n"),

                loop(Map2,Level,List,Pids);
            % caso ja exista algum utilizador com esse nome
            % envia uma mensagem de erro
            % e nao faz nada.
            _->
                %From ! {invalid, ?MODULE},
                gen_tcp:send(Socket,"invalid\n"),
                loop(Map,Level,List,Pids)
        end;

    % fechar uma conta............................
    %
    {close_accont,U,P,_,Socket}->
        % verificar se a conta realmente existe
        % e se a Password é a correta
        case maps:find(U,Map) of
            % se a conta existir,
            % a password for a correta
            % e estiver online
            % a conta é apagada
            {ok, {P,_,_,_,_}}->
                %From ! { ok , ?MODULE},
                gen_tcp:send(Socket,"ok\n"),
                Map2 = maps:remove(U,Map),
                loop(Map2,Level,List,Pids);
            % qualquer outro caso é enviado uma mensagem de erro
            _->
%                From ! { invalid, ?MODULE},
                gen_tcp:send(Socket,"invalid\n"),
                loop(Map,Level,List,Pids)
        end;
    % login de uma conta..........................
    %
    {login,U,P,From,Socket}->
      io:fwrite("coisas!\n"),
        % vereficar se a conta existe
        % e se a password é a correta
        % estar online é algo irrelevante (apsar de ser estranho)
        case maps:find(U,Map) of
            {ok,{P,_,L,Pt,V}}->
%                From ! {ok, ?MODULE },
                gen_tcp:send(Socket,"ok\n"),
                Map2 = maps:put(U,{P,true,L,Pt,V},Map),
                loop(Map2,Level,List,maps:put(From,U,Pids));
            % qualquer outro caso é enviado uma mensagem de erro
            _->
%                From ! { invalid, ?MODULE},
                gen_tcp:send(Socket,"invalid\n"),
                loop(Map,Level,List,Pids)
        end;
    % logout de umma conta .........................
    %
     {logout,U,P,From,Socket}->
        % vereficar se a conta existe
        % e se a password é a correta
        % estar ofline é algo irrelevante (apsar de ser estranho)
        case maps:find(U,Map) of
            {ok,{P,_,L,Pt,V}}->
%                From ! {ok, ?MODULE },
                gen_tcp:send(Socket,"approved\n"),
                Map2 = maps:put(U,{P,false,L,Pt,V},Map),
                loop(Map2,Level,List,maps:remove(From,Pids));
            % qualquer outro caso é enviado uma mensagem de erro
            _->
%                From ! { invalid, ?MODULE},
                gen_tcp:send(Socket,"unapproved\n"),
                loop(Map,Level,List,Pids)
        end;
    % subir de nivel...............................
    %
     {levelUp,U}->
        % verificar se a conta realmente existe
        % se a password está correta
        % e atribuir a X o nivel atual do jogador.
            {ok,{_,_,X,_,_}} = maps:find(U,Map),
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
            [H|_] = List,
            if
                ( (length(List) < 3) or (X > element(2,H)) )->
                        List_aux = replace(List,{U,X+1}),
                        List2 = lists:keysort(2, List_aux),
                        loop(Map,Level,List2,Pids);
                true->
                        loop(Map,Level,List,Pids)

            end;

    % top3...............................
    %
    {top3,_}->
        Msg = list_to_binary(string:join(lists:map(fun(X)-> element(1,X) ++" "++ integer_to_list(element(2,X)) end,List),",")),
        LPids = maps:keys(Pids),
        Map_aux = maps:map(fun(_,V)-> element(4,V)end,Map),
        Msg2 = list_to_binary(lists:sublist(lists:sort(fun(X)-> element(2,X)end, maps:to_list(Map_aux)),3)),
        [Pid ! {top3,Msg,Msg2} || Pid <- LPids];

    {Win,Lose,Points}->
            UsernameW = maps:get(Win,Pids),
            UsernameL = maps:get(Lose,Pids),
            KeyW = maps:get(UsernameW,Map),
            {P,O,L,Pt,V} = maps:get(UsernameL,Map),
            Map2 = maps:put(UsernameL,{P,O,L,Pt+Points,V},Map),
            Lose ! {lose,L,Pt + Points,V},
            Aux =  element_in_list(3,KeyW),
            if
                (element(5,KeyW)+1 == Aux)->
                    ?MODULE ! {levelUp,UsernameW},
                    Map3 = maps:put(UsernameW,{P,O,L+1,Pt+Points,0},Map2),
                    Win ! {win,L+1,Pt + Points,0},
                    loop(Map3,Level,List,Pids);
                true->
                    Map3 = maps:put(UsernameW,{P,O,L,Pt+Points,V+1},Map2),
                    Win ! {win,L,Pt + Points,V},
                    loop(Map3,Level,List,Pids)
            end;


     {play,U,P,From,Socket}->
        case maps:find(U,Map) of
            {ok,{P,_,X,_,_}} -> gen_tcp:send(Socket,"ok\n"),
                    L = maps:filter(fun(K,_)-> (K == X) or (K == X+1) or (K == X-1) end,Level), 
                    Players = maps:values(L),
                    if
                        (length(Players) > 0)->
                            [H|_] = Players,
                            gen_tcp:send(Socket,"play\n"),
                            gen_tcp:send(element(1,H),"play\n"),
                            Pid = spawn( fun()-> init_game(From,element(2,H)) end),
                            From ! {socket,Pid},
                            element(2,H) ! {socket,Pid},
                            loop(Map,Level,List,Pids);

                        true->
                            loop(Map,maps:put(X,{Socket,From},Level),List,Pids)
                    end
                            
                        
                        
%%                case maps:find(X,Level) of
%                    {ok,L} when length(L)>0 ->
%                        gen_tcp:send(Socket,"play\n"),
%                        spawn( fun()-> init_game(From,lists:get(1,L)) end),
%                        loop(Map,Level,List,Pids);
%
%                    _-> case maps:find(X+1,Level) of
%                        {ok,L} when length(L)>0 ->
%                            gen_tcp:send(Socket,"play\n"),
%                            spawn( fun()-> init_game(From,lists:get(1,L)) end),
%                            loop(Map,Level,List,Pids);
%
%                        _-> case maps:find(X-1,Level) of
%                            {ok,L} when length(L)>0 ->
%                                gen_tcp:send(Socket,"play\n"),
%                                spawn( fun()-> init_game(From,lists:get(1,L)) end),
%                                loop(Map,Level,List,Pids);
%
%                            _-> 
%                                    gen_tcp:send(Socket,"wait\n"),
%                                    loop(Map,maps:put(X,From,Level),List,Pids)
%                            end
%                        end
%                end
        end;
        _->
            loop(Map,Level,List,Pids)

        end.

time_top(Pid)->
    timer:sleep(100),
    Pid ! {top3,self()},
    time_top(Pid).

start(Port)->
    Pid = spawn(fun() -> loop(#{},#{},[],#{}) end),
    register(?MODULE,Pid),
    start_server(Port),
    time_top(Pid),
    start(Port).


%...............................................
%
