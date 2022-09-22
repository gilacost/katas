-module(first).

-export([main/0, readlines/1]).

main() ->
    Lines = readlines("input"),
    erlang:display(Lines).

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    BinSplit = binary:split(Data, [<<"\n">>], [global]),
    {_, Max} = parse(BinSplit, [], 0),
    erlang:display(Max).

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

parse([<<>>], Buffer, MaxId) ->
    {lists:reverse(Buffer), MaxId};
parse([<<Row:7/binary, Column:3/binary>> | T], Buffer, MaxId) ->
    RowCalc = binary_partition(Row, {0, 127}),
    ColCalc = binary_partition(Column, {0, 7}),
    Id = (RowCalc * 8) + ColCalc,
    print_id(Id, RowCalc, ColCalc),

    parse(T, [{RowCalc, ColCalc, Id} | Buffer], max(Id, MaxId)).

print_id(1, RowCalc, ColCalc) -> erlang:display({RowCalc, ColCalc});
print_id(-1, RowCalc, ColCalc) -> erlang:display({RowCalc, ColCalc}).
