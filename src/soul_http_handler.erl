-module(soul_http_handler).

-type method() :: <<>>.
-type path() :: any().
-type body() :: <<>>.

-callback handle(method(), path()) ->
    body() | {atom(), body()}.
    


