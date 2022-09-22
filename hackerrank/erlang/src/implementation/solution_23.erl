-module(solution_23).

-export([main/0, get_money_spent/3]).

-import(os, [getenv/1]).

get_money_spent(Keyboards, Drives, B) when is_list(Keyboards), is_list(Drives) ->
    Pos = lists:foldl(
        fun(K, Pairs) ->
            Pairs ++
                lists:foldl(
                    fun(D, SubPair) ->
                        Cost = K + D,
                        SubPair ++ [Cost]
                    end,
                    [],
                    Drives
                )
        end,
        [],
        Keyboards
    ),

    PossibleCosts = lists:filter(fun(Cost) -> Cost =< B end, Pos),
    if
        PossibleCosts /= [] -> lists:max(PossibleCosts);
        true -> -1
    end;
get_money_spent(Keyboards, Drives, B) when is_list(Keyboards) /= true, is_list(Drives) /= true ->
    get_money_spent([Keyboards], [Drives], B);
get_money_spent(Keyboards, Drives, B) when is_list(Keyboards) /= true ->
    get_money_spent([Keyboards], Drives, B);
get_money_spent(Keyboards, Drives, B) when is_list(Drives) /= true ->
    get_money_spent(Keyboards, [Drives], B).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    Bnm = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    {B, _} = string:to_integer(lists:nth(1, Bnm)),

    KeyboardsTemp = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    Keyboards = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(X),
            I
        end,
        KeyboardsTemp
    ),

    DrivesTemp = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    Drives = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(X),
            I
        end,
        DrivesTemp
    ),

    %
    % The maximum amount of money she can spend on a keyboard and USB drive, or -1 if she can't purchase both items
    %

    MoneySpent = get_money_spent(Keyboards, Drives, B),

    io:fwrite(Fptr, "~w~n", [MoneySpent]),

    file:close(Fptr),

    ok.

%%%
%%% Tests
%%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

get_money_spent_0_test() ->
    MoneySpent = get_money_spent([3, 1], [5, 2, 8], 10),
    ?assert(MoneySpent =:= 9).

get_money_spent_1_test() ->
    MoneySpent = get_money_spent(5, 4, 5),
    ?assert(MoneySpent =:= -1).
-endif.
