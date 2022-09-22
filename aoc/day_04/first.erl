-module(first).

-export([main/0, readlines/1]).

main() ->
    Lines = readlines("input"),
    erlang:display(Lines).

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    BinSplit = binary:split(Data, [<<"\n\n">>], [global]),
    ValidPassports = parse(BinSplit, []),
    erlang:display(lists:sum(ValidPassports)),
    ok.

is_valid([], _Fields, IsValid) ->
    IsValid;
is_valid([_H | _T], _Fields, false) ->
    false;
is_valid([H | T], Fields, _IsValid) ->
    is_valid(T, Fields, lists:member(H, Fields)).

required_fields() ->
    [byr, ecl, eyr, hcl, hgt, iyr, pid].

bool_to_int(true) -> 1;
bool_to_int(_) -> 0.

passport_fields(Passport) ->
    maps:keys(maps:from_list(Passport)).

map_passport([], PassportBuffer) ->
    PassportBuffer;
map_passport([H | T], PassportBuffer) ->
    PassportField = passport_field(list_to_binary(H)),
    map_passport(T, [PassportField | PassportBuffer]).

passport_field(<<"ecl:", Ecl/binary>>) -> {ecl, Ecl};
passport_field(<<"pid:", Pid/binary>>) -> {pid, Pid};
passport_field(<<"eyr:", Eyr/binary>>) -> {eyr, Eyr};
passport_field(<<"hcl:", Hcl/binary>>) -> {hcl, Hcl};
passport_field(<<"iyr:", Iyr/binary>>) -> {iyr, Iyr};
passport_field(<<"cid:", Cid/binary>>) -> {cid, Cid};
passport_field(<<"byr:", Byr/binary>>) -> {byr, Byr};
passport_field(<<"hgt:", Hgt/binary>>) -> {hgt, Hgt}.

parse([], Buffer) ->
    lists:reverse(Buffer);
parse([<<H/binary>> | T], Buffer) ->
    Line = binary:bin_to_list(H),
    LineCleanned = string:replace(Line, "\n", " ", all),
    PassportString = string:join(LineCleanned, ""),
    PassportStringTrimmed = string:trim(PassportString),
    PassportItems = string:split(PassportStringTrimmed, " ", all),

    Passport = map_passport(PassportItems, []),
    IsValid = is_valid(required_fields(), passport_fields(Passport), true),
    IsValidInt = bool_to_int(IsValid),

    parse(T, [IsValidInt | Buffer]).
