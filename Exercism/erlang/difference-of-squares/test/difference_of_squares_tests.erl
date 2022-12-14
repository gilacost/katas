%% Generated with 'testgen v0.2.0'
%% Revision 1 of the exercises generator was used
%% https://github.com/exercism/problem-specifications/raw/42dd0cea20498fd544b152c4e2c0a419bb7e266a/exercises/difference-of-squares/canonical-data.json
%% This file is automatically generated from the exercises canonical data.

-module(difference_of_squares_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

'1_square_of_sum_1_test_'() ->
    {"square of sum 1", ?_assertEqual(1, difference_of_squares:square_of_sum(1))}.

'2_square_of_sum_5_test_'() ->
    {"square of sum 5", ?_assertEqual(225, difference_of_squares:square_of_sum(5))}.

'3_square_of_sum_100_test_'() ->
    {"square of sum 100", ?_assertEqual(25502500, difference_of_squares:square_of_sum(100))}.

'4_sum_of_squares_1_test_'() ->
    {"sum of squares 1", ?_assertEqual(1, difference_of_squares:sum_of_squares(1))}.

'5_sum_of_squares_5_test_'() ->
    {"sum of squares 5", ?_assertEqual(55, difference_of_squares:sum_of_squares(5))}.

'6_sum_of_squares_100_test_'() ->
    {"sum of squares 100", ?_assertEqual(338350, difference_of_squares:sum_of_squares(100))}.

'7_difference_of_squares_1_test_'() ->
    {"difference of squares 1", ?_assertEqual(0, difference_of_squares:difference_of_squares(1))}.

'8_difference_of_squares_5_test_'() ->
    {"difference of squares 5", ?_assertEqual(170, difference_of_squares:difference_of_squares(5))}.

'9_difference_of_squares_100_test_'() ->
    {"difference of squares 100",
        ?_assertEqual(25164150, difference_of_squares:difference_of_squares(100))}.
