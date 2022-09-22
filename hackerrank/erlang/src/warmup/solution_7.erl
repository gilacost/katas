-module(solution_7).

-export([main/0]).

% Complete the staircase function below.
staircase(N) ->
    Enum = lists:seq(1, N),

    lists:map(
        fun(I) ->
            LineContent = lists:duplicate(N - I, "\s") ++ lists:duplicate(I, "#"),
            Line = "~s~n",
            io:fwrite(io_lib:format(Line, [lists:concat(LineContent)]))
        end,
        Enum
    ).

main() ->
    {N, _} = string:to_integer(string:chomp(io:get_line(""))),

    staircase(N),

    ok.
