-module(solution_12).

-export([main/0]).

-import(os, [getenv/1]).

% Complete the kangaroo function below.
kangaroo(X1, V1, X2, V2) when V1 > V2, X1 < X2 ->
    MeetingTime = calculate_meeting_time(X1, V1, X2, V2),
    will_meet_at_exact_second(MeetingTime);
kangaroo(X1, V1, X2, V2) when V2 > V1, X2 < X1 ->
    MeetingTime = calculate_meeting_time(X1, V1, X2, V2),
    will_meet_at_exact_second(MeetingTime);
kangaroo(_X1, _V1, _X2, _V2) ->
    "NO".

calculate_meeting_time(XOa, Va, XOb, Vb) ->
    (XOa - XOb) / (Vb - Va).

will_meet_at_exact_second(Time) ->
    if
        (Time - trunc(Time)) /= 0 -> "NO";
        true -> "YES"
    end.

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),
    X1V1X2V2 = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    {X1, _} = string:to_integer(lists:nth(1, X1V1X2V2)),
    {V1, _} = string:to_integer(lists:nth(2, X1V1X2V2)),
    {X2, _} = string:to_integer(lists:nth(3, X1V1X2V2)),
    {V2, _} = string:to_integer(lists:nth(4, X1V1X2V2)),

    Result = kangaroo(X1, V1, X2, V2),
    erlang:display(Result),
    io:fwrite(Fptr, "~s~n", [Result]),
    file:close(Fptr),

    ok.
