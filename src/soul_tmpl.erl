-module(soul_tmpl).
-export([dtl/3, dtl/4]).

dtl(Tmpl, Name, Values) ->
    dtl(Tmpl, Name, Values, []).

dtl(Tmpl, Name, Values, Options) ->
    try
        ok = erlydtl:compile(Tmpl, Name, Options),
        {ok, _Iolist} = Name:render(Values)
    catch
        _:Reason ->
            {error, Reason}
    end.
