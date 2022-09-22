-module(solution_19).

-export([main/0]).

% bill: an array of integers representing the cost of each item ordered
% k: an integer representing the zero-based index of the item Anna doesn't eat
% b: the amount of money that Anna contributed to the bill
bon_appetit(Bill, K, B) ->
    SubBill = Bill -- [lists:nth(K + 1, Bill)],
    SubBillCost = lists:sum(SubBill) / 2,
    if
        B /= SubBillCost ->
            integer_to_list(trunc(B - SubBillCost));
        true ->
            "Bon Appetit"
    end.

main() ->
    Nk = re:split(re:replace(io:get_line(""), "\\s+$", "", [global, {return, list}]), "\\s+", [
        {return, list}
    ]),

    {_N, _} = string:to_integer(lists:nth(1, Nk)),

    {K, _} = string:to_integer(lists:nth(2, Nk)),

    BillTemp = re:split(
        re:replace(io:get_line(""), "\\s+$", "", [global, {return, list}]),
        "\\s+",
        [{return, list}]
    ),

    Bill = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(
                re:replace(X, "(^\\s+)|(\\s+$)", "", [global, {return, list}])
            ),
            I
        end,
        BillTemp
    ),

    {B, _} = string:to_integer(
        re:replace(io:get_line(""), "(^\\s+)|(\\s+$)", "", [global, {return, list}])
    ),

    Result = bon_appetit(Bill, K, B),

    io:format("~s", [Result]),

    ok.
