%% Generated with 'testgen v0.2.0'
%% Revision 1 of the exercises generator was used
%% https://github.com/exercism/problem-specifications/raw/42dd0cea20498fd544b152c4e2c0a419bb7e266a/exercises/custom-set/canonical-data.json
%% This file is automatically generated from the exercises canonical data.

-module(custom_set_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

'1_empty_sets_are_equal_test_'() ->
    {"empty sets are equal",
        ?_assert(
            custom_set:equal(
                custom_set:from_list([]),
                custom_set:from_list([])
            )
        )}.

'2_empty_set_is_not_equal_to_non_empty_set_test_'() ->
    {"empty set is not equal to non-empty "
        "set",
        ?_assertNot(
            custom_set:equal(
                custom_set:from_list([]),
                custom_set:from_list([1, 2, 3])
            )
        )}.

'3_non_empty_set_is_not_equal_to_empty_set_test_'() ->
    {"non-empty set is not equal to empty "
        "set",
        ?_assertNot(
            custom_set:equal(
                custom_set:from_list([
                    1,
                    2,
                    3
                ]),
                custom_set:from_list([])
            )
        )}.

'4_sets_with_the_same_elements_are_equal_test_'() ->
    {"sets with the same elements are equal",
        ?_assert(
            custom_set:equal(
                custom_set:from_list([1, 2]),
                custom_set:from_list([2, 1])
            )
        )}.

'5_sets_with_different_elements_are_not_equal_test_'() ->
    {"sets with different elements are not "
        "equal",
        ?_assertNot(
            custom_set:equal(
                custom_set:from_list([
                    1,
                    2,
                    3
                ]),
                custom_set:from_list([1, 2, 4])
            )
        )}.

'6_set_is_not_equal_to_larger_set_with_same_elements_test_'() ->
    {"set is not equal to larger set with "
        "same elements",
        ?_assertNot(
            custom_set:equal(
                custom_set:from_list([
                    1,
                    2,
                    3
                ]),
                custom_set:from_list([1, 2, 3, 4])
            )
        )}.

'7_sets_with_no_elements_are_empty_test_'() ->
    {"sets with no elements are empty", ?_assert(custom_set:empty(custom_set:from_list([])))}.

'8_sets_with_elements_are_not_empty_test_'() ->
    {"sets with elements are not empty", ?_assertNot(custom_set:empty(custom_set:from_list([1])))}.

'9_nothing_is_contained_in_an_empty_set_test_'() ->
    {"nothing is contained in an empty set",
        ?_assertNot(
            custom_set:contains(
                1,
                custom_set:from_list([])
            )
        )}.

'10_when_the_element_is_in_the_set_test_'() ->
    {"when the element is in the set",
        ?_assert(
            custom_set:contains(
                1,
                custom_set:from_list([1, 2, 3])
            )
        )}.

'11_when_the_element_is_not_in_the_set_test_'() ->
    {"when the element is not in the set",
        ?_assertNot(
            custom_set:contains(
                4,
                custom_set:from_list([1, 2, 3])
            )
        )}.

'12_empty_set_is_a_subset_of_another_empty_set_test_'() ->
    {"empty set is a subset of another empty "
        "set",
        ?_assert(
            custom_set:subset(
                custom_set:from_list([]),
                custom_set:from_list([])
            )
        )}.

'13_empty_set_is_a_subset_of_non_empty_set_test_'() ->
    {"empty set is a subset of non-empty set",
        ?_assert(
            custom_set:subset(
                custom_set:from_list([]),
                custom_set:from_list([1])
            )
        )}.

'14_non_empty_set_is_not_a_subset_of_empty_set_test_'() ->
    {"non-empty set is not a subset of empty "
        "set",
        ?_assertNot(
            custom_set:subset(
                custom_set:from_list([1]),
                custom_set:from_list([])
            )
        )}.

'15_set_is_a_subset_of_set_with_exact_same_elements_test_'() ->
    {"set is a subset of set with exact same "
        "elements",
        ?_assert(
            custom_set:subset(
                custom_set:from_list([
                    1,
                    2,
                    3
                ]),
                custom_set:from_list([1, 2, 3])
            )
        )}.

'16_set_is_a_subset_of_larger_set_with_same_elements_test_'() ->
    {"set is a subset of larger set with same "
        "elements",
        ?_assert(
            custom_set:subset(
                custom_set:from_list([
                    1,
                    2,
                    3
                ]),
                custom_set:from_list([4, 1, 2, 3])
            )
        )}.

'17_set_is_not_a_subset_of_set_that_does_not_contain_its_elements_test_'() ->
    {"set is not a subset of set that does "
        "not contain its elements",
        ?_assertNot(
            custom_set:subset(
                custom_set:from_list([
                    1,
                    2,
                    3
                ]),
                custom_set:from_list([4, 1, 3])
            )
        )}.

'18_the_empty_set_is_disjoint_with_itself_test_'() ->
    {"the empty set is disjoint with itself",
        ?_assert(
            custom_set:disjoint(
                custom_set:from_list([]),
                custom_set:from_list([])
            )
        )}.

'19_empty_set_is_disjoint_with_non_empty_set_test_'() ->
    {"empty set is disjoint with non-empty "
        "set",
        ?_assert(
            custom_set:disjoint(
                custom_set:from_list([]),
                custom_set:from_list([1])
            )
        )}.

'20_non_empty_set_is_disjoint_with_empty_set_test_'() ->
    {"non-empty set is disjoint with empty "
        "set",
        ?_assert(
            custom_set:disjoint(
                custom_set:from_list([1]),
                custom_set:from_list([])
            )
        )}.

'21_sets_are_not_disjoint_if_they_share_an_element_test_'() ->
    {"sets are not disjoint if they share "
        "an element",
        ?_assertNot(
            custom_set:disjoint(
                custom_set:from_list([
                    1,
                    2
                ]),
                custom_set:from_list([2, 3])
            )
        )}.

'22_sets_are_disjoint_if_they_share_no_elements_test_'() ->
    {"sets are disjoint if they share no elements",
        ?_assert(
            custom_set:disjoint(
                custom_set:from_list([
                    1,
                    2
                ]),
                custom_set:from_list([3, 4])
            )
        )}.

'23_add_to_empty_set_test_'() ->
    {"add to empty set",
        ?_assert(
            custom_set:equal(
                custom_set:from_list([3]),
                custom_set:add(3, custom_set:from_list([]))
            )
        )}.

'24_add_to_non_empty_set_test_'() ->
    {"add to non-empty set",
        ?_assert(
            custom_set:equal(
                custom_set:from_list([
                    1,
                    2,
                    3,
                    4
                ]),
                custom_set:add(
                    3,
                    custom_set:from_list([
                        1,
                        2,
                        4
                    ])
                )
            )
        )}.

'25_adding_an_existing_element_does_not_change_the_set_test_'() ->
    {"adding an existing element does not "
        "change the set",
        ?_assert(
            custom_set:equal(
                custom_set:from_list([
                    1,
                    2,
                    3
                ]),
                custom_set:add(
                    3,
                    custom_set:from_list([
                        1,
                        2,
                        3
                    ])
                )
            )
        )}.

'26_intersection_of_two_empty_sets_is_an_empty_set_test_'() ->
    {"intersection of two empty sets is an "
        "empty set",
        ?_assert(
            custom_set:equal(
                custom_set:from_list([]),
                custom_set:intersection(
                    custom_set:from_list([]),
                    custom_set:from_list([])
                )
            )
        )}.

'27_intersection_of_an_empty_set_and_non_empty_set_is_an_empty_set_test_'() ->
    {"intersection of an empty set and non-empty "
        "set is an empty set",
        ?_assert(
            custom_set:equal(
                custom_set:from_list([]),
                custom_set:intersection(
                    custom_set:from_list([]),
                    custom_set:from_list([
                        3,
                        2,
                        5
                    ])
                )
            )
        )}.

'28_intersection_of_a_non_empty_set_and_an_empty_set_is_an_empty_set_test_'() ->
    {"intersection of a non-empty set and "
        "an empty set is an empty set",
        ?_assert(
            custom_set:equal(
                custom_set:from_list([]),
                custom_set:intersection(
                    custom_set:from_list([
                        1,
                        2,
                        3,
                        4
                    ]),
                    custom_set:from_list([])
                )
            )
        )}.

'29_intersection_of_two_sets_with_no_shared_elements_is_an_empty_set_test_'() ->
    {"intersection of two sets with no shared "
        "elements is an empty set",
        ?_assert(
            custom_set:equal(
                custom_set:from_list([]),
                custom_set:intersection(
                    custom_set:from_list([
                        1,
                        2,
                        3
                    ]),
                    custom_set:from_list([
                        4,
                        5,
                        6
                    ])
                )
            )
        )}.

'30_intersection_of_two_sets_with_shared_elements_is_a_set_of_the_shared_elements_test_'() ->
    {"intersection of two sets with shared "
        "elements is a set of the shared elements",
        ?_assert(
            custom_set:equal(
                custom_set:from_list([2, 3]),
                custom_set:intersection(
                    custom_set:from_list([
                        1,
                        2,
                        3,
                        4
                    ]),
                    custom_set:from_list([
                        3,
                        2,
                        5
                    ])
                )
            )
        )}.

'31_difference_of_two_empty_sets_is_an_empty_set_test_'() ->
    {"difference of two empty sets is an empty "
        "set",
        ?_assert(
            custom_set:equal(
                custom_set:from_list([]),
                custom_set:difference(custom_set:from_list([]), custom_set:from_list([]))
            )
        )}.

'32_difference_of_empty_set_and_non_empty_set_is_an_empty_set_test_'() ->
    {"difference of empty set and non-empty "
        "set is an empty set",
        ?_assert(
            custom_set:equal(
                custom_set:from_list([]),
                custom_set:difference(
                    custom_set:from_list([]),
                    custom_set:from_list([
                        3,
                        2,
                        5
                    ])
                )
            )
        )}.

'33_difference_of_a_non_empty_set_and_an_empty_set_is_the_non_empty_set_test_'() ->
    {"difference of a non-empty set and an "
        "empty set is the non-empty set",
        ?_assert(
            custom_set:equal(
                custom_set:from_list([
                    1,
                    2,
                    3,
                    4
                ]),
                custom_set:difference(
                    custom_set:from_list([
                        1,
                        2,
                        3,
                        4
                    ]),
                    custom_set:from_list([])
                )
            )
        )}.

'34_difference_of_two_non_empty_sets_is_a_set_of_elements_that_are_only_in_the_first_set_test_'() ->
    {"difference of two non-empty sets is "
        "a set of elements that are only in the "
        "first set",
        ?_assert(
            custom_set:equal(
                custom_set:from_list([1, 3]),
                custom_set:difference(
                    custom_set:from_list([
                        3,
                        2,
                        1
                    ]),
                    custom_set:from_list([
                        2,
                        4
                    ])
                )
            )
        )}.

'35_union_of_empty_sets_is_an_empty_set_test_'() ->
    {"union of empty sets is an empty set",
        ?_assert(
            custom_set:equal(
                custom_set:from_list([]),
                custom_set:union(
                    custom_set:from_list([]),
                    custom_set:from_list([])
                )
            )
        )}.

'36_union_of_an_empty_set_and_non_empty_set_is_the_non_empty_set_test_'() ->
    {"union of an empty set and non-empty "
        "set is the non-empty set",
        ?_assert(
            custom_set:equal(
                custom_set:from_list([2]),
                custom_set:union(
                    custom_set:from_list([]),
                    custom_set:from_list([2])
                )
            )
        )}.

'37_union_of_a_non_empty_set_and_empty_set_is_the_non_empty_set_test_'() ->
    {"union of a non-empty set and empty set "
        "is the non-empty set",
        ?_assert(
            custom_set:equal(
                custom_set:from_list([1, 3]),
                custom_set:union(
                    custom_set:from_list([1, 3]),
                    custom_set:from_list([])
                )
            )
        )}.

'38_union_of_non_empty_sets_contains_all_unique_elements_test_'() ->
    {"union of non-empty sets contains all "
        "unique elements",
        ?_assert(
            custom_set:equal(
                custom_set:from_list([
                    3,
                    2,
                    1
                ]),
                custom_set:union(
                    custom_set:from_list([1, 3]),
                    custom_set:from_list([
                        2,
                        3
                    ])
                )
            )
        )}.
