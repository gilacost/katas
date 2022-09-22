-module(second).

-export([main/0, readlines/1]).

main() ->
    PasswordList = readlines("input"),
    erlang:display(length(PasswordList)),
    walk_through(PasswordList, []).

walk_through([], ValidPasswords) ->
    length(ValidPasswords);
walk_through([[{P1, P2}, L, Password] = Line | T], ValidPasswords) ->
    IsValidTuple = {([lists:nth(P1, Password)] == L), ([lists:nth(P2, Password)] == L)},
    IsValid =
        case IsValidTuple of
            {true, false} -> true;
            {false, true} -> true;
            _ -> false
        end,
    NewValidPasswords = add_password(IsValid, ValidPasswords, Line),
    walk_through(T, NewValidPasswords).

add_password(false, ValidPasswords, _Password) -> ValidPasswords;
add_password(true, ValidPasswords, Password) -> [Password | ValidPasswords].

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    BinSplit = binary:split(Data, [<<"\n">>], [global]),
    parse(BinSplit, []).

parse([], Buffer) ->
    Buffer;
parse([<<>>], Buffer) ->
    Buffer;
parse([<<Line/binary>> | T], Buffer) ->
    LineParsed = parse_line(binary:bin_to_list(Line)),
    parse(T, [LineParsed | Buffer]).

parse_line(Line) ->
    [MinMax, Letter, Password] = string:split(Line, " ", all),
    [parse_int(string:split(MinMax, "-"), []), Letter -- ":", Password].

parse_int([], [Max, Min]) ->
    {Min, Max};
parse_int([H | T], IntList) ->
    {Int, []} = string:to_integer(H),
    parse_int(T, [Int | IntList]).
