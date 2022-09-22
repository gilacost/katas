-module(first).

-export([main/0, readlines/1]).

main() ->
    PasswordList = readlines("input"),
    erlang:display(length(PasswordList)),
    walk_through(PasswordList, []).

walk_through([], ValidPasswords) ->
    length(ValidPasswords);
walk_through([[{Min, Max}, L, Password] | T], ValidPasswords) ->
    Ocurrences = length([X || X <- Password, [X] =:= L]),
    IsValid = (Ocurrences >= Min) and (Ocurrences =< Max),
    NewValidPasswords = add_password(IsValid, ValidPasswords, Password),
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
