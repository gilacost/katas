-module(first).

-export([main/0, readlines/1]).

main() ->
    {BinSplit, Lines} = readlines("input"),
    Tobbogan = parse(BinSplit, [], Lines * 4),
    erlang:display(slide(Tobbogan, {0, 0}, 0)).

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    BinSplit = binary:split(Data, [<<"\n">>], [global]),
    Lines = length(BinSplit),
    erlang:display(Lines),
    {BinSplit, Lines}.

slide([], {O, X}, _CurrentLine) ->
    {O, X};
slide([_H | T], Count, 0) ->
    slide(T, Count, 1);
slide([H | T], Count, CurrentLine) ->
    ElementAtPosition = lists:nth((CurrentLine * 3) + 1, H),
    NewCount = maybe_tree([ElementAtPosition], Count),
    slide(T, NewCount, CurrentLine + 1).

maybe_tree(".", {O, X}) -> {O + 1, X};
maybe_tree("#", {O, X}) -> {O, X + 1}.

parse([<<>>], Buffer, _PatternReps) ->
    lists:reverse(Buffer);
parse([<<H/binary>> | T], Buffer, PatternReps) ->
    Line = binary:bin_to_list(H),
    Reps = ceil(PatternReps / (length(Line))),
    LineRepeated = string:copies(Line, Reps),
    parse(T, [LineRepeated | Buffer], PatternReps).
