-module(nucleotide_count).

-export([count/2, nucleotide_counts/1]).

count(Strand, Nucleotide) ->
    walk_through(Strand, Nucleotide, 0).

nucleotide_counts(Strand) ->
    [
        {"A", count(Strand, "A")},
        {"C", count(Strand, "C")},
        {"G", count(Strand, "G")},
        {"T", count(Strand, "T")}
    ].

walk_through([], _Nucleotide, Result) ->
    Result;
walk_through([H | T], Nucleotide, Result) when [H] == Nucleotide ->
    walk_through(T, Nucleotide, Result + 1);
walk_through([H | _T], Nucleotide, _Result) when [H] /= "A", [H] /= "C", [H] /= "G", [H] /= "T" ->
    erlang:error("strand with invalid nucleotides, " ++ Nucleotide);
walk_through([_H | T], Nucleotide, Result) ->
    walk_through(T, Nucleotide, Result).
