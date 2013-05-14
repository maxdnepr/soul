-module(soul_tmpl).
-export([dtl/2, dtl/3]).

dtl(Tmpl, Values) ->
    dtl(Tmpl, Values, []).

dtl(Tmpl, Values, Options) ->
    try
        [NameStr, _Expansion] = string:tokens(Tmpl, "."),
        Path = lists:concat(["src/view", "/", Tmpl]),
        Name = list_to_atom(NameStr),
        ok = erlydtl:compile(Path, Name, Options),
        {ok, _Iolist} = Name:render(Values)
    catch
        _:Reason ->
            {error, Reason}
    end.
