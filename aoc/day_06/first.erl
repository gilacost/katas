-module(first).

-export([main/0, readlines/1, remove_dups/1]).

main() ->
    Lines = readlines("input"),
    erlang:display(Lines),
    count_answers(Lines, 0).

count_answers([], Acc) ->
    Acc;
count_answers([H | T], Acc) when length(H) == 1 ->
    CurrentGroupAnswers = remove_dups(lists:flatten(H)),
    count_answers(T, Acc + length(CurrentGroupAnswers));
count_answers([H | T], Acc) ->
    CurrentGroupAnswers = remove_dups(string:join(H, "")),
    count_answers(T, Acc + length(CurrentGroupAnswers)).

remove_dups([]) -> [];
remove_dups([H | T]) -> [H | [X || X <- remove_dups(T), X /= H]].

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    BinSplit = binary:split(Data, [<<"\n\n">>], [global]),
    parse(BinSplit, []).

parse([], Buffer) ->
    lists:reverse(Buffer);
parse([<<H/binary>> | T], Buffer) ->
    Line = binary:bin_to_list(H),
    LineTrimed = string:trim(Line),
    Persons = string:split(LineTrimed, "\n", all),

    parse(T, [Persons | Buffer]).
