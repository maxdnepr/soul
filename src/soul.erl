-module(soul).
-export([start/1, stop/0]).

start(Dispatch) ->
    CompiledDispatch = cowboy_router:compile(Dispatch),
    {ok, Acceptors}  = application:get_env(soul, nb_acceptors),
    {ok, Port}       = application:get_env(soul, port),
    cowboy:start_http(soul_http_listener, Acceptors, [{port, Port}], [
            {env, [{dispatch, CompiledDispatch}]},
            {middlewares, [cowboy_router, soul_handler]}]).    
            
stop() ->
    application:stop(soul).
