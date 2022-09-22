-module(second).

-export([main/0, readlines/1, parse_int/1, validate/1, passport_field/1]).

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
    lists:filter(
        fun({_FName, FValue}) ->
            FValue /= error
        end,
        PassportBuffer
    );
map_passport([H | T], PassportBuffer) ->
    PassportField = passport_field(list_to_binary(H)),
    map_passport(T, [PassportField | PassportBuffer]).

passport_field(<<"ecl:", Ecl/binary>>) -> validate({ecl, parse_string(Ecl)});
passport_field(<<"pid:", Pid/binary>>) -> validate({pid, Pid});
passport_field(<<"eyr:", Eyr/binary>>) -> validate({eyr, parse_int(Eyr)});
passport_field(<<"hcl:", Hcl/binary>>) -> validate({hcl, Hcl});
passport_field(<<"iyr:", Iyr/binary>>) -> validate({iyr, parse_int(Iyr)});
passport_field(<<"cid:", Cid/binary>>) -> {cid, Cid};
passport_field(<<"byr:", Byr/binary>>) -> validate({byr, parse_int(Byr)});
passport_field(<<"hgt:", Hgt/binary>>) -> validate({hgt, Hgt}).

parse_int(Bin) ->
    case string:to_integer(Bin) of
        {Int, <<>>} -> Int;
        _ -> error
    end.

parse_string(Ecl) when is_binary(Ecl) -> binary:bin_to_list(Ecl).

validate({Field, error}) ->
    {Field, error};
validate({byr, Byr}) when Byr >= 1920, Byr =< 2002 ->
    {byr, Byr};
validate({byr, _Byr}) ->
    {byr, error};
validate({iyr, Iyr}) when Iyr >= 2010, Iyr =< 2020 ->
    {iyr, Iyr};
validate({iyr, _Iyr}) ->
    {iyr, error};
validate({eyr, Eyr}) when Eyr >= 2020, Eyr =< 2030 ->
    {eyr, Eyr};
validate({eyr, _Eyr}) ->
    {eyr, error};
validate({ecl, Ecl}) ->
    ValidColors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"],
    case lists:member(Ecl, ValidColors) of
        true -> {ecl, Ecl};
        _ -> {ecl, error}
    end;
validate({hcl, <<"#", Hcl:6/binary>>}) ->
    ValidHexRe = "^[A-Fa-f0-9]+$",
    case re:run(Hcl, ValidHexRe) of
        {match, [{0, 6}]} -> {hcl, Hcl};
        nomatch -> {hcl, error}
    end;
validate({hcl, _}) ->
    {hcl, error};
validate({pid, <<Pid:9/binary>>}) ->
    {pid, parse_int(Pid)};
validate({pid, _}) ->
    {pid, error};
validate({hgt, <<Hgt:3/binary, "cm">>}) ->
    validate({hgt, parse_int(Hgt), cm});
validate({hgt, <<Hgt:2/binary, "in">>}) ->
    validate({hgt, parse_int(Hgt), in});
validate({hgt, Hgt, cm}) when is_integer(Hgt), Hgt >= 150, Hgt =< 193 ->
    {hgt, Hgt};
validate({hgt, Hgt, in}) when is_integer(Hgt), Hgt >= 59, Hgt =< 76 ->
    {hgt, Hgt};
validate({hgt, _}) ->
    {hgt, error}.

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
