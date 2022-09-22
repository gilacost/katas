-module(solution_1).

-export([main/0]).

solve_me_first(A, B) ->
    A + B.

main() ->
    {ok, [A, B]} = io:fread("", "~d~d"),
    Res = solve_me_first(A, B),
    io:format("~p~n", [Res]).
