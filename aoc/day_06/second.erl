-module(second).

-export([main/0, readlines/1]).

main() ->
    Lines = readlines("input"),
    count_answers(Lines, 0).

count_answers([], Acc) ->
    Acc;
count_answers([H | T], Acc) when length(H) == 1 ->
    [GroupUniqAns] = sets:to_list(sets:from_list(H)),
    count_answers(T, Acc + length(GroupUniqAns));
count_answers([H | T], Acc) ->
    SetList = to_set_list(H, []),
    Intersection = sets:to_list(sets:intersection(SetList)),
    CurrentGroupAnswers = length(Intersection),
    count_answers(T, Acc + CurrentGroupAnswers).

to_set_list([], SetList) -> SetList;
to_set_list([H | T], SetList) -> to_set_list(T, [sets:from_list(H) | SetList]).

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    BinSplit = binary:split(Data, [<<"\n\n">>], [global]),
    parse(BinSplit, []).

parse([], Buffer) ->
    lists:reverse(Buffer);
parse([<<H/binary>> | T], Buffer) ->
    Line = binary:bin_to_list(H),
    LineTrimed = string:trim(Line),
    Group = string:split(LineTrimed, "\n", all),

    parse(T, [Group | Buffer]).
