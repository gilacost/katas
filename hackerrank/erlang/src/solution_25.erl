-module(solution_25).

-export([main/0]).

-import(os, [getenv/1]).

magic_squares_for_3x3() ->
    [
        [
            [6, 1, 8],
            [7, 5, 3],
            [2, 9, 4]
        ],

        [
            [8, 1, 6],
            [3, 5, 7],
            [4, 9, 2]
        ],

        [
            [6, 7, 2],
            [1, 5, 9],
            [8, 3, 4]
        ],

        [
            [8, 3, 4],
            [1, 5, 9],
            [6, 7, 2]
        ],

        [
            [2, 7, 6],
            [9, 5, 1],
            [4, 3, 8]
        ],

        [
            [4, 3, 8],
            [9, 5, 1],
            [2, 7, 6]
        ],

        [
            [2, 9, 4],
            [7, 5, 3],
            [6, 1, 8]
        ],

        [
            [4, 9, 2],
            [3, 5, 7],
            [8, 1, 6]
        ]
    ].

forming_magic_square([[R00, R01, R02], [R10, R11, R12], [R20, R21, R22]]) ->
    Costs = lists:map(
        fun([[M00, M01, M02], [M10, M11, M12], [M20, M21, M22]]) ->
            lists:sum([
                abs(M00 - R00),
                abs(M01 - R01),
                abs(M02 - R02),
                abs(M10 - R10),
                abs(M11 - R11),
                abs(M12 - R12),
                abs(M20 - R20),
                abs(M21 - R21),
                abs(M22 - R22)
            ])
        end,
        magic_squares_for_3x3()
    ),
    lists:min(Costs).

read_multiple_lines_as_list_of_strings(N) ->
    read_multiple_lines_as_list_of_strings(N, []).

read_multiple_lines_as_list_of_strings(0, Acc) ->
    lists:reverse(Acc);
read_multiple_lines_as_list_of_strings(N, Acc) when N > 0 ->
    read_multiple_lines_as_list_of_strings(N - 1, [string:chomp(io:get_line("")) | Acc]).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    STemp = read_multiple_lines_as_list_of_strings(3),

    S = lists:map(
        fun(X) ->
            lists:map(
                fun(Y) ->
                    {I, _} = string:to_integer(Y),
                    I
                end,
                re:split(X, "\\s+", [{return, list}, trim])
            )
        end,
        STemp
    ),

    Result = forming_magic_square(S),
    erlang:display(Result),

    io:fwrite(Fptr, "~w~n", [Result]),

    file:close(Fptr),

    ok.

%%%
%%% Tests
%%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

forming_magic_square_0_test() ->
    Matrix = [[4, 9, 2], [3, 5, 7], [8, 1, 5]],
    MinimumCost = forming_magic_square(Matrix),
    ?assert(MinimumCost =:= 1).

forming_magic_square_1_test() ->
    Matrix = [[4, 8, 2], [4, 5, 7], [6, 1, 6]],
    MinimumCost = forming_magic_square(Matrix),
    ?assert(MinimumCost =:= 4).

forming_magic_square_2_test() ->
    Matrix = [[4, 5, 8], [2, 4, 1], [1, 9, 7]],
    MinimumCost = forming_magic_square(Matrix),
    ?assert(MinimumCost =:= 14).

-endif.
