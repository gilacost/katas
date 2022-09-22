-module(solution_6).

-export([main/0]).

-import(os, [getenv/1]).

plus_minus(Arr) ->
    Len = length(Arr),

    {Pos, Neg, Zero} = lists:foldr(
        fun(Element, {AccPos, AccNeg, AccZero}) ->
            case Element of
                N when N > 0 -> {1 + AccPos, AccNeg, AccZero};
                N when N < 0 -> {AccPos, 1 + AccNeg, AccZero};
                N when N == 0 -> {AccPos, AccNeg, 1 + AccZero}
            end
        end,
        {0, 0, 0},
        Arr
    ),

    lists:map(
        fun(X) ->
            NumStr = io_lib:format("~.6f", [X / Len]),
            Line = "~s~n",
            io:fwrite(io_lib:format(Line, [NumStr]))
        end,
        [Pos, Neg, Zero]
    ).

main() ->
    ArrTemp = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    Arr = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(X),
            I
        end,
        ArrTemp
    ),

    plus_minus(Arr),

    ok.
