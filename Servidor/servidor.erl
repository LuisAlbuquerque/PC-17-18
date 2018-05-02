-module(servidor).
-export([server/1,start/0,create_accont/2, close_accont/2, login/2, logout/1, online/0]).

start()->
    Pid = spawn(fun() -> loop(#{}) end),
    register(?MODULE,Pid).

%...............................................
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


%................................................

server(Port)->
    Room = spawn( fun()-> room([]) end),
    {ok, LSock} = gen_tcp:listen(Port,[binary,{packet,line},{reuseaddr,true}]),
    acceptor(LSock,Room).

acceptor(Lsock,Room)->
    {ok,Sock} = gen_tcp:accept(Lsock),
    spawn(fun()->acceptor(Lsock,Room) end),
    Room ! {enter, self()},
    user(Sock,Room).

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

%..........................................

loop(Map) ->
    receive {create_accont,U,P,From}->
        case maps:: find(U,Map) of
            error ->
                From ! {ok, ?MODULE},
                    loop(maps:put(User,{P,true),Map);
            _->
                From ! {invalid, ?MODULE},
                    loop(Map)
        end;
    receive {close_accont,U,P,From}->
        case maps:: find(U,Map) of
            {ok, {Pass,_}}-> 
                From ! { ok , ?MODULE},
                loop(maps:remove(User,Map));
            _->
                From ! { invalid, ?MODULE},
                loop(Map)
        end
    receive {login,U,P,From}->
        case maps:: find(U,Map) of
    end.
