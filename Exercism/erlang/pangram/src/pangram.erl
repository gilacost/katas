-module(pangram).

-export([is_pangram/1]).

is_pangram(Sentence) ->
    LoSentence = string:lowercase(Sentence),
    length(walk_through(LoSentence, alphabet())) == 0.

walk_through([], Alphabet) -> Alphabet;
walk_through([H | T], Alphabet) -> walk_through(T, Alphabet -- [H]).

alphabet() ->
    "abcdefghijklmnopqrstuvwxyz".
