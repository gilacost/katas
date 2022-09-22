-module(solution_4).

-export([main/0]).

-import(os, [getenv/1]).

% Complete the aVeryBigSum function below.
a_very_big_sum(Ar, ArCount) ->
    lists:sum(lists:sublist(Ar, ArCount)).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    {ArCount, _} = string:to_integer(string:chomp(io:get_line(""))),

    ArTemp = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    Ar = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(X),
            I
        end,
        ArTemp
    ),

    Result = a_very_big_sum(Ar, ArCount),

    io:fwrite(Fptr, "~w~n", [Result]),

    file:close(Fptr),

    ok.
