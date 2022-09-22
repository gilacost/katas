-module(diamond).

-export([rows/1, alphabet/0, even_print/1]).

rows(Letter) ->
    Letters = (alphabet() -- string:find(alphabet(), Letter)) ++ Letter,
    LettersLength = length(Letters),
    Top = lists:map(
        fun(L) ->
            lists:flatten(pad([L], LettersLength))
        end,
        Letters
    ),
    Top ++ lists:reverse(lists:droplast(Top)).

pad("A", Length) ->
    LeftPad = string:pad("A", Length, leading, " "),
    RightPad = string:pad("", Length - 1, trailing, " "),
    string:concat(LeftPad, RightPad);
pad(Str, Length) ->
    LetterPos = string:str(alphabet(), Str) - 1,
    LeftPad = string:pad(Str, Length - LetterPos, leading, " "),
    RightPad = string:pad("", LetterPos, trailing, " "),

    First = string:concat(LeftPad, RightPad),
    string:concat(First, string:reverse(lists:droplast(First))).

alphabet() ->
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ".

even_print([]) ->
    [];
even_print([H | T]) when H rem 2 /= 0 ->
    even_print(T);
even_print([H | T]) ->
    io:format("printing: ~p~n", [H]),
    [H | even_print(T)].
