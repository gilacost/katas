-module(solution_24).

-export([main/0, who_catches_first/1]).

-import(os, [getenv/1]).

who_catches_first([CatA, CatB, MouseC]) ->
    Distances = [abs(MouseC - CatA), abs(MouseC - CatB)],
    case Distances of
        [A, B] when A == B -> "Mouse C\n";
        [A, B] when A < B -> "Cat A\n";
        [A, B] when A > B -> "Cat B\n"
    end.

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

    Result = lists:map(fun(X) -> who_catches_first(X) end, Arr),

    io:fwrite(Fptr, "~s", [Result]),

    file:close(Fptr),

    ok.

%%%
%%% Tests
%%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

who_catches_first_0_test() ->
    Who = who_catches_first([1, 2, 3]),
    ?assert(Who =:= "Cat B\n").

who_catches_first_1_test() ->
    Who = who_catches_first([1, 3, 2]),
    ?assert(Who =:= "Mouse C\n").

who_catches_first_2_test() ->
    Who = who_catches_first([84, 17, 18]),
    erlang:display(Who),
    ?assert(Who =:= "Cat B\n").

-endif.
