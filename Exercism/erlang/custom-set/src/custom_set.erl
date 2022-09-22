-module(custom_set).

-export([
    add/2,
    contains/2,
    difference/2,
    disjoint/2,
    empty/1,
    equal/2,
    from_list/1,
    intersection/2,
    subset/2,
    union/2
]).

add(Elem, Set) -> sets:add_element(Elem, Set).

contains(Elem, Set) -> sets:is_element(Elem, Set).

difference(Set1, Set2) -> sets:subtract(Set1, Set2).

disjoint(Set1, Set2) -> sets:is_disjoint(Set1, Set2).

empty(Set) -> sets:is_empty(Set).

equal(Set1, Set2) -> Set1 == Set2.

from_list(List) -> sets:from_list(List).

intersection(Set1, Set2) -> sets:intersection(Set1, Set2).

subset(Set1, Set2) -> sets:is_subset(Set1, Set2).

union(Set1, Set2) -> sets:union(Set1, Set2).
