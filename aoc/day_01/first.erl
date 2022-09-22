-module(first).

-export([main/0, readlines/1]).

main() ->
    ExpenseList = readlines("input"),
    walk_through(ExpenseList, ExpenseList).

walk_through([], _ExpenseList) ->
    erlang:error("Not FOuND");
walk_through([H | T], ExpenseList) ->
    check_sum(ExpenseList, H),
    walk_through(T, ExpenseList).

check_sum([], Number) ->
    Number;
check_sum([H | _T], Number) when H + Number == 2020 ->
    erlang:display("IN"),
    Mul = H * Number,
    erlang:display(Mul),
    Mul;
check_sum([_H | T], Number) ->
    check_sum(T, Number).

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
