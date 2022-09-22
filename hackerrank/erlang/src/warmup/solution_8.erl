-module(solution_8).

-export([main/0]).

% Complete the miniMaxSum function below.
mini_max_sum(Arr) ->
    Max = lists:max(Arr),

    Min = lists:min(Arr),

    MidValues = Arr -- [Max, Min],

    MinSum = lists:sum(MidValues ++ [Min]),
    MaxSum = lists:sum(MidValues ++ [Max]),

    Line = "~w ~w~n",

    io:fwrite(io_lib:format(Line, [MinSum, MaxSum])).

main() ->
    ArrTemp = re:split(string:chomp(io:get_line("")), ["\\s+"], [{return, list}, trim]),

    Arr = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(X),
            I
        end,
        ArrTemp
    ),

    mini_max_sum(Arr),

    ok.
