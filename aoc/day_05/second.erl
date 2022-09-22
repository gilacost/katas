-module(second).

-export([main/0, readlines/1]).

main() ->
    Lines = readlines("input"),
    erlang:display(Lines).

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    BinSplit = binary:split(Data, [<<"\n">>], [global]),
    {_, IdList, _Max} = parse(BinSplit, [], [], 0),
    [Prev | _T] = IdList,
    FreeSeatId = free_seat_id(IdList, Prev - 1),
    erlang:display(FreeSeatId).

free_seat_id([], _Prev) -> erlang:error("Not found");
free_seat_id([H | T], Prev) when (H - Prev) == 1 -> free_seat_id(T, H);
free_seat_id([H | _T], Prev) -> (H + Prev) div 2.

binary_partition(<<>>, {_Initial, Final}) ->
    Final;
binary_partition(<<H, T/binary>>, {Initial, Final}) ->
    binary_partition(T, upper_lower(<<H>>, Initial, Final)).

upper_lower(<<"B">>, Initial, Final) ->
    upper(Initial, Final);
upper_lower(<<"F">>, Initial, Final) ->
    lower(Initial, Final);
upper_lower(<<"R">>, Initial, Final) ->
    upper(Initial, Final);
upper_lower(<<"L">>, Initial, Final) ->
    lower(Initial, Final).

upper(Initial, Final) -> {ceil((Initial + Final) / 2), Final}.

lower(Initial, Final) -> {Initial, (Final + Initial) div 2}.

parse([<<>>], Seats, IdList, MaxId) ->
    {lists:reverse(Seats), lists:sort(IdList), MaxId};
parse([<<Row:7/binary, Column:3/binary>> | T], Seats, IdList, MaxId) ->
    RowCalc = binary_partition(Row, {0, 127}),
    ColCalc = binary_partition(Column, {0, 7}),
    Id = (RowCalc * 8) + ColCalc,

    parse(T, [{RowCalc, ColCalc, Id} | Seats], [Id | IdList], max(Id, MaxId)).
