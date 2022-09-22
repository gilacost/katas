-module(first).

-export([main/1, readlines/1]).

main(Input) ->
    Adapters = readlines(Input),
    Max = lists:max(Adapters),
    use_adapters(Adapters, {0, 0, 1}, 0, Max).

use_adapters(
    Adapters,
    {OneJoltJmps, TwoJoltJmp, ThreeJoltJmps} = Jmps,
    CurrentJoltage,
    MaxJoltAdapter
) ->
    {NewJmps, JoltageInc} =
        case next_jumps(Adapters, CurrentJoltage) of
            {true, _, _} ->
                {{OneJoltJmps + 1, TwoJoltJmp, ThreeJoltJmps}, 1};
            {false, true, _} ->
                {{OneJoltJmps, TwoJoltJmp + 1, ThreeJoltJmps}, 2};
            {false, false, true} ->
                {{OneJoltJmps, TwoJoltJmp, ThreeJoltJmps + 1}, 3};
            _ ->
                erlang:display(Jmps),
                erlang:display(OneJoltJmps * ThreeJoltJmps),
                erlang:error(CurrentJoltage)
        end,
    use_adapters(Adapters, NewJmps, CurrentJoltage + JoltageInc, MaxJoltAdapter);
use_adapters(_, Jmps, CurrentJoltage, MaxJoltAdapter) when CurrentJoltage >= MaxJoltAdapter + 3 ->
    io:format("Jmps: ~p~nCurrentJoltage: ~p~n", [Jmps, CurrentJoltage]).

next_jumps(Adapters, CurrentJoltage) ->
    {
        lists:member(CurrentJoltage + 1, Adapters),
        lists:member(CurrentJoltage + 2, Adapters),
        lists:member(CurrentJoltage + 3, Adapters)
    }.

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    BinSplit = binary:split(Data, [<<"\n">>], [global]),
    parse(BinSplit, []).

parse([<<>>], Buffer) ->
    lists:sort(Buffer);
parse([<<H/binary>> | T], Buffer) ->
    {Number, <<>>} = string:to_integer(H),
    parse(T, [Number | Buffer]).
