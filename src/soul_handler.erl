-module(soul_handler).
-behaviour(cowboy_middleware).

-export([execute/2]).

execute(Req, Env) ->
    {_, Handler} = lists:keyfind(handler, 1, Env),
    {Method, _} = cowboy_req:method(Req),
    {Path, _} = cowboy_req:path(Req),
    handler_handle(Handler, Method, Path, Req),
    {ok, Req, Env}.

handler_handle(Handler, Method, Path, Req) ->
    try Handler:handle(Method, Path) of
        Body ->
            cowboy_req:reply(200, [], Body, Req)
    catch 
        _:Reason ->
            {error, Reason}
    end.



