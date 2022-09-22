-module(second).

-export([main/1, readlines/1]).

main(Input) ->
    Lines = readlines(Input),
    erlang:display(Lines).

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    BinSplit = binary:split(Data, [<<"\n">>], [global]),
    parse(BinSplit, []).

% ocurrences(List, El, string) -> length([X || X <- List, [X] =:= El]),

% even_print([]) ->
%     [];
% even_print([H | T]) when H rem 2 /= 0 ->
%     even_print(T);
% even_print([H | T]) ->
%     io:format("printing: ~p~n", [H]),
%     [H | even_print(T)].

parse([<<>>], Buffer) ->
    lists:reverse(Buffer);
parse([<<H/binary>> | T], Buffer) ->
    {Number, <<>>} = string:to_integer(H),
    parse(T, [Number | Buffer]).
