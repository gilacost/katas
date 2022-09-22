-module(second).

-export([main/0, readlines/1]).

main() ->
    ExpenseList = readlines("input"),
    walk_through_first(ExpenseList, ExpenseList).

walk_through_first([], _ExpenseList) ->
    erlang:error("Not found first");
walk_through_first([H1 | T1], ExpenseList) ->
    walk_through_second(ExpenseList, ExpenseList, H1),
    walk_through_first(T1, ExpenseList).

walk_through_second([], _ExpenseList2, _H1) ->
    [];
walk_through_second([H2 | T2], ExpenseList, H1) ->
    check_sum(ExpenseList, H1, H2),
    walk_through_second(T2, ExpenseList, H1).

check_sum([], H1, H2) ->
    {H1, H2};
check_sum([H3 | _T3], H1, H2) when H1 + H2 + H3 == 2020 ->
    erlang:display("IN"),
    Mul = H1 * H2 * H3,
    erlang:display(Mul),
    Mul;
check_sum([_H3 | T3], H1, H2) ->
    check_sum(T3, H1, H2).

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    BinSplit = binary:split(Data, [<<"\n">>], [global]),
    parse(BinSplit, []).

parse([], Buffer) ->
    Buffer;
parse([<<>>], Buffer) ->
    Buffer;
parse([<<H/binary>> | T], Buffer) ->
    {Number, <<>>} = string:to_integer(H),
    parse(T, [Number | Buffer]).
