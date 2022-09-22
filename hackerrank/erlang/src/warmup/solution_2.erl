-module(solution_2).

-export([main/0]).

-import(os, [getenv/1]).

simple_array_sum(Ar) ->
    lists:sum(Ar).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    {_ArCount, _} = string:to_integer(string:chomp(io:get_line(""))),

    ArTemp = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    Ar = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(X),
            I
        end,
        ArTemp
    ),

    Result = simple_array_sum(Ar),

    io:fwrite(Fptr, "~w~n", [Result]),

    file:close(Fptr),

    ok.
