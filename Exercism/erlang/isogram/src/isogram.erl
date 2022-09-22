-module(isogram).

-export([is_isogram/1]).

is_isogram(Phrase) ->
    OnlyCharacters = clean_hypens_and_empty_spaces(Phrase, []),
    UniqLowerChars = sets:to_list(sets:from_list(string:to_lower(OnlyCharacters))),
    length(UniqLowerChars) == length(OnlyCharacters).

clean_hypens_and_empty_spaces([], Buffer) ->
    lists:flatten(Buffer);
clean_hypens_and_empty_spaces([H | T], Buffer) when H == 32 ->
    clean_hypens_and_empty_spaces(T, Buffer);
clean_hypens_and_empty_spaces([H | T], Buffer) when H == 45 ->
    clean_hypens_and_empty_spaces(T, Buffer);
clean_hypens_and_empty_spaces([H | T], Buffer) ->
    clean_hypens_and_empty_spaces(T, [Buffer | [H]]).
