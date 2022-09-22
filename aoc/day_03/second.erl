-module(second).

-export([main/0, readlines/1]).

main() ->
    {BinSplit, Lines} = readlines("input"),
    Tobbogan = parse(BinSplit, [], Lines * 12),
    erlang:display(
        slide(Tobbogan, {0, 0}, 0, {1, 1}) *
            slide(Tobbogan, {0, 0}, 0, {3, 1}) *
            slide(Tobbogan, {0, 0}, 0, {5, 1}) *
            slide(Tobbogan, {0, 0}, 0, {7, 1}) *
            slide(Tobbogan, {0, 0}, 0, {1, 2})
    ).

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    BinSplit = binary:split(Data, [<<"\n">>], [global]),
    Lines = length(BinSplit),
    {BinSplit, Lines}.

slide([], {_O, X}, _CurrentLine, _DownRight) ->
    X;
slide([H | T], Count, CurrentLine, {_R, 2} = DownRight) when
    CurrentLine > 1, CurrentLine rem 2 == 0
->
    ElementAtPosition = lists:nth((CurrentLine div 2) + 1, H),
    NewCount = maybe_tree([ElementAtPosition], Count),
    slide(T, NewCount, CurrentLine + 1, DownRight);
slide([_H | T], Count, CurrentLine, {_R, 2} = DownRight) ->
    slide(T, Count, CurrentLine + 1, DownRight);
slide([H | T], Count, CurrentLine, {R, _D} = DownRight) ->
    ElementAtPosition = lists:nth((CurrentLine * R) + 1, H),
    NewCount = maybe_tree([ElementAtPosition], Count),
    slide(T, NewCount, CurrentLine + 1, DownRight).

maybe_tree(".", {O, X}) -> {O + 1, X};
maybe_tree("#", {O, X}) -> {O, X + 1};
maybe_tree(_, _) -> erlang:error("something went wrong").

parse([<<>>], Buffer, _PatternReps) ->
    lists:reverse(Buffer);
parse([<<H/binary>> | T], Buffer, PatternReps) ->
    Line = binary:bin_to_list(H),
    Reps = ceil(PatternReps / (length(Line))),
    LineRepeated = string:copies(Line, Reps),
    parse(T, [LineRepeated | Buffer], PatternReps).
