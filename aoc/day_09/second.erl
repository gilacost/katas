-module(second).

-export([main/3, readlines/1]).

% second:main("input", 400480901, 616).
main(Input, Value, ValueIndex) ->
    Lines = readlines(Input),
    contiguous_sum(Lines, 2, 3, Value, ValueIndex).

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    BinSplit = binary:split(Data, [<<"\n">>], [global]),
    parse(BinSplit, [], 0).

contiguous_sum(NumberMap, PreambuleLength, CurrentIndex, Value, ValueIndex) ->
    PrevNumIndexList = lists:seq(CurrentIndex - 1, CurrentIndex - PreambuleLength, -1),
    PrevNumbers = prev_numbers(NumberMap, PrevNumIndexList),
    PrevNumbersSum = lists:sum(PrevNumbers),
    case PrevNumbersSum == Value of
        false ->
            if
                CurrentIndex =< ValueIndex ->
                    contiguous_sum(NumberMap, PreambuleLength, CurrentIndex + 1, Value, ValueIndex);
                true ->
                    NewPreambule = PreambuleLength + 1,
                    NewIndex = NewPreambule + 1,
                    contiguous_sum(NumberMap, NewPreambule, NewIndex, Value, ValueIndex)
            end;
        true ->
            erlang:error(lists:max(PrevNumbers) + lists:min(PrevNumbers))
    end.

prev_numbers(NumberMap, PrevNumIndexList) ->
    lists:map(fun(Index) -> maps:get(Index, NumberMap) end, PrevNumIndexList).

parse([<<>>], Buffer, _Index) ->
    maps:from_list(lists:reverse(Buffer));
parse([<<H/binary>> | T], Buffer, Index) ->
    {Number, <<>>} = string:to_integer(H),
    NewIndex = Index + 1,
    parse(T, [{NewIndex, Number} | Buffer], NewIndex).
