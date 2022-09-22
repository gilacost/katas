-module(solution_9).

-export([main/0]).

-import(os, [getenv/1]).

birthday_cake_candles(Candles, CandlesCount) ->
    CandlesOfCount = lists:sort(lists:sublist(Candles, CandlesCount)),
    Max = lists:max(CandlesOfCount),
    {_, MaxList} = lists:splitwith(fun(X) -> X /= Max end, CandlesOfCount),
    length(MaxList).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    {CandlesCount, _} = string:to_integer(
        re:replace(io:get_line(""), "(^\\s+)|(\\s+$)", "", [global, {return, list}])
    ),

    CandlesTemp = re:split(
        re:replace(io:get_line(""), "\\s+$", "", [global, {return, list}]),
        "\\s+",
        [{return, list}]
    ),

    Candles = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(
                re:replace(X, "(^\\s+)|(\\s+$)", "", [global, {return, list}])
            ),
            I
        end,
        CandlesTemp
    ),

    Result = birthday_cake_candles(Candles, CandlesCount),

    io:fwrite(Fptr, "~w~n", [Result]),

    file:close(Fptr),

    ok.
