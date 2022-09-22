-module(solution_10).

-export([main/0]).

-import(os, [getenv/1]).

time_conversion(<<Hours:2/binary, Rest:6/binary, Period/binary>>) ->
    MilitarTime =
        case Period of
            <<"AM">> ->
                case Hours of
                    <<"12">> ->
                        [<<"00">>, Rest];
                    _ ->
                        [Hours, Rest]
                end;
            <<"PM">> ->
                case Hours of
                    <<"12">> ->
                        [Hours, Rest];
                    _ ->
                        {HoursInt, _} = string:to_integer(Hours),
                        HoursTmp = list_to_binary(
                            string:right(integer_to_list(HoursInt + 12), 2, $0)
                        ),
                        [HoursTmp, Rest]
                end
        end,

    binary_to_list(iolist_to_binary(MilitarTime)).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    S =
        case io:get_line("") of
            eof -> "";
            SData -> string:chomp(SData)
        end,

    erlang:display(S),

    Result = time_conversion(list_to_binary(S)),

    erlang:display(Result),

    io:fwrite(Fptr, "~s~n", [Result]),

    file:close(Fptr),

    ok.
