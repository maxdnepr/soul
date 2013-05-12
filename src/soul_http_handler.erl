-module(soul_http_handler).

-type method() :: <<>>.
-type path() :: any().
-type tmpl() :: any().
-type name() :: atom().
-type values() :: list().
-type options() :: list().

-callback handle(method(), path()) ->
    {tmpl(), name(), values()} | {tmpl(), name(), values(), options()}.
    


