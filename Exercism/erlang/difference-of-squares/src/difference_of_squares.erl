-module(difference_of_squares).

-export([difference_of_squares/1, square_of_sum/1, sum_of_squares/1]).

difference_of_squares(N) ->
    square_of_sum(N) - sum_of_squares(N).

square_of_sum(N) ->
    Seq = lists:seq(1, N),
    Acc = lists:foldl(fun(X, Sum) -> Sum + X end, 0, Seq),

    Acc * Acc.

sum_of_squares(N) ->
    Seq = lists:seq(1, N),
    lists:foldl(
        fun(X, Sum) ->
            Sum + (X * X)
        end,
        0,
        Seq
    ).
