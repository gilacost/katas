-module(queen_attack).

-export([can_attack/2]).

can_attack({WQx, WQy}, {BQx, BQy}) when WQx /= BQx, WQy /= BQy ->
    abs(WQx - BQx) == abs(WQy - BQy);

can_attack(_, _) -> true.
