-module(solution_15).

-export([main/0]).

-import(os, [getenv/1]).

birthday(S, D, M) ->
    Segments = generate_segments(S, M),
    Result = lists:filter(
        fun(Segment) ->
            lists:sum(Segment) == D
        end,
        Segments
    ),
    erlang:display(length(Result)),
    length(Result).

generate_segments(TabletArray, SegmentsSize) ->
    TabletSize = length(TabletArray),
    Seq = lists:seq(1, TabletSize),
    lists:foldl(
        fun(X, Segments) ->
            if
                SegmentsSize == 1 ->
                    Segments ++ [TabletArray];
                true ->
                    if
                        X > TabletSize - SegmentsSize + 1 ->
                            Segments;
                        true ->
                            Segment = lists:sublist(TabletArray, X, SegmentsSize),
                            Segments ++ [Segment]
                    end
            end
        end,
        [],
        Seq
    ).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    {_N, _} = string:to_integer(
        re:replace(io:get_line(""), "(^\\s+)|(\\s+$)", "", [global, {return, list}])
    ),

    STemp = re:split(re:replace(io:get_line(""), "\\s+$", "", [global, {return, list}]), "\\s+", [
        {return, list}
    ]),

    S = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(
                re:replace(X, "(^\\s+)|(\\s+$)", "", [global, {return, list}])
            ),
            I
        end,
        STemp
    ),

    Dm = re:split(re:replace(io:get_line(""), "\\s+$", "", [global, {return, list}]), "\\s+", [
        {return, list}
    ]),

    {D, _} = string:to_integer(lists:nth(1, Dm)),

    {M, _} = string:to_integer(lists:nth(2, Dm)),

    Result = birthday(S, D, M),

    io:fwrite(Fptr, "~w~n", [Result]),

    file:close(Fptr),

    ok.
