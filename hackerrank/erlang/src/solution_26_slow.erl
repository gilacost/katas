-module(solution_26_slow).

-export([main/0]).

-import(os, [getenv/1]).

picking_numbers(A) ->
    CombinationList = combinations(A),
    lists:foldl(
        fun(Combination, Longest) ->
            UniquePairs = unique(pairs(Combination)),
            case {absolute_difference(UniquePairs), length(Combination)} of
                {AD, CombLength} when AD == 1, CombLength > Longest ->
                    CombLength;
                _ ->
                    Longest
            end
        end,
        0,
        CombinationList
    ).

combinations([]) ->
    [];
combinations([H | T]) ->
    CT = combinations(T),
    [[H]] ++ [[H | CT1] || CT1 <- CT] ++ CT.

absolute_difference(List) -> lists:sum([abs(A - B) || [A, B] <- List]).

pairs(L) -> [[X, Y] || X <- L, Y <- L, X =/= Y].

unique(L) -> lists:usort([lists:sort(X) || X <- L]).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    {_N, _} = string:to_integer(
        re:replace(io:get_line(""), "(^\\s+)|(\\s+$)", "", [global, {return, list}])
    ),

    ATemp = re:split(re:replace(io:get_line(""), "\\s+$", "", [global, {return, list}]), "\\s+", [
        {return, list}
    ]),

    A = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(
                re:replace(X, "(^\\s+)|(\\s+$)", "", [global, {return, list}])
            ),
            I
        end,
        ATemp
    ),

    Result = picking_numbers(A),

    io:fwrite(Fptr, "~w~n", [Result]),

    file:close(Fptr),

    ok.

%%%
%%% Tests
%%%
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

combinations_test() ->
    Array = [1, 2, 3],
    Expected = [[1], [1, 2], [1, 2, 3], [1, 3], [2], [2, 3], [3]],
    Result = combinations(Array),
    ?assert(Expected =:= Result).

% get_pairs_test() ->
%     Array = [[1], [2, 3], [1, 2, 3]],
%     Expected = [[2, 3]],
%     Result = pairs(Array),
%     ?assert(Expected =:= Result).

% absolute_difference_test() ->
%     Array = [[4, 3], [3, 3]],
%     ?assert(absolute_difference(Array) =:= 1),

%     Array1 = [[1, 2], [1, 1], [2, 2]],
%     ?assert(absolute_difference(Array1) =:= 1).

% remove_dups_test() ->
%     CombList = combinations([1, 2, 2, 1, 2]),
%     Pairs = pairs(CombList),
%     UniquePairs = unique(Pairs),
%     Expected = [[1, 2], [1, 1], [2, 2]],
%     ?assert(UniquePairs =:= Expected).

% picking_numbers_test() ->
%     Array = [4, 6, 5, 3, 3, 1],
%     ?assert(picking_numbers(Array) =:= 3),

%     Array1 = [1, 2, 2, 3, 1, 2],
%     ?assert(picking_numbers(Array1) =:= 5).

-endif.

%
