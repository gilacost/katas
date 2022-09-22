-module(solution_16).

-export([main/0]).

-import(os, [getenv/1]).

divisible_sum_pairs(_N, K, Ar) ->
    WithIndex =
        lists:zip(lists:seq(1, length(Ar)), Ar),

    Pairs = lists:foldr(
        fun({I, LeftEl}, Pairs) ->
            Pairs ++
                lists:foldr(
                    fun({J, RightEl}, ChildPairs) ->
                        Divisible = (LeftEl + RightEl) rem K == 0,
                        if
                            (I < J) and Divisible -> ChildPairs ++ [{LeftEl, RightEl}];
                            true -> ChildPairs
                        end
                    end,
                    [],
                    WithIndex
                )
        end,
        [],
        WithIndex
    ),

    length(Pairs).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    Nk = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    {N, _} = string:to_integer(lists:nth(1, Nk)),

    {K, _} = string:to_integer(lists:nth(2, Nk)),

    ArTemp = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    Ar = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(X),
            I
        end,
        ArTemp
    ),

    Result = divisible_sum_pairs(N, K, Ar),

    io:fwrite(Fptr, "~w~n", [Result]),

    file:close(Fptr),

    ok.
