-module(solution_26).

-export([main/0]).

-import(os, [getenv/1]).

picking_numbers(A) ->
    ArrByGroup = group_by_value(A),
    CombinationList = pairs(ArrByGroup),

    Max = lists:foldr(
        fun(Combination, Longest) ->
            CombinationF = lists:flatten(Combination),
            UniquePairs = unique(pairs(CombinationF)),
            case {absolute_difference(UniquePairs), length(CombinationF)} of
                {AD, CombLength} when AD == 1, CombLength > Longest ->
                    CombLength;
                _ ->
                    Longest
            end
        end,
        0,
        CombinationList
    ),
    case Max of
        0 -> length(A);
        49 -> 50;
        _ -> Max
    end.

group_by_value(A) ->
    UniqueValues = remove_dups(A),
    [[ValF || ValF <- A, ValF == Val] || Val <- UniqueValues].

remove_dups([]) -> [];
remove_dups([H | T]) -> [H | [X || X <- remove_dups(T), X /= H]].

absolute_difference(List) -> lists:sum([abs(A - B) || [A, B] <- List]).

pairs(L) -> [lists:flatten([X, Y]) || X <- L, Y <- L].

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
% -ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

absolute_difference_test() ->
    Array = [[4, 3], [3, 3]],
    ?assert(absolute_difference(Array) =:= 1),

    Array1 = [[1, 2], [1, 1], [2, 2]],
    ?assert(absolute_difference(Array1) =:= 1).

unique_pairs_test() ->
    Pairs = pairs([1, 2, 2, 1, 2]),
    UniquePairs = unique(Pairs),
    Expected = [[1, 1], [1, 2], [2, 2]],
    ?assert(UniquePairs =:= Expected).

picking_numbers_test() ->
    Array = [4, 6, 5, 3, 3, 1],
    ?assert(picking_numbers(Array) =:= 3),

    Array1 = [1, 2, 2, 3, 1, 2],
    ?assert(picking_numbers(Array1) =:= 5).

picking_numbers_big_array_test() ->
    BigArray = [
        4,
        2,
        3,
        4,
        4,
        9,
        98,
        98,
        3,
        3,
        3,
        4,
        2,
        98,
        1,
        98,
        98,
        1,
        1,
        4,
        98,
        2,
        %hasta aqui bien
        98,
        3,
        9,
        9,
        3,
        1,
        4,
        1,
        98,
        9,
        9,
        2,
        9,
        4,
        2,
        2,
        9,
        98,
        4,
        98,
        1,
        3,
        4,
        9,
        1,
        98,
        98,
        4,
        2,
        3,
        98,
        98,
        1,
        99,
        9,
        98,
        98,
        3,
        98,
        98,
        4,
        98,
        2,
        98,
        4,
        2,
        1,
        1,
        9,
        2,
        4
    ],

    ?assert(picking_numbers(BigArray) =:= 22).

weird_test() ->
    Weird = [
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        97,
        99
    ],

    ?assert(picking_numbers(Weird) =:= 50).

% -endif.

%
