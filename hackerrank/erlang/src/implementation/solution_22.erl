-module(solution_22).

-export([main/0, counting_valleys/2]).

-import(os, [getenv/1]).

counting_valleys(_Steps, Path) ->
    {_Level, ValleyCount} = iterate_string(Path, {0, 0}),
    ValleyCount.

iterate_string([], Acc) ->
    Acc;
iterate_string([Step | T], {Level, ValleyCount}) ->
    NextLevel =
        if
            Step == 85 -> Level + 1;
            true -> Level - 1
        end,
    Acc =
        if
            NextLevel < 0, Level > -1 ->
                {NextLevel, ValleyCount + 1};
            true ->
                {NextLevel, ValleyCount}
        end,

    iterate_string(T, Acc).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    {Steps, _} = string:to_integer(
        re:replace(io:get_line(""), "(^\\s+)|(\\s+$)", "", [global, {return, list}])
    ),

    Path =
        case io:get_line("") of
            eof -> "";
            PathData -> re:replace(PathData, "(\\r\\n$)|(\\n$)", "", [global, {return, list}])
        end,

    Result = counting_valleys(Steps, Path),

    io:fwrite(Fptr, "~w~n", [Result]),

    file:close(Fptr),

    ok.

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

counting_valleys_0_test() ->
    ValleyCount = counting_valleys(8, "UDDDUDUU"),
    ?assert(ValleyCount =:= 1).

-endif.
