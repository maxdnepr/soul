-module(soul).
-export([start/1, stop/0]).

start({PathDispatch, Port, Acceptors}) ->
    {ok, File} = file:consult(PathDispatch),
    Dispatch = cowboy_router:compile(File),
    cowboy:start_http(soul_http_listener, Acceptors, [{port, Port}], [
            {env, [{dispatch, Dispatch}]},
            {middlewares, [cowboy_router, soul_handler]}]).    
            
stop() ->
    application:stop(soul).
