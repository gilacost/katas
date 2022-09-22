-module(solution_17).

-export([main/0]).

-import(os, [getenv/1]).

migratoryBirds(Arr) ->
    UniqElList = remove_dups(Arr),
    Count = lists:foldl(
        fun(BirdType, Acc) ->
            Acc ++ [{BirdType, count_in_list(Arr, BirdType)}]
        end,
        [],
        UniqElList
    ),
    {MostSeen, _} = lists:split(
        2,
        lists:sort(fun({_BirdTypeA, SeenA}, {_BirdTypeB, SeenB}) -> SeenA > SeenB end, Count)
    ),
    case MostSeen of
        [{BirdTypeA, SeenA}, {BirdTypeB, SeenB}] when SeenA == SeenB ->
            lists:min([BirdTypeA, BirdTypeB]);
        [{BirdTypeA, _SeenA}, _] ->
            BirdTypeA;
        _ ->
            true
    end.

remove_dups([]) -> [];
remove_dups([H | T]) -> [H | [X || X <- remove_dups(T), X /= H]].

count_in_list(L, El) ->
    length([X || X <- L, X == El]).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    {_ArrCount, _} = string:to_integer(
        re:replace(io:get_line(""), "(^\\s+)|(\\s+$)", "", [global, {return, list}])
    ),

    ArrTemp = re:split(
        re:replace(io:get_line(""), "\\s+$", "", [global, {return, list}]),
        "\\s+",
        [{return, list}]
    ),

    Arr = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(
                re:replace(X, "(^\\s+)|(\\s+$)", "", [global, {return, list}])
            ),
            I
        end,
        ArrTemp
    ),

    Result = migratoryBirds(Arr),

    io:fwrite(Fptr, "~w~n", [Result]),

    file:close(Fptr),

    ok.
