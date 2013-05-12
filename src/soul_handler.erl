-module(soul_handler).
-behaviour(cowboy_middleware).

-export([execute/2]).

execute(Req, Env) ->
    {_, Handler} = lists:keyfind(handler, 1, Env),
    {Method, _} = cowboy_req:method(Req),
    {Path, _} = cowboy_req:path(Req),
    Result = handler_handle(Handler, Method, Path),
    {Code, Body} = check_response(Result),
    {Status, Req2} =cowboy_req:reply(Code, [], Body, Req),
    {Status, Req2, Env}.

handler_handle(Handler, Method, Path) ->
    try Handler:handle(Method, Path) of
        {Tmpl, Name, Values} ->
            soul_tmpl:dtl(Tmpl, Name, Values);
        {Tmpl, Name, Values, Options} ->
            soul_tmpl:dtl(Tmpl, Name, Values, Options);
        Reason ->
            {error, Reason}
    catch 
        _:Reason ->
            {error, Reason}
    end.

check_response({ok, [Iolist]}) ->
    {200, Iolist};
check_response({error, _Reason}) ->
    {404, <<"Not found">>}.


