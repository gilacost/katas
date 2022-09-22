-module(first).

-export([main/2, readlines/1]).

main(Input, PreambuleLength) ->
    Lines = readlines(Input),
    decode_by_preambule(Lines, PreambuleLength, PreambuleLength + 1).

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    BinSplit = binary:split(Data, [<<"\n">>], [global]),
    parse(BinSplit, [], 0).

decode_by_preambule(NumberMap, PreambuleLength, CurrentIndex) ->
    CurrentNumber = maps:get(CurrentIndex, NumberMap),
    PrevNumIndexList = lists:seq(CurrentIndex - 1, CurrentIndex - PreambuleLength, -1),
    PrevNumbers = prev_numbers(NumberMap, PrevNumIndexList),
    case is_sum_of_prev_nums(PrevNumbers, CurrentNumber) of
        false -> erlang:error(CurrentNumber);
        true -> decode_by_preambule(NumberMap, PreambuleLength, CurrentIndex + 1)
    end.

is_sum_of_prev_nums(PrevNumbers, CurrentNumber) ->
    PrevCombinations = [X + Y || X <- PrevNumbers, Y <- lists:reverse(PrevNumbers)],
    lists:member(CurrentNumber, PrevCombinations).

prev_numbers(NumberMap, PrevNumIndexList) ->
    lists:map(fun(Index) -> maps:get(Index, NumberMap) end, PrevNumIndexList).

parse([<<>>], Buffer, _Index) ->
    maps:from_list(lists:reverse(Buffer));
parse([<<H/binary>> | T], Buffer, Index) ->
    {Number, <<>>} = string:to_integer(H),
    NewIndex = Index + 1,
    parse(T, [{NewIndex, Number} | Buffer], NewIndex).
