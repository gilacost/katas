%% Generated with 'testgen v0.2.0'
%% Revision 1 of the exercises generator was used
%% https://github.com/exercism/problem-specifications/raw/42dd0cea20498fd544b152c4e2c0a419bb7e266a/exercises/pangram/canonical-data.json
%% This file is automatically generated from the exercises canonical data.

-module(pangram_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

'1_empty_sentence_test_'() ->
    {"empty sentence", ?_assertNot(pangram:is_pangram([]))}.

'2_perfect_lower_case_test_'() ->
    {"perfect lower case", ?_assert(pangram:is_pangram("abcdefghijklmnopqrstuvwxyz"))}.

'3_only_lower_case_test_'() ->
    {"only lower case",
        ?_assert(
            pangram:is_pangram(
                "the quick brown fox jumps over the lazy "
                "dog"
            )
        )}.

'4_missing_the_letter_x_test_'() ->
    {"missing the letter 'x'",
        ?_assertNot(
            pangram:is_pangram(
                "a quick movement of the enemy will jeopardize "
                "five gunboats"
            )
        )}.

'5_missing_the_letter_h_test_'() ->
    {"missing the letter 'h'",
        ?_assertNot(pangram:is_pangram("five boxing wizards jump quickly at it"))}.

'6_with_underscores_test_'() ->
    {"with underscores",
        ?_assert(pangram:is_pangram("the_quick_brown_fox_jumps_over_the_lazy_dog"))}.

'7_with_numbers_test_'() ->
    {"with numbers",
        ?_assert(
            pangram:is_pangram(
                "the 1 quick brown fox jumps over the "
                "2 lazy dogs"
            )
        )}.

'8_missing_letters_replaced_by_numbers_test_'() ->
    {"missing letters replaced by numbers",
        ?_assertNot(
            pangram:is_pangram(
                "7h3 qu1ck brown fox jumps ov3r 7h3 lazy "
                "dog"
            )
        )}.

'9_mixed_case_and_punctuation_test_'() ->
    {"mixed case and punctuation",
        ?_assert(
            pangram:is_pangram(
                "\"Five quacking Zephyrs jolt my wax "
                "bed.\""
            )
        )}.

'10_case_insensitive_test_'() ->
    {"case insensitive",
        ?_assertNot(
            pangram:is_pangram(
                "the quick brown fox jumps over with "
                "lazy FX"
            )
        )}.
