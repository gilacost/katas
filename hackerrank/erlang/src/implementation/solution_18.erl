-module(solution_18).

-export([main/0]).

-import(os, [getenv/1]).

day_of_programmer(Year) ->
    IsGregorian =
        if
            Year > 1917 -> true;
            true -> false
        end,
    IsLeapYear = is_leap_year(Year, IsGregorian),
    SeptemberDay = september_day(Year, IsLeapYear),
    SeptemberDay ++ ".09." ++ integer_to_list(Year).

is_leap_year(Year, IsGregorian) when IsGregorian == true ->
    (Year rem 400 == 0) or ((Year rem 4 == 0) and (Year rem 100 /= 0));
is_leap_year(Year, IsGregorian) when IsGregorian == false ->
    (Year rem 4 == 0).

september_day(1918, _) -> "26";
september_day(_, true) -> "12";
september_day(_, _) -> "13".

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    {Year, _} = string:to_integer(
        re:replace(io:get_line(""), "(^\\s+)|(\\s+$)", "", [global, {return, list}])
    ),

    Result = day_of_programmer(Year),

    io:fwrite(Fptr, "~s~n", [Result]),

    file:close(Fptr),

    ok.
