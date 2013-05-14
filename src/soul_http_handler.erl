-module(soul_http_handler).

-type method() :: <<>>.
-type path() :: any().
-type tmpl() :: any().
-type values() :: list().
-type options() :: list().

-callback handle(method(), path()) ->
    {tmpl(), values()} | {tmpl(), values(), options()}.
    


