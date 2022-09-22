-module(darts).

-export([score/2, module/2]).

score(X, Y) ->
    case module(X, Y) of
        Distance when Distance > 10 -> 0;
        Distance when Distance =< 10, Distance > 5 -> 1;
        Distance when Distance =< 5, Distance > 1 -> 5;
        Distance when Distance =< 1, Distance >= 0 -> 10;
        _ -> 0
    end.

module(X, Y) -> math:sqrt(math:pow(X, 2) + math:pow(Y, 2)).
