-module(solution_14).

-export([main/0]).

-import(os, [getenv/1]).

breaking_records(Scores) ->
    {_, Max, Min} =
        lists:foldl(
            fun(Score, {PrevScoresAcc, BreakMaxCount, BreakMinCount}) ->
                if
                    length(PrevScoresAcc) == 0 ->
                        ScoresAcc = PrevScoresAcc ++ [Score],
                        {ScoresAcc, BreakMaxCount, BreakMinCount};
                    true ->
                        CurrentMin = lists:min(PrevScoresAcc),
                        CurrentMax = lists:max(PrevScoresAcc),
                        {BMaxC, BMinC} =
                            if
                                CurrentMax < Score ->
                                    {BreakMaxCount + 1, BreakMinCount};
                                true ->
                                    if
                                        CurrentMin > Score ->
                                            {BreakMaxCount, BreakMinCount + 1};
                                        true ->
                                            {BreakMaxCount, BreakMinCount}
                                    end
                            end,

                        ScoresAcc = PrevScoresAcc ++ [Score],

                        {ScoresAcc, BMaxC, BMinC}
                end
            end,
            {[], 0, 0},
            Scores
        ),
    erlang:display([Min, Max]),
    [Max, Min].

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    {_N, _} = string:to_integer(string:chomp(io:get_line(""))),

    ScoresTemp = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    Scores = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(X),
            I
        end,
        ScoresTemp
    ),

    Result = breaking_records(Scores),

    io:fwrite(Fptr, "~s~n", [lists:join(" ", lists:map(fun(X) -> integer_to_list(X) end, Result))]),

    file:close(Fptr),

    ok.
