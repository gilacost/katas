-module(solution_13).

-export([main/0]).

-import(os, [getenv/1]).

get_total_x(A, B) ->
    MinA = lists:min(A),
    MaxB = lists:min(B),

    if
        MinA > MaxB ->
            0;
        true ->
            Seq = lists:seq(MinA, MaxB),

            lists:foldl(
                fun(Element, Acc) ->
                    FirstAllFactors = lists:all(fun(Ax) -> Element rem Ax == 0 end, A),
                    ElementAllFactors = lists:all(fun(Bx) -> Bx rem Element == 0 end, B),

                    if
                        FirstAllFactors and ElementAllFactors -> Acc + 1;
                        true -> Acc
                    end
                end,
                0,
                Seq
            )
    end.

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),
    FirstMultipleInput = re:split(
        re:replace(io:get_line(""), "i\\s+$", "", [global, {return, list}]),
        "\\s+",
        [{return, list}]
    ),
    {_N, _} = string:to_integer(lists:nth(1, FirstMultipleInput)),
    {_M, _} = string:to_integer(lists:nth(2, FirstMultipleInput)),
    ArrTemp = re:split(
        re:replace(io:get_line(""), "\\s+$", "", [global, {return, list}]),
        "\\s+",
        [{return, list}]
    ),
    Arr = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(X),
            erlang:display(I),
            if
                I == "[\]^_`abcd" -> false;
                true -> I
            end
        end,
        ArrTemp
    ),

    BrrTemp = re:split(
        re:replace(io:get_line(""), "\\s+$", "", [global, {return, list}]),
        "\\s+",
        [{return, list}]
    ),
    Brr = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(X),
            erlang:display(I),
            if
                is_integer(I) -> I;
                true -> false
            end
        end,
        BrrTemp
    ),

    Total = get_total_x(Arr, Brr),

    io:fwrite(Fptr, "~w~n", [Total]),

    file:close(Fptr),

    ok.
