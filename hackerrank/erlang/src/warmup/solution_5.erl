-module(solution_5).

-export([main/0]).

-import(os, [getenv/1]).

diagonal_difference(Arr) ->
    WithIndex =
        lists:zip(lists:seq(1, length(Arr)), Arr),

    {D1, D2} = lists:foldr(
        fun({I, Row}, {AccD1, AccD2}) ->
            {AccD1 + lists:nth(I, Row), AccD2 + lists:nth(I, lists:reverse(Row))}
        end,
        {0, 0},
        WithIndex
    ),
    erlang:display(abs(D1 - D2)),

    abs(D1 - D2).

read_multiple_lines_as_list_of_strings(N) ->
    read_multiple_lines_as_list_of_strings(N, []).

read_multiple_lines_as_list_of_strings(0, Acc) ->
    lists:reverse(Acc);
read_multiple_lines_as_list_of_strings(N, Acc) when N > 0 ->
    read_multiple_lines_as_list_of_strings(N - 1, [
        re:replace(io:get_line(""), "(\\r\\n$)|(\\n$)", "", [global, {return, list}])
        | Acc
    ]).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    {N, _} = string:to_integer(
        re:replace(io:get_line(""), "(^\\s+)|(\\s+$)", "", [global, {return, list}])
    ),

    ArrTemp = read_multiple_lines_as_list_of_strings(N),

    Arr = lists:map(
        fun(X) ->
            lists:map(
                fun(Y) ->
                    {I, _} = string:to_integer(Y),
                    I
                end,
                re:split(re:replace(X, "\\s+$", "", [global, {return, list}]), "\\s+", [
                    {return, list}
                ])
            )
        end,
        ArrTemp
    ),

    Result = diagonal_difference(Arr),

    io:fwrite(Fptr, "~w~n", [Result]),

    file:close(Fptr),

    ok.
