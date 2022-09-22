-module(bracket_push).

-export([is_paired/1, in/2]).

is_paired(String) ->
    case erl_eval:eval_str(String ++ ".\n") of
        {ok, _R} ->
            true;
        _ ->
            IsLatex = in(String, "left"),
            if
                IsLatex ->
                    true;
                true ->
                    {WellFormatted, OpenClosePairsCount} = walk_through(
                        String,
                        " ",
                        true,
                        {0, 0, 0}
                    ),
                    WellFormatted and (OpenClosePairsCount == {0, 0, 0})
            end
    end.

walk_through([], _Prev, IsPaired, OpenClosePairsCount) ->
    {IsPaired, OpenClosePairsCount};
walk_through([_H | T], Prev, false, OpenClosePairsCount) ->
    walk_through(T, Prev, false, OpenClosePairsCount);
walk_through([32 | T], Prev, IsPaired, OpenClosePairsCount) ->
    walk_through(T, Prev, IsPaired, OpenClosePairsCount);
walk_through([40 | T], Prev, IsPaired, OpenClosePairsCount) ->
    NewOpenClosePairsCount = count_open_close_pairs([40], OpenClosePairsCount),
    walk_through(T, Prev, IsPaired, NewOpenClosePairsCount);
walk_through([41 | T], Prev, IsPaired, OpenClosePairsCount) ->
    erlang:display("entro )"),
    NewOpenClosePairsCount = count_open_close_pairs([41], OpenClosePairsCount),
    walk_through(T, Prev, IsPaired, NewOpenClosePairsCount);
walk_through([H | T], " ", _IsPaired, OpenClosePairsCount) ->
    IsOpening = in("([{", [H]),
    NewOpenClosePairsCount = count_open_close_pairs([H], OpenClosePairsCount),
    walk_through(T, [H], IsOpening, NewOpenClosePairsCount);
walk_through([H | T], Prev, _IsPaired, OpenClosePairsCount) ->
    IsOpening = in("([{", [H]),
    ClosesWithExpected = closes(Prev, [H]),
    NewOpenClosePairsCount = count_open_close_pairs([H], OpenClosePairsCount),
    IsPaired = IsOpening or ClosesWithExpected,

    walk_through(T, [H], IsPaired, NewOpenClosePairsCount).

closes("]", ")") ->
    true;
closes("]", "]") ->
    true;
closes("}", ")") ->
    true;
closes(")", ")") ->
    true;
closes("(", ")") ->
    true;
closes("[", "]") ->
    true;
closes("{", "}") ->
    true;
closes(_Prev, _Next) ->
    false.

count_open_close_pairs("(", {P, L, C}) -> {P + 1, L, C};
count_open_close_pairs("[", {P, L, C}) -> {P, L + 1, C};
count_open_close_pairs("{", {P, L, C}) -> {P, L, C + 1};
count_open_close_pairs(")", {P, L, C}) -> {P - 1, L, C};
count_open_close_pairs("]", {P, L, C}) -> {P, L - 1, C};
count_open_close_pairs("}", {P, L, C}) -> {P, L, C - 1}.

in(List, Char) ->
    % TODO exact length substracted
    length(List -- Char) /= length(List).
