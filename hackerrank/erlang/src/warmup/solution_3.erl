-module(solution_3).

-export([main/0]).

-import(os, [getenv/1]).

compare_triplets(A, B) ->
    ValuePairs = lists:zip(A, B),

    ResultComparation = lists:map(fun(Pair) -> compare_pairs(Pair) end, ValuePairs),

    {Ar, Br} = lists:unzip(ResultComparation),

    lists:map(fun(R) -> lists:sum(R) end, [Ar, Br]).

compare_pairs({Ax, Bx}) when Ax > Bx ->
    {1, 0};
compare_pairs({Ax, Bx}) when Ax < Bx ->
    {0, 1};
compare_pairs({Ax, Bx}) when Ax == Bx ->
    {0, 0}.

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    ATemp = re:split(re:replace(io:get_line(""), "\\s+$", "", [global, {return, list}]), "\\s+", [
        {return, list}
    ]),

    A = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(
                re:replace(X, "(^\\s+)|(\\s+$)", "", [global, {return, list}])
            ),
            I
        end,
        ATemp
    ),

    BTemp = re:split(re:replace(io:get_line(""), "\\s+$", "", [global, {return, list}]), "\\s+", [
        {return, list}
    ]),

    B = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(
                re:replace(X, "(^\\s+)|(\\s+$)", "", [global, {return, list}])
            ),
            I
        end,
        BTemp
    ),

    Result = compare_triplets(A, B),

    io:fwrite(Fptr, "~s~n", [lists:join(" ", lists:map(fun(X) -> integer_to_list(X) end, Result))]),

    file:close(Fptr),

    ok.
